#Peter de Jong Attractor 漸化式
def setup
  createCanvas(800, 800)
  background(0)

  translate(600, 400)
  stroke(250, 70, 130, 80)
  attractor

  translate(-400, 0)
  stroke(30, 150, 160, 80)
  attractor
end

def attractor
  scale = 120
  x = 0.1
  y = 0.1
  a = 1
  b = 2
  c = 2
  d = 1

  (1..300000).each do | i |
    xx = Math.sin(a*y) - Math.cos(a*x)*c
    yy = Math.sin(b*x) - Math.cos(b*y)*d

    point(-xx*scale, yy*scale)
    x = xx
    y = yy
  end
end


