# GENUARY 2025 jan10 "You can only use TAU in your code, no other number allowed."
# https://genuary.art/prompts

def setup
  @canvas_size = (TAU + TAU + TAU) * TAU * TAU
  createCanvas(@canvas_size, @canvas_size)
  noStroke()
  @t = TAU - TAU
end

def draw
  background(TAU * TAU, TAU * TAU * TAU, TAU * TAU * TAU * TAU)
  @t += TAU / (TAU * TAU * TAU)

  translate(@canvas_size / (TWO_PI / TWO_PI + TWO_PI / TWO_PI),
    @canvas_size / (TAU / TAU + TAU / TAU))

  ((TAU - TAU)..TAU).step(TAU / (TAU * TAU - TAU - TAU)) do |angle|
    r = (cos(@t) + TAU / TAU) * (@canvas_size / TAU)
    x = cos(angle) * r
    y = sin(angle) * r

    ellipse(x, y, TAU * TAU, TAU * TAU)
  end
end
