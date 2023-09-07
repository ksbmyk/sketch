# 改変して
# https://rbcanvas.net/p5/ や
# https://p5rb.ongaeshi.me/editor で
# 実行してみてください
# 気に入ったものができたらぜひ #creativecoding #osrb03 をつけて公開してみてください！

$side = 80
$split = 9

# カラーパレットサンプル
$colors = ["#bd516f", "#848484", "#979ca2", "#e1dad6"]
#$colors = ["#B6E3FF", "#54AEFF", "#0969DA", "#0A3069"]
#$colors = ["#016A70", "#FFFFDD", "#D2DE32", "#A2C579"]
#$colors = ["#191D88", "#1450A3", "#337CCF", "#FFC436"]
#$colors = ["#FFE6E6", "#F2D1D1", "#DAEAF1", "#C6DCE4"]

def setup
  createCanvas($side * $split, $side * $split)
  angleMode(DEGREES)
  background(255) # 背景白
  #background(0) # 背景黒  ("#ffffff") (0, 0, 0) でも指定可能
end

def draw
  noLoop

  x = 0
  while x < width do
    y = 0
    while y < width do
      coler_index = rand(0..$colors.length - 1) # 色を決める
      fill($colors[coler_index])
      shape_type = rand(0..4) # 形を決める
      noStroke
      case shape_type
      when 0
        # 円
        ellipse(x + $side / 2 , y + $side / 2, $side)
        # 楕円
        #ellipse(x + $side / 2 , y + $side / 2, $side / 2, $side)
      when 1
        # 円弧
        arc(x, y, $side * 2, $side * 2, 0, 90)
        #arc(x, y + $side, $side * 2, $side * 2, 270, 360)
      when 2
        # 三角形
        triangle(x, y, x, y + $side, x + $side, y + $side)
        # triangle(x + $side / 2 , y, x, y + $side, x + $side, y + $side)
      when 3
        # 長方形
        rect(x + $side /4, y, $side/2,  $side)
        # 正方形
        #rect(x, y, $side, $side)
      when 4
        # 3点
        stroke($colors[coler_index])
        strokeWeight(10)
        point(x + 10,  y + $side / 2)
        point(x + $side /2,  y + $side / 2)
        point(x + $side - 10,  y + $side / 2)

        # 菱形
        # quad(x + $side / 2, y, x,  y + $side / 2, x + $side / 2, y+$side, x+$side,  y + $side / 2)
      end
      y += $side
    end
    x += $side
  end
end
