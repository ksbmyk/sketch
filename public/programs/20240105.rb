# GENUARY 2024 jan5 In the style of Vera Molnár (1924-2023).
# https://genuary.art/prompts

$side = 80
$split = 9

def setup
  createCanvas($side * $split, $side * $split)
  background(255)
end

def draw
  noLoop
  noStroke
  x = 0
  while x < width - $side do
    y = 0
    while y < width - $side do
      fill("#54AEFF")
      #noise(x_noise, y_noise) * 255
      rect(noise(x), noise(y), $side - 10)
      y += $side
    end
    x += $side
  end
end
