#ref: https://note.com/deconbatch/n/nadd699e04580

def setup
  createCanvas(700, 700)
  background(0, 30, 70)
  noLoop
end

def draw
  fill(255)
  blendMode(SCREEN)

  200.times do
    x = rand(1..700)
    y = rand(1..700)
    1..25.times do | i |
      strokeWeight(i )
      stroke(5, 10, 35 - i, 100)
      ellipse(x, y, 5, 5)
    end

    r1 = rand(1..70)*10
    r2 = rand(1..10)*10
    1..25.times do | i |
      strokeWeight(i )
      stroke(5, 10, 35 - i, 100)
      ellipse(r1 + r2, r1, 10, 10)
      ellipse(r1, r1 + r2, 10, 10)
      ellipse(r1 + 10, r1 + r2, 5, 5)
      ellipse(r1 + 10, r1 - r2, 5, 5)
      ellipse(r1 - 10, r1 + r2, 5, 5)
      ellipse(r1 - 10, r1 - r2, 5, 5)
    end
  end
end
