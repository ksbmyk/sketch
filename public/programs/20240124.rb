# GENUARY 2024 jan24 "Impossible objects (undecided geometry)."
# https://genuary.art/prompts
# refs https://30min-processing.hatenablog.com/entry/2016/06/27/000000

def setup
  createCanvas(600, 600)
  colors1 = %w(#559fb5 #abd7c9 #bf6d7d)
  colors2 = %w(#e7df73 #bad545 #c39f39)
  colors3 = %w(#8da7b6 #895747 #d9bdd4)
  colors4 = %w(#5abad5 #67283f #96d1e6)
  @color = eval("colors#{rand(1..4)}")
  noLoop
end

def draw
    background("#efeddb")
    noStroke
    
    (0..5).each do |i|
      (0..3).each do |j|
        push
        translate(150*i, 85+150*j)
        impossible_object
        pop
      end
    end
  end

# ペンローズの三角形
def impossible_object
  fill(@color[0])
  side_object
  rotate(TWO_PI / 3)
  fill(@color[1])
  side_object
  rotate(TWO_PI / 3)
  fill(@color[2])
  side_object
end

def side_object
  e = 20 
  w = 20
  sin30 = sin(PI / 6)
  cos30 = cos(PI / 6)
  sin60 = sin(PI / 3)
  cos60 = cos(PI / 3)

  beginShape()
  x1 = -e * cos60
  y1 = (e * cos60) / sqrt(3)
  vertex(x1, y1)
  x2 = x1 - w
  y2 = y1
  vertex(x2, y2)
  x3 = x2 + (e + 3.0 * w) * cos60
  y3 = y2 - (e + 3.0 * w) * sin60
  vertex(x3, y3)
  x4 = x3 + (e + 4.0 * w) * sin30
  y4 = y3 + (e + 4.0 * w) * cos30
  vertex(x4, y4)
  x5 = x4 - w * cos60
  y5 = y4 + w * sin60
  vertex(x5, y5)
  x6 = x5 - (e + 3 * w) * cos60
  y6 = y5 - (e + 3 * w) * sin60
  vertex(x6, y6)
  endShape(CLOSE)
end
