# GENUARY 2024 jan18 "Bauhaus."
# https://genuary.art/prompts


def setup
  @side = 70
  @split = 8
  @margin = 8
  
  # カラーパレットサンプル
  # 茶 983a29  黄土 666762 ベージュ 918577 
  @colors = ["#983a29", "#666762", "#918577"]
  
  createCanvas(@side * @split + @margin * (@split+1) , @side * @split + @margin * (@split+1))
  angleMode(DEGREES)
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
      shape_type = rand(0..4) # 形を決める

      noStroke

      fill(color_codes[0])
      rect(x, y, @side, @side)
      fill(color_codes[1])
      case shape_type
      when 0
        # 円
        # 茶円x黄土、ベージュ円x白、ベージュ円*茶
        ellipse(x + @side / 2 , y + @side / 2, @side)
      when 1
        # 円弧
        # ベージュ円X黄土
   	    # 黄土円*白
		# 茶円*ベージュ
        # ベージュ*白
        # ベージュ円*茶
        arc(x, y, @side * 2, @side * 2, 0, 90)
      when 2
        # 円弧+四角
        # 茶円*白 半四角+半円
        rect(x, y, @side/2,  @side)
        arc(x + @side/2, y + @side / 2, @side, @side, -90, 90)
      when 3
        #四角　ベージュ
        rect(x, y, @side/4,  @side)
      when 4
        #茶円*ベージュ 1/3四角+半円　逆向きで茶円*白
        rect(x, y, @side/3,  @side)
        arc(x + @side/3, y + @side / 2, @side, @side, -90, 90)
      end
      y += @side + @margin
    end
    x += @side + @margin
  end
end
