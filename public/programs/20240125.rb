# GENUARY 2024 jan25 "If you like generative art, you probably have some photos on your phone of cool looking patterns, textures, shapes or things that you’ve seen. You might have even thought, “I should try to recreate this with code”. Today is the day."
# https://genuary.art/prompts


def setup
  @side = 80
  @split = 7
  @margin = 10

  # 0茶  1 黄土  2ベージュ  3白 
  @colors = ["#983a29", "#666762", "#918577", "#ffffff"]

  createCanvas(@side * @split + @margin * (@split+1) , @side * @split + @margin * (@split+1))
  angleMode(DEGREES)
  background(255)
end
  
def draw
  noLoop

  x = @margin
  while x < width do
    y = @margin
    while y < width do
      coler_index = rand(0..@colors.length - 1) # 色を決める
      color_codes = @colors.sample(2)

      fill(@colors[coler_index])
      shape_type = rand(0..9) # 形を決める

      noStroke

      fill(color_codes[0])
      rect(x, y, @side, @side)
      fill(color_codes[1])
      case shape_type
      when 0
        r = rand(0..2)
        case r
        when 0
          fill(@colors[1])# 黄土
          rect(x, y, @side, @side)
          fill(@colors[0])# 茶
          ellipse(x + @side / 2 , y + @side / 2, @side)
        when 1
          fill(@colors[3])# 白
          rect(x, y, @side, @side)
          fill(@colors[2])# ベージュ
          ellipse(x + @side / 2 , y + @side / 2, @side)
          
        when 2
          fill(@colors[2])# ベージュ
          rect(x, y, @side, @side)
          fill(@colors[0])# 茶
          ellipse(x + @side / 2 , y + @side / 2, @side)
        end
      when 1
        if r == 0
          fill(@colors[2])# ベージュ
          rect(x, y, @side, @side)
          fill(@colors[1])# 黄土
          arc(x, y, @side * 2, @side * 2, 0, 90)
        else
          fill(@colors[2])# ベージュ
          rect(x, y, @side, @side)
          fill(@colors[0])# 茶
          arc(x, y+@side, @side * 2, @side * 2, -90, 0)
        end
      when 2
        fill(@colors[3])# 白
        rect(x, y, @side, @side)
        fill(@colors[1])# 黄土
        arc(x, y, @side * 2, @side * 2, 0, 90)
      when 3
        fill(@colors[0])# 茶
        rect(x, y, @side, @side)
        fill(@colors[2])# ベージュ
        arc(x, y, @side * 2, @side * 2, 0, 90)
      when 4
        fill(@colors[3]) # 白
        rect(x, y, @side, @side)
        fill(@colors[2]) # ベージュ
        r = rand(0..1)
        if r == 0
          arc(x+@side, y, @side * 2, @side * 2, 90, 180)
        else
          arc(x+@side, y+@side, @side * 2, @side * 2, 180, 270)
        end  
      when 5
        fill(@colors[0]) # 茶
        rect(x, y, @side, @side)
        fill(@colors[2]) # ベージュ
        r = rand(0..1)
        if r == 0
          arc(x, y, @side * 2, @side * 2, 0, 90)
        else
          arc(x, y +@side, @side * 2, @side * 2, -90, 0)
        end
      when 6
        fill(@colors[3])# 白
        rect(x, y, @side, @side)
        fill(@colors[0])# 茶
        r = rand(0..1)
        if r == 0
          arc(x, y, @side * 2, @side * 2, 0, 90)
        else
          arc(x, y +@side, @side * 2, @side * 2, -90, 0)
        end
      when 7
        r = rand(0..2)
        if r == 0
          fill(@colors[3])# 白
          rect(x, y, @side, @side)
          fill(@colors[0])# 茶
          rect(x, y, @side/2,  @side)
          arc(x + @side/2, y + @side / 2, @side, @side, -90, 90)
        elsif r == 1
          fill(@colors[0])# 茶
          rect(x, y, @side, @side)
          fill(@colors[1])# 黄土
          rect(x, y + @side - @side/3, @side,@side/3)
          arc(x+@side/2, y+@side - @side/3, @side, @side, 180, 360)
        else
          fill(@colors[2])# ベージュ
          rect(x, y, @side, @side)
          fill(@colors[3])# 白
          rect(x, y, @side, @side/3)
          arc(x+@side/2, y + @side/3-1, @side, @side, 0, 180)
        end
      when 8
        fill(@colors[2])# ベージュ
        rect(x, y, @side,  @side)
      when 9
        r = rand(0..1)
        if r == 0
          fill(@colors[1])# 黄土
          rect(x, y, @side, @side)

          fill(@colors[2])# ベージュ
          rect(x, y, @side/3,  @side)
          arc(x + @side/3-1, y + @side / 2, @side, @side, -90, 90) 
        else
          fill(@colors[3])# 白
          rect(x, y, @side, @side)
          fill(@colors[0])# 茶
          rect(x + @side - @side/3, y, @side/3,  @side)
          arc(x + @side - @side/3 +1, y + @side / 2, @side, @side, 90, 270)
        end
      end
      y += @side + @margin
    end
    x += @side + @margin
  end
end
  