def setup
  createCanvas(400,400)
  background(255)
end

def draw
  noLoop
  100.times do
    noStroke
    fill('#aac8ff')
    ellipse(rand(0..400), rand(0..400), 30, 30)
  end
end
