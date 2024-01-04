# GENUARY 2024 jan4 "Pixels."
# https://genuary.art/prompts

$base = 10
$split = 9
$colors = %w(#B6E3FF #54AEFF #0969DA #0A3069)
def setup
  createCanvas($base * $split, $base * $split)
  angleMode(DEGREES)
  background(0)
  noLoop
end

def draw
  background(255)
  #d = width / $split
  x = $base
  while x < width do
    y = $base
    while y < height do
      noStroke
      c = rand(0..3)
      fill($colors[c])
      rect(x, y , $base, $base)
      y += $base
    end
    x += $base
  end
end
