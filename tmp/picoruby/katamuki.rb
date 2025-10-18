require 'i2c'
require 'mpu6886'

puts "傾き検知プログラム開始"

# ATOM Matrix用のI2C設定
i2c = I2C.new(
  unit: :ESP32_I2C0,
  frequency: 100_000,
  sda_pin: 25,
  scl_pin: 21
)

# MPU6886センサーを初期化
mpu = MPU6886.new(i2c)

puts "センサー初期化完了"
puts "---"

# センサーデータを繰り返し読み取る
loop do
  # 加速度を取得（単位：G、重力加速度）
  accel = mpu.acceleration
  
  # 傾き角度を取得（単位：度）
  tilt = mpu.tilt_angles
  
  # X軸方向の傾きを判定（閾値：0.3G）
  if accel[:x] > 0.3
    puts "右に傾いています！ X軸: #{accel[:x]}"
  elsif accel[:x] < -0.3
    puts "左に傾いています！ X軸: #{accel[:x]}"
  end
  
  # Y軸方向の傾きを判定（閾値：0.3G）
  if accel[:y] > 0.3
    puts "前に傾いています！ Y軸: #{accel[:y]}"
  elsif accel[:y] < -0.3
    puts "後ろに傾いています！ Y軸: #{accel[:y]}"
  end
  
  # 詳細な数値も表示
  puts "加速度 X:#{accel[:x]} Y:#{accel[:y]} Z:#{accel[:z]} (G単位)"
  puts "傾き角度 Pitch:#{tilt[:pitch]} Roll:#{tilt[:roll]} (度)"
  puts "---"
  
  # 200ミリ秒待機
  sleep_ms 200
end