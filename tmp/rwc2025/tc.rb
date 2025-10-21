require "uart"
require "processing"
using Processing

def setup
  # ポートを指定 (Mac ls /dev/cu.* で確認)
  port = "/dev/cu.usbserial-BG00ECUT"
  baud = 115200

  # UART 通信を開始
  @uart = UART.open(port, baud)

  @circle_count = 4 # 感圧
  @distance = 100 # 曲げ
  @circle_size = 150 # ボリューム
  @hue_value = 200 # ロータリエンコーダ
 
  @is_dark_mode = false # トグルスイッチ
  @angle_offset = 0
  @is_button_push = false # ボタン
  @speed = 0

  size(1000, 1000)
  colorMode(HSB, 360, 100, 100, 255)
  noStroke
end

def draw
  handle_serial_data

  blendMode(BLEND)
  if (@is_dark_mode)
    background(0, 0, 0)
    blendMode(ADD)
  else
    background(0, 0, 100)
    blendMode(MULTIPLY)
  end

  translate(width / 2, height / 2)
  fill(@hue_value, 80, 100, 150)

  @speed = @is_button_push ? 100 : 0

  @angle_offset += @speed

  @circle_count.times do |i|
    angle = TWO_PI / @circle_count * i + @angle_offset
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
      when "B"
        @is_button_push = values[1] == "1"
      when "R"
        @hue_value = ((values[1].to_i % 360) + 360) % 360
      when "P"
        @circle_size = map(values[1].strip.to_i, 0, 4095, 10, 500).to_i
      when "K"
        @circle_count = map(values[1].to_i, 10, 150, 4, 50).to_i
      when "M"
        @distance = map(values[1].to_i, 500, 3000, 50, 200).to_i
      else
        puts "Error #{values}"
      end
    end
  end
end
