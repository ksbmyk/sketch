$base = 80
$split = 9
$colors = ["#ba083d", "#444444", "#a9a7ad"]
def setup
  createCanvas($base * $split, $base * $split)
  angleMode(DEGREES)
  noStroke
  noLoop
end

def draw
  background(255)

  fill($colors[0])
  x = width / 2
  y = width / 2
  d = $base
  ellipse(x, y, d, d)
  ellipse(x - $base, y + $base, d, d)

  fill($colors[1])
  arc(x - $base / 2, y -  $base / 2, $base*2, $base*2, 90, 270)
  arc(x + $base / 2, y +  $base / 2, $base*2, $base*2, 270, 90)

  fill($colors[2])
  arc(x - $base / 2 + $base, y - $base / 2 - $base, $base*2, $base*2, 90, 180)
  arc(x + $base / 2, y - $base / 2, $base*2, $base*2, 270, 360)
  arc(x - $base / 2, y + $base / 2 + $base, $base*2, $base*2, 270, 360)
end
