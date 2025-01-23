def setup
  createCanvas(600, 600)
  noLoop
end

def draw
  background(20)
  size = 60
  (0..height).step(size) do |y|
    (0..width).step(size) do |x|
      stroke(200)
      fill(rand(100..255))
      rect(x, y, size, size)
      fill(rand(50..200))
      stroke(rand(50..200))
      if rand > 0.5
        ellipse(x + size / 2, y + size / 2, size / 2)
      end
    end
  end
end
