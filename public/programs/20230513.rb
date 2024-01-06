# RubyKaigi 2023 https://rubykaigi.org/2023/ のロゴ design by attsumi

def setup
  @side = 80
  @split = 9
  @colors = %w(#ba083d #444444 #a9a7ad)
  createCanvas(@side * @split, @side * @split)
  angleMode(DEGREES)
  rectMode(CENTER)
  noStroke
  noLoop
end

def draw
  background(255)
  x = 0
  while x < width do
    y = 0
    while y < width do
      r = rand(0..4)
      case r
      when 0
        fill_pale_color(@colors[0])
        ellipse(x + @side / 2 , y + @side / 2, @side, @side)
      when 1
        fill_pale_color(@colors[rand(1..2)])
        arc(x, y, @side * 2, @side * 2, 0, 90)
      when 2
        fill_pale_color(@colors[rand(1..2)])
        push
        translate(0, @side)
        arc(x, y, @side * 2, @side * 2, 270, 360)
        pop
      when 3
        fill_pale_color(@colors[rand(1..2)])
        push
        translate(@side, 0)
        arc(x, y, @side * 2, @side * 2, 90, 180)
        pop
      when 4
        fill_pale_color(@colors[rand(1..2)])
        push
        translate(@side, @side)
        arc(x, y, @side * 2, @side * 2, 180, 270)
        pop
      end
      y += @side
    end
    x += @side
  end
  fill(255)
  rect(width / 2, width / 2, @side * 3, @side * 3)
  ruby_kaigi_logo
end

def ruby_kaigi_logo
  fill(@colors[0])
  x = width / 2
  y = width / 2
  ellipse(x, y, @side, @side)
  ellipse(x - @side, y + @side, @side, @side)

  fill(@colors[1])
  arc(x - @side / 2, y -  @side / 2, @side * 2, @side * 2, 90, 270)
  arc(x + @side / 2, y +  @side / 2, @side * 2, @side * 2, 270, 90)

  fill(@colors[2])
  arc(x - @side / 2 + @side, y - @side / 2 - @side, @side * 2, @side * 2, 90, 180)
  arc(x + @side / 2, y - @side / 2, @side * 2, @side * 2, 270, 360)
  arc(x - @side / 2, y + @side / 2 + @side, @side * 2, @side * 2, 270, 360)
end

def fill_pale_color(color_code)
  rgba = color(color_code)
  rgba.setAlpha(160)
  fill(rgba)
end

def keyPressed
  redraw
end
