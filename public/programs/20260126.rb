def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  noLoop
end

def draw
  background(220, 80, 5)
  
  @max_depth = 6
  @noise_scale = 0.005
  
  blendMode(ADD)
  noFill
  
  subdivide(0, 0, width, 0)
end

def subdivide(x, y, size, depth)
  # Perlinノイズで再帰を続けるか決定
  noise_val = noise(x * @noise_scale, y * @noise_scale)
  
  # ノイズ値が高いほど深く再帰する傾向
  threshold = depth.to_f / @max_depth
  
  if depth >= @max_depth || noise_val < threshold
    # 対角線を描画（ノイズ値で向きを決定）
    draw_diagonal(x, y, size, noise_val)
  else
    # 4分割して再帰
    half = size / 2.0
    subdivide(x, y, half, depth + 1)
    subdivide(x + half, y, half, depth + 1)
    subdivide(x, y + half, half, depth + 1)
    subdivide(x + half, y + half, half, depth + 1)
  end
end

def draw_diagonal(x, y, size, noise_val)
  direction_noise = noise(x * @noise_scale * 3, y * @noise_scale * 3)

  layers = [
    [8, 10],
    [4, 20],
    [2, 40],
    [1, 80]
  ]

  layers.each do |weight, alpha|
    stroke(200, 70, 90, alpha)
    strokeWeight(weight)

    if direction_noise > 0.5
      line(x, y, x + size, y + size)
    else
      line(x + size, y, x, y + size)
    end
  end
end
