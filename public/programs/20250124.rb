def setup
  createCanvas(700, 700)
  @grid_size = 70
  @margin = 7
  @cols = 9
  @rows = 9
  @colors = [
    color('#f39c12'), # オレンジ
    color('#e74c3c'), # 赤
    color('#3498db'), # 青
    color('#2ecc71'), # 緑
    color('#9b59b6')  # 紫
  ]
  rectMode(CENTER)
  noStroke

end

def draw
  noLoop
  background(0)

  @rows.times do |y|
    @cols.times do |x|
      x_pos = x * (@grid_size + @margin) + @grid_size / 2 + @margin
      y_pos = y * (@grid_size + @margin) + @grid_size / 2 + @margin

      rect_color = @colors.sample
      fill(rect_color)
      rect_size = @grid_size
      rect(x_pos, y_pos, rect_size, rect_size)

      triangle_color = @colors.sample
	    triangle_color = @colors.sample while triangle_color == rect_color
      fill(triangle_color)
      triangle_size = rect_size / 2

      direction = rand(3)
	    if direction == 0
        fill(255, 150)
        rect(x_pos, y_pos, rect_size / 2, rect_size / 2)
      elsif direction == 1
        triangle(
          x_pos - triangle_size, y_pos - rect_size / 2,
          x_pos + triangle_size, y_pos - rect_size / 2,
          x_pos, y_pos - rect_size / 2 + triangle_size / 2
        )
      elsif direction == 2
        triangle(
          x_pos - triangle_size, y_pos + rect_size / 2,
          x_pos + triangle_size, y_pos + rect_size / 2,
          x_pos, y_pos + rect_size / 2 - triangle_size / 2
        )
      end
    end
  end
end
