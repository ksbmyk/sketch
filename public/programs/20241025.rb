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
      #double_arc_blue(i*@size, j*@size)
      triangles(i * @size, j * @size)
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
  push
  fill("#aaaaaa")
  rect(x, y, @size)
  size = @size / 2
  margin = 5

  fill("#fe4053")
  arc(x + 1 * size, y + 1 * size, size * 2 -10, size * 2 - margin * 2, 180, 270)
  fill("#00c5da")
  arc(x + 2 * size-margin, y + 1 * size, size * 2 -10, size * 2 - margin * 2, 180, 270)
  arc(x + 1 * size, y + 2 * size - margin, size * 2 -10, size * 2 - margin * 2, 180, 270)
  fill("#fe4053")
  arc(x + 2*size-margin, y + 2 * size-margin, size * 2 -10, size * 2 - margin * 2, 180, 270)
  pop
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

def triangles(x, y)
  fill("#aaaaaa")
  rect(x, y, @size)
  size = @size / 3
  fill("#fe4053")
  rect(x, y, size * 2)
  fill("#000000")
  triangle(x, y + size * 2, x, y + size * 3, x + size, y + size * 2)
  fill("#ffffff")
  triangle(x + size, y + size * 2, x + size, y + size * 3, x + size * 2, y + size * 2)
  fill("#fe4053")
  triangle(x + size * 2, y + size * 2, x + size * 2, y + size * 3, x + size * 3, y + size * 2)
end
