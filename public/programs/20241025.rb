def setup
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
    end
  end
end
