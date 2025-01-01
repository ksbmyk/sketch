def shooting_star(width, height, speed)
  chars = [' ', '.', '*', '✨']
  (1..height).each do |y|
    system('clear')
    (1..y).each do |line|
      puts " " * (line % width) + chars.sample
    end
    puts " " * (y % width) + "🌟"
    sleep(speed)
  end
  
  system('clear')
  (1..height).each do |line|
    puts " " * (line % width) + chars.sample
  end
end

shooting_star(50, 20, 0.1)