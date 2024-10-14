def setup
  angleMode(DEGREES)
  @size = 100
  @num = 6
  createCanvas(@size * @num, @size * @num)
  noLoop
end

def draw
  noStroke
  @num.times do |i|
    @num.times do |j|
      pattern_type = (i + j) % 5 + 1
      if j.even?
        # 偶数行
        case pattern_type
        when 1
          dot_arc(i * @size, j * @size)
        when 2
          patterned_arcs(i * @size, j * @size)
        when 3
          layered_arc(i * @size, j * @size, 90, :top_right, :red)
        when 4
          layered_arc(i * @size, j * @size, 0, :top_left, :blue)
        when 5
          patterned_triangles(i * @size, j * @size, :top)
        end
      else
        # 奇数行
        case pattern_type
        when 1
          dot_arc_reverse(i * @size, j * @size)
        when 2
          patterned_triangles(i * @size, j * @size, :bottom)
        when 3
          layered_arc(i * @size, j * @size, 180, :bottom_right, :blue)
        when 4
          layered_arc(i * @size, j * @size, 270, :bottom_left, :red)
        when 5
          patterned_arcs(i * @size, j * @size)
        end
      end
    end
  end
end

def dot_arc(x, y)
  fill("#00c5da")
  rect(x, y, @size)

  fill("#ffffff")
  arc(x + @size, y + @size, @size * 2, @size * 2, 180, 270)

  # ドット
  cols = 8
  rows = 8
  max_diameter = 15
  spacing = 15

  # 右にいくほど小さなドットにする
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

def dot_arc_reverse(x, y)
  fill("#00c5da")
  rect(x, y, @size)

  fill("#ffffff")
  arc(x, y + @size, @size * 2, @size * 2, 270, 0)

  # ドット
  cols = 8
  rows = 8
  max_diameter = 15
  spacing = 15

  # 下にいくほど小さなドットにする
  rows.times do |i|
    cols.times do |j|
      diameter = max_diameter * (1 - i.to_f / rows)
      pos_x = j * spacing + spacing / 2
      # 並びを違い違いにする
      pos_y = i * spacing + (j.even? ? spacing / 2 : 0)
      fill("#00c5da")
      ellipse(x + pos_x, y + pos_y + 8, diameter, diameter)
    end
  end

  blendMode(OVERLAY)
  fill("#000000")
  # 黒にするために重ねる
  3.times do
    arc(x, y + @size, @size * 2, @size * 2, 270, 0)
  end

  blendMode(BLEND)
end

def patterned_arcs(x, y)
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

def layered_arc(x, y, start_angle, position, color)
  color_code = case color
  when :red
    "#fe4053"
  when :blue
    "#00c5da"
  end

  fill(color_code)
  rect(x, y, @size)

  fill("#ffffff")
  case position
  when :top_right
    arc(x + @size, y, @size * 2, @size * 2, start_angle, start_angle + 90)
    arc_x = x + @size
    arc_y = y
  when :bottom_left
    arc(x, y + @size, @size * 2, @size * 2, start_angle, start_angle + 90)
    arc_x = x
    arc_y = y + @size
  when :top_left
    arc(x, y, @size * 2, @size * 2, start_angle, start_angle + 90)
    arc_x = x
    arc_y = y
  when :bottom_right
    arc(x + @size, y + @size, @size * 2, @size * 2, start_angle, start_angle + 90)
    arc_x = x + @size
    arc_y = y + @size
  end

  # 大きな円弧の上に小さな円弧を重ね差分を線に見せる
  fill(color_code)
  arc(arc_x, arc_y, @size * 2 - @size * 0.35, @size * 2 - @size * 0.35, start_angle, start_angle + 90)
  fill("#aaaaaa")
  arc(arc_x, arc_y, @size * 2 - @size * 0.5, @size * 2 - @size * 0.5, start_angle, start_angle + 90)
  fill(color_code)
  arc(arc_x, arc_y, @size * 2 - @size * 0.85, @size * 2 - @size * 0.85, start_angle, start_angle + 90)
end

def patterned_triangles(x, y, position)
  fill("#aaaaaa")
  rect(x, y, @size)
  size = @size / 3

  case position
  when :top
    fill("#fe4053")
    rect(x + size, y + size, size * 2)
    fill("#fe4053")
    triangle(x, y + size, x + size, y, x + size, y + size)
    fill("#ffffff")
    triangle(x + size, y + size, x + size * 2, y, x + size * 2, y + size)
    fill("#000000")
    triangle(x + size * 2, y + size, x + size * 3, y, x + size * 3, y + size)
  when :bottom
    fill("#fe4053")
    rect(x, y, size * 2)
    fill("#000000")
    triangle(x, y + size * 2, x, y + size * 3, x + size, y + size * 2)
    fill("#ffffff")
    triangle(x + size, y + size * 2, x + size, y + size * 3, x + size * 2, y + size * 2)
    fill("#fe4053")
    triangle(x + size * 2, y + size * 2, x + size * 2, y + size * 3, x + size * 3, y + size * 2)
  end
end
