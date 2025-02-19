->(w, h, s) {
  c=[' ','.','*','✨']
  h.times{|y|print "\e[H\e[2J";y.times{|l|puts' '.rjust(l%w)+c.sample};puts'🌟'.rjust(y%w);sleep s}
  print "\e[H\e[2J";h.times{|l|puts' '.rjust(l%w)+c.sample};puts'⛰️ '*h
}[50,20,0.1]
