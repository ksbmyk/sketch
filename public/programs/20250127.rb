def setup
  createCanvas(700, 700)
  noFill
  @ripples = []
end

def draw
  background('#A6D1E6')

  centerX = width / 2
  centerY = height / 2

  # 自動的に発生する波紋
  3.times do |i|
    t = (frameCount + i * 10) % 200
    radius = map(t, 0, 200, 10, width)
    stroke(255, map(t, 0, 200, 200, 0))
    ellipse(centerX, centerY, radius, radius)
  end

  # クリックされた場所の波紋
  @ripples.reverse_each do |ripple|
    is_active = false
    3.times do |j|
      t = frameCount - ripple[:startTime] - j * 10
      if t >= 0 && t < 200  # 波紋が表示中か
        radius = map(t, 0, 200, 10, width)
        stroke(255, map(t, 0, 200, 200, 0))
        ellipse(ripple[:x], ripple[:y], radius, radius)
        is_active = true
      end
    end

    @ripples.delete(ripple) unless is_active
  end
end

# クリック時に波紋を追加
def mousePressed
  @ripples.push({ x: mouseX, y: mouseY, startTime: frameCount })
end

# タップ時に波紋を追加
def touchStarted
  @ripples.push({ x: mouseX, y: mouseY, startTime: frameCount })
  return false  # デフォルトの動作防止
end
