
def setup
  createCanvas(700, 700)
  @square_size = 200
  @spacing = 10
  @scroll_speed = 2

  @total_height = @square_size + @spacing
  @num_rows = (height / @total_height).ceil + 2

  @items = (0...@num_rows).map do |i|
    (0...3).map do |j|
      graphics = createGraphics(@square_size, @square_size)
      create_random_pattern(graphics)
      {
        x: j * (@square_size + @spacing),
        y: i * @total_height,
        graphics: graphics
      }
    end
  end
end

def draw
  background(240)

  @items.each do |row|
    row.each do |square|
      image(square[:graphics], square[:x] + width / 2 - 1.5 * (@square_size + @spacing), square[:y])
      square[:y] -= @scroll_speed # 縦方向にスクロール
    end

    # 画面外に出たら再配置
    if row[0][:y] + @square_size < 0
      new_y = row[0][:y] + @num_rows * @total_height
      row.each do |square|
        square[:y] = new_y
        square[:graphics].clear
        create_random_pattern(square[:graphics]) # 新しい模様を作成
      end
    end
  end
end

# 模様
def create_random_pattern(graphics)
  c = [0, 200, 255].sample
  graphics.background(c)
  graphics.noStroke
  if c == 0
   graphics.blendMode(ADD)
  else
   graphics.blendMode(BLEND)
  end

  # 円
  5.times do
    x = rand(0..graphics.width)
    y = rand(0..graphics.height)
    size = rand(20..50)
    graphics.fill(rand(0..255), rand(0..255), rand(0..255), 150)
    graphics.ellipse(x, y, size, size)
  end

  # 線
  3.times do
    x1 = rand(0..graphics.width)
    y1 = rand(0..graphics.height)
    x2 = rand(0..graphics.width)
    y2 = rand(0..graphics.height)
    graphics.stroke(rand(0..255), rand(0..255), rand(0..255), 200)
    graphics.strokeWeight(rand(1..3))
    graphics.line(x1, y1, x2, y2)
  end

  # 長方形
  3.times do
    x = rand(0..graphics.width)
    y = rand(0..graphics.height)
    w = rand(20..60)
    h = rand(10..30)
    graphics.fill(rand(0..255), rand(0..255), rand(0..255), 180)
    graphics.rect(x, y, w, h)
  end
end
