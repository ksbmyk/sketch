$side = 80
$split = 9
$colors = ["#ba083d", "#444444", "#a9a7ad"]
def setup
  createCanvas($side * $split, $side * $split)
  angleMode(DEGREES)
  rectMode(CENTER)
  noStroke
  noLoop
end

def draw
  background(255)
  x = 0
  while x < width do
    y = 0
    while y < height do
      r = rand(0..4)
      case r
      when 0
        fill($colors[0])
        ellipse(x + $side / 2 , y + $side / 2, $side, $side)
      when 1
        fill($colors[rand(1..2)])
        arc(x, y, $side * 2, $side * 2, 0, 90)
      when 2
        fill($colors[rand(1..2)])
        push
        translate(0, $side)
        arc(x, y, $side * 2, $side * 2, 270, 360)
        pop
      when 3
        fill($colors[rand(1..2)])
        push
        translate($side, 0)
        arc(x, y, $side * 2, $side * 2, 90, 180)
        pop
      when 4
        fill($colors[rand(1..2)])
        push
        translate($side, $side)
        arc(x, y, $side * 2, $side * 2, 180, 270)
        pop
      end
      y += $side
    end
    x += $side
  end
end
