def setup
  createCanvas(1400, 400)
  # ラベル、日付、モチベーションの値
  @labels = ["1/1", "1/25", "2/15", "3/25", "4/1", "5/3", "5/15", "5/16", "6/30", "7/15", "8/25", "9/20", "9/30", "10/5", "10/28", "11/7", "11/30", "12/5", "12/17", "12/23"]
  @dates = [1, 25, 46, 85, 92, 124, 136, 137, 151, 197, 238, 264, 274, 279, 302, 312, 335, 340, 352, 358]
  @motivation_values = [20, 50, 30, 80, 20, 80, 10, 90, 60, 30, 90, 30, 70, 90, 30, 30, 30, 90, 40, 80]
  @max_value = 100
  @padding = 40
end

def draw
  background(240)
  draw_axes
  draw_graph(@dates, @motivation_values)
end

# 軸
def draw_axes
  stroke(0)
  strokeWeight(1)

  line(@padding, height - @padding, width - @padding, height - @padding) # X
  line(@padding, height - @padding, @padding, @padding) # Y

  # x軸ラベル
  textAlign(CENTER)
  textSize(12)
  noStroke()
  
  @labels.each_with_index do |label, i|
    x = map(@dates[i], 0, 365, @padding, width - @padding)
    text(label, x, height - @padding + 20)
  end

  # y軸ラベル
  (0..5).each do |i|
    y = map(i * 20, 0, @max_value, height - @padding, @padding)
    text(i * 20, @padding - 20, y)
  end
end

# 滑らかなグラフ
def draw_graph(x_data, y_data)
  stroke(0, 100, 200)
  strokeWeight(2)
  noFill()

  beginShape()

  # 始点の補助点
  first_x = map(x_data[0], 0, 365, @padding, width - @padding)
  first_y = map(y_data[0], 0, @max_value, height - @padding, @padding)
  curveVertex(first_x, first_y) # 最初の補助点
  curveVertex(first_x, first_y) # 始点を補助点として2回追加

  # 全ての点を描画
  x_data.each_with_index do |_, i|
    x = map(x_data[i], 0, 365, @padding, width - @padding)
    y = map(y_data[i], 0, @max_value, height - @padding, @padding)
    curveVertex(x, y)
  end

  # 終点の補助点
  last_x = map(x_data[-1], 0, 365, @padding, width - @padding)
  last_y = map(y_data[-1], 0, @max_value, height - @padding, @padding)
  curveVertex(last_x, last_y) # 終点を補助点として2回追加
  curveVertex(last_x, last_y)

  endShape()

  # 点を描画
  fill(0, 100, 200)
  noStroke()
  x_data.each_with_index do |_, i|
    x = map(x_data[i], 0, 365, @padding, width - @padding)
    y = map(y_data[i], 0, @max_value, height - @padding, @padding)
    ellipse(x, y, 8, 8)
  end
end
