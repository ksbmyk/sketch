def setup
  createCanvas(600, 600)
  frameRate(0.5)
  colorMode(HSB, 360, 100, 100)
end

def draw
  colors = set_color
  background(colors[:background])
  noFill

  stroke(colors[:stroke1])
  strokeWeight(10)
  diamond_pattern
  
  stroke(colors[:stroke2])
  strokeWeight(2)
  diamond_pattern
end

def diamond_pattern
  (0..8).each do |i|
    (0..8).each do |j|
      diamond(80 * i, 80 * j, 100, rand(3..5), rand(2..6))
    end
  end
end

def diamond(x, y, radius, depth, n)
  return if depth.zero?
  
  beginShape
  n.times do |i|
    angle = map(i, 0, n, 0, TWO_PI)
    new_x = x + cos(angle) * radius
    new_y = y + sin(angle) * radius
    vertex(new_x, new_y)
    
    next_radius = radius * 0.3
    next_x = x + cos(angle) * next_radius
    next_y = y + sin(angle) * next_radius
    diamond(next_x, next_y, next_radius, depth - 1, n)
  end
  endShape(CLOSE)
end

def set_color
  base_hue = rand(0..360)
  saturation = 80
  brightness = 90
  
  {
    background: color(base_hue, saturation, brightness),
    stroke1: color((base_hue + 30) % 360, saturation, brightness - 50),
    stroke2: color((base_hue - 30 + 360) % 360, saturation, brightness)
  }
end
