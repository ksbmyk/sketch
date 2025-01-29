def setup
  createCanvas(700, 700)
  noStroke
  background(240)

  grid_size = 100

  (0..height).step(grid_size) do |y|
    (0..width).step(grid_size) do |x|
      draw_pattern(x, y, grid_size)
    end
  end
end

def draw_pattern(x, y, size)
  colors = [
    color(rand(100..200), rand(150..255), rand(200..255)),
    color(rand(50..150), rand(100..200), rand(150..255)),
    color(rand(200..255), rand(200..255), rand(240..255))
  ]
  
  pattern = rand(0..3)

  case pattern
  when 0
    # 左上と右下の三角形
    fill(colors[0])
    triangle(x, y, x + size, y, x, y + size)
    fill(colors[1])
    triangle(x + size, y, x + size, y + size, x, y + size)
  when 1
    # 右上と左下の三角形
    fill(colors[1])
    triangle(x + size, y, x + size, y + size, x, y)
    fill(colors[2])
    triangle(x, y, x, y + size, x + size, y + size)
  when 2
    # 上下の長方形
    fill(colors[0])
    rect(x, y, size, size / 2)
    fill(colors[2])
    rect(x, y + size / 2, size, size / 2)
  when 3
    # 左右の長方形
    fill(colors[1])
    rect(x, y, size / 2, size)
    fill(colors[0])
    rect(x + size / 2, y, size / 2, size)
  end
end
