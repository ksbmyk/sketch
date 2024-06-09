# #minacoding 2024 June 6 "Morning"
# https://minacoding.online/theme

$circles = []

def setup
  createCanvas(700, 700)
  background("#c0c0c0")
  noStroke
  until $circles.length >= 200
    if (new_circle = create_new_circle)
      $circles << new_circle
    end
  end
  draw_circles
end

def create_new_circle
  x = rand(0..width)
  y = rand(0..height)
  r = rand(5..50)
  c = color(map(x, 0, width, 100, 0), map(y, 0, height, 255, 0), 255)
  
  return nil if $circles.any? { |circle| dist(x, y, circle[:x], circle[:y]) < r + circle[:r] }

  { x: x, y: y, r: r, c: c }
end

def draw_circles
  $circles.each do |circle|
    fill(circle[:c])
    ellipse(circle[:x], circle[:y], circle[:r] * 2)
  end
end
