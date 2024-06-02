# #minacoding 2024 June 2 "Color"
# https://minacoding.online/theme

def setup
  createCanvas(500, 500)
  noLoop
end

def draw
  background(255)

  wave_height = 50
  freq = 0.02
  rate = 1
  amp = 100

  (0..width).step do |y|
    r = map(y, 0, height, 100, 0)
    g = map(y, 0, height, 0, 255)
    b = 255

    stroke(r, g, b)
    noFill

    beginShape
    (0..height).step do |x|
      wave_y = y + sin(x * freq + y * rate) * amp # 波 sin⁡(𝑎𝑥+𝑏𝑦)×𝑐sin(ax+by)×c
      vertex(x, wave_y)
    end
    endShape
  end
end
