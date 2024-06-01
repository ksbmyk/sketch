$radius = 0
$alpha = 255
def setup
  createCanvas(700, 700)
end

def draw
  background(255)
  noStroke
  fill(0, 0, 255, $alpha)

  ellipse(width/2, height/2, $radius * 2)
  $radius = $radius + 1
  $alpha  = $alpha -1
end
