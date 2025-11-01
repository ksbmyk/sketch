require 'adc'
require 'uart'

# 疎通確認用Lチカ
pin = GPIO.new(25, GPIO::OUT)
pin.write 1

# 可変抵抗器(1)
pot = ADC.new(26)

# 可変抵抗器(2)
bend = ADC.new(27)

# 可変抵抗器(3)
pressure = ADC.new(28)

# トグルスイッチ
toggle = GPIO.new(2, GPIO::IN|GPIO::PULL_UP) # 内部プルアップに設定

# プッシュボタン
button = GPIO.new(4, GPIO::IN|GPIO::PULL_UP) # 内部プルアップに設定

# ロータリーエンコーダー
a = GPIO.new(14, GPIO::IN|GPIO::PULL_UP)
b = GPIO.new(15, GPIO::IN|GPIO::PULL_UP)
last_state = (a.read << 1) | b.read
pos = 0

# ADC 履歴
pot_readings = []
bend_readings = []
pressure_readings = []

# 初期値
last_toggle_state = 0
last_pot_value = 0
last_bend_value = 0
last_pressure_value = 0

button_pressed = false


uart = UART.new(unit: :RP2040_UART0, txd_pin: 0, rxd_pin: 1, baudrate: 115200)
puts "start"
loop do
  # トグルスイッチ
  toggle_state = (toggle.read == 0) # LOW の場合 ON
  if toggle_state != last_toggle_state # 変化があれば出力
    puts "スイッチ: #{toggle_state ? 'ON' : 'OFF'}"
    uart.write("T,#{toggle_state ? 1 : 0}\n")  # シリアル送信
    sleep_ms 5
    last_toggle_state = toggle_state
  end

  if button.read == 0 # 押された
    if !button_pressed
      puts "ボタン : 押された"
      uart.write("B,1\n")
      sleep_ms 5
      button_pressed = true
    end
  else # 離された
    if button_pressed
      puts "ボタン: 離された"
      uart.write("B,0\n")
      sleep_ms 5
      button_pressed = false
    end
  end

  # ロータリーエンコーダー
  state = (a.read << 1) | b.read
  if state != last_state
    case [last_state, state]
    when [0b00, 0b01], [0b01, 0b11], [0b11, 0b10], [0b10, 0b00]
      pos += 1
      puts "ロータリーエンコーダー: #{pos}"
      uart.write("R,#{pos}\n")
    when [0b00, 0b10], [0b10, 0b11], [0b11, 0b01], [0b01, 0b00]
      pos -= 1
      puts "ロータリーエンコーダー: #{pos}"
      uart.write("R,#{pos}\n")
    else
    #   無効な遷移は無視
    end
    last_state = state
    sleep_ms 1  # ← 1msに短縮（またはこの行を削除）
  end

  # 各ADC値
  current_pot_raw = pot.read_raw
  current_bend_raw = bend.read_raw
  current_pressure_raw = pressure.read_raw

  # 可変抵抗器(1)
  pot_readings << current_pot_raw
  pot_readings.shift if pot_readings.length > 5 # 移動平均フィルタサイズ5

  pot_sum = 0
  pot_readings.each { |val| pot_sum += val }
  filtered_pot_value = pot_sum / pot_readings.length if pot_readings.length > 0

  # 可変抵抗器(2)
  bend_readings << current_bend_raw
  bend_readings.shift if bend_readings.length > 5

  bend_sum = 0
  bend_readings.each { |val| bend_sum += val }
  filtered_bend_value = bend_sum / bend_readings.length if bend_readings.length > 0

  # 可変抵抗器(3)
  pressure_readings << current_pressure_raw
  pressure_readings.shift if pressure_readings.length > 5
  
  pressure_sum = 0
  pressure_readings.each { |val| pressure_sum += val }
  filtered_pressure_value = pressure_sum / pressure_readings.length if pressure_readings.length > 0

  # フィルタリングされた値が十分に変化した場合のみ出力
  if filtered_pot_value && (filtered_pot_value - last_pot_value).abs > 50
    puts "可変抵抗器 1 #{filtered_pot_value}"
    uart.write("P,#{filtered_pot_value}\n")
    sleep_ms 5
    last_pot_value = filtered_pot_value
  end

  if filtered_bend_value && (filtered_bend_value - last_bend_value).abs > 50
    puts "可変抵抗器 2: #{filtered_bend_value}"
    uart.write("M,#{filtered_bend_value}\n")
    sleep_ms 5
    last_bend_value = filtered_bend_value
  end

  if filtered_pressure_value && (filtered_pressure_value - last_pressure_value).abs >  50
    puts "可変抵抗器 3: #{filtered_pressure_value}"
    uart.write("K,#{filtered_pressure_value}\n")
    sleep_ms 5
    last_pressure_value = filtered_pressure_value
  end

  sleep_ms 1
end
