# GENUARY 2024 jan4 "Pixels."
# https://genuary.art/prompts

$base = 10
$split = 20
$colors = %w(#ffee4a #ffc501 #fe9600)
def setup
  createCanvas($base * $split * 3, $base * $split * 3)
  angleMode(DEGREES)
  background(255)
  frameRate(2)
end

def draw
  pixel_box

  push
  translate($base * $split, $base * $split)
  pixel_box
  pop

  push
  translate($base * $split * 2, 0)
  pixel_box
  pop

  push
  translate(0, $base * $split * 2)
  pixel_box
  pop

  push
  translate($base * $split * 2, $base * $split * 2)
  pixel_box
  pop
end

def pixel_box
  x = 0
  while x < $base * $split do
    y = 0
    while y < $base * $split do
      noStroke
      c = rand(0..$colors.length - 1)
      fill($colors[c])
      rect(x, y , $base, $base)
      y += $base
    end
    x += $base
  end
end
