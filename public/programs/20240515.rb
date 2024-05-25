# RubyKaigi 2024 logo https://rubykaigi.org/2024/ design by mmito1224

def setup
  createCanvas(400, 400)
  background("#fced4f")
  frameRate(5)
end

def draw
  translate(width / 2, height / 2)
  rotate(HALF_PI - frameCount)
  draw_frame
  draw_minsa
  draw_ruby
end

def draw_frame
  strokeWeight(3)
  fill("#9cee60")
  ellipse(0, 0, 280)
  fill(255)
  ellipse(0, 0, 250)
  fill("#9cee60")
  ellipse(0, 0, 190)
  fill(255)
  ellipse(0, 0, 170)
end

def draw_minsa
  noStroke
  fill(0)
  rect_count = 10 #四角形の数

  3.times do |t|
    radius = 100 + 10 * t # 円の半径
    interval_angle = TWO_PI / rect_count # 各四角形の間隔の角度

    # 円周に沿って四角を並べる
    rect_count.times do |i|
      angle = i * interval_angle # 四角形の角度
      x = radius * cos(angle)
      y = radius * sin(angle)
      push
      translate(x, y)
      rotate(angle) # 四角形を円周に沿って回転
      rectMode(CENTER)

      if t.even?
        if i.odd?
          rect(0, 0, 10, 10)
        else
          rect(0, 0 - 10, 10, 10)
          rect(0, 0 + 10, 10, 10)
        end
      else
        if i.even?
          rect(0, 0, 10, 10)
        else
          rect(0, 0 - 10, 10, 10)
          rect(0, 0 + 10, 10, 10)
        end
      end
      pop
    end
  end
end

def draw_ruby
  stroke(0)
  fill("#ec6158")
  rotate(TWO_PI + frameCount)
  beginShape()
  vertex(-45, 45)
  vertex(-45, -45)
  vertex(-10, -70)
  vertex(65, 0)
  vertex(-10, 70)
  endShape(CLOSE)

  line(-45, 45, -10, 25)
  line(-45, 0, -10, 25)
  line(-45, 0, -10, -25)
  line(-45, -45, -10, -25)
  line(-10, 70, -10, -70)
  line(-10, 25, 65, 0)
  line(-10, -25, 65, 0)
end
