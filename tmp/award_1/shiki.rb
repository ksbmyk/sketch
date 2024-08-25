def setup
  createCanvas(600, 600)
  textAlign(CENTER, CENTER)
  initialize_data
  initialize_flakes
  frameRate(60)
end

def draw
  update_background_color
  handle_season_transition
  update_and_display_flakes
end

private

def initialize_data
  @flakes = []
  @flake_num = 100
  @seasons = [:spring, :summer, :autumn, :winter]
  @season_data = {
    spring: { char: '✿', rotates: true, size: 32, color: [255, 105, 180], bg_color: [255, 182, 193] },
    summer: { char: ';', rotates: false, size: 32, color: [30, 144, 255], bg_color: [135, 206, 250] },
    autumn: { char: '♣', rotates: true, size: 32, color: [204, 85, 0], bg_color: [204, 163, 0] },
    winter: { char: '*', rotates: false, size: 50, color: [255, 255, 255], bg_color: [0, 31, 63] }
  }
  @current_season = :spring
  @next_season = :summer
  @lerp_ratio = 0.0
  @season_frame_count = 600
end

def update_background_color
  transition_threshold = 0.5  # 色変化の開始点
  adjusted_lerp_ratio = @lerp_ratio < transition_threshold ? 0 : map(@lerp_ratio, transition_threshold, 1, 0, 1)
  
  current_bg_color = @season_data[@current_season][:bg_color]  # 現在の季節の背景色
  next_bg_color = @season_data[@next_season][:bg_color]  # 次の季節の背景色
  bg_color = lerpColor(color(*current_bg_color), color(*next_bg_color), adjusted_lerp_ratio)  # 背景色の補間
  
  background(bg_color)
  @lerp_ratio += 1.0 / @season_frame_count
end

def handle_season_transition
  if @lerp_ratio >= 1
    @lerp_ratio = 0
    @current_season = @next_season
    @next_season = @seasons[(@seasons.index(@current_season) + 1) % @seasons.length]
    initialize_flakes
  end
end

def initialize_flakes
  season_attributes = @season_data[@current_season]
  @flake_num.times do
    x = rand(width)
    y = rand(-height..0)
    @flakes << Flake.new(x, y, season_attributes[:char], season_attributes[:color], season_attributes[:size], season_attributes[:rotates])
  end
end

def update_and_display_flakes
  @flakes.reject! do |flake|
    flake.update
    flake.display
    flake.out_of_screen?
  end
end

class Flake
  attr_reader :x, :y, :char, :color, :size

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

  def out_of_screen?
    @y > height
  end
end
