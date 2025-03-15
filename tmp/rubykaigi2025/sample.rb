require "uart"

# ポートを指定 (Mac ls /dev/cu.* で確認)
# Arduino の場合
# port = "/dev/cu.usbmodem1101"
# baud = 9600
# Raspberry Pi Pico
port = "/dev/cu.usbserial-BG00ECUT"
baud = 115200

# UART 通信を開始
uart = UART.open(port, baud)

puts "pico からのデータを待機中..."

# 継続的にデータを受信
loop do
  if (line = uart.gets)
    line.chomp!
    puts "受信: #{line}"

#     if line.start_with?("T,")  # トグルスイッチ
#       toggle_state = line.split(",")[1].to_i
#       # puts "#{toggle_state == 1 ? 'ON' : 'OFF'}"
#     else
#       sensor_id, sensor_value = line.split(",").map(&:to_i)

#       if sensor_id == 0
#         puts "#{sensor_id} の値: #{sensor_value}"
#       end
#     end
  end
end
