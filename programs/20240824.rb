def setup
  @n = 7
  @size = 300
  @grid = 1
  createCanvas(@size * @grid, @size * @grid)
  background(0)
end

def draw
  if frameCount % 30 == 0
    background(0)

    (0...width).step(@size) do |x|
      (0...height).step(@size) do |y|
        r1, r2 = get_unique_random_pair(3, 6)

        stroke(255)
        strokeWeight(2)
        noFill
        pattern(x, y, @n, r1)

        stroke(random(0, 100), random(80, 180), 255)
        strokeWeight(1)
        pattern(x, y, @n, r2)
        @n = rand(5..9)
      end
    end
  end
end

def pattern(x, y, n, r)
  geometric(x + @size / 2, y + @size / 2, @size, n, r)
end

def geometric(x, y, radius, sides, depth)
  return if depth == 0

  beginShape
  (0...sides).each do |i|
    angle = map(i, 0, sides, 0, TWO_PI)
    new_x = x + cos(angle) * radius
    new_y = y + sin(angle) * radius
    vertex(new_x, new_y)

    next_radius = radius * 0.3
    next_x = x + cos(angle) * next_radius
    next_y = y + sin(angle) * next_radius
    geometric(next_x, next_y, next_radius, sides, depth - 1)
  end
  endShape(CLOSE)
end

def get_unique_random_pair(min, max)
  values = (min..max).to_a.sample(2)
  return values if values[0] != values[1]
  get_unique_random_pair(min, max)
end