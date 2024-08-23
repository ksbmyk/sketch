$falling_objects = []
$num_objects = 10
$seasons = ["spring", "summer", "autumn", "winter"]
$season_colors = {
  "spring" => [0, 0, 0],       # 春色 (ピンク)
  "summer" => [255, 182, 193], # 夏色 (空色)
  "autumn" => [135, 206, 250], # 秋色 (オレンジ)
  "winter" => [255, 204, 0]    # 冬色 (黒)
}

$season_objects = {
  "spring" => { char: '🌸', rotates: true },
  "summer" => { char: '💧', rotates: false },
  "autumn" => { char: '🍁', rotates: true },
  "winter" => { char: '❄️', rotates: true }
}

$current_season_index = 0
$next_season_index = 1
$lerp_amount = 0
$total_frames_per_season = 500

def setup
  createCanvas(600, 600)
  textAlign(CENTER, CENTER)
  initialize_objects
end

def draw
  textSize(32)
  # 背景色の設定
  current_season_color = $season_colors[$seasons[$current_season_index]]
  next_season_color = $season_colors[$seasons[$next_season_index]]

  #adjusted_lerp_amount = $lerp_amount

  #bg_color = lerpColor(color(*current_season_color), color(*next_season_color), adjusted_lerp_amount)
  bg_color = lerpColor(color(*current_season_color), color(*next_season_color), $lerp_amount)
  background(bg_color)

  # オブジェクトを表示
  $falling_objects.reject! do |obj|
    obj.update
    obj.display
    obj.is_out_of_screen
  end

  # 徐々に次の季節へ
  $lerp_amount += 1.0 / $total_frames_per_season
  if $lerp_amount >= 1
    $lerp_amount = 0
    $current_season_index = ($current_season_index + 1) % $seasons.length
    $next_season_index = ($current_season_index + 1) % $seasons.length
    add_new_season_objects
  end
end

def initialize_objects
  season_info = $season_objects[$seasons[$current_season_index]]
  
  # $num_objects.times do
  10.times do
    x = rand(0..width)
    y = rand(-height..0)
    $falling_objects << FallingObject.new(x, y, season_info[:char], season_info[:rotates])
  end
end

def add_new_season_objects
  season_info = $season_objects[$seasons[$current_season_index]]

  # 新しい季節のオブジェクトを追加（古いオブジェクトは落ち切るまで残る）
  # $num_objects.times do
  10.times do
    x = rand(0..width)
    y = rand(-height..0)
    $falling_objects << FallingObject.new(x, y, season_info[:char], season_info[:rotates])
  end
end

# FallingObjectクラスを定義
class FallingObject
  attr_accessor :x, :y, :char, :rotates, :rotation, :speed

  def initialize(x, y, char, rotates)
    @x = x
    @y = y
    @char = char
    @rotates = rotates
    @rotation = rotates ? rand(0..TWO_PI) : 0  # 回転しない場合は0に固定
    @speed = rand(2..5)
  end

  def update
    @y += @speed
    @rotation += 0.05 if @rotates
  end

  def display
    push
    translate(@x, @y)
    rotate(@rotation)  # rotatesがfalseならrotationは0なので回転しない
    text(@char, 0, 0)
    pop
  end
  
  # オブジェクトが画面外に出たかどうかをチェックする
  def is_out_of_screen
    @y > height
  end
end
