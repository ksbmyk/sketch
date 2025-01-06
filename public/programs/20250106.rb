def setup
  createCanvas(700, 700)
  frameRate(10)
end

def draw
  background(0)
  draw_background
  draw_puddle
end

def draw_background
  strokeWeight(4)
  blendMode(ADD)
  (0..height).each do |y|
    if y.odd?
      gradient = map(abs(y - height / 2), 0, height / 2, 255, 0)
      stroke(lerpColor(color(100, 120, 255), color(40, 50, 255), gradient.to_f / 255))
      line(0, y, width, y)
    end
  end
  blendMode(BLEND)
  strokeWeight(1)
  50.times do
    stroke(255, 255, 255, rand(100..200))
    x_point = rand(0..height)
    y_start = rand(10..height)
    length = rand(0..100)
    line(x_point, y_start, x_point, y_start + length)
  end
end

def draw_puddle
  fill(255, 50)
  ellipse(200, 700 + rand(1..5), 200, 30)
  ellipse(200, 700 + rand(1..5), 300, 50)
  ellipse(200, 700 + rand(1..5), 400, 100)
  
  ellipse(500, 670 + rand(1..5), 200, 10)
  ellipse(500, 670 + rand(1..5), 500, 50)
  ellipse(500, 670 + rand(1..5), 550, 100)
end
