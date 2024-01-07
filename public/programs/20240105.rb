# GENUARY 2024 jan5 "In the style of Vera Molnár (1924-2023)."
# https://genuary.art/prompts

def setup
  @base = 60
  split = 12
  createCanvas(@base * split + 20 , @base * split + 20)
  colorMode(HSB, 360, 100, 100, 100)
  background(0,0,100)
end

def draw
  translate(10, 10)
  noLoop
  noStroke
  count = 0
  x = 0
  while x < width - @base do
    y = 0
    while y < height - @base do
      if count.odd?
        fill(270, 55, 100, 70)
      else
        fill(208, 67, 100, 70)
      end
      rect(x + rand(-4..5), y + rand(-5..10), @base - 10, @base - 3)
      y += @base
    end
    x += @base
    count += 1
  end
end
