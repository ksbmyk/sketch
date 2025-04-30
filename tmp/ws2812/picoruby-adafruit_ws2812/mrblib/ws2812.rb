require 'rmt'

class WS2812
  def initialize(pin, max_pixels)
    @rmt = RMT.new(pin,
    t0h_ns: 350,
    t0l_ns: 800,
    t1h_ns: 700,
    t1l_ns: 600,
    reset_ns: 80_000, # 80µs
    max_pixels: max_pixels
  )
  end

  def send_pixel(color)
    r, g, b = parse_color(color)
    # bytes = [g, r, b] # WS2812はGRB順
    @rmt.write([g, r, b])
  end

  def show(*colors)
    bytes = []
    colors.each do |color|
      puts "color: #{color}"
      # row.each do |color|
        r, g, b = parse_color(color)
        # WS2812 は GRB の順でバイトを受け取る
        bytes << g << r << b
      # end
    end
    puts "color: #{bytes}"
    @rmt.write(bytes)
  end

  def parse_color(color)
    if color.is_a?(Integer)
      [(color>>16)&0xFF, (color>>8)&0xFF, color&0xFF]
    else
      color
    end
  end
end
