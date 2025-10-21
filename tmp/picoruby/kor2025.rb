require 'ws2812'

rmt = RMTDriver.new(27)
led = WS2812.new(rmt)

class AtomMatrix
  def initialize(led)
    @led = led
    
    # 色の定義
    @orange = 0xFF4500  # オレンジ（六角形）
    @blue = 0x0080FF    # 青（軌道の明るい部分）
    @blue_dim = 0x004080  # 暗い青（軌道のベース）
    @black = 0x000000   # 黒（消灯）
    
    # パターンをインデックス配列で管理
    # 六角形のインデックス
    @hexagon = [1, 2, 3, 5, 9, 10, 14, 15, 19, 21, 22, 23]
    
    # 軌道のインデックス
    @orbit = [4, 8, 12, 16, 20]
    
    @pixels = Array.new(25, @black)
    
    @counter = 0
  end
  
  def show
    @led.show_hex(*@pixels)
  end
  
  def draw_hexagon
    # 六角形
    @hexagon.each do |i|
      @pixels[i] = @orange
    end
  end
  
  def flowing_light_animation(delay_ms)
    loop do
      # 全消去
      25.times { |i| @pixels[i] = @black }
      
      draw_hexagon
      
      # 軌道全体を暗い青で描画（ベースライン）
      @orbit.each do |i|
        @pixels[i] = @blue_dim
      end
      
      # 光の位置（0-4）
      light_pos = @counter % 5
      
      # 現在の光の位置を明るく
      @pixels[@orbit[light_pos]] = @blue
      
      # 前の位置も少し明るく
      if light_pos > 0
        @pixels[@orbit[light_pos - 1]] = 0x0060C0
      end
      
      show
      sleep_ms(delay_ms)
      @counter = (@counter + 1) % 100  # オーバーフロー防止
    end
  end
end

# 実行
matrix = AtomMatrix.new(led)

matrix.flowing_light_animation(150)
