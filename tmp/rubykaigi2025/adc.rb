require 'adc'

pin = GPIO.new(25, GPIO::OUT)
pin.write 1

adc = ADC.new(26)
sleep 1 

loop do
  value = adc.read
  value_r = adc.read_raw
  voltage = adc.read_voltage
  puts "ADC Value: #{value}, #{value_r}, Voltage: #{voltage} V"
  sleep 1
end
