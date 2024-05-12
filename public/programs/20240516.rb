def setup
  size = min(windowWidth, 1000)
  createCanvas(size, size)
  @base = width / 10
  @sky_patterns = [
    [color(105, 179, 256), color(255, 255, 255)],
    [color(5, 29, 191), color(105, 179, 255)],
    [color(0, 31, 114), color(183, 255, 251)]
  ]
  angleMode(DEGREES)
  background("gray")
  noLoop
end

def draw
  sea
  sky
  frame
  ruby
end

def sea
  noStroke
  drawingContext.shadowColor = color(255)
  drawingContext.shadowBlur = 50

  x_value = width / 100
  y_value = height / 15
  freq = map(100, 0, width, 1, 5)
  vel = map(200, 0, height, 1, 50)

  (height/10 * 3..height/10 * 8).step(y_value) do |y|
	 if y < height/10 * 7
      fill(0, random(100, 150), random(200, 250))
    else
      fill(220, 221, 178)
    end
    beginShape()

    (0..width).step(x_value) do |x|
      a = 200
      b = sin((y + x + a) * freq) * vel
      vertex(x, b + y)
    end
    vertex(width, height)
    vertex(0, height)
    endShape(CLOSE)
  end
end

def frame
  # TODO フレームの色パターン追加
  # フレーム
  drawingContext.shadowColor = 'transparent'
  drawingContext.shadowBlur = 0
  stroke(0)
  rect_size = 80
  rect_weight = 2
  strokeWeight(rect_weight)

  fill("#9cee60")
  rect(rect_weight, rect_weight, width, rect_size)
  rect(width - rect_weight - rect_size , rect_weight, rect_size, height)
  rect(rect_weight, height - rect_weight - rect_size, width, rect_size)
  rect(rect_weight, rect_weight, rect_size, height)

  fill("#4b92f7")
  rect(rect_weight, rect_weight, rect_size)
  rect(width - rect_weight - rect_size , rect_weight, rect_size)
  rect(rect_weight, height - rect_weight - rect_size, rect_size)
  rect(width - rect_weight - rect_size , height - rect_weight - rect_size, rect_size)
end

def sky
  drawingContext.shadowColor = 'transparent'
  drawingContext.shadowBlur = 10
  p = @sky_patterns.sample

  noFill
  (0..@base*4).step do |i|
    inter = map(i, 0, @base*4, 0, 1)
    c = lerpColor(p[0], p[1], inter)
    stroke(c)
    line(0, i, width, i)
  end

  cloud(@base * 2, height / 10 * 2, @base)
  cloud(@base * 5, height / 10 * 3, @base)
  cloud(@base * 8, height / 10 * 1.5, @base)
end

def cloud(x, y, s)
  noStroke
  fill(255)
  drawingContext.shadowColor = color(255)
  drawingContext.shadowBlur = 10

  ellipse(x,    y,    s-20, 20)
  ellipse(x+10, y+10, s,    20)
  ellipse(x-10, y+20, s-0,  20)
end

def ruby
  translate(@base * 5, @base * 7.5)
  r = rand(-90..90)
  rotate(r)
  scale(0.25)

  drawingContext.shadowColor = color(255)
  drawingContext.shadowBlur = 50

  stroke(255)
  fill("#ec6158")
  x = rand (-width..width)
  y = rand(-@base * 3..@base * 6)
  puts ("x:" + x.to_s + ", y:" + y.to_s + ", r:" + r.to_s )
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
end
