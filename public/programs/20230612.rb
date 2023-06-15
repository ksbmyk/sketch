def setup
  createCanvas(600, 600)
  background('#007bed')
  blendMode(SOFT_LIGHT)
  noLoop
end

def draw
  fill('#dddddd')
  noStroke
  1000.times do
    r1 = rand(1..100)
    r2 = rand(1..100)
    rect(r1*10, r2*10, r2, r2)
    rect(r2*10, r1*10, r2, r2)
  end
end
