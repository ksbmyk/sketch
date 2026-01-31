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
  
  // SDF for circle
  float sdCircle(vec2 p, float r) {
    return length(p) - r;
  }
  
  // SDF for square
  float sdSquare(vec2 p, float s) {
    vec2 d = abs(p) - s;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
  }
  
  // SDF for hexagon
  float sdHexagon(vec2 p, float r) {
    const vec3 k = vec3(-0.866025404, 0.5, 0.577350269);
    p = abs(p);
    p -= 2.0 * min(dot(k.xy, p), 0.0) * k.xy;
    p -= vec2(clamp(p.x, -k.z * r, k.z * r), r);
    return length(p) * sign(p.y);
  }
  
  // Morph between shapes based on time
  float morphShape(vec2 p, float size, float t) {
    float phase = mod(t, 3.0);
    
    float circle = sdCircle(p, size);
    float square = sdSquare(p, size * 0.8);
    float hexagon = sdHexagon(p, size * 0.9);
    
    float d;
    if (phase < 1.0) {
      d = mix(circle, square, phase);
    } else if (phase < 2.0) {
      d = mix(square, hexagon, phase - 1.0);
    } else {
      d = mix(hexagon, circle, phase - 2.0);
    }
    
    return d;
  }
  
  void main() {
    vec2 uv = vTexCoord;
    uv = uv * 2.0 - 1.0;
    uv.x *= u_width / u_height;
    
    // Grid settings
    float gridSize = 5.0;
    vec2 gridUV = fract(uv * gridSize) - 0.5;
    vec2 gridID = floor(uv * gridSize);
    
    // Time offset based on grid position
    float timeOffset = (gridID.x + gridID.y) * 0.3;
    float localTime = u_time * 0.5 + timeOffset;
    
    // Shape size
    float size = 0.35;
    
    // Get morphed SDF
    float d = morphShape(gridUV, size, localTime);
    
    // Colors
    vec3 color1 = vec3(0.1, 0.3, 0.6);
    vec3 color2 = vec3(0.3, 0.6, 0.9);
    vec3 color3 = vec3(0.5, 0.8, 1.0);
    
    // Edge and inner
    float edge = smoothstep(0.02, 0.0, abs(d));
    float inner = smoothstep(0.02, -0.1, d);
    
    // Background
    vec3 bg = mix(vec3(0.02, 0.05, 0.1), vec3(0.05, 0.1, 0.2), uv.y * 0.5 + 0.5);
    
    // Shape color
    vec3 shapeColor = mix(color1, color2, inner);
    shapeColor = mix(shapeColor, color3, edge);
    
    // Final color
    vec3 finalColor = mix(bg, shapeColor, inner + edge * 0.5);
    
    // Glow
    float glow = exp(-abs(d) * 10.0) * 0.3;
    finalColor += vec3(0.2, 0.5, 0.8) * glow;
    
    gl_FragColor = vec4(finalColor, 1.0);
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
