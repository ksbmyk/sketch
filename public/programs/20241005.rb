# YAPC::Hakodate 2024 https://yapcjapan.org/2024hakodate/ design by @nagayama

def setup
  createCanvas(400, 400)

  rectMode(CENTER)
  frameRate(10)
  background("#004b6d")
  @grid_size = 20
  @x = @grid_size / 2
  @y = @grid_size / 2
  @rect_color = "#0174a9"
end

def draw
  fill(@rect_color)
  noStroke()
  push
  translate(@x, @y)
  
  if rand < 0.5
    rotate(PI / 4)
  else
    rotate(-PI / 4)
  end
  rect(0, 0, @grid_size * 1.7, 7)
  pop
  
  @x += @grid_size
  if @x >= width
    @x = @grid_size / 2
    @y += @grid_size
  end
  
  if @y >= height
    noLoop
  end
end
