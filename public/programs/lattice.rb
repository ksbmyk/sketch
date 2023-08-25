$base = 80
$split = 9
$colors = %w(#ba083d #444444 #a9a7ad)
def setup
  createCanvas($base * $split, $base * $split)
  angleMode(DEGREES)
  background(255)
end

def draw
  noStroke
  noLoop
  x = 0
  while x < width do
    y = 0
    while y < width do
      fill("#444444")
      #ellipse(x + $base/2, y + $base/2, $base , $base )

      #arc(x  , y , $base * 2, $base * 2, 0, 90)

      push
      translate($base, 0)
      #arc(x  , y , $base * 2, $base * 2, 90, 180)
      pop

      push
      translate($base, $base)
      #arc(x  , y , $base * 2, $base * 2, 180, 270)
      pop

      push
      translate(0, $base)
      arc(x  , y , $base * 2, $base * 2, 270, 360)
      pop

      y += $base
    end
    x += $base
  end
end
