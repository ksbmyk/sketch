def setup
  size = min(windowWidth, 1000)
  createCanvas(size, size)
  background("gray")
  noLoop
end

def draw
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
