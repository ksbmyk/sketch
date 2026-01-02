# GENUARY 2026 jan2 "Twelve principles of animation."
# https://genuary.art/prompts

NUM_PARTICLES = 500
NOISE_SCALE = 0.005

class Particle
  attr_accessor :x, :y, :vx, :vy
  attr_reader :hue, :size

  def initialize(x_range, y_range)
    @x_range = x_range
    @y_range = y_range
    reset
    @x = rand(@x_range)
    @y = rand(@y_range)
  end

  def update(angle, strength)
    # Perlinノイズで、この位置での流れる方向を決定
    @vx += cos(angle) * strength * 0.1
    @vy += sin(angle) * strength * 0.1
    # 減衰させ徐々に減速
    @vx *= 0.95
    @vy *= 0.95
    @x += @vx
    @y += @vy
  end

  def out_of_bounds?
    @x < 0 || @x > @x_range || @y < 0 || @y > @y_range
  end

  def reset
    @x = rand(@x_range)
    @y = rand(@y_range)
    @vx = 0
    @vy = 0
    @hue = rand(180..240)
    @size = rand(2.0..6.0)
  end

  def speed
    sqrt(@vx * @vx + @vy * @vy)
  end
end

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  background(220, 30, 10)
  
  @particles = NUM_PARTICLES.times.map { Particle.new(width, height) }
  @time = 0.0
end

def draw
  background(220, 30, 10, 10)
  
  # Slow In and Slow Out: sinの2乗で緩急を強調
  # 0〜1を滑らかに往復
  ease = sin(@time * 0.5) * 0.5 + 0.5
  # 2乗でより緩急がを際立たせる
  flow_strength = ease * ease * 4 + 0.2
  
  @particles.each do |p|
    # Perlinノイズで流れ場の角度を決定
    angle = noise(p.x * NOISE_SCALE, p.y * NOISE_SCALE, @time * 0.1) * TWO_PI * 2
    
    p.update(angle, flow_strength)
    p.reset if p.out_of_bounds?
    
    noStroke
    # 速いほど明るく
    brightness = map(p.speed, 0, 3, 40, 100)
    fill(p.hue, 60, brightness, 80)
    circle(p.x, p.y, p.size)
  end
  
  @time += 0.016
end
