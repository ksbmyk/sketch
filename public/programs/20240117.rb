def setup
    createCanvas(600, 600)
    background("#335fa6")
    noLoop()
  end
  
  def draw
    #translate(width / 2, height / 2)
    
    stroke(255)
    strokeWeight(10)
    noFill()
    
    (0..8).step do |i|
      drawArabesque(90*i   , 0   , 100, 5, 5)
      drawArabesque(45+90*i, 75  , 100, 5, 5)
      drawArabesque(90*i   , 75*2, 100, 5, 5)
      drawArabesque(45+90*i, 75*3, 100, 5, 5)
      drawArabesque(90*i   , 75*4, 100, 5, 5)
      drawArabesque(45+90*i, 75*5, 100, 5, 5)
      drawArabesque(90*i   , 75*6, 100, 5, 5)
      drawArabesque(45+90*i, 75*7, 100, 5, 5)
      drawArabesque(90*i   , 75*8, 100, 5, 5)
    end
    
    stroke("#7eaab7")
    strokeWeight(2)
    noFill()
    
    (0..8).step do |i|
      drawArabesque(90*i   , 0   , 100, 5, 5)
      drawArabesque(45+90*i, 75  , 100, 5, 5)
      drawArabesque(90*i   , 75*2, 100, 5, 5)
      drawArabesque(45+90*i, 75*3, 100, 5, 5)
      drawArabesque(90*i   , 75*4, 100, 5, 5)
      drawArabesque(45+90*i, 75*5, 100, 5, 5)
      drawArabesque(90*i   , 75*6, 100, 5, 5)
      drawArabesque(45+90*i, 75*7, 100, 5, 5)
      drawArabesque(90*i   , 75*8, 100, 5, 5)
    end

    noStroke
    fill("#c7a964")
    (0..8).step do |i|
      circle(90*i   , 0, 10)
      circle(45+90*i, 75, 10)
      circle(90*i, 75*2, 10)
      circle(45+90*i, 75*3, 10)
      circle(90*i, 75*4, 10)
      circle(45+90*i, 75*5, 10)
      circle(90*i, 75*6, 10)
      circle(45+90*i, 75*7, 10)
      circle(90*i, 75*8, 10)
    end
    
  end
  
  def drawArabesque(x, y, radius, sides, depth)
    return if depth == 0
    
    beginShape()
    sides.times do |i|
      angle = map(i, 0, sides, 0, TWO_PI)
      newX = x + cos(angle) * radius
      newY = y + sin(angle) * radius
      vertex(newX, newY)
      
      nextRadius = radius * 0.3 # Adjust this factor to control the size of the next iteration
      nextX = x + cos(angle) * nextRadius
      nextY = y + sin(angle) * nextRadius
      drawArabesque(nextX, nextY, nextRadius, sides, depth - 1)
    end
    endShape(CLOSE)
  end
  