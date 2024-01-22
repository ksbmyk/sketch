# GENUARY 2024 jan22 "Point - line - plane."
# https://genuary.art/prompts

def setup
  createCanvas(720, 720)
  background("#f2e9c0")
  noLoop
end

def draw
  noFill
  circle(200, 200, 200)
  rect(200, 250, width - 200*2, 400)

  w = 500
  5.times do |i|
    #strokeWeight(3)
    line(w+i*30, height/2+100, w+i*30, height) # 縦
    line(width/2+100, w+i*30, width, w+i*30) # 縦
  end
  #circle(rand(50..width/2), rand(50..height/2), rand(1..5)*50)
  #rect(rand(100..width-100), rand(100..height-100), rand(2..5)*100, rand(1..3)*50, )
end

