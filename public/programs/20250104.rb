def setup
  createCanvas(700, 700)
  noLoop
end

def draw
  noStroke
  0.step(width, 10) do |i|
    fill(0, random(50, 205))
    rect(i, 0, 10, height)
    rect(0, i, width, 10)
  end
end
