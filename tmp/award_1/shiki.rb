def setup
  createCanvas(600, 600)
  textAlign(CENTER, CENTER)
  @falling_objects = []
  @seasons = [:spring, :summer, :autumn, :winter]
  @season_colors = {
    spring: [0, 0, 0], 
    summer: [255, 182, 193], 
    autumn: [135, 206, 250], 
    winter:  [255, 204, 0] 
  }
  @season_objects = {
    spring: { char: '✿', rotates: true, size: 32, color: [255, 105, 180]},
    summer: { char: ';', rotates: false, size: 32, color: [30, 144, 255]},
    autumn: { char: '♣', rotates: true, size: 32, color: [204, 85, 0]},
    winter: { char: '*', rotates: false, size: 50, color: [255, 255, 255]}
  }
  @current_season_index = 0
  @next_season_index = 1
  @lerp_amount = 0
  @total_frames_per_season = 500
  initialize_objects(@current_season_index)
  frameRate(60)
end

def draw
  current_season_color = @season_colors[@seasons[@current_season_index]]
  next_season_color = @season_colors[@seasons[@next_season_index]]

  bg_color = lerpColor(color(*current_season_color), color(*next_season_color), @lerp_amount)
  background(bg_color)

  @falling_objects.reject! do |obj|
    obj.update
    obj.display
    obj.is_out_of_screen?
  end

  @lerp_amount += 1.0 / @total_frames_per_season
  if @lerp_amount >= 1
    @lerp_amount = 0
    @current_season_index = (@current_season_index + 1) % @seasons.length
    @next_season_index = (@current_season_index + 1) % @seasons.length
    initialize_objects(@current_season_index)
  end
end

def initialize_objects(season_index)
  season_info = @season_objects[@seasons[season_index]]
  10.times do
    x = rand(0..width)
    y = rand(-height..0)
    @falling_objects << FallingObject.new(x, y, season_info[:char], season_info[:color], season_info[:size], season_info[:rotates])
  end
end

class FallingObject
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
