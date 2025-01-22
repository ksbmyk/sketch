# GENUARY 2025 jan20 "Generative Architecture."
# https://genuary.art/prompts

def setup
  @buildings = []
  grid_size = 50
  createCanvas(600, 600)
  cols = width / grid_size
  rows = height / grid_size
  frameRate(0.5)
  noStroke
  
  set_gradient(0, 0, width.to_i, height.to_i, color(50, 50, 150), color(20, 20, 80), 1)

  rows.to_i.times do |y|
    cols.to_i.times do |x|
      building = {
        x: x * grid_size,
        y: height - (y * grid_size),
        width: rand(grid_size * 0.6..grid_size),
        height: rand(150..350),
        color1: color(rand(50..150), rand(100..200), rand(150..255)),
        color2: color(rand(0..100), rand(50..150), rand(100..200)),
        offset: rand(0..5),
        windows: []
      }

      window_rows = building[:height] / 20
      window_rows.times do |i|
        (building[:width] / 20).floor.times do |j|
          building[:windows] << { x: j * 20 + building[:x] + 5, y: building[:y] - (i + 1) * 20 }
        end
      end

      @buildings << building
    end
  end
end

def draw
  @buildings.each do |b|
    set_gradient(b[:x] + b[:offset], b[:y] - b[:height], b[:width], b[:height], b[:color1], b[:color2], 1)
    rect(b[:x] + b[:offset], b[:y] - b[:height], b[:width], b[:height])

    b[:windows].each do |window|
      if rand < 0.5
        drawingContext.shadowBlur = 20
        drawingContext.shadowColor = color(255, 220, 0, 200)
        fill(255, 220, 0)
        noStroke
        rect(window[:x], window[:y], 15, 15)
        drawingContext.shadowBlur = 0
      end
    end
  end
end

def set_gradient(x, y, w, h, c1, c2, axis)
  noFill
  if axis == 1
    (0..h).each do |i|
      inter = map(i, 0, h, 0, 1)
      c = lerpColor(c1, c2, inter)
      stroke(c)
      line(x, y + i, x + w, y + i)
    end
  end
end