require 'ws2812'

rmt = RMTDriver.new(27)
led = WS2812.new(rmt)

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

    @background = [
      [0x000000, 0x000000, 0x000000, 0x000000, 0x000000],
      [0x000000, 0x9696FF, 0x9696FF, 0x9696FF, 0x000000],
      [0x9696FF, 0x000000, 0x000000, 0x000000, 0x9696FF],
      [0x000000, 0x9696FF, 0x000000, 0x9696FF, 0x000000],
      [0x000000, 0x000000, 0x9696FF, 0x000000, 0x000000]
    ]

    @matrix = [
      [0x000000, 0x000000, 0x000000, 0x000000, 0x000000],
      [0x000000, 0x000000, 0x000000, 0x000000, 0x000000],
      [0x000000, 0x000000, 0x000000, 0x000000, 0x000000],
      [0x000000, 0x000000, 0x000000, 0x000000, 0x000000],
      [0x000000, 0x000000, 0x000000, 0x000000, 0x000000]
    ]

    clear_to_background
  end

  def clear_to_background
    5.times do |y|
      5.times do |x|
        @matrix[y][x] = @background[y][x]
      end
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
    @led.show_hex(*pixels)
  end

  def bubble_animation(delay_ms)
    bubbles = []
  
    loop do
      clear_to_background
  
      bubbles.each { |b| b[:y] -= 1 }
      bubbles.reject! { |b| b[:y] < 0 }

      # 30%の確率で泡を追加
      if @randgen.rand(10) < 3
        bubbles << { x: @randgen.rand(5), y: 4 }
      end
  
      # 泡を描画
      bubbles.each do |b|
        set_pixel(b[:x], b[:y], 0xC53E73)  # 白[150, 150, 255]
      end
  
      show
      sleep_ms(delay_ms)
    end
  end
end

matrix = AtomMatrix.new(led)
matrix.bubble_animation(200)