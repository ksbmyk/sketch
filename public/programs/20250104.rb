# GENUARY 2025 jan4 "Black on black."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
end

def draw
  background(255)
  noStroke
  0.step(width, 10) do |i|
    fill(0, random(50, 250))
    rect(i, 0, 15, height)
  end
end
