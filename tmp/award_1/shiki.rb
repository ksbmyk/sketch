def setup
  createCanvas(600, 600)
  textAlign(CENTER, CENTER)
  @flakes = []
  @flake_num = 100
  @seasons = [:spring, :summer, :autumn, :winter]
  @season_colors = {
  spring: [255, 182, 193],
  summer: [135, 206, 250],
  autumn: [204, 163, 0],
  winter: [0, 31, 63]
  }
  @season_params = {
    spring: { char: '✿', rotates: true, size: 32, color: [255, 105, 180]},
    summer: { char: ';', rotates: false, size: 32, color: [30, 144, 255]},
    autumn: { char: '♣', rotates: true, size: 32, color: [204, 85, 0]},
    winter: { char: '*', rotates: false, size: 50, color: [255, 255, 255]}
  }
  @current_season_index = 0
  @next_season_index = 1
  @lerp_ratio = 0
  @total_frames_per_season = 600
  initialize_objects(@current_season_index)
  frameRate(60)
end

def draw
  # 色変化のタイミングを調整するための変数
  transition_threshold = 0.5 # 0.5までのlerp_ratioで色を維持する

  # 季節を変えるコード
  @lerp_ratio += 1.0 / @total_frames_per_season
  
  # # 序盤は現在の色を維持し、後半で次の色に変化
  if (@lerp_ratio < transition_threshold)
    adjustedlerp_ratio = 0;  # 色を維持
  else
    adjustedlerp_ratio = map(@lerp_ratio, transition_threshold, 1, 0, 1)  # 徐々に変化
  end
  
  # 背景色の設定
  current_season_color = @season_colors[@seasons[@current_season_index]]
  next_season_color = @season_colors[@seasons[@next_season_index]]
  bg_color = lerpColor(color(*current_season_color), color(*next_season_color), adjustedlerp_ratio)
  background(bg_color)

  # 季節が変わるタイミング
  if @lerp_ratio >= 1
    @lerp_ratio = 0
    @current_season_index = (@current_season_index + 1) % @seasons.length
    @next_season_index = (@current_season_index + 1) % @seasons.length
    initialize_objects(@current_season_index)
  end

  # 表示
  @flakes.reject! do |obj|
    obj.update
    obj.display
    obj.is_out_of_screen?
  end
end

def initialize_objects(season_index)
  season_info = @season_params[@seasons[season_index]]
  @flake_num.times do
    x = rand(0..width)
    y = rand(-height..0)
    @flakes << Flake.new(x, y, season_info[:char], season_info[:color], season_info[:size], season_info[:rotates])
  end
end

class Flake
  attr_accessor :x, :y, :char, :rotates, :rotation, :speed

  def initialize(x, y, char, color, size, rotates)
    @x, @y, @char, @color, @size, @rotates = x, y, char, color, size, rotates
    @rotation = rotates ? rand(0..TWO_PI) : 0
    @speed = rand(2..5)
    @variation = rotates ? rand(-2..2) : 0
  end

  def update
    @y += @speed
    @rotation += 0.05 if @rotates
  end

  def display
    push
    translate(@x, @y)
    rotate(@rotation)
    fill(@color)
    textSize(@size)
    text(@char, 0, 0)
    pop
  end

  def is_out_of_screen?
    @y > height
  end
end
