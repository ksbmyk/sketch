# GENUARY 2025 jan3 "Exactly 42 lines of code."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  @graphic1 = createGraphics(width/2, height/2)
  @graphic2 = createGraphics(width/2, height/2)
  shippo("#cc512e", "#f9ede9")
  image(@graphic1, 0, 0)
  seigaiha(["#f9ede9", "#cc512e"])
  image(@graphic2, width/2, 0)
  seigaiha(["#cc512e", "#f9ede9"])
  image(@graphic2, 0, height/2)
  shippo("#f9ede9", "#cc512e")
  image(@graphic1, width/2, height/2)
end

def shippo(line_color, background_color)
  draw_size = @graphic1.height / 4
  @graphic1.background(background_color)
  @graphic1.stroke(line_color)
  @graphic1.strokeWeight(3)
  @graphic1.noFill
  0.step(@graphic1.height, draw_size) do |y|
    0.step(@graphic1.width, draw_size) do |x|
      @graphic1.ellipse(x, y - draw_size / 2, draw_size) # 上
      @graphic1.ellipse(x, y + draw_size / 2, draw_size) # 下
      @graphic1.ellipse(x - draw_size / 2, y, draw_size) # 左
      @graphic1.ellipse(x + draw_size / 2, y, draw_size) # 右
    end
  end
end

def seigaiha(colors)
  draw_size = @graphic2.height / 4
  mark_num = 6
  @graphic2.noStroke
  0.step(@graphic2.height + draw_size / 4, draw_size / 4).with_index do |y, yi|
    dx = yi.odd? ? draw_size / 2 : 0
    0.step(@graphic2.width, draw_size) do |x|
      mark_num.times do |i|
        @graphic2.fill(colors[i % 2])
        @graphic2.ellipse(x + dx, y, draw_size / mark_num * (mark_num - i))
      end
    end
  end
end
