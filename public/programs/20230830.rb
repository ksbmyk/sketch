def setup
  @side = 80
  split = 9
  #ブルーナカラー
  @colors = %w(#eb6100 #004c97 #15722c #fccc00)
  createCanvas(@side * split, @side * split)
  background(255)
end

def draw
  noLoop
  noStroke
  x = 0
  while x < width do
    y = 0
    while y < width do
      fill(@colors[rand(0..@colors.length - 1)])
      ellipse(x + @side/2 , y + @side/2, @side, @side)
      y += @side
    end
    x += @side
  end
end
