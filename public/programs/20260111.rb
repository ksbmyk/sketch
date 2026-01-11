WIDTH = 70
HEIGHT = 50
canvas = Array.new(HEIGHT) { " " * WIDTH }

def draw_circle(canvas, cx, cy, r, char)
  canvas.each_with_index do |row, y|
    WIDTH.times do |x|
      # 縦方向を2倍に伸ばして計算
      dist = Math.sqrt((x - cx)**2 + ((y - cy) * 2)**2)
      if dist <= r
        if canvas[y][x] != ' '
          canvas[y][x] = '@'
        else
          canvas[y][x] = char
        end
      end
    end
  end
end

# 中心座標
center_x = 35
center_y = 25

# 6枚の花弁
distance = 14  # 中心からの距離
radius = 8     # 花弁の半径

6.times do |i|
  angle = i * 60 * Math::PI / 180
  cx = center_x + (distance * Math.cos(angle)).round
  cy = center_y + (distance * Math.sin(angle) * 0.5).round
  draw_circle(canvas, cx, cy, radius, '#')
end

# 出力
canvas.each { |row| puts row.rstrip }