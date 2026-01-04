def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  noStroke
  @time = 0.0
end

def draw
  background(0)

  @time += 0.02

  # 解像度の周期的変化（ピクセルサイズ: 5〜50）
  pixel_size = map(sin(@time * 0.3), -1, 1, 5, 50).to_i
  pixel_size = [pixel_size, 2].max

  a = 3
  b = 4
  phase = @time  # 位相が時間で変化

  margin = 70                                 # 画面端からの余白
  amplitude = width / 2 - margin              # 振幅
  center_x = width / 2
  center_y = height / 2
  angle_step = 0.5                            # 角度の刻み（度）
  num_points = (360 / angle_step).to_i + 1    # 点の数

  # 曲線上の点を収集し、ピクセルグリッドに量子化
  pixels_to_draw = {}

  num_points.times do |i|
    angle = radians(i * angle_step)
    x = center_x + amplitude * sin(a * angle + phase)
    y = center_y + amplitude * sin(b * angle)

    # ピクセルグリッドにスナップ
    px = (x / pixel_size).floor * pixel_size
    py = (y / pixel_size).floor * pixel_size

    key = "#{px},#{py}"
    pixels_to_draw[key] ||= { x: px, y: py, count: 0 }
    pixels_to_draw[key][:count] += 1
  end

  # ピクセルを描画
  pixels_to_draw.each_value do |pixel|
    brightness = map([pixel[:count], 10].min, 1, 10, 50, 100)
    fill(190, 80, brightness)
    rect(pixel[:x], pixel[:y], pixel_size - 1, pixel_size - 1)
  end
end