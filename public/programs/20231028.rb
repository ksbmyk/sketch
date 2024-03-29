# Kaigi on Rails 2023 https://kaigionrails.org/2023 のロゴ design by hiromisugie
def setup
  createCanvas(400, 400)
end

def draw
  back_color = "#84240f"
  logo_color = "#ffffff"
  background(back_color)

  # 円
  noFill()
  stroke(logo_color)
  strokeWeight(2)
  ellipse(200, 200, 200, 200)

  # 線
  stroke(logo_color)
  strokeWeight(2)
  line(100, 200, 300, 200)

  # 菱形
  push
  translate(200, 130)
  rotate(PI / 4)
  fill(logo_color)
  rect(0, 0, 100, 100)
  pop

  # 四角
  noStroke()
  fill(back_color)
  rect(130, 165, 140, 15)
  rect(130, 145, 140, 5)
  rect(130, 135, 140, 3)
end
