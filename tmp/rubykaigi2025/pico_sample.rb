require 'uart'
require 'adc'

# 疎通確認用Lチカ
pin = GPIO.new(25, GPIO::OUT)
pin.write 1

# ポテンショメータ
# sensor_pins = [26, 27, 28]  # GP26～GP28
# sensors = sensor_pins.map { |pin| ADC.new(pin) }
sensor = ADC.new(26)

# ポテンショメータより先に設定するとトグルスイッチの値がとれない
toggle_pin = 2 # GP2（物理4）
toggle = GPIO.new(toggle_pin, GPIO::IN|GPIO::PULL_UP) # 内部プルアップに設定

# 初期値
# last_sensor_values = Array.new(sensor_pins.size, 0)
last_sensor_value = 0
last_toggle_state = false

# UART0 を使用（GP0: TX, GP1: RX）
uart = UART.new(unit: :RP2040_UART0, txd_pin: 0, rxd_pin: 1, baudrate: 115200)

loop do
  uart.write("Hello from Pico!\n")
  sleep 0.5

  toggle_state = toggle.read == 0  # LOW の場合 ON
  # トグルスイッチの変化があれば送信
  if toggle_state != last_toggle_state
    puts "T,#{toggle_state ? 1 : 0}"
    message = "T,#{toggle_state ? 1 : 0}\n"
    uart.write(message)  # シリアル送信
    sleep 0.5
    last_toggle_state = toggle_state
  end

  # ポテンショメータの値をチェック
  # sensors.each_with_index do |sensor, i|
  #   if (Time.now.to_f.to_i % 2) == 0 # 2秒に1回
  #     value = sensor.read_raw # 0〜4095 の値を取得
  #     if (value - last_sensor_values[i]).abs > 20 # 変化が大きければ送信
  #       puts "#{i},#{value}"
  #       message = "#{i},#{value}\n"
  #       uart.write(message)  # シリアル送信
  #       sleep 0.5
  #       last_sensor_values[i] = value
  #     end
  #   end
  # end

  if Time.now.to_i % 2 == 0 # 2秒に1回
    value = sensor.read_raw # 0〜4095 の値を取得
    if (value - last_sensor_value).abs > 20 # 変化が大きければ送信
      puts "0,#{value}"
      message = "0,#{value}\n"
      uart.write(message)  # シリアル送信
      sleep 0.5
      last_sensor_value = value
    end
  end
end
