def setup
  angleMode(DEGREES)
  @size = 100
  @num = 5
  createCanvas(@size * @num, @size * @num)
  # background("#aaaaaa")
  noLoop
end

def draw
  noStroke
  @num.times do |i|
    @num.times do |j|
      #dot_arc(i * @size, j * @size)
      #small_arc(i*@size, j*@size)
      #double_arc_red(i*@size, j*@size)
      double_arc_blue(i*@size, j*@size)
    end
  end
end

def dot_arc(x, y)
  fill("#00c5da")
  rect(x, y, @size)

  fill("#ffffff")
  arc(x + @size, y + @size, @size * 2, @size * 2, 180, 270)

  cols = 8
  rows = 8
  max_diameter = 15
  spacing = 15

  # 水玉
  rows.times do |i|
    cols.times do |j|
      diameter = max_diameter * (1 - i.to_f / cols)
      pos_x = i * spacing + spacing / 2
      pos_y = j * spacing + (i.even? ? spacing / 2 : 0)
      fill("#00c5da")
      ellipse(x + pos_x, y + pos_y + 8, diameter, diameter)
    end
  end

  blendMode(OVERLAY)
  fill("#000000")
  # 黒にするために重ねる
  3.times do
    arc(x + @size, y + @size, @size * 2, @size * 2, 180, 270)
  end

  blendMode(BLEND)
end

def small_arc(x, y)
  size = @size/2
  2.times do |i|
    2.times do |j|
      c = (i + j).even? ? "#fe4053" : "#00c5da"
      fill(c)
      push
      translate(size, size)
      arc(x + i*size, y + j*size, size * 2, size * 2, 180, 270)
      pop
    end
  end
end

def double_arc_red(x, y)
  fill("#fe4053")
  rect(x, y, @size)
  fill("#ffffff")
  arc(x + @size, y, @size * 2, @size * 2, 90, 180)
  fill("#fe4053")
  arc(x + @size, y, @size * 2 - @size * 0.35, @size * 2 - @size * 0.35, 90, 180)
  fill("#aaaaaa")
  arc(x + @size, y, @size * 2 - @size * 0.5, @size * 2 - @size * 0.5, 90, 180)
  fill("#fe4053")
  arc(x + @size, y, @size * 2 - @size * 0.85, @size * 2 - @size * 0.85, 90, 180)
end

def double_arc_blue(x, y)
  fill("#00c5da")
  rect(x, y, @size)
  fill("#ffffff")
  arc(x, y, @size * 2, @size * 2, 0, 90)
  fill("#00c5da")
  arc(x, y, @size * 2 - @size * 0.35, @size * 2 - @size * 0.35, 0, 90)
  fill("#aaaaaa")
  arc(x, y, @size * 2 - @size * 0.5, @size * 2 - @size * 0.5, 0, 90)
  fill("#00c5da")
  arc(x, y, @size * 2 - @size * 0.85, @size * 2 - @size * 0.85, 0, 90)
end
