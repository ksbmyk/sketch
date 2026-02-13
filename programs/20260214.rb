def setup
  createCanvas(700, 700)
  textAlign(CENTER, CENTER)
  @petals = []
  spawn_petals
end

def draw
  background(233, 165, 158)
  spawn_petals if frameCount % 120 == 0
  fill(210, 49, 6)
  textSize(50)
  @petals.reject! do |petal|
    petal[:y] += petal[:fall_speed]
    petal[:x] += petal[:drift]
    petal[:angle] += 0.05

    push
    translate(petal[:x], petal[:y])
    rotate(petal[:angle])
    text('✿', 0, 0)
    pop

    petal[:y] > width + 20
  end
end

def spawn_petals
  50.times do
    @petals << {
      x: rand * width,
      y: -rand * width * 1.2,
      angle: rand * PI * 2,
      fall_speed: rand * 4.0 + 2.0,
      drift: rand * 4.0 - 2.0
    }
  end
end
