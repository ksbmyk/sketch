def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100)
  angleMode(DEGREES)
  background(0)
  frameRate(30)
end

def draw
  noLoop
  noStroke
  fill(0, 5)

  50.times do
    ran = rand(1..10)
    x = rand(50..650)
    y = rand(50..650)
    if ran.even?
      firework(x, y)
    elsif ran % 3 == 0
      small_firework(x, y)
    else
      big_firework(x, y)
    end
  end
end

def big_firework(x, y)
  stroke_change(rand(360))
  center_point(x, y, 15)
  raund_poit(x, y, 105, 15, 5)
  stroke_w = 3
  (50..64).step(1) do |i|
    raund_poit(x, y, i, 15, stroke_w)
    stroke_w += 0.5
  end

  stroke_change(rand(360))
  raund_poit(x, y, 20, 45, 5)
  raund_poit(x, y, 40, 15, 5)
  raund_poit(x, y, 85, 15, 10)
  raund_poit(x, y, 120, 30, 3)
end

def small_firework(x, y)
  stroke_change(rand(360))
  center_point(x, y, 10)
  raund_poit(x, y, 53, 30, 2)
  stroke_w = 1
  (27..37).step(0.5) do |i|
    raund_poit(x, y, i, 15, stroke_w)
    stroke_w += 0.2
  end

  stroke_change(rand(360))
  raund_poit(x, y, 10, 45, 2)
  raund_poit(x, y, 20, 15, 2)
  raund_poit(x, y, 45, 15, 4.5)
  raund_poit(x, y, 53, 15, 1)
end

def firework(x, y)
  stroke_change(rand(360))
  center_point(x, y, 1)
  raund_poit(x, y, 5, 30, 1)
  raund_poit(x, y, 10, 30, 1)
  raund_poit(x, y, 15, 30, 1.5)
  raund_poit(x, y, 25, 45, 2)
  raund_poit(x, y, 35, 45, 5)
end

def center_point(x, y, stroke_w)
  strokeWeight(stroke_w)
  point(x, y)
end
def raund_poit(x, y, size, increase, stroke_w)
  strokeWeight(stroke_w)
  (0..359).step(increase) do |a|
    point(x + size * cos(a), y + size * sin(a))
  end
end

def stroke_change(hue)
  stroke(hue, 100, 100)
end
