# GENUARY 2024 jan4 "Pixels."
# https://genuary.art/prompts

$base = 10
$split = 20
$colors = %w(#ffee4a #ffc501 #fe9600 #77477e)
def setup
  createCanvas($base * $split * 3, $base * $split * 3)
  angleMode(DEGREES)
  background(255)
  frameRate(1)
end

def draw
  if frameCount.to_i.odd?
    background(255)

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
    
  else
    background(255)
    push
    translate($base * $split, 0)
    pixel_box
    pop

    push
    translate(0, $base * $split)
    pixel_box
    pop

    push
    translate($base * $split * 2, $base * $split)
    pixel_box
    pop
    
    push
    translate($base * $split, $base * $split * 2)
    pixel_box
    pop
  end
end

def pixel_box
  x = 0
  while x < $base * $split do
    y = 0
    while y < $base * $split do
      noStroke
      c = rand(0..3)
      fill($colors[c])
      rect(x, y , $base, $base)
      y += $base
    end
    x += $base
  end
end
