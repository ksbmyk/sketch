# GENUARY 2024 jan26 "Grow a seed."
# https://genuary.art/prompts

def setup      
  @palette1 = [color(50, 69, 107), color(229,205,199)]
  @palette2 = [color(69, 131, 172), color(246,233,175)]
  @palette3 = [color(54, 116, 178), color(198,168,200)]
  @palette4 = [color(116, 123, 167), color(242,210,198)]
  @palette5 = [color(109, 135, 201), color(221,204,232)]
  @palette6 = [color(137, 164, 185), color(240,159,129)]
  @palette7 =  [color(157, 124, 159), color(251,249,240)]
  @palette8 =  [color(161, 212, 238), color(222,232,245)]
  @palette9 =  [color(83, 130, 187), color(205,218,230)]
  @palette10 = [color(51, 116, 166), color(234,238,251)]
  @palette11 = [color(54, 124, 173), color(197,217,217)]
  @palette12 = [color(51, 81, 168), color(218,239,251)]
  @palette13 = [color(4, 14, 108), color(106,134,232)]
  @palette14 = [color(61, 79, 101), color(229,207,151)]
  @palette15 = [color(75, 69, 171), color(187,134,192)]
  @palette16 = [color(77, 98, 165), color(213,170,186)]
  @palette17 = [color(3, 10, 70), color(163,112,172)]
  createCanvas(720, 720)
  angleMode(DEGREES)
  noLoop
end
        
def draw
  seed = rand(1..1000)
  # set like seed
  # seed = xxx
  randomSeed(seed)

  r = (floor(random() * 17) + 1).to_i
  p = eval("@palette#{r}")
  sky(p[0], p[1])

  c = color(random(255), random(255), random(255))
  500.times do
    x = random(-10, width+10)
    y = random(height/3*2, height + 10)
  flower(x, y, c)
  end
  
  fill(p[1])
  text("Seed: #{seed}", width - 80, height - 20)
end
        
def flower(x, y, c)
  push
  translate(x, y)
  rotate(floor(random() * 9) + 1 * 20)
  fill(c)
  stroke(221, 221, 221, 100)
  n = 12
  n.times do
    ellipse(0, 20, 10, 40)
    rotate(360 / n)
  end
  pop
end
    
def sky(c1, c2)
  noFill
  (0..height.to_i).each do |i|
    inter = map(i, 0, height, 0, 1)
    c = lerpColor(c1, c2, inter)
    stroke(c)
    line(0, i, width, i)
  end
end
