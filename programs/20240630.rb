$particles = []
COLORS = [
  [135, 206, 250], # Light Sky Blue
  [0, 191, 255], # Deep Sky Blue
  [30, 144, 255], # Dodger Blue
  [65, 105, 225], # Royal Blue
  [123, 104, 238], # Medium Slate Blue
  [70, 130, 180], # Steel Blue
  [100, 149, 237], # Cornflower Blue
  [0, 128, 128], # Teal Blue
  [0, 0, 128], # Navy Blue
  [72, 61, 139] # Dark Slate Blue
]

def setup
  createCanvas(700, 700)
  background(0)
  noStroke
end

def draw
   background(0)

  # 削除条件をを満たすのは、一番最初に描画された円なので、逆順に処理して最後に配列から消す
  $particles.reverse_each do |particle|
    a = particle[:alpha] / 10.0
    10.downto(1) do |j|
      fill(particle[:color][0], particle[:color][1], particle[:color][2], a * j)
      
      ellipse(particle[:x], particle[:y], j * 4, j * 4)
    end

    particle[:alpha] -= 5

    $particles.delete(particle) if particle[:alpha] <= 0
  end
end

def mousePressed
  add_particle(mouseX, mouseY)
end

def touchStarted
  add_particle(touchX, touchY)
end

def add_particle(x, y)
  color = COLORS.sample
  alpha = 255
  $particles << { x: x, y: y, color: color, alpha: alpha }
end
