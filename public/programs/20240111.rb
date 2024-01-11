# GENUARY 2024 jan11 "In the style of Anni Albers (1899-1994)."
# https://genuary.art/prompts

def setup
  @side = 80
  @split = 9
  @colors = %w(#f8efce #827e27 #797f8b #f6ed6a #79837b #676f71)
  createCanvas(@side * @split, @side * @split)
  noStroke
  noLoop
end

def draw
  background(255)
  x = 0
  while x < width do
    y = 0
    while y < width do
      r = rand(0..5)
      case r
      when 0
        fill(@colors[0])
        rect(x, y, @side)
      when 1
        fill(@colors[1])
        rect(x, y, @side)
        r = rand(0..1)
        if r == 1
          fill(0)
          rect(x, y+20, @side, 10)
          rect(x, y+50, @side, 10)
        end
      when 2
        fill(@colors[2])
        rect(x, y, @side)
        r = rand(0..1)
        if r == 1
          fill(@colors[1])
          rect(x, y+20, @side, 10)
          rect(x, y+50, @side, 10)
        end
      when 3
        fill(@colors[3])
        rect(x, y, @side)
      when 4
        fill(@colors[4])
        rect(x, y, @side)
​
        fill(0)
        rect(x, y+20, @side, 10)
        rect(x, y+50, @side, 10)
      when 5
        fill(@colors[5])
        rect(x, y, @side)
      end
      y += @side
    end
    x += @side
  end
end
​