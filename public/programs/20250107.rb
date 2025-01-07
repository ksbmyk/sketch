# GENUARY 2025 jan7 "Use software that is not intended to create art or images."
# https://genuary.art/prompts

class Ball
  attr_reader :position, :symbol

  def initialize(symbol, wait_time, height)
    @symbol = symbol
    @wait_time = wait_time
    @height = height
    @position = nil
    @direction = 1
  end

  def move(current_time)
    return if current_time < @wait_time

    if @position.nil?
      @position = 0
    else
      @position += @direction
      if @position == 0 || @position == @height
        @direction *= -1
      end
    end
  end
end

height = 20
num_balls = 5
balls = num_balls.times.map do
  Ball.new(
    rand < 0.5 ? "\e[36m○\e[0m" : "\e[36m●\e[0m",
    rand(10),
    height 
  )
end

current_time = 0
loop do
  system("clear")
  
  (0..height).each do |y|
    row = balls.map do |ball|
      if ball.position == y
        ball.symbol
      else
        " "
      end
    end.join(" " * 15)
    puts row
  end

  balls.each { |ball| ball.move(current_time) }

  current_time += 1
  sleep 0.1
end
