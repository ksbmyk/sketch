# GENUARY 2024 jan3 "Droste effect."
# https://genuary.art/prompts

$side = 80
$split = 9
$count = 0
def setup
  createCanvas($side * $split, $side * $split)
  rectMode(CENTER)
  background(0)
  frameRate(3)
end

def draw
	stroke(255)
    noFill
	square(($side * $split) / 2, ($side * $split) / 2, $side * $count)
	
  if $count == $split -1
  	$count = 0
    noStroke
    fill(0)
    square(($side * $split) /2, ($side * $split) /2, $side * $split)
  else
    $count += 1
  end
end
