$base = 80
$split = 2
#$colors = %w(#B6E3FF #54AEFF #0969DA #0A3069)
$colors = %w(#0A3069 #0969DA #54AEFF #B6E3FF)
def setup
  pixelDensity(20)
  createCanvas($base * $split, $base * $split)
  angleMode(DEGREES)
  background(0)
  noLoop
end

def draw
  background(255)
  d = width / $split
  x = d / 2
  count = 0
  while x < width do
    y = d / 2
    while y < width do
      noStroke
      fill($colors[count])
      ellipse(x, y, d, d)
      arc(x - d / 2, y - d / 2, d * 2, d * 2, 0, 90)

      #白い線(ハイライト)を入れる
      stroke(255)
      strokeWeight(5)
      noFill
      arc(x - d / 2, y - d / 2, d * 2 - 20, d * 2-20, 0, 15)
      arc(x - d / 2, y - d / 2, d * 2 - 20, d * 2-20, 81, 83)
      arc(x , y , d - 20, d  - 20, 10, 80)

      y += d
      count += 1
    end
    x += d
  end
end
