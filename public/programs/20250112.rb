# GENUARY 2025 jan12 "Subdivision."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  noStroke
  frameRate(20)
end

def draw
  recursive_circles(width / 2, height / 2, 250, 5, 0)
end

def recursive_circles(x, y, r, depth, hue)
  return if depth <= 0

  fill((hue + frameCount) % 360, 80, 100, 80)
  ellipse(x, y, r * 2)

  new_r = r / 2
  recursive_circles(x - new_r, y, new_r, depth - 1, (hue + 60) % 360)
  recursive_circles(x + new_r, y, new_r, depth - 1, (hue + 60 * 2) % 360)
  recursive_circles(x, y - new_r, new_r, depth - 1, (hue + 60 * 3) % 360)
  recursive_circles(x, y + new_r, new_r, depth - 1, (hue + 60 * 4) % 360)
end
