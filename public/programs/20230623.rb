def setup
  createCanvas(600, 600)
  colorMode(HSB, 360, 100, 100, 100)
  angleMode(DEGREES) # 角度を使わないかもしれないが
  background('#007BED') # 背景の色に表情を持たせたい
  noStroke
  noLoop
end

def draw
  noFill()
  stroke('#CCDDED') #線の色

  strokeWeight(1);
  # 円
  10.times do
    r1 = rand(10..20)
    r2 = rand(1..10)
    ellipse(r1*10, r1*10,  r2*100, r2*100)
  end

  #  r1 = rand(10..20)
  #  r2 = rand(1..10)
  #  bezier(0, r1*20, r2*100, r1*10, r2*10, r1*100, 600, r2*20)

end
