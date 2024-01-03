# GENUARY 2024 jan3 "Droste effect."
# https://genuary.art/prompts

$side = 80
$split = 9
def setup
  createCanvas($side * $split, $side * $split)
  rectMode(CENTER)
  background(255)
  noLoop
end

def draw
  noFill
  (1...$split).each do |i|
  	square(($side * $split) /2, ($side * $split) /2, $side * i)
  end
end
