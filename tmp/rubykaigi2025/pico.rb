require 'adc'

# 疎通確認用Lチカ
pin = GPIO.new(25, GPIO::OUT)
pin.write 1

# ポテンショメータ
sensor_pins = [26, 27, 28]  # GP26～GP28
sensors = sensor_pins.map { |pin| ADC.new(pin) }

toggle_pin = 2 # GP2（物理4）
toggle = GPIO.new(toggle_pin, GPIO::IN|GPIO::PULL_UP) # 内部プルアップに設定

# 初期値
last_sensor_values = Array.new(sensor_pins.size, 0)
last_toggle_state = false

loop do
  toggle_state = toggle.read == 0  # LOW の場合 ON

  # トグルスイッチの変化があれば送信
  if toggle_state != last_toggle_state
    puts "T,#{toggle_state ? 1 : 0}"
    last_toggle_state = toggle_state
  end

  # ポテンショメータの値をチェック
  sensors.each_with_index do |sensor, i|
    value = sensor.read_raw # 0〜4095 の値を取得
    if (value - last_sensor_values[i]).abs > 20 # 変化が大きければ送信
      puts "#{i},#{value}"
      last_sensor_values[i] = value
    end
  end

  sleep 0.5
end
