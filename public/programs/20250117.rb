def setup
  createCanvas(600, 600)
  noFill
end

def draw
  translate(width / 2, height / 2)
  # p = PI
  p = 4
  10.times do |i|
    angle = frameCount * (0.01 + i * 0.001) + i * p / 5
    radius = 50 + i * 10
    stroke(255 - i * 20, 150, 255, 50)
    beginShape
     (0...p * 2).step(p.fdiv(6)) do |a|
      x = cos(a + angle) * radius
      y = sin(a + angle) * radius
      vertex(x, y)
    end
    endShape(CLOSE)
  end
end
