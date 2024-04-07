def setup
  createCanvas(720, 300)
  background(255)
  noLoop
end

def draw
  fill("#b62e2c")
  stroke("#b62e2c")
  rect(0, height-50, 30, height)
  rect(30, height-40, 30/2, height)
  rect(30+30/2, height-100, 30, height)
  triangle(30+30/2+1, height-100,
    30+30/2 +10,  height-100-5,
    30+30/2+30-2, height-100)
  
  rect(30+30/2+30, height-70, 30, height)
  
  #docomo
  rect(30+30/2+30+30-5, height-150, 30+10, height)
  rect(30+30/2+30+30, height-170, 30, height)
  rect(30+30/2+30+30+5, height-190, 20, height)
  rect(30+30/2+30+30+5+5, height-200, 10, height)
  rect(30+30/2+30+30+5+5+3, height-230, 4, height)
  
  rect(30+30/2+30+30+30, height-60, 20, height)
  
  rect(30+30/2+30+30+30+20, height-100, 15, height)
  rect(30+30/2+30+30+30+20+15, height-90, 15, height)
  rect(30+30/2+30+30+30+20+15+15, height-80, 15, height)
  
  rect(30+30/2+30+30+30+20+15+15+15, height-50, 30, height)
  rect(30+30/2+30+30+30+20+15+15+15+30, height-45, 10, height)
  rect(30+30/2+30+30+30+20+15+15+15+30+10, height-95, 20, height)
  triangle(30+30/2+30+30+30+20+15+15+15+30+10+1, height-95,
    30+30/2+30+30+30+20+15+15+15+30+10+10,  height-98,
    30+30/2+30+30+30+20+15+15+15+30+10+20-1, height-95)
  rect(30+30/2+30+30+30+20+15+15+15+30+10+8, height-110, 2, height)
  
  rect(30+30/2+30+30+30+20+15+15+15+30+10+20, height-115, 40, height)
  rect(30+30/2+30+30+30+20+15+15+15+30+10+20+5, height-120, 30, height)
  rect(30+30/2+30+30+30+20+15+15+15+30+10+20+5+10, height-125, 10, height)
  rect(30+30/2+30+30+30+20+15+15+15+30+10+20+5+10-2, height-125, 10+4, 2)
  
  rect(30+30/2+30+30+30+20+15+15+15+30+10+20+40, height-95, 10, height)
  rect(30+30/2+30+30+30+20+15+15+15+30+10+20+40+10, height-85, 10, height)
end
