# #minacoding 2024 June 2 "Color"
# https://minacoding.online/theme

def setup
  createCanvas(500, 500)
  colorMode(HSB, 360, 100, 100)
  noLoop
end

def draw
  background(255)

  wave_height = 50
  freq = 0.02
  rate = 1
  amp = 100

  height.to_i.times do |y|
    hue = map(y, 0, height, 170, 230)
    stroke(hue, 60, 100)
    noFill

    beginShape
    width.to_i.times do |x|
      wave_y = y + sin(x * freq + y * rate) * amp # 波 sin⁡(𝑎𝑥+𝑏𝑦)×𝑐sin(ax+by)×c
      vertex(x, wave_y)
    end
    endShape
  end
end
