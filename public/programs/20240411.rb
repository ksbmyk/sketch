def setup
  createCanvas(720, 300)
  background(255)
  noLoop
end

def draw
  fill("#b62e2c")
  stroke("#b62e2c")
  rect(0, height-50, 30, height)
  rect(30, height-40, 15, height)
  rect(45, height-100, 30, height)
  triangle(46, height-100,
    55,  height-105,
    73, height-100)
  
  rect(75, height-70, 30, height)
  
  #docomo
  rect(100, height-150, 40, height)
  rect(105, height-170, 30, height)
  rect(110, height-190, 20, height)
  rect(115, height-200, 10, height)
  rect(118, height-230, 4, height)
  
  rect(135, height-60, 20, height)
  
  rect(155, height-100, 15, height)
  rect(170, height-90, 15, height)
  rect(185, height-80, 15, height)
  
  rect(200, height-50, 30, height)
  rect(230, height-45, 10, height)
  rect(240, height-95, 20, height)
  triangle(241, height-95,
    250,  height-98,
    259, height-95)
  rect(248, height-110, 2, height)
  
  rect(260, height-115, 40, height)
  rect(265, height-120, 30, height)
  rect(275, height-125, 10, height)
  rect(273, height-125, 14, 2)
  
  rect(300, height-95, 10, height)
  rect(310, height-85, 10, height)
end
