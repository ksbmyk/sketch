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
end

def draw
  data = @uart.gets

  # return if data.nil? || data.empty?
  if data
    line = data.chomp!
    # puts "line: #{line}"

    values = line.split(',')
    # puts "values: #{values}"

    if values.length == 2
      case values[0]
      when "T"
        # @is_dark_mode = values[1] == "1"
        puts "T: #{values[1]}"
      when "0"
        # @circle_count = map(values[1].to_i, 0, 1023, 1, 100)
        # puts "circleCount: #{@circle_count}"
        puts "0: #{values[1]}"
      when "1"
        # @circle_size = map(values[1].to_i, 0, 1023, 31, 800)
        # puts "circleSize: #{@circle_size}"
        puts "1: #{values[1]}"
      when "2"
        # @hue_value = map(values[1].to_i, 0, 1023, 0, 360)
        # puts "hueValue: #{@hue_value}"
        puts "2: #{values[1]}"
      else
        puts "Error"
      end
    end
  end
end
