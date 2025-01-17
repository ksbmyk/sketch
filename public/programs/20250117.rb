# GENUARY 2025 jan17 "What happens if pi=4?"
# https://genuary.art/prompts

def setup
  createCanvas(600, 600)
  noFill
end

def draw
  translate(width / 2, height / 2)

  10.times do |i|
    # angle = frameCount * (0.01 + i * 0.001) + i * PI / 5
    angle = frameCount * (0.01 + i * 0.001) + i * 4 / 5
    radius = 50 + i * 10
    stroke(255 - i * 20, 150, 255, 50)
    beginShape
    # (0...TWO_PI).step(PI / 6) do |a|
    (0...4 * 2).step(4 / 6) do |a|
      x = cos(a + angle) * radius
      y = sin(a + angle) * radius
      vertex(x, y)
    end
    endShape(CLOSE)
  end
end
