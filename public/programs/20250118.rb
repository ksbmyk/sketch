# GENUARY 2025 jan18 "What does wind look like?"
# https://genuary.art/prompts

def setup
  createCanvas(600, 600)
  noStroke
  @snowflakes = []
end

def draw
  background(135, 206, 235)

  if rand < 0.5
    @snowflakes << Snowflake.new(rand(0..width), rand(-20..0))
  end

  @snowflakes.reverse_each.with_index do |s, i|
    s.update
    s.display

    @snowflakes.delete_at(@snowflakes.length - 1 - i) if s.pos[:y] > height
  end
end

class Snowflake
  attr_reader :pos

  def initialize(x, y)
    @pos = { x: x, y: y }
    @vel = { x: rand(-1..1), y: rand(1..3) } # 速度
    @acc = { x: 0, y: 0.05 } # 加速度(重力)
    @size = rand(2.5..8)
    @alpha = rand(180..255)
  end

  def update
    # 風を設定
    wind = { x: sin(frameCount * 0.01) * 0.5, y: 0 }
    @vel[:x] += @acc[:x] + wind[:x]
    @vel[:y] += @acc[:y] + wind[:y]
    @pos[:x] += @vel[:x]
    @pos[:y] += @vel[:y]

    # 横方向の揺らぎを加算
    @pos[:x] += sin(frameCount * 0.05 + @pos[:y] * 0.1) * 0.5
  end

  def display
    fill(255, @alpha)
    ellipse(@pos[:x], @pos[:y], @size)
  end
end
