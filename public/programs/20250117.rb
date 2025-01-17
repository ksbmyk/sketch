def setup
  createCanvas(600, 600)
  noFill
  strokeWeight(2)
end

def draw
  background(20)
  translate(width / 2, height / 2)
  10.times do |i|
    angle = frameCount * (0.01 + i * 0.001) + i * PI / 5
    radius = 50 + i * 10
    stroke(255 - i * 20)
    beginShape
    (0..TWO_PI).step(PI / 6) do |a|
      x = cos(a + angle) * radius
      y = sin(a + angle) * radius
      vertex(x, y)
    end
    endShape(CLOSE)
  end
end
