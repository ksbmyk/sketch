def setup
  createCanvas(700, 700)
  noLoop
end

def draw
  background(50, 150, 50)
  noStroke
  grid_size = 20

  (0..height).step(grid_size).with_index do |y, yi|
    (0..width).step(grid_size).with_index do |x, xi|
      if (xi + yi).even?
        fill(70 + rand(-10..10), 170 + rand(-10..10), 70 + rand(-10..10))
      else
        fill(40 + rand(-10..10), 130 + rand(-10..10), 40 + rand(-10..10))
      end
      next if rand < 0.05

      rect(x, y, grid_size, grid_size)
    end
  end
end
