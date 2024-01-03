# GENUARY 2024 jan3 "Droste effect."
# https://genuary.art/prompts
# ref: https://note.com/deconbatch/n/nadd699e04580

$side = 80
$split = 9
$count = 0
def setup
  createCanvas($side * $split, $side * $split)
  # HSBモード。色相の範囲を 0～360、彩度・明度・α値 の範囲を 0～100 に設定
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER)
  background(0)
  frameRate(2)
end

def draw
  stroke(255)
  noFill

  blendMode(SCREEN)
  (1..50).each do |i|
    strokeWeight(i * 0.5)

    # 変換後の値 = map(変換前の値, 変換前の範囲の最小値, 変換前の範囲の最大値, 変換後の範囲の最小値, 変換後の範囲の最大値)
    stroke(
      map(i, 1, 150, 180, 360), # 色相の範囲
      80,                       # 彩度
      map(i, 1, 50, 15, 1),     # 明度
      100                       # α値
    )
    square(($side * $split) / 2, ($side * $split) / 2, $side * $count)
  end

  if $count == $split
  	$count = 0
  	blendMode(BLEND)
    noStroke
    fill(0)
    square(($side * $split) /2, ($side * $split) /2, $side * $split)
  else
    $count += 1
  end
end
