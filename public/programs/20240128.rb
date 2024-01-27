# GENUARY 2024 jan28 "Skeuomorphism."
# https://genuary.art/prompts

def setup
  createCanvas(720, 720)
  noLoop
  background("#dddddd")

  @graphic1 = createGraphics(200, 200)
  @graphic2 = createGraphics(200, 200)
  @graphic3 = createGraphics(200, 200)
end

def draw
  frame_size = 240
  frame_colors = ["#33363a", "#405959"]
  frame_color = frame_colors[rand(0..1)]
  noStroke

  fill(frame_color)
  rect(20, 100, 240)
  
  penrose
  image(@graphic1, 20+20, 100+20)

  fill(frame_color)
  rect(width-frame_size-20, 100, frame_size)

  arabesque
  image(@graphic2, width-frame_size-20+20, 100+20)

  fill(frame_color)
  rect(width/2 - frame_size/2, height - frame_size- 100, frame_size)

  bauhaus
  image(@graphic3, width/2 - frame_size/2 + 20, height - frame_size- 100 + 20)
end

def penrose
  @graphic1.background("#efeddb")
  @graphic1.translate(@graphic1.width / 2, @graphic1.height * 3 / 5);
  @graphic1.noStroke
  @graphic1.fill("#559fb5")
  penrose_object
  @graphic1.rotate(TWO_PI / 3)
  @graphic1.fill("#abd7c9")
  penrose_object
  @graphic1.rotate(TWO_PI / 3)
  @graphic1.fill("#bf6d7d")
  penrose_object
end

def penrose_object
  e = 30 
  w = 15
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
  sides = rand(3..8)
  @graphic2.stroke(255)
  @graphic2.strokeWeight(10)
  @graphic2.noFill
  arabesque_object(@graphic2.width / 2, @graphic2.height / 2, 100, sides, 5)
  
  @graphic2.stroke("#7eaab7")
  @graphic2.strokeWeight(2)
  @graphic2.noFill
  arabesque_object(@graphic2.width / 2, @graphic2.height / 2, 100, sides, 5)

  @graphic2.noStroke
  @graphic2.fill("#c7a964")
  @graphic2.circle(@graphic2.width / 2, @graphic2.height / 2, 10)
end
  
def arabesque_object(x, y, radius, sides, depth)
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
    arabesque_object(next_x, next_y, next_radius, sides, depth - 1)
  end
  @graphic2.endShape(CLOSE)
end

def bauhaus
  angleMode(DEGREES)
  colors = ["#e15553", "#306fdd", "#f7d05b", "#242536", "#fdf4e7"]
  side = @graphic3.width / 2
  x = 0
  while x < @graphic3.width do
    y = 0
    while y < @graphic3.height do
      coler_index = rand(0..colors.length - 1)
      color_codes = colors.sample(2)
      @graphic3.fill(colors[coler_index])
      
      shape_type = rand(0..6)
      @graphic3.noStroke

      @graphic3.fill(color_codes[0])
      @graphic3.rect(x, y, side, side)
      @graphic3.fill(color_codes[1])
      case shape_type
      when 0
        @graphic3.ellipse(x + side / 2 , y + side / 2, side)
      when 1
        @graphic3.arc(x, y, side * 2, side * 2, 0, PI / 2)
      when 2
        @graphic3.triangle(x, y, x, y + side, x + side, y + side)
      when 3
        @graphic3.rect(x, y, side/4,  side)
        @graphic3.rect(x + side/8*3, y, side/4,  side)
        @graphic3.rect(x + side/8*6, y, side/4,  side)
      when 4
        @graphic3.arc(x, y + side, side * 2, side * 2, -PI / 2, 0)
      when 5
        @graphic3.rect(x, y, side,  side/4)
        @graphic3.rect(x, y + side/8*3, side,  side/4)
        @graphic3.rect(x, y + side/8*6, side,  side/4)
      when 6
        @graphic3.triangle(x + side/2, y, x, y + side/2, x + side, y + side/2)
        @graphic3.triangle(x + side/2, y + side/2, x, y + side, x + side, y + side)
      end
      y += side
    end
    x += side
  end
end