def setup
  size = min(windowWidth, 1000)
  createCanvas(size, size)
  @base = width / 10
  angleMode(DEGREES)
  noLoop
end

def draw
  sea
  sky
  ruby
  frame
end

def sea
  noStroke
  drawingContext.shadowColor = color(255)
  drawingContext.shadowBlur = 50

  x_value = @base * 0.1 #width / 100
  y_value = @base * 0.7 #height / 15
  freq = map(@base, 0, width, 1,  @base * 0.05)
  vel = map(@base * 2, 0, height, 1, @base * 0.5)

  (@base * 3..@base * 8).step(y_value) do |y|
    if y < @base * 7
      fill(0, rand(100..150), rand(200..255))
    else
      fill(220, 221, 178)
    end
    beginShape()

    (0..width).step(x_value) do |x|
      a = @base
      b = sin((y + x + a) * freq) * vel
      vertex(x, b + y)
    end
    vertex(width, height)
    vertex(0, height)
    endShape(CLOSE)
  end
end

def frame
  patterns = [
    ["#9cee60", "#4b92f7"],
    ["#fced4f", "#4b92f7"],
    ["#fced4f", "#9cee60"]
  ]
  p = patterns.sample
  drawingContext.shadowColor = 'transparent'
  drawingContext.shadowBlur = 0
  stroke(0)
  rect_size = @base * 0.8
  rect_weight = 2
  strokeWeight(rect_weight)

  fill(p[0])
  rect(rect_weight, rect_weight, width-rect_weight * 2, rect_size)
  rect(width - rect_weight - rect_size , rect_weight, rect_size, height)
  rect(rect_weight, height - rect_weight - rect_size, width - rect_weight * 2, rect_size)
  rect(rect_weight, rect_weight, rect_size, height)

  fill(p[1])
  rect(rect_weight, rect_weight, rect_size)
  rect(width - rect_weight - rect_size, rect_weight, rect_size)
  rect(rect_weight, height - rect_weight - rect_size, rect_size)
  rect(width - rect_weight - rect_size, height - rect_weight - rect_size, rect_size)
end

def sky
  drawingContext.shadowColor = 'transparent'
  drawingContext.shadowBlur = 10

  r = rand(0..100)
  case r
  when 0..80
    sky_patterns = [
      [color(105, 179, 256), color(255, 255, 255)],
      [color(5, 29, 191), color(105, 179, 255)],
      [color(0, 31, 114), color(183, 255, 251)]
    ]
    gradation(sky_patterns.sample)

    cloud(@base * rand(1.5..2.5), height / 10 * rand(1.5..2.5), @base * rand(0.7..1.0))
    cloud(@base * rand(4.5..5.5), height / 10 * rand(2.5..3.5), @base * rand(0.5..1.5))
    cloud(@base * rand(7.5..8.5), height / 10 * rand(1.5..2.5), @base * rand(0.8..1.2))
  when 81..90
    hr_patterns = [
      [color(112, 132, 165), color(212, 176, 181)],
      [color(200, 206, 202), color(226, 168, 114)]
    ]
    gradation(hr_patterns.sample)

    first_star(@base * 4)
  else
    night_patterns = [
      [color(5, 22, 55), color(92, 101, 139)],
      [color(6, 7, 14), color(76, 95, 187)]
    ]
    gradation(night_patterns.sample)
    stars(@base * 4)
  end
end

def gradation(pattern)
  noFill
  (0..@base * 4).step do |i|
    inter = map(i, 0, @base * 4, 0, 1)
    c = lerpColor(pattern[0], pattern[1], inter)
    stroke(c)
    line(0, i, width, i)
  end
end

def cloud(x, y, s)
  noStroke
  fill(255)
  drawingContext.shadowColor = color(255)
  drawingContext.shadowBlur = 10

  ellipse(x,    y,    s-@base*0.2, rand(18..22))
  ellipse(x+@base*0.1, y+@base*0.1, s,    rand(18..22))
  ellipse(x-@base*0.1, y+@base*0.2, s,    rand(18..22))
end


def first_star(h)
  noStroke
  fill(255, 255, 170)
  drawingContext.shadowColor = color(255)
  drawingContext.shadowBlur = 80
  ellipse(rand(@base..width - @base), rand(@base..h - @base), 5)
end

def stars(h)
  fill(255)
  100.times { ellipse(rand(@base..width - @base), rand(@base..h - 3), 3) }
end

def ruby
  push
  translate(@base * 5, @base * 7.5)
  r = [-45,15,105].sample
  rotate(r)
  scale(0.25)

  drawingContext.shadowColor = color(255)
  drawingContext.shadowBlur = 50

  stroke(255)
  fill("#ec6158")
  case r
  when -45
    x = rand(-@base*4..-@base*3)
    y = rand(-@base*5..@base*3)
  when 15
    x = rand(@base*8..@base*13)
    y = rand(0..@base*2)
  when 105
    x = rand(0..@base*6)
    y = rand(0..@base*6)
  end
  beginShape()
  vertex(x-45, y+45)
  vertex(x-45, y-45)
  vertex(x-10, y-70)
  vertex(x+65, y+0)
  vertex(x-10, y+70)
  endShape(CLOSE)

  line(x-45, y+45, x-10, y+25)
  line(x-45, y+0, x-10, y+25)
  line(x-45, y+0, x-10, y-25)
  line(x-45, y-45, x-10, y-25)
  line(x-10, y+70, x-10, y-70)
  line(x-10, y+25, x+65, y+0)
  line(x-10, y+-25, x+65, y+0)
  pop
end
