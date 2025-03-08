require "uart"

# ポートを指定（環境によって異なるので変更）
port = "/dev/cu.usbmodem1101"  # macOS/Linux の場合（Windows なら "COM3" など）
baud = 9600  # Arduino 側と合わせる

# UART 通信を開始
uart = UART.open(port, baud)

puts "Arduino からのデータを待機中..."

# 継続的にデータを受信
loop do
  if (line = uart.gets)
    puts "受信: #{line.chomp}"  # 受信したデータを出力
  end
end
