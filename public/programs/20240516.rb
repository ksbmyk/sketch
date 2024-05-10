def setup
  size = min(windowWidth, 1000)
  createCanvas(size, size)
  angleMode(DEGREES)
  background("gray")
  noLoop
end

def draw
  sea
  frame
end

def frame
    # TODO フレームの色パターン追加
    # フレーム
    stroke(0)
    rect_size = 80
    rect_weight = 2
    strokeWeight(rect_weight)
    
    fill("#9cee60")
    rect(rect_weight, rect_weight, width, rect_size)
    rect(width - rect_weight - rect_size , rect_weight, rect_size, height)
    rect(rect_weight, height - rect_weight - rect_size, width, rect_size)
    rect(rect_weight, rect_weight, rect_size, height)
    
    fill("#4b92f7")
    rect(rect_weight, rect_weight, rect_size)
    rect(width - rect_weight - rect_size , rect_weight, rect_size)
    rect(rect_weight, height - rect_weight - rect_size, rect_size)
    rect(width - rect_weight - rect_size , height - rect_weight - rect_size, rect_size)
end


def sea
  noStroke
  drawingContext.shadowColor = color(255)
  drawingContext.shadowBlur = 50

  x_value = width / 100
  y_value = height / 15
  freq = map(100, 0, width, 1, 5)
  vel = map(200, 0, height, 1, 50)

  (height/10 * 4..height/10 * 8).step(y_value) do |y|
	 if y < height/10 * 7
      fill(0, random(100, 150), random(200, 250))
    else
      fill(220, 221, 178)
    end
    beginShape()

    (0..width).step(x_value) do |x|
      a = 200
      b = sin((y + x + a) * freq) * vel
      vertex(x, b + y)
    end
    vertex(width, height)
    vertex(0, height)
    endShape(CLOSE)
  end
end
