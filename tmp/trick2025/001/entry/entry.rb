->(w, h, s) {
  c=[' ', '.', '*', '✨']
  h.times { |y| system('clear'); y.times { |l| puts ' ' * (l % w) + c.sample }; puts ' ' * (y % w) + '🌟'; sleep s }
  system('clear'); h.times { |l| puts ' ' * (l % w) + c.sample }
  puts '-' * w
}[50, 20, 0.1]
