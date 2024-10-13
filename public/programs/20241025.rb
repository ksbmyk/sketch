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
      c = (i + j).even? ? "#fe4053" : "#00c5da"
      large_arc(i * @size, j * @size, c)
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
