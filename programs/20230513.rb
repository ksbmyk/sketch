$base = 80
$split = 9
$colors = ["#ba083d", "#444444", "#a9a7ad", "#444444", "#a9a7ad"]
def setup
  createCanvas($base * $split, $base * $split)
  angleMode(DEGREES)
  noStroke
  noLoop
end

def draw
  background(255)
  d = width / $split
  x = d / 2
  while x < width do
    y = d / 2
    while y < width do
      c = rand(0..4)
      fill($colors[c])
      case c
      when 0
        ellipse(x, y, d, d)
      when 1
        push
        translate(0, d)
        arc(x - d / 2, y - d / 2, d * 2, d * 2, 270, 360)
        pop
      when 2
        arc(x - d / 2, y - d / 2, d * 2, d * 2, 0, 90) # このままでいい
      when 3
        push
        translate(d, 0)
        arc(x - d / 2, y - d / 2, d * 2, d * 2, 90, 180)
        pop
      when 4
        push
        translate(d, d)
        arc(x - d / 2, y - d / 2, d * 2, d * 2, 180, 270)
        pop
      end
      y += d
    end
    x += d
  end
end
