->(w, h, s) {
  c=[32.chr,'.','*','✨']
  h.times{|y|print"\e[H\e[2J";y.times{|l|puts 32.chr.rjust(l%w)+c.sample};puts'🌟'.rjust(y%w);sleep s}
  print"\e[H\e[2J";h.times{|l|puts 32.chr.rjust(l%w)+c.sample};puts'⛰️ '*h
}[50,20,0.1]
