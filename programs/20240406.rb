#refs https://p5js.org/reference/#/p5/texture

def preload
  @img = loadImage('https://ksbmyk.github.io/sketch/images/20240102.png')
end

def setup
  createCanvas(700, 700, WEBGL);
end

def draw
  background(0)
  rotateZ(frameCount * 0.008)
  rotateX(frameCount * 0.008)
  rotateY(frameCount * 0.008)
  # pass image as texture
  texture(@img)
  box(width / 5)
end
