# GENUARY 2024 jan7 Progress bar / indicator / loading animation.
# https://genuary.art/prompts

def setup
  createCanvas(600, 600)
  angleMode(DEGREES) # ０°-３６０°で扱う
  @num_circles = 10
  @angle = 0
  @rotation_speed = 4
  @max_alpha = 0
end

def draw
  background("#2EAADC")
  translate(width / 2, height / 2)

  @angle += @rotation_speed
  rotate(@angle)

  radius = 80

  (1..@num_circles).each do |i|
    x = cos(360 / @num_circles * i) * radius;
    y = sin(360 / @num_circles * i) * radius;

    alpha = map(sin(@angle + i * 20), -1, 1, 255, 0)
    @max_alpha = max(@max_alpha, alpha)

    noStroke
    fill(255, 255, 255, alpha)
    ellipse(x, y, 20, 20)
  end  
end
