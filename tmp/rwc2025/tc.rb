require "uart"
require "processing"
using Processing

def setup
  # ポートを指定 (Mac ls /dev/cu.* で確認)
  port = "/dev/cu.usbserial-BG00ECUT"
  baud = 115200

  # UART 通信を開始
  # @uart = UART.open(port, baud)

  @circle_count = 4 # 感圧
  @distance = 100 # 曲げ
  @circle_size = 150 # ボリューム
  @hue_value = 200 # ロータリエンコーダ
 
  @is_dark_mode = false # トグルスイッチ
  @angle_offset = 0
  @is_button_push = true # ボタン

  size(displayWidth, displayHeight)
  colorMode(HSB, 360, 100, 100, 255)
  noStroke
end

def draw
  # handle_serial_data

  # 1. 全体背景を対照的に設定
  @is_dark_mode = true
  if (@is_dark_mode)
    background(0, 0, 0)      # 全体が黒背景
  else
    background(0, 0, 100)    # 全体が白背景
  end

  # 2. 右側：図形領域を先に描画
  draw_graphics_area

  # 3. 左側：テキストエリア（黒背景）を上から重ねる
  blendMode(BLEND)  # blendModeをリセット
  fill(0, 0, 0)
  rect(0, 0, width / 2, height)

  draw_text_area
end

def draw_text_area
  # 文字色は常に白
  fill(0, 0, 100)

  textAlign(LEFT, TOP)
  textSize(14)

  x_offset = 20
  y_offset = 20
  line_height = 20

  # コードを表示
  code_lines = [
    "require \"processing\"",
    "using Processing",
    "",
    "def setup",
    "  @circle_count = 4 # 感圧",
    "  @distance = 100 # 曲げ",
    "  @circle_size = 150 # ボリューム",
    "  @hue_value = 200 # ロータリエンコーダ",
    "",
    "  @is_dark_mode = false # トグルスイッチ",
    "  @angle_offset = 0",
    "  @is_button_push = false # ボタン",
    "",
    "  size(displayWidth, displayHeight)",
    "  colorMode(HSB, 360, 100, 100, 255)",
    "  noStroke",
    "end",
    "",
    "def draw",
    "  # blendModeを対照的に設定",
    "  @is_dark_mode = #{@is_dark_mode}",
    "  if (@is_dark_mode)",
    "    background(0, 0, 0)",
    "    blendMode(ADD)",
    "  else",
    "    background(0, 0, 100)",
    "    blendMode(MULTIPLY)",
    "  end",
    "",
    "  @hue_value = #{@hue_value}",
    "  fill(@hue_value, 80, 100, 150)",
    "",
    "  @is_button_push = #{@is_button_push}",
    "  @angle_offset += @is_button_push ? 0.05 : 0.01",
    "",
    "  @circle_count = #{@circle_count}",
    "  @distance = #{@distance}",
    "  @circle_size = #{@circle_size}",
    "  @circle_count.times do |i|",
    "    angle = TWO_PI / @circle_count * i + @angle_offset",
    "    x = cos(angle) * @distance",
    "    y = sin(angle) * @distance",
    "    circle(x, y, @circle_size + (i.even? ? 30 : -30))",
    "  end",
    "end"
  ]

  code_lines.each_with_index do |line, i|
    y_pos = y_offset + line_height * i
    draw_syntax_highlighted_line(line, x_offset, y_pos)
  end
end

def draw_syntax_highlighted_line(line, x, y)
  # 空行
  if line.strip.empty?
    # 何も描画しない
  # コメント（行全体）
  elsif line.strip.start_with?("#")
    fill(120, 30, 60)  # 落ち着いたグレー
    text(line, x, y)
  else
    # 行を解析してトークンごとに色分け
    current_x = x
    indent = line[/^\s*/]

    # インデント部分を描画
    fill(0, 0, 100)
    text(indent, current_x, y)
    current_x += textWidth(indent)

    # インデント以降の部分を解析
    remaining = line.strip
    after_def = false  # defの直後かどうかを追跡

    while remaining.length > 0
      matched = false

      # コメント（行の途中の#以降）
      if remaining.start_with?("#")
        fill(120, 30, 60)  # 落ち着いたグレー
        text(remaining, current_x, y)
        break  # コメント以降は処理終了
      # インポート文
      elsif remaining =~ /^(require|using)\b/
        keyword = $1
        fill(270, 50, 75)  # 落ち着いた紫
        text(keyword, current_x, y)
        current_x += textWidth(keyword)
        remaining = remaining[keyword.length..-1]
        matched = true
      # キーワード
      elsif remaining =~ /^(def|if|else|elsif|end|do|times)\b/
        keyword = $1
        fill(300, 60, 80)  # 落ち着いたマゼンタ
        text(keyword, current_x, y)
        current_x += textWidth(keyword)
        remaining = remaining[keyword.length..-1]
        matched = true
        after_def = (keyword == "def")  # defの場合フラグを立てる
      # インスタンス変数
      elsif remaining =~ /^(@\w+)/
        variable = $1
        fill(200, 60, 85)  # 落ち着いたシアン
        text(variable, current_x, y)
        current_x += textWidth(variable)
        remaining = remaining[variable.length..-1]
        matched = true
      # 定数 (TWO_PI, ADD, MULTIPLY など、完全に大文字のみ)
      elsif remaining =~ /^([A-Z_][A-Z_0-9]*)(?![a-z])/
        constant = $1
        fill(180, 50, 80)  # 落ち着いた水色
        text(constant, current_x, y)
        current_x += textWidth(constant)
        remaining = remaining[constant.length..-1]
        matched = true
      # メソッド呼び出し (単語 + 括弧)
      elsif remaining =~ /^(\w+)(?=\()/
        method_name = $1
        fill(50, 60, 85)  # 落ち着いた黄色
        text(method_name, current_x, y)
        current_x += textWidth(method_name)
        remaining = remaining[method_name.length..-1]
        matched = true
      # メソッド名やシンボル (その他の単語)
      elsif remaining =~ /^([a-zA-Z_]\w*)/
        word = $1
        # defの直後の場合はメソッド定義なので黄色
        if after_def
          fill(50, 60, 85)  # 落ち着いた黄色
          after_def = false  # フラグをリセット
        else
          fill(0, 0, 100)  # 白
        end
        text(word, current_x, y)
        current_x += textWidth(word)
        remaining = remaining[word.length..-1]
        matched = true
      # 数値
      elsif remaining =~ /^(\d+\.?\d*)/
        number = $1
        fill(100, 40, 75)  # 落ち着いた緑がかった色
        text(number, current_x, y)
        current_x += textWidth(number)
        remaining = remaining[number.length..-1]
        matched = true
      # その他（記号、空白など）
      else
        char = remaining[0]
        fill(0, 0, 100)  # 白
        text(char, current_x, y)
        current_x += textWidth(char)
        remaining = remaining[1..-1]
        matched = true
        # 空白文字以外が来たらafter_defをリセット
        if char != " " && after_def
          after_def = false
        end
      end
    end
  end
end

def draw_graphics_area
  pushMatrix

  # 右側の中央に移動
  translate(width * 3 / 4, height / 2)

  # blendModeを対照的に設定
  if (@is_dark_mode)
    background(0, 0, 0)
    blendMode(ADD)
  else
    background(0, 0, 100) 
    blendMode(MULTIPLY)
  end

  fill(@hue_value, 80, 100, 150)
  @angle_offset +=  @is_button_push ? 0.1 : 0.01

  @circle_count.times do |i|
    angle = TWO_PI / @circle_count * i + @angle_offset
    x = cos(angle) * @distance
    y = sin(angle) * @distance
    circle(x, y, @circle_size + (i.even? ? 30 : -30))
  end

  popMatrix
end

def handle_serial_data
  data = @uart.gets
  return if data.nil? || data.empty?
  if data
    line = data.chomp!
    values = line.split(',')

    if values.length == 2
      case values[0]
      when "T"
        @is_dark_mode = values[1] == "1"
      when "B"
        @is_button_push = values[1] == "1"
      when "R"
        @hue_value = ((values[1].to_i % 360) + 360) % 360
      when "P"
        @circle_size = map(values[1].strip.to_i, 0, 4095, 10, 500).to_i
      when "K"
        @circle_count = map(values[1].to_i, 10, 150, 4, 50).to_i
      when "M"
        @distance = map(values[1].to_i, 500, 3000, 50, 200).to_i
      else
        puts "Error #{values}"
      end
    end
  end
end
