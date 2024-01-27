# GENUARY 2024 jan27 "Code for one hour. At the one hour mark, you’re done."
# https://genuary.art/prompts

def setup
  @size = 50
  createCanvas(720, 720)
  angleMode(DEGREES)
  background("#efeddb")
  noLoop
end
  
def draw
  noStroke
  500.times do
    draw_object(rand(0..width), rand(0..height))
  end
end

def draw_object(x, y)
  fill(rand(70..200), rand(130..230), rand(230..250))
  ellipse(x, y+@size/2, @size, @size)
  ellipse(x, y+@size/2, @size, @size)
  arc(x - @size/2, y - @size/2, @size * 2, @size * 2, 0, 90)
end