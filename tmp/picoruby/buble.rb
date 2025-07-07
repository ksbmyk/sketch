require 'ws2812'

class SimpleRand
  def initialize(seed = 12345)
    @seed = seed
  end

  def rand(max)
    @seed = (@seed * 1103515245 + 12345) & 0x7fffffff
    @seed % max
  end
end

class AtomMatrix
  def initialize(led)
    @led = led
    @randgen = SimpleRand.new
    @matrix = []
    5.times do
      row = []
      5.times do
        row << [0, 0, 0]
      end
      @matrix << row
    end
  end

  def set_pixel(x, y, color)
    return if x < 0 || x >= 5 || y < 0 || y >= 5
    @matrix[y][x] = color
  end

  def show
    pixels = []
    5.times do |y|
      5.times do |x|
        pixels << @matrix[y][x]
      end
    end
    @led.show_rgb(*pixels)
  end

  def clear
    5.times do |y|
      5.times do |x|
        @matrix[y][x] = [0, 0, 0]
      end
    end
    show
  end

  def bubble_animation(delay_ms)
    bubbles = []
  
    loop do
      clear
  
      # 泡を1段上に
      bubbles.each { |b| b[:y] -= 1 }

      # 画面内にある泡だけ残す
      bubbles.reject! { |b| b[:y] < 0 }

      # 30%の確率で新しい泡を一番下に追加。
      if @randgen.rand(10) < 3
        bubbles << { x: @randgen.rand(5), y: 4 }
      end
  
      # 泡を描画
      bubbles.each do |b|
        set_pixel(b[:x], b[:y], [150, 150, 255])
      end
  
      show
      sleep_ms(delay_ms)
    end
  end
end

rmt = RMTDriver.new(27)
led = WS2812.new(rmt)
matrix = AtomMatrix.new(led)
matrix.bubble_animation(150)