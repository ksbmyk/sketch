# GENUARY 2024 jan10 "Hexagonal."
# https://genuary.art/prompts

def setup
  createCanvas(600, 600)
  colorMode(HSB, 360, 100, 100, 100)
  background(0)
  noStroke
  noLoop
end

def draw
  1..1000.times do |i|
    x = rand(10..560)
    y = rand(0..560)

    if(x < 300)
   	  fill(180, 80, i / 10, 75)
    else 
      fill(90, 80, i / 10, 75)
    end
    hexagon(x, y)
  end
end

def hexagon(x, y)
  beginShape()
    vertex(0 + x, 12 + y)
    vertex(10 + x, 0 + y)
    vertex(20 + x, 0 + y)
    vertex(30 + x, 12 + y)
    vertex(20 + x, 24 + y)
    vertex(10 + x, 24 + y)
  endShape(CLOSE)
end
