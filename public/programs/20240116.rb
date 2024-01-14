def setup
    createCanvas(720, 720)
    background(255)
  	colorMode(HSB, 360, 100, 100, 100)
    #blendMode(SOFT_LIGHT)
    noLoop
  end
  
  def draw
	size = 10
    noStroke
    10000.times do |i|
      fill(60, 80, 80, 30)
      rect(rand(0..width - size), rand(0..width - size), size)
    end
  end
  