# GENUARY 2024 jan10 "Hexagonal."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  background(0)
  noStroke
  noLoop
end

def draw
  (1..1200).each do |i|
    x = rand(0..width)
    y = rand(-10..height)
    if(x < 350)
   	  fill(180, 80, i / 12, 75)
    else 
      fill(60, 80, i / 12, 75)
    end
    hexagon(x, y)
  end
  
  fill(255)
  triangle(0, 0, 0, height / 2, 150, 0)
  triangle(width - 150, 0, width, 0, width, height / 2)
  triangle(0, height / 2, 0, height, 150, height)
  triangle(width - 150, height, width, height, width, height / 2)
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
