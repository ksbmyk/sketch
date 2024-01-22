# GENUARY 2024 jan22 "Point - line - plane."
# https://genuary.art/prompts

def setup
  createCanvas(720, 720)
  background("#b09d75")
  noLoop
end

def draw
  noStroke

  fill("#696343")
  circle(200, 200, 200)
  fill("#2b5563")
  rect(200, 250, width - 200 * 2, 400)

  fill("#624a40")
  circle(rand(50..width / 2), rand(50..height / 2), 50)
  fill(0)
  circle(rand(50..width / 2), rand(50..height / 2), 30)
  fill("#3e221e")
  rect(rand(100..width - 100), rand(100..height - 100), rand(2..5)*100, rand(1..3) * 50)

  fill("#843f20")

  triangle(rand(width / 2..width), rand(0..height / 2), rand(width / 2..width), rand(0..height / 2), rand(width / 2..width), rand(0..height / 2) )
  triangle(rand(0..width/2),rand(height/2..height), rand(0..width/2),rand(height/2..height), rand(0..width/2), rand(height/2..height) )
  
  fill(255,255,255,80)
  circle(rand(50..width / 2), 500, rand(200..300))

  stroke(1)
  w = 500
  5.times do |i|
    line(w + i * 30, height / 2 + 100, w + i * 30, height)
    line(width / 2 + 100, w + i * 30, width, w + i * 30)
  end
end

