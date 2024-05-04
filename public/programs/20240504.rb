def setup
  createCanvas(700, 700)
  background(255)
  noLoop
end

def draw
  noStroke

  fill("#94c75b")
  rect(0, 0, width / 2)
  flower(170, 120, "#abe1fa")
  flower(120, 170, "#ffcccc")
  flower(220, 170, "#ffcccc")
  flower(170, 220, "#abe1fa")

  fill("#ffe3e3")
  rect(width / 2, 0, width / 2)
  rabbit(width / 4 *3, 200)

  fill("#fbebba")
  rect(0, height / 2, width / 2)
  bear(width / 4, 540)

  fill("#abe1fa")
  rect(width / 2, height / 2, width / 2)
  snow_man(width / 4 * 3, height / 2 + 110)
end

def flower(x, y, c)
  fill(c)
  ellipse(x + 20, y, 30, 30)
  ellipse(x - 20, y, 30, 30)
  ellipse(x, y + 20, 30, 30)
  ellipse(x, y - 20, 30, 30)
  fill("#fbebba")
  ellipse(x, y, 20, 20)
end

def rabbit(x, y)
  fill("#ffcccc")
  ellipse(x - 50, y - 50, 50, 230)
  ellipse(x + 50, y - 50, 50, 230)
  fill("#d18d89")
  ellipse(x - 50, y - 40, 20, 200)
  ellipse(x + 50, y - 40, 20, 200)
  fill("#ffcccc")
  ellipse(x, y, 200, 150)
  fill("#2f221e")
  ellipse(x - 40, y - 10, 15)
  ellipse(x + 40, y - 10, 15)
  ellipse(x, y + 10, 20, 15)
  fill("#d18d89")
  ellipse(x - 60, y + 15, 35, 30)
  ellipse(x + 60, y + 15, 35, 30)
end

def bear(x, y)
  fill("#bc834c")
  ellipse(x - 70, y - 70, 70)
  ellipse(x + 70, y - 70, 70)
  fill("#fbebba")
  ellipse(x - 70, y - 70, 40)
  ellipse(x + 70, y - 70, 40)
  fill("#bc834c")
  ellipse(x, y, 200, 150)
  fill("#2f221e")
  ellipse(x - 40, y - 20, 15)
  ellipse(x + 40, y - 20, 15)
  fill("#ffffff")
  ellipse(x, y + 40, 90, 70)
  fill("#2f221e")
  ellipse(x, y + 10, 20, 15)
end

def snow_man(x, y)
  fill(255)
  ellipse(x, y, 100)
  ellipse(x, y + 100, 150)
  fill(0)
  ellipse(x - 20, y - 10, 10)
  ellipse(x + 20, y - 10, 10)
  ellipse(x, y + 10, 20, 5)
end
