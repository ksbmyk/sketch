require 'adc'

# 疎通確認用Lチカ
pin = GPIO.new(25, GPIO::OUT)
pin.write 1

# adc = ADC.new(26)

toggle = GPIO.new(2, GPIO::IN|GPIO::PULL_UP) # GP2（物理4）内部プルアップに設定

loop do
  puts "Toggle Switch State: #{toggle.read}"

  # value = adc.read # 0-3.3
  # value_r = adc.read_raw # 0-4095
  # puts "ADC Value: #{value}, #{value_r}"
  sleep 1
end
