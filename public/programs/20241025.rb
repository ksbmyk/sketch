def setup
  angleMode(DEGREES)
  @size = 100
  @num = 5
  createCanvas(@size * @num, @size * @num)
  background("#aaaaaa")
  noLoop
end

def draw
  noStroke
  @num.times do |i|
    @num.times do |j|
      large_arc(i * @size, j * @size, "#ffffff")
      small_arc(i*@size, j*@size)
    end
  end
end

def large_arc(x, y, color)
  fill(color)
  push
  translate(@size, @size)
  arc(x, y, @size * 2, @size * 2, 180, 270)
  pop
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
