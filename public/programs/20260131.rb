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
    
    for (int i = 0; i < 6; i++) {
      value += amplitude * noise(p * frequency);
      p *= rot2D(0.5);
      frequency *= 2.0;
      amplitude *= 0.5;
    }
    
    return value;
  }
  
  // Domain warping
  float warpedFbm(vec2 p, float t) {
    // Slower time for calmer movement
    float slowT = t * 0.5;

    vec2 q = vec2(
      fbm(p + vec2(0.0, 0.0) + slowT * 0.08),
      fbm(p + vec2(5.2, 1.3) + slowT * 0.09)
    );
    
    vec2 r = vec2(
      fbm(p + 4.0 * q + vec2(1.7, 9.2) + slowT * 0.1),
      fbm(p + 4.0 * q + vec2(8.3, 2.8) + slowT * 0.08)
    );
    
    return fbm(p + 4.0 * r);
  }
  
  // Floating particle
  float particle(vec2 uv, vec2 pos, float size) {
    float d = length(uv - pos);
    // Soft gaussian-like falloff
    return exp(-d * d / (size * size));
  }

  // Multiple floating particles
  float particles(vec2 uv, float t) {
    float p = 0.0;

    for (int i = 0; i < 15; i++) {
      float fi = float(i);

      // Unique position and movement per particle
      float seed1 = hash(vec2(fi, 0.0));
      float seed2 = hash(vec2(fi, 1.0));
      float seed3 = hash(vec2(fi, 2.0));

      // Slow, floating movement
      float speed = 0.1 + seed1 * 0.15;
      vec2 pos = vec2(
        sin(t * speed + seed1 * PI * 2.0) * 0.8 + cos(t * speed * 0.7 + seed2 * PI) * 0.3,
        cos(t * speed * 0.8 + seed2 * PI * 2.0) * 0.6 + sin(t * speed * 0.5 + seed3 * PI) * 0.4
      );

      // Vary size and brightness
      float size = 0.08 + seed3 * 0.12;
      float brightness = 0.3 + seed1 * 0.7;
¥
      // Gentle pulsing
      brightness *= 0.7 + 0.3 * sin(t * (0.5 + seed2 * 0.5) + seed1 * PI * 2.0);

      p += particle(uv, pos, size) * brightness;
    }

    return p;
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

    vec2 p = uv * 2.0;

    // Slower, calmer FBM
    float n1 = warpedFbm(p, u_time);
    float n2 = warpedFbm(p * 1.3 + 10.0, u_time * 0.7);
    float n = n1 * 0.7 + n2 * 0.3;

    // Softer color mapping - lower contrast
    float hue = 0.55 + n * 0.1 + sin(u_time * 0.15) * 0.03;
    float sat = 0.4 + n * 0.2;
    float val = 0.25 + n * 0.35;

    vec3 col = hsv2rgb(vec3(hue, sat, val));

    // Soft glow in valleys
    float glow = smoothstep(0.5, 0.2, n);
    col += vec3(0.1, 0.2, 0.4) * glow * 0.4;

    // Soft highlights on peaks
    float highlight = smoothstep(0.6, 0.8, n);
    col += vec3(0.2, 0.4, 0.6) * highlight * 0.3;

    // Floating light particles
    float pts = particles(uv, u_time);
    vec3 particleColor = vec3(0.6, 0.8, 1.0);
    col += particleColor * pts * 0.6;

    // Extra soft glow around particles
    float ptsGlow = particles(uv * 0.95, u_time);
    ptsGlow += particles(uv * 0.9, u_time) * 0.5;
    col += vec3(0.3, 0.5, 0.8) * ptsGlow * 0.15;

    // Global soft bloom
    vec3 bloom = col * col;
    col += bloom * 0.25;

    // Very soft vignette
    float vignette = 1.0 - dot(uv * 0.3, uv * 0.3);
    vignette = smoothstep(0.0, 1.0, vignette);
    col *= 0.7 + vignette * 0.3;

    // Soften overall
    col = pow(col, vec3(0.95));

    // Slight desaturation for dreamier feel
    float gray = dot(col, vec3(0.299, 0.587, 0.114));
    col = mix(vec3(gray), col, 0.85);

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
