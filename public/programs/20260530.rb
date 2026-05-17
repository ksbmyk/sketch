def setup
  createCanvas(700, 700)
  noLoop
end

def draw
  background(197,174,81)

  stroke(191,168,71)
  strokeWeight(12)

  slope = 0.5
  spacing = 60.0
  step = spacing / cos(atan(slope))
  count = 30

  (-count..count).each do |i|
    offset = i * step
    line(-200, -200 * slope + offset, 900, 900 * slope + offset)
    line(-200, 200 * slope + offset, 900, -900 * slope + offset)
  end
end
