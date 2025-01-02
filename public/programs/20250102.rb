# GENUARY 2025 jan2 "Layers upon layers upon layers."
# https://genuary.art/prompts

SIZE = 50
def setup
  createCanvas(700, 700)
  background(0)
  rectMode(CENTER)
  noStroke
  frameRate(1)
end

def draw
  blendMode(BLEND)
  background(0)

  blendMode(ADD)
  0.step(height, SIZE) do |y|
    0.step(width, SIZE) do |x|
      fill(rand(100..255), 150, 100, rand(0..255))

      ellipse(x + SIZE / 2, y + SIZE / 2, rand(3..SIZE * 2 ))
      rect(x + SIZE / 2, y + SIZE / 2, rand(3..SIZE * 2))
      push
      translate(x + SIZE / 2, y + SIZE / 2)
      rotate(PI / 4)
      rect(0, 0, rand(3..SIZE * 0.7))
      pop
    end
  end
end
