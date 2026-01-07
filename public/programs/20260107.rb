# GENUARY 2026 jan6 "Lights on/off. Make something that changes when you switch on or off the “digital” lights."
# https://genuary.art/prompts


class Gate
  attr_reader :x, :y, :gate_type, :inputs, :outputs, :hue
  
  TYPES = [:and, :or, :not, :xor, :nand]
  
  def initialize(x, y, gate_type)
    @x = x
    @y = y
    @gate_type = gate_type
    @inputs = []   # 入力として接続されている配線
    @outputs = []  # 出力として接続されている配線
    # ゲートタイプごとに色相を割り当て
    @hue = case gate_type
           when :and  then 150
           when :or   then 172
           when :not  then 195
           when :xor  then 217
           when :nand then 240
           end
  end
end

class Wire
  attr_reader :from_gate, :to_gate, :segments, :total_length
  attr_accessor :hue
  
  def initialize(from_gate, to_gate)
    @from_gate = from_gate
    @to_gate = to_gate
    @hue = from_gate.hue
    @segments = calculate_segments
    @total_length = calculate_total_length
  end
  
  # 直角折れの経路を計算（水平→垂直）
  def calculate_segments
    x1, y1 = @from_gate.x + 18, @from_gate.y
    x2, y2 = @to_gate.x - 18, @to_gate.y
    mid_x = (x1 + x2) / 2.0
    
    [
      { x1: x1, y1: y1, x2: mid_x, y2: y1 },
      { x1: mid_x, y1: y1, x2: mid_x, y2: y2 },
      { x1: mid_x, y1: y2, x2: x2, y2: y2 }
    ]
  end
  
  def calculate_total_length
    @segments.sum do |seg|
      Math.sqrt((seg[:x2] - seg[:x1])**2 + (seg[:y2] - seg[:y1])**2)
    end
  end
  
  # 配線上の位置を0.0〜1.0のパラメータで取得
  def position_at(t)
    target_dist = t * @total_length
    current_dist = 0.0
    
    @segments.each do |seg|
      seg_length = Math.sqrt((seg[:x2] - seg[:x1])**2 + (seg[:y2] - seg[:y1])**2)
      if current_dist + seg_length >= target_dist
        ratio = (target_dist - current_dist) / seg_length
        return {
          x: seg[:x1] + (seg[:x2] - seg[:x1]) * ratio,
          y: seg[:y1] + (seg[:y2] - seg[:y1]) * ratio
        }
      end
      current_dist += seg_length
    end
    
    { x: @segments.last[:x2], y: @segments.last[:y2] }
  end
end

class Pulse
  attr_reader :wire, :progress, :alive, :hue
  
  def initialize(wire)
    @wire = wire
    @progress = 0.0
    @alive = true
    @hue = wire.hue
    @speed = rand(0.005..0.015)
  end
  
  def update
    @progress += @speed
    @hue = lerp_hue(@wire.from_gate.hue, @wire.to_gate.hue, @progress)
    @alive = false if @progress >= 1.0
  end
  
  def position
    @wire.position_at(@progress)
  end
  
  private
  
  def lerp_hue(h1, h2, t)
    h1 + (h2 - h1) * t
  end
end

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  @gates = []
  @wires = []
  @pulses = []
  @frame_count = 0
  
  generate_circuit
end

def generate_circuit
  # 画面を緩やかなグリッドに分割してゲートを配置
  grid_cols = 5
  grid_rows = 4
  cell_w = 700.0 / grid_cols
  cell_h = 700.0 / grid_rows
  margin = 60
  
  grid_cols.times do |col|
    grid_rows.times do |row|
      # 各セルに70%の確率でゲートを配置
      next unless rand < 0.7
      
      x = margin + col * cell_w + rand(-20..20)
      y = margin + row * cell_h + rand(-20..20)
      gate_type = Gate::TYPES.sample
      @gates << Gate.new(x, y, gate_type)
    end
  end
  
  # ゲート間を配線で接続
  @gates.each_with_index do |gate, i|
    # 各ゲートから1〜2本の出力配線を生成
    num_outputs = rand(1..2)
    candidates = @gates.select.with_index { |g, j| j != i && g.x > gate.x - 50 }
    
    candidates.sample([num_outputs, candidates.size].min)&.each do |target|
      wire = Wire.new(gate, target)
      @wires << wire
      gate.outputs << wire
      target.inputs << wire
    end
  end
end

def draw
  background(240, 80, 8)
  @frame_count += 1
  
  draw_wires
  draw_gates
  update_and_draw_pulses
  
  # 定期的に新しいパルスを発生
  spawn_pulses if @frame_count % 10 == 0
end

def draw_wires
  @wires.each do |wire|
    # ベース配線（暗め）
    strokeWeight(2)
    stroke(wire.hue, 60, 30, 60)
    noFill
    
    wire.segments.each do |seg|
      line(seg[:x1], seg[:y1], seg[:x2], seg[:y2])
    end
  end
end

def draw_gates
  @gates.each do |gate|
    push
    translate(gate.x, gate.y)
    
    3.times do |i|
      glow_alpha = 20 - i * 6
      glow_size = 30 + i * 10
      noStroke
      fill(gate.hue, 70, 50, glow_alpha)
      ellipse(0, 0, glow_size, glow_size)
    end
    
    stroke(gate.hue, 80, 90)
    strokeWeight(2)
    fill(gate.hue, 60, 20)
    
    case gate.gate_type
    when :and
      draw_and_gate
    when :or
      draw_or_gate
    when :not
      draw_not_gate
    when :xor
      draw_xor_gate
    when :nand
      draw_nand_gate
    end
    
    pop
  end
end

def draw_and_gate
  beginShape
  vertex(-12, -8)
  vertex(0, -8)
  bezierVertex(12, -8, 12, 8, 0, 8)
  vertex(-12, 8)
  endShape(CLOSE)
end

def draw_or_gate
  beginShape
  vertex(-12, -8)
  bezierVertex(-6, 0, -6, 0, -12, 8)
  bezierVertex(0, 5, 8, 3, 15, 0)
  bezierVertex(8, -3, 0, -5, -12, -8)
  endShape(CLOSE)
end

def draw_not_gate
  triangle(-12, -8, -12, 8, 8, 0)
  ellipse(13, 0, 6, 6)
end

def draw_xor_gate
  draw_or_gate
  noFill
  beginShape
  vertex(-16, -8)
  bezierVertex(-10, 0, -10, 0, -16, 8)
  endShape
end

def draw_nand_gate
  beginShape
  vertex(-12, -8)
  vertex(0, -8)
  bezierVertex(8, -8, 8, 8, 0, 8)
  vertex(-12, 8)
  endShape(CLOSE)
  ellipse(13, 0, 6, 6)
end

def update_and_draw_pulses
  @pulses.each(&:update)
  @pulses.reject! { |p| !p.alive }
  
  @pulses.each do |pulse|
    pos = pulse.position
    
    noStroke
    4.times do |i|
      glow_alpha = 60 - i * 15
      glow_size = 8 + i * 8
      fill(pulse.hue, 80, 90, glow_alpha)
      ellipse(pos[:x], pos[:y], glow_size, glow_size)
    end
    
    fill(pulse.hue, 30, 100)
    ellipse(pos[:x], pos[:y], 6, 6)
  end
end

def spawn_pulses
  # 入力のないゲート（ソース）からパルスを発生
  source_gates = @gates.select { |g| g.inputs.empty? && g.outputs.any? }
  
  # ソースがなければランダムなゲートから
  source_gates = @gates.select { |g| g.outputs.any? } if source_gates.empty?
  
  return if source_gates.empty?
  
  gate = source_gates.sample
  wire = gate.outputs.sample
  @pulses << Pulse.new(wire) if wire
end

def mousePressed
  # クリック位置に最も近いゲートを探す
  closest = @gates.min_by { |g| dist(mouseX, mouseY, g.x, g.y) }
  
  if closest && dist(mouseX, mouseY, closest.x, closest.y) < 50
    closest.outputs.each do |wire|
      @pulses << Pulse.new(wire)
    end
  end
end