# GENUARY 2024 jan5 In the style of Vera Molnár (1924-2023).
# https://genuary.art/prompts

$side = 60
$split = 12

def setup
  createCanvas($side * $split + 20 , $side * $split + 20)
  colorMode(HSB, 360, 100, 100, 100)
  background(0,0,100)
end

def draw
  translate(10, 10)
  noLoop
  noStroke
  count = 0
  x = 0
  while x < width - $side do
    y = 0
    while y < height - $side do
      if count.odd?
        fill(270, 55, 100, 70)
      else
        fill(208, 67, 100, 70)
      end
      rect(x + rand(-4..5), y + rand(-5..10), $side - 10, $side - 3)
      y += $side
    end
    x += $side
    count += 1
  end
end
