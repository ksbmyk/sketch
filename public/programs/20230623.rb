# refs https://editor.p5js.org/techty/sketches/HUs2dx-vF

$tile_count = 100
$noise_scale = 0.02

def setup
  createCanvas(700, 700)
  angleMode(DEGREES) # 角度を使わないかもしれないが
  background('#6EAAFF')
  noStroke
  noLoop
end

def draw
  draw_tile
  draw_ellipse
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
    r1 = rand(10..20)
    r2 = rand(1..10)
    ellipse(r1 * 10, r1 * 10,  r2 * 100, r2 * 100)
  end
end


