#Peter de Jong Attractor
def setup
  w=800
  createCanvas(w, w)
  background(0)
  scale = 120
  x = 0.1
  y = 0.1
  a = 1
  b = 2
  c = 2
  d = 1

  translate(w/2, w/2)
  stroke(0, 200, 255, 80)
  (1..300000).each do | i |
    xx = Math.sin(a*y) - Math.cos(a*x)*c
    yy = Math.sin(b*x) - Math.cos(b*y)*d

    point(-xx * scale, -yy*scale)
    x = xx
    y = yy
  end
end

