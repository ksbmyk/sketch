->(w, h, s) {
  c=[' ', '.', '*', '✨']
  h.times { |y| system('clear'); y.times { |l| puts ' '.rjust(l % w) + c.sample }; puts '🌟'.rjust(y % w); sleep s }
  system('clear'); h.times { |l| puts ' '.rjust(l % w) + c.sample };puts '⛰️ ' * h
}[50, 20, 0.1]
