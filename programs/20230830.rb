def setup
  #ブルーナカラーイメージ
  @colors = ["#eb6100", "#004c97", "#15722c", "#fccc00"]
  @side = 80
  split = 9
  createCanvas(@side * split, @side * split)
  background(255)
  noLoop
  noStroke
end

def draw
  x = 0
  while x < width do
    y = 0
    while y < width do
      fill(@colors.sample)
      ellipse(x + @side/2 , y + @side/2, @side, @side)
      y += @side
    end
    x += @side
  end
end
