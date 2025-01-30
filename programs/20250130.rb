# GENUARY 2025 jan30 "Abstract map."
# https://genuary.art/prompts
# かなり重い

def setup
  createCanvas(600, 600)
  noLoop

  # ランダムなサイト（点）を生成
  @sites = 20.times.map { createVector(rand(0..width), rand(0..height)) }
  @colors = 20.times.map { color(rand(150..255), rand(150..255), rand(150..255)) }
end

def draw
  background(255)

  # ボロノイ図
  (0...height.to_i).each do |y|
    (0...width.to_i).each do |x|
      closest_site = get_closest_site(x, y)
      stroke(closest_site[:color])
      point(x, y)
    end
  end
end

# 点 (x, y) に最も近いサイト（点）を求める
def get_closest_site(x, y)
  min_dist = Float::INFINITY
  closest_site = nil

  @sites.each_with_index do |site, i|
    d = dist(x, y, site.x, site.y)
    if d < min_dist
      min_dist = d
      closest_site = { site: site, color: @colors[i] }
    end
  end

  closest_site
end
