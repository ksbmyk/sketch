$base = 80
$split = 9
$colors = %w(#ba083d #444444 #a9a7ad)
def setup
  createCanvas($base * $split, $base * $split)
  angleMode(DEGREES)
  rectMode(CENTER)
  noStroke
  noLoop
end

def draw
  background(255)
  d = width / $split
  x = d / 2
  while x < width do
    y = d / 2
    while y < width do
      r = rand(0..4)

      case r
      when 0 #赤丸
        # fill_pale_color($colors[0])
        ellipse(x, y, d, d)
      when 1 #グレーか濃いグレーの円弧(270-360)
        push
        translate(0, d)
        # fill_pale_color($colors[rand(1..2)])
        arc(x - d / 2, y - d / 2, d * 2, d * 2, 270, 360)
        pop
      when 2
        # fill_pale_color($colors[rand(1..2)])
        arc(x - d / 2, y - d / 2, d * 2, d * 2, 0, 90)
      when 3
        push
        translate(d, 0)
        # fill_pale_color($colors[rand(1..2)])
        arc(x - d / 2, y - d / 2, d * 2, d * 2, 90, 180)
        pop
      when 4
        push
        translate(d, d)
        # fill_pale_color($colors[rand(1..2)])
        arc(x - d / 2, y - d / 2, d * 2, d * 2, 180, 270)
        pop
      end
      y += d
    end
    x += d
  end
  # fill(255)
  # rect(width / 2, width / 2, $base * 3, $base * 3)
  # ruby_kaigi_logo
end

# def fill_pale_color(color_code)
#   rgba = color(color_code)
#   rgba.setAlpha(160)
#   fill(rgba)
# end

# def keyPressed
#   redraw
# end
