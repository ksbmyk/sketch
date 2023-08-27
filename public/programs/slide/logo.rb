def setup
  createCanvas(400, 400)
  angleMode(DEGREES)
  rectMode(CENTER)
  noStroke
  noLoop
end

def draw
  background(255)
  n = 80
  fill("#ba083d")
  ellipse(n + n / 2, n + n / 2, n, n)
  ellipse(n / 2, n * 2 + n / 2, n, n)

  fill("#444444")
  arc(n, n, n * 2, n * 2, 90, 270)
  arc(n * 2, n * 2, n * 2, n * 2, 270, 90)

  fill("#a9a7ad")
  arc(n * 2, 0, n * 2, n * 2, 90, 180)
  arc(n * 2, n, n * 2, n * 2, 270, 360)
  arc(n, n * 3, n * 2, n * 2, 270, 360)
end