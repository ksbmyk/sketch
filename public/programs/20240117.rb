def setup
    createCanvas(400, 400)
    background("blue")
    noLoop()
  end
  
  def draw
    translate(width / 2, height / 2)
    
    stroke(255)
    strokeWeight(10)
    noFill()
    
    drawArabesque(0, 0, 100, 5, 5)
    drawArabesque(0+90, 0, 100, 5, 5)
    
    stroke(0)
    strokeWeight(2)
    noFill()
    
    drawArabesque(0, 0, 100, 5, 5)
    drawArabesque(0+90, 0, 100, 5, 5)
    drawArabesque(0+90*2, 0, 100, 5, 5)
    
    drawArabesque(0+45, 0+75, 100, 5, 5)
    drawArabesque(0+45+90, 0+75, 100, 5, 5)
    
    # fill("yellow")
    # circle(0, 0, 10)
    
  end
  
  def drawArabesque(x, y, radius, sides, depth)
    return if depth == 0
    
    beginShape()
    sides.times do |i|
  #   for (let i = 0; i < sides; i++) {
      angle = map(i, 0, sides, 0, TWO_PI)
      newX = x + cos(angle) * radius
      newY = y + sin(angle) * radius
      vertex(newX, newY)
      
      nextRadius = radius * 0.3; # Adjust this factor to control the size of the next iteration
      nextX = x + cos(angle) * nextRadius
      nextY = y + sin(angle) * nextRadius
      drawArabesque(nextX, nextY, nextRadius, sides, depth - 1)
      
      # fill("yellow")
      # circle(x, y, 5)
      # noFill
    end
    endShape(CLOSE)
  end
  