# GENUARY 2024 jan14 "Less than 1KB artwork."
# https://genuary.art/prompts

def setup
  @w = 615
  @t = 1
  createCanvas(@w, @w)
  noStroke
  colorMode(HSB)
end
  
def draw
  background(255)
  check_pattern(@t)
  @t = @ t < 360 ? @t + 0.25 : 0 
end
  
def check_pattern(t)
  s = 15
  x = 0
  y = 0
  while x <= width do
    fill(t, 80, 80, 0.5)
    rect(x, 0, s, @w) 
    rect(0, y, @w, s)  
    x += s * 2
    y += s * 2
  end
end
