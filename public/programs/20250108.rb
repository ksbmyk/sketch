# GENUARY 2025 jan8 "Draw one million of something."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  background(255)
end

def draw
  stroke(0, 0, 200, 100)
  x = rand(1..width - 1)
  y = rand(1..height - 1)
  if frameCount.to_i.odd?
    line(x, y, x + 50, y)
  else
    line(x, y, x, y + 50)
  end
  noLoop if frameCount == 1000000
end
