# GENUARY 2024 jan13 "Wobbly function day."
# https://genuary.art/prompts
# https://piterpasma.nl/articles/wobbly


def setup
  @base = 80
  split = 9
  createCanvas(@base * split, @base * split)
  #rectMode(CENTER)
  
  background(255)
  @t = 0
end

def draw
  background("blue")
  scale(1.5)
  box(@t)
  @t += 0.01
end

def box(f)
  	t = f
    x = 0
  while x < width do
    y = 0
    while y < width do
      fill(0)
      push
	    translate(250, -130)
      rotate(0.8)
      rect(x, y, (wobbly_function(x, y, t) * 10))
      circle(x, y, (wobbly_function(x, y, t) * 20))
      pop
      y += @base
    end
    x += @base
  end
  
end

def wobbly_function(x, y, t)
  sin(2.31*x+1.11*t+5.95+2.57*sin(1.73*y-1.65*t+1.87)) + sin(3.09*y-1.28*t+4.15+2.31*sin(2.53*x+1.66*t+4.45))
end
