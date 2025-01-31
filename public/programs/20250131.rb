# GENUARY 2025 jan30 "Pixel sorting."
# https://genuary.art/prompts

def preload
  @img = loadImage('https://ksbmyk.github.io/sketch/images/20240102.png')
end

def setup
  createCanvas(700, 700)
  @img.resize(700, 700)
  @img.loadPixels

  (0...@img.width.to_i).each do |x|
    column = []

    (0...@img.height.to_i).each do |y|
      index = (x + y * @img.width.to_i) * 4
      column << [
        @img.pixels[index], 
        @img.pixels[index + 1], 
        @img.pixels[index + 2], 
        @img.pixels[index + 3]
      ]
    end

    # RGBAのG(緑)でソート
    column.sort_by! { |c| -c[1].to_i }

    (0...@img.height.to_i).each do |y|
      index = (x + y * @img.width.to_i) * 4
      @img.pixels[index] = column[y][0]
      @img.pixels[index + 1] = column[y][1]
      @img.pixels[index + 2] = column[y][2]
      @img.pixels[index + 3] = column[y][3]
    end
  end

  @img.updatePixels
  image(@img, 0, 0)
end
