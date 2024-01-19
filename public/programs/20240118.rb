# GENUARY 2024 jan18 "Bauhaus."
# https://genuary.art/prompts


def setup
  @side = 80
  @split = 9
  
  # カラーパレットサンプル
  # 赤 #e15553  青 306fdd 黄色 f7d05b 黒　242536 白 fdf4e7
  @colors = ["#e15553", "#306fdd", "#f7d05b", "#242536", "#fdf4e7"]
  

  createCanvas(@side * @split, @side * @split)
  angleMode(DEGREES)
  background("#fdf4e7") # 背景白
end

def draw
  noLoop

  x = 0
  while x < width do
    y = 0
    while y < width do
      coler_index = rand(0..@colors.length - 1) # 色を決める
      color_codes = @colors.sample(2)

      fill(@colors[coler_index])
      shape_type = rand(0..6) # 形を決める

      noStroke

      fill(color_codes[0])
      rect(x, y, @side, @side)
      fill(color_codes[1])
      case shape_type
      when 0
        ellipse(x + @side / 2 , y + @side / 2, @side)
      when 1
        arc(x, y, @side * 2, @side * 2, 0, 90)
      when 2
        triangle(x, y, x, y + @side, x + @side, y + @side)
      when 3
        rect(x, y, @side/4,  @side)
        rect(x + @side/8*3, y, @side/4,  @side)
        rect(x + @side/8*6, y, @side/4,  @side)
      when 4
        arc(x, y + @side, @side * 2, @side * 2, 270, 360)
      when 5

        rect(x, y, @side,  @side/4)
        rect(x, y + @side/8*3, @side,  @side/4)
        rect(x, y + @side/8*6, @side,  @side/4)
      when 6
        triangle(x + @side/2, y, x, y + @side/2, x + @side, y + @side/2)
        triangle(x + @side/2, y + @side/2, x, y + @side, x + @side, y + @side)
      end
      y += @side
    end
    x += @side
  end
end