# GENUARY 2026 jan5 "Write “Genuary”. Avoid using a font."
# https://genuary.art/prompts


class Letter
  attr_reader :rects
  
  def initialize(rects)
    @rects = rects
  end
  
  def contains?(px, py)
    @rects.any? do |r|
      x, y, w, h = r
      px >= x && px <= x + w && py >= y && py <= y + h
    end
  end
  
  def nearest_edge_direction(px, py)
    min_dist = Float::INFINITY
    direction = [1, 0]
    
    @rects.each do |r|
      x, y, w, h = r
      next unless px >= x && px <= x + w && py >= y && py <= y + h
      
      edges = [
        { dist: py - y, dir: [1, 0] },
        { dist: y + h - py, dir: [-1, 0] },
        { dist: px - x, dir: [0, 1] },
        { dist: x + w - px, dir: [0, -1] }
      ]
      
      nearest = edges.min_by { |e| e[:dist] }
      if nearest[:dist] < min_dist
        min_dist = nearest[:dist]
        direction = nearest[:dir]
      end
    end
    
    direction
  end
end

class Particle
  attr_accessor :x, :y, :px, :py, :remaining, :duration
  
  def initialize(x, y)
    @x = x
    @y = y
    @px = x
    @py = y
    @duration = rand(100..300)
    @remaining = @duration
  end
  
  def update(letters, speed)
    @px = @x
    @py = @y
    
    letters.each do |letter|
      if letter.contains?(@x, @y)
        dir = letter.nearest_edge_direction(@x, @y)
        @x += dir[0] * speed
        @y += dir[1] * speed
        break
      end
    end
    
    @remaining -= 1
  end
  
  def expired?
    @remaining <= 0
  end
  
  def alpha
    (@remaining.to_f / @duration * 255).to_i
  end
end

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 255)
  background(0)
  
  @letters = create_letters
  @particles = []
  @speed = 2
end

def draw
  fill(0, 0, 0, 15)
  noStroke
  rect(0, 0, 700, 700)
  
  5.times { spawn_particle }
  
  @particles.each do |p|
    p.update(@letters, @speed)
    stroke(190, 80, 100, p.alpha)
    strokeWeight(1.5)
    line(p.px, p.py, p.x, p.y)
  end
  
  @particles.reject!(&:expired?)
end

def spawn_particle
  50.times do
    x = rand(30..670)
    y = rand(200..480)
    
    @letters.each do |letter|
      if letter.contains?(x, y)
        @particles << Particle.new(x, y)
        return
      end
    end
  end
end

def create_letters
  letters = []
  
  s = 12          # ストローク幅
  cap_h = 100     # 大文字高さ
  x_h = 70        # 小文字高さ
  desc = 25       # ディセンダー
  baseline = 370  # ベースライン
  cap_top = baseline - cap_h
  x_top = baseline - x_h
  
  char_w = 50     # 文字幅
  
  x = 50
  
  # G: 左縦 + 上横 + 下横 + 右縦（下半分） + 中央横（右から中央へ）
  g_w = char_w + 10
  letters << Letter.new([
    [x, cap_top, s, cap_h],                              # 左縦棒
    [x, cap_top, g_w, s],                                # 上横棒
    [x, baseline - s, g_w, s],                           # 下横棒
    [x + g_w - s, cap_top + cap_h/2, s, cap_h/2],        # 右縦棒（下半分のみ）
    [x + g_w/2, cap_top + cap_h/2 - s/2, g_w/2, s]       # 中央横棒（右から中央へ）
  ])
  x += 80
  
  # e: 上部は閉じた箱、下部は右が開いている
  letters << Letter.new([
    [x, x_top, s, x_h],                        # 左縦棒
    [x, x_top, char_w, s],                     # 上横棒
    [x + char_w - s, x_top, s, x_h/2 + s/2],   # 右縦棒（上半分のみ）
    [x, x_top + x_h/2 - s/2, char_w, s],       # 中央横棒
    [x, baseline - s, char_w, s]               # 下横棒（右開き）
  ])
  x += 65
  
  # n: 左縦 + 上横 + 右縦
  letters << Letter.new([
    [x, x_top, s, x_h],                        # 左縦棒
    [x, x_top, char_w, s],                     # 上横棒
    [x + char_w - s, x_top, s, x_h]            # 右縦棒
  ])
  x += 65
  
  # u: 左縦 + 下横 + 右縦
  letters << Letter.new([
    [x, x_top, s, x_h],                        # 左縦棒
    [x, baseline - s, char_w, s],              # 下横棒
    [x + char_w - s, x_top, s, x_h]            # 右縦棒
  ])
  x += 65
  
  # a: 上横 + 左縦（上半分） + 中央横 + 右縦（全高） + 左下の足
  letters << Letter.new([
    [x, x_top, 50, s],                         # 上横棒
    [x, x_top + x_h/2 - s/2, s, x_h/2 + s/2],  # 左縦棒（下半分）
    [x, x_top + x_h/2 - s/2, 50, s],           # 中央横棒
    [x, baseline - s, 55, s],                  # 下横棒（右にはみ出す）
    [x + 50 - s, x_top, s, x_h]                # 右縦棒
  ])
  x += 65
  
  # r: 左縦 + 上横（短い）
  letters << Letter.new([
    [x, x_top, s, x_h],                  # 左縦棒
    [x, x_top, 50, s]                    # 上横棒
  ])
  x += 65
  
  # y: 左縦（全高） + 右縦（全高） + 下横 + 下横棒
  letters << Letter.new([
    [x, x_top, s, x_h],                        # 左縦棒
    [x + 50 - s, x_top, s, x_h + desc],        # 右縦棒
    [x, baseline - s, 50, s],                  # 下横棒
    [x, baseline + desc - s, 50, s]            # 下横棒
  ])
  letters
end