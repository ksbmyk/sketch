require "uart"

# ポートを指定
# port = "/dev/cu.usbmodem1101"  # Mac ls /dev/cu.* で確認
# baud = 9600  # Arduino 側と合わせる
port = "/dev/cu.usbmodem1234567890121"
baud = 9600

# UART 通信を開始
uart = UART.open(port, baud)

puts "Arduino からのデータを待機中..."

# 継続的にデータを受信
loop do
  if (line = uart.gets)
    line.chomp!
    # puts "受信: #{line}" 

    if line.start_with?("T,")  # トグルスイッチ
      toggle_state = line.split(",")[1].to_i
      # puts "トグルスイッチの状態: #{toggle_state == 1 ? 'ON' : 'OFF'}"
    else
      sensor_id, sensor_value = line.split(",").map(&:to_i)

      # **センサー 0 のみ処理する**
      if sensor_id == 0
        puts "センサー #{sensor_id} の値: #{sensor_value}"
      end
    end
  end
end
