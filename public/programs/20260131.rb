WIDTH = 700
HEIGHT = 700

VERTEX_SHADER = <<~GLSL
  precision highp float;
  attribute vec3 aPosition;
  attribute vec2 aTexCoord;
  varying vec2 vTexCoord;
  uniform mat4 uProjectionMatrix;
  uniform mat4 uModelViewMatrix;
  
  void main() {
    vec4 positionVec4 = vec4(aPosition, 1.0);
    gl_Position = uProjectionMatrix * uModelViewMatrix * positionVec4;
    vTexCoord = aTexCoord;
  }
GLSL

FRAGMENT_SHADER = <<~GLSL
  precision highp float;
  varying vec2 vTexCoord;
  uniform float u_time;
  uniform float u_width;
  uniform float u_height;
  
  #define PI 3.14159265359
  
  // Hash function
  float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
  }
  
  // 2D Noise
  float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    
    // Cubic interpolation
    vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix(
      mix(hash(i + vec2(0.0, 0.0)), hash(i + vec2(1.0, 0.0)), u.x),
      mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x),
      u.y
    );
  }
  
  // Rotation matrix
  mat2 rot2D(float a) {
    float s = sin(a), c = cos(a);
    return mat2(c, -s, s, c);
  }
  
  // Fractal Brownian Motion
  float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    
    // 6 octaves
    for (int i = 0; i < 6; i++) {
      value += amplitude * noise(p * frequency);
      p *= rot2D(0.5); // Rotate each octave
      frequency *= 2.0;
      amplitude *= 0.5;
    }
    
    return value;
  }
  
  // Domain warping - creates more organic flow
  float warpedFbm(vec2 p, float t) {
    vec2 q = vec2(
      fbm(p + vec2(0.0, 0.0) + t * 0.1),
      fbm(p + vec2(5.2, 1.3) + t * 0.12)
    );
    
    vec2 r = vec2(
      fbm(p + 4.0 * q + vec2(1.7, 9.2) + t * 0.15),
      fbm(p + 4.0 * q + vec2(8.3, 2.8) + t * 0.13)
    );
    
    return fbm(p + 4.0 * r);
  }
  
  // HSV to RGB
  vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
  }
  
  void main() {
    vec2 uv = vTexCoord * 2.0 - 1.0;
    uv.x *= u_width / u_height;
    
    // Scale
    vec2 p = uv * 2.0;
    
    // Multiple layers of warped FBM
    float n1 = warpedFbm(p, u_time);
    float n2 = warpedFbm(p * 1.5 + 10.0, u_time * 0.8);
    float n3 = fbm(p * 3.0 + u_time * 0.2);
    
    // Combine layers
    float n = n1 * 0.6 + n2 * 0.3 + n3 * 0.1;
    
    // Create ridges (turbulence-like effect)
    float ridge = abs(n * 2.0 - 1.0);
    ridge = 1.0 - ridge;
    ridge = pow(ridge, 2.0);
    
    // Color mapping
    float hue = 0.55 + n * 0.15 + sin(u_time * 0.2) * 0.05; // Cyan to blue range
    float sat = 0.6 + ridge * 0.4;
    float val = 0.2 + n * 0.5 + ridge * 0.4;
    
    vec3 col = hsv2rgb(vec3(hue, sat, val));
    
    // Add bright veins
    float vein = smoothstep(0.48, 0.52, n1);
    vein += smoothstep(0.52, 0.48, n1);
    col += vec3(0.3, 0.5, 0.9) * vein * 0.4;
    
    // Deep areas glow
    float deep = smoothstep(0.3, 0.0, n);
    col += vec3(0.1, 0.2, 0.5) * deep * 0.3;
    
    // Highlight peaks
    float peak = smoothstep(0.7, 0.9, n);
    col += vec3(0.5, 0.8, 1.0) * peak * 0.6;
    
    // Subtle texture overlay
    float detail = noise(uv * 50.0 + u_time);
    col += col * (detail - 0.5) * 0.1;
    
    // Vignette
    float vignette = 1.0 - dot(uv * 0.4, uv * 0.4);
    vignette = smoothstep(0.0, 1.0, vignette);
    col *= vignette;
    
    // Bloom
    col += col * col * 0.2;
    
    // Gamma
    col = pow(col, vec3(0.9));
    
    gl_FragColor = vec4(col, 1.0);
  }
GLSL

def setup
  createCanvas(WIDTH, HEIGHT, WEBGL)
  @shader = createShader(VERTEX_SHADER, FRAGMENT_SHADER)
  noStroke
end

def draw
  background(0)
  shader(@shader)
  @shader.setUniform('u_time', frameCount / 60.0)
  @shader.setUniform('u_width', WIDTH.to_f)
  @shader.setUniform('u_height', HEIGHT.to_f)
  rect(-WIDTH / 2, -HEIGHT / 2, WIDTH, HEIGHT)
end
