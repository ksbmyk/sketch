require "uart"

# ポートを指定（環境によって異なるので変更）
port = "/dev/cu.usbmodem1101"  # macOS/Linux の場合（Windows なら "COM3" など）
baud = 115200  # Arduino 側と合わせる

# UART 通信を開始
uart = UART.open(port, baud)

puts "Arduino からのデータを待機中..."

# 継続的にデータを受信
uart.each do |line|
  puts "受信: #{line.chomp}"  # 1行ずつ出力
end
