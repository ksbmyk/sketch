# GENUARY 2025 jan24 "Geometric art - pick either a circle, rectangle, or triangle and use only that geometric shape."
# https://genuary.art/prompts

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

      color1 = @colors.sample
      fill(color1)

      triangle(
        x_pos - @grid_size / 2, y_pos - @grid_size / 2,
        x_pos + @grid_size / 2, y_pos - @grid_size / 2,
        x_pos, y_pos - @grid_size / 2 + @grid_size / 2
      )

      color2 = @colors.sample
      color2 = @colors.sample while color2 == color1
      fill(color2)

      triangle(
        x_pos - @grid_size / 2, y_pos + @grid_size / 2,
        x_pos + @grid_size / 2, y_pos + @grid_size / 2,
        x_pos, y_pos + @grid_size / 2 - @grid_size / 2
      )

      color3 = @colors.sample
      color3 = @colors.sample while color1 == color3
      fill(color3)

        triangle(
          x_pos - @grid_size / 2, y_pos - @grid_size / 2,
          x_pos + @grid_size / 2, y_pos - @grid_size / 2,
          x_pos, y_pos - @grid_size / 2 + @grid_size / 2 / 2
        )

      color4 = @colors.sample
      color4 = @colors.sample while color2 == color4
      fill(color4)
        triangle(
          x_pos - @grid_size / 2, y_pos + @grid_size / 2,
          x_pos + @grid_size / 2, y_pos + @grid_size / 2,
          x_pos, y_pos + @grid_size / 2 - @grid_size / 2 / 2
        )
    end
  end
end
