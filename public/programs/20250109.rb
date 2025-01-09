def setup
  createCanvas(700, 700)
  noLoop
end

def draw
  noStroke
  grid_size = 20

  (0..height).step(grid_size).with_index do |y, yi|
    (0..width).step(grid_size).with_index do |x, xi|
      if (xi + yi).even?
        fill(70 , 170, 70)
      else
        fill(40, 130 , 40)
      end

      rect(x, y, grid_size, grid_size)
    end
  end
end
