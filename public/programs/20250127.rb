# GENUARY 2025 jan27 "Make something interesting with no randomness or noise or trig."
# https://genuary.art/prompts

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
      t = frameCount - ripple[:start_time] - j * 10
      if t.between?(0, 200)
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
  @ripples.push({ x: mouseX, y: mouseY, start_time: frameCount })
end

# タップ時に波紋を追加
def touchStarted
  @ripples.push({ x: mouseX, y: mouseY, start_time: frameCount })
  return false  # デフォルトの動作防止
end
