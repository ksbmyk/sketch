require 'processing'
using Processing

setup { createCanvas(600, 600); textAlign(CENTER, CENTER); i; f }
draw { u; h; uf }

private

def i
  @f = []; @n = 150
  @s = [:spring, :summer, :autumn, :winter]
  @d = { spring: { c: '✿', r: true, s: 32, co: [255, 105, 180], bg: [255, 182, 193] },
         summer: { c: ';', r: false, s: 32, co: [30, 144, 255], bg: [135, 206, 250] },
         autumn: { c: '♠', r: true, s: 32, co: [204, 85, 0], bg: [204, 163, 0] },
         winter: { c: '*', r: false, s: 50, co: [255, 255, 255], bg: [0, 31, 63] } }
  @cs, @ns, @l, @sf = :spring, :summer, 0.0, 600
end

def u
  t = 0.5; l = @l < t ? 0 : map(@l, t, 1, 0, 1)
  bg = lerpColor(color(*@d[@cs][:bg]), color(*@d[@ns][:bg]), l)
  background(*[red(bg), green(bg), blue(bg), alpha(bg)])
  @l += 1.0 / @sf
end

def h
  @l >= 1 && (@l = 0; @cs = @ns; @ns = @s[(@s.index(@cs) + 1) % @s.length]; f)
end

def f
  @n.times { |i| @f << F.new(rand(width), rand(-height * 1.2..0), @d[@cs][:c], @d[@cs][:co], @d[@cs][:s], @d[@cs][:r]) }
end

def uf
  @f.reject! { |x| x.u; x.d; x.o }
end

class F
  attr_reader :x, :y, :c, :co, :s
  def initialize(x, y, c, co, s, r)
    @x, @y, @c, @co, @s, @r = x, y, c, co, s, r ? rand(TWO_PI) : 0
    @sp = rand(2.0..6.0)
    @v = r ? rand(-2.0..2.0) : 0
  end

  def u
    @y += @sp; @x += @v; @r += 0.05 if @r != 0
  end

  def d
    push; translate(@x, @y); rotate(@r); fill(*@co); textSize(@s); text(@c, 0, 0); pop
  end

  def o
    @y > height + 10
  end
end
