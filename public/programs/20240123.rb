# GENUARY 2024 jan23 "128×128."
# https://genuary.art/prompts

def setup
  @size = 5
  @split = 128
  createCanvas(@size * @split, @size * @split)
  noLoop
end
  
def draw
  noStroke
  x = 0
  while x <= width do
    y = 0
    while y <= width do
    fill(rand(70..200), rand(130..230), rand(230..250))
    ellipse(x, y, @size, @size)
    arc(x - @size/2, y - @size/2, @size * 2, @size * 2, 0, 90)
    y += @size
    end
    x += @size
  end
end
