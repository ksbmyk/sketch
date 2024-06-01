$radius = 0
def setup
  createCanvas(700, 700)
end

def draw
  background(255)
  noStroke
  fill("blue")

  ellipse(width/2, height/2, $radius * 2)
  $radius = $radius + 1

  if ($radius > width / 3)
    noLoop
  end
end
