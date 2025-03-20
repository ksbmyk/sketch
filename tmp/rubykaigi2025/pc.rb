require "uart"
require "processing"
using Processing

def setup
  # ポートを指定 (Mac ls /dev/cu.* で確認)
  # Arduino の場合
  # port = "/dev/cu.usbmodem1101"
  # baud = 9600
  # Raspberry Pi Pico
  port = "/dev/cu.usbserial-BG00ECUT"
  baud = 115200

  # UART 通信を開始
  @uart = UART.open(port, baud)

  @circle_count = 10  # 円の個数
  @circle_size = 150  # 円のサイズ
  @hue_value = 200    # 色相
  @alpha_value = 150  # 透明度
  @distance = 200    # 距離
  # @speed = 10      # アニメーションの速度
  @is_dark_mode = false # トグルスイッチの状態
  @angle_offset = 0

  # fullScreen() # 全画面に表示
  size(1000, 1000)
  colorMode(HSB, 360, 100, 100, 255) # 色の指定をHBSモードに
  noStroke # 円の枠は表示しない
end

def draw
  handle_serial_data

  # blendMode(BLEND)
  if (@is_dark_mode)
    background(0, 0, 0)
    blendMode(ADD)
  else
    background(0, 0, 100)
    blendMode(MULTIPLY)
  end

  translate(width / 2, height / 2)
  fill(@hue_value, 80, 100, @alpha_value)
  # @angle_offset += @speed

  @circle_count.times do |i|
    angle = TWO_PI / @circle_count * i #+ @angle_offset
    x = cos(angle) * @distance
    y = sin(angle) * @distance
    circle(x, y, @circle_size + (i.even? ? 30 : -30))
  end
end

def handle_serial_data
  data = @uart.gets
  return if data.nil? || data.empty?
  if data
    line = data.chomp!
    values = line.split(',')

    if values.length == 2
      case values[0]
      when "T"
        @is_dark_mode = values[1] == "1"
        puts "T: #{values[1]}"
      when "0"
        @circle_count = map(values[1].to_i, 0, 4095, 1, 100).to_i
        puts "circleCount: #{@circle_count}"
      when "1"
        @circle_size = map(values[1].to_i, 0, 4095, 31, 500).to_i
        puts "circleSize: #{@circle_size}"
      when "2"
        @hue_value = map(values[1].to_i, 0, 4095, 0, 360).to_i
        puts "hueValue: #{@hue_value}"
      else
        puts "Error #{values}"
      end
    end
  end
end
