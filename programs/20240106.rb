# GENUARY 2024 jan6 "Screensaver."
# https://genuary.art/prompts

def setup
  createCanvas(720, 720)
  @particles = 50.times.map { Particle.new(rand(0..width), rand(0..height)) }
end

def draw
  background(0)
  @particles.each do |particle|
    particle.update
    particle.show
  end
end

class Particle
  attr_accessor :pos, :vel, :acc, :maxspeed, :prev_pos, :size, :r, :g, :b

  def initialize(x, y)
    @pos = createVector(x, y) # 位置
    @vel = createVector(rand(0.1..3.0), rand(-2.0..3.0)) # 速度
    @acc = createVector(0, 0) # 加速度
    @maxspeed = 4
    @prev_pos = pos.copy #前回の位置を初期化
    @r = 0
    @g = rand(0..255)
    @b = rand(100..200)
    @size = rand(10..20)
  end

  def update
    vel.add(acc)
    vel.limit(maxspeed)
    pos.add(vel)
    acc.mult(0)

    prev_pos = pos.copy

    if pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0
      @pos = createVector(rand(0..width), rand(0..height))
      @prev_pos = pos.copy
    end
  end

  def show
    strokeWeight(2)
    stroke(255, 255, 255, 80)
    fill(r, g, b)
    ellipse(pos.x, pos.y, size)
  end
end
