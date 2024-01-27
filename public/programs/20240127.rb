# GENUARY 2024 jan27 "Code for one hour. At the one hour mark, you’re done."
# https://genuary.art/prompts

def setup
  @size = 40
  createCanvas(720, 720)
  background(30, rand(30..50), rand(50..80))
  noLoop
  @flock = []
  100.times do
    angle = random(0, TWO_PI)
    distance = random(0, 80)
    x = distance * cos(angle)
    y = distance * sin(angle)
    @flock << createVector(x, y)
  end
end
  
def draw
  noStroke
  1000.times do
    c = color(40, rand(30..50), rand(80..100))
  	draw_object(rand(0..width), rand(0..height), c)
  end
  
  800.times do
    c = color(100, rand(150..180), rand(230..250))
  	draw_object(rand(0..width), rand(height / 3 * 2..height), c)
  end

  translate(width / 4*3, height / 5)
  @flock.each do |flock|
	c = color(rand(200..250), rand(200..250), rand(0..100))
    fill(c)
    draw_object(flock.x, flock.y, c)
  end
  
  @flock.each do |flock|
	  c = color(rand(200..250), rand(200..250), rand(0..100), 80)
    fill(c)
    draw_object(flock.x, flock.y + 500, c)
  end
end

def draw_object(x, y, c)
  fill(c)
  ellipse(x, y, @size, @size)
  ellipse(x-10, y+10, @size, @size)
end