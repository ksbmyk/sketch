# GENUARY 2024 jan28 "Skeuomorphism."
# https://genuary.art/prompts

def setup
  createCanvas(720, 720)
  noLoop
  background("#dddddd")
  @graphic1 = createGraphics(200, 200)
  @graphic2 = createGraphics(200, 200)
 
end

def draw
  frame_size = 240
  noStroke
  # 額 
  fill("#33363a")
  rect(10, 10, 240)
  
  penrose
  image(@graphic1, 10+20, 10+20)

  # 額 
  fill("#33363a")
  rect(width-frame_size-10, 10, frame_size)

  arabesque
  image(@graphic2, width-frame_size-10+20, 10+20)

end

def penrose
  @graphic1.background("#efeddb")
  @graphic1.translate(@graphic1.width / 2, @graphic1.height * 3 / 5);
  @graphic1.noStroke
  @graphic1.fill("#559fb5")
  side_object
  @graphic1.rotate(TWO_PI / 3)
  @graphic1.fill("#abd7c9")
  side_object
  @graphic1.rotate(TWO_PI / 3)
  @graphic1.fill("#bf6d7d")
  side_object
end

def side_object
  e = 30 
  w = 20
  sin30 = sin(PI / 6)
  cos30 = cos(PI / 6)
  sin60 = sin(PI / 3)
  cos60 = cos(PI / 3)

  @graphic1.beginShape()
  x1 = -e * cos60
  y1 = (e * cos60) / sqrt(3)
  @graphic1.vertex(x1, y1)
  x2 = x1 - w
  y2 = y1
  @graphic1.vertex(x2, y2)
  x3 = x2 + (e + 3.0 * w) * cos60
  y3 = y2 - (e + 3.0 * w) * sin60
  @graphic1.vertex(x3, y3)
  x4 = x3 + (e + 4.0 * w) * sin30
  y4 = y3 + (e + 4.0 * w) * cos30
  @graphic1.vertex(x4, y4)
  x5 = x4 - w * cos60
  y5 = y4 + w * sin60
  @graphic1.vertex(x5, y5)
  x6 = x5 - (e + 3 * w) * cos60
  y6 = y5 - (e + 3 * w) * sin60
  @graphic1.vertex(x6, y6)
  @graphic1.endShape(CLOSE)
end


def arabesque
  @graphic2.background("#335fa6")

  @graphic2.stroke(255)
  @graphic2.strokeWeight(10)
  @graphic2.noFill
  pattern(@graphic2.width / 2, @graphic2.height / 2, 100, 8, 5)
  
  @graphic2.stroke("#7eaab7")
  @graphic2.strokeWeight(2)
  @graphic2.noFill
  pattern(@graphic2.width / 2, @graphic2.height / 2, 100, 8, 5)

  @graphic2.noStroke
  @graphic2.fill("#c7a964")
  @graphic2.circle(@graphic2.width / 2, @graphic2.height / 2, 10)
end
  
def pattern(x, y, radius, sides, depth)
  return if depth == 0
  
  @graphic2.beginShape()
  sides.to_i.times do |i|
    angle = map(i, 0, sides, 0, TWO_PI)
    new_x = x + cos(angle) * radius
    new_y = y + sin(angle) * radius
    @graphic2.vertex(new_x, new_y)
    
    next_radius = radius * 0.3 # 反復サイズ
    next_x = x + cos(angle) * next_radius
    next_y = y + sin(angle) * next_radius
    pattern(next_x, next_y, next_radius, sides, depth - 1)
  end
  @graphic2.endShape(CLOSE)
end
