def setup
  createCanvas(400, 400)
end

def draw
  background(150, 180, 255)
  createGrid
  showGrid
  # t += 0.01
end

def createGrid
  @grid = []
  tileSize = width / tileCount
  ynoise = t
  (0...tileCount).each do |row|
    @grid[row] = []
    xnoise = t
    (0...tileCount).each do |col|
      x = col * tileSize
      y = row * tileSize
      a = noise(xnoise, ynoise) * 255
      @grid[row][col] = Tile.new(x, y, tileSize, a)
      xnoise += noiseScale
    end
    ynoise += noiseScale
  end
end

def showGrid
  (0...tileCount).each do |row|
    (0...tileCount).each do |col|
      @grid[row][col].show
    end
  end
end

class Tile
  attr_reader :x, :y, :size, :c

  def initialize(x, y, size, a)
    @x = x
    @y = y
    @size = size
    @c = color(255, a)
  end

  def show
    noStroke
    fill(c)
    rect(x, y, size, size)
  end
end

# 初期設定
$tileCount = 100
$noiseScale = 0.05
$t = 0

P5::init