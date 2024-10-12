def setup
  angleMode(DEGREES)
  @size = 100
  @num = 5
  createCanvas(@size * @num, @size * @num)
  noLoop
end

def draw
  noStroke
  @num.times do |i|
    @num.times do |j|
      c = (i + j).even? ? "#fe4053" : "#00c5da"
      fill(c)
      rect(i * @size, j * @size, @size)

      large_arc(i * @size + @size, j * @size + @size)
    end
  end
end

def large_arc(x, y)
  fill("#ffffff")
  arc(x, y, @size * 2, @size * 2, 180, 270)
end
