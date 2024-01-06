def setup
  @base = 80
  @colors = %w(#B6E3FF #54AEFF #0969DA #0A3069)
  split = 9
  createCanvas(@base * split, @base * split)
  angleMode(DEGREES)
  background(0)
  noLoop
end

def draw
  background(255)
  half = @base / 2
  double = @base * 2
  x = half
  while x < width do
    y = half
    while y < width do
      noStroke
      c = rand(0..3)
      fill(@colors[c])
      ellipse(x, y, @base, @base)
      arc(x - half, y - half, double, double, 0, 90)

      #白い線(ハイライト)を入れる
      stroke(255)
      strokeWeight(5)
      noFill
      arc(x - half, y - half, double - 20, double - 20, 0, 15)
      arc(x - half, y - half, double - 20, double - 20, 81, 83)
      arc(x , y , @base - 20, @base  - 20, 10, 80)

      y += @base
    end
    x += @base
  end
end
