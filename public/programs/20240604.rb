# #minacoding 2024 June 4 "One Hand"
# https://minacoding.online/theme

def setup
  createCanvas(700, 700)
  background(32, 47, 85)
  blendMode(OVERLAY)
  
  stroke(255, 80)
  fill(180, 230, 250)

  150.times do |i|
   x = noise(i * 0.1) * width
   y = noise(i * 0.1 + 100) * height
   r = rand(5..50)
   circle(x, y, r)
  end
end