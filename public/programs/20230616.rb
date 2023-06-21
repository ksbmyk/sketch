# ref https://techty.hatenablog.com/entry/2019/05/29/194903

$tile_count = 100
$noise_scale = 0.02

def setup
  createCanvas(700, 700)
  angleMode(DEGREES)
  background('#6EAAFF')
  noStroke
  noLoop
end

def draw
  draw_tile
  draw_ellipse
  draw_hydrangea

end

def draw_tile
  tile_size = width / $tile_count # tile1つの幅。10分割なら70
  y_noise = 0
  (0...$tile_count).each do |row|
    x_noise = 0
    (0...$tile_count).each do |col|
      x = col * tile_size # 10分割なら座標は0,70,140,210…となる
      y = row * tile_size
      a = noise(x_noise, y_noise) * 255 # 指定した座標のパーリンノイズ値を取得(0〜1)、255を乗じて透明度（アルファ値）にする
      noStroke
      c = color(255, a) # color(gray, [alpha])
      fill(c)
      rect(x, y, tile_size, tile_size)
      x_noise += $noise_scale
    end
    y_noise += $noise_scale
  end
end

def draw_ellipse
  stroke('#F0F8FF')
  noFill
  10.times do
    random_number1 = rand(10..20)
    random_number2 = rand(1..10)
    ellipse(random_number1 * 10, random_number1 * 10,  random_number2 * 100, random_number2 * 100)
  end
end

def draw_hydrangea
  rounded_rect_size = 12
  corner_radius = 3
  rectMode(CENTER)
  colors = %w(#9093E0 #9093E0 #9093E0)
  (0..2).each do | i |
    fill(colors[i])
    noStroke
    push
    translate(width / 2, height / 2)
    rotate(rand(1..3) * 15)
    x = rand(-3..2) * 100
    y = rand(-3..2) * 100
    rect(x, y, rounded_rect_size, rounded_rect_size, corner_radius)
    rect(x + rounded_rect_size, y, rounded_rect_size, rounded_rect_size, corner_radius)
    rect(x, y + rounded_rect_size, rounded_rect_size, rounded_rect_size, corner_radius)
    rect(x + rounded_rect_size, y + rounded_rect_size, rounded_rect_size, rounded_rect_size, corner_radius)
    pop
  end
end
