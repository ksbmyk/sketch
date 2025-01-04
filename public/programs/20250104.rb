# GENUARY 2025 jan4 "Black on black."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  frameRate(5)
end

def draw
  background(255)
  noStroke
  0.step(width, 10) do |i|
    fill(0, random(50, 250))
    rect(i, 0, 15, height)
  end

  maskGraphics = createGraphics(width, height)
  maskGraphics.background(0)
  maskGraphics.erase
  maskGraphics.circle(width / 2, height / 2, width / 2)
  maskGraphics.noErase
  image(maskGraphics, 0, 0)
end
