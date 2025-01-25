def setup
  createCanvas(600, 600)
  colorMode(HSB, 360, 100, 100)
  background(0)
  strokeWeight(2)
  noFill

  @step_size = 20
  @hue = 0
  
  @points = []
  @points << createVector(width / 2, height / 2)
end

def draw
  current = @points.last
  angle = rand(0..TWO_PI)
  next_point = createVector(current.x + sin(angle) * @step_size, current.y + cos(angle) * @step_size)

  if next_point.x.between?(0, width) && next_point.y.between?(0, height)
    @points << next_point

    stroke(@hue, 100, 100)
    @hue = (@hue + 2) % 360

    line(current.x, current.y, next_point.x, next_point.y)
  end

  noLoop if @points.size > 1500
end
