# #minacoding 2024 June 7 "What to Create"
# https://minacoding.online/theme

$ang = 0
$dir = 1

def preload() 
  @img = loadImage('https://ksbmyk.github.io/sketch/images/20240602.png')
end

def setup()
  createCanvas(500, 500, WEBGL)
end

def draw
  background(220)

  lights()
  # 光が円柱の内側にうまく当たらない
  #pointLight(color(255), 0, 10, -100)
  pointLight(color(255), 0, 10, 400)

  $ang += $dir * 0.005
  #if ($ang >= QUARTER_PI || $ang <= -HALF_PI) 
  if ($ang >= QUARTER_PI || $ang <= - QUARTER_PI) 
    $dir *= -1
  end

  noStroke
  texture(@img)
  rotateX($ang)
  rotateY(- frameCount * 0.005)
  cylinder(70, 220, 24, 1, false)
end

# let img;
# let ang = 0;
# let dir = 1;

# function preload() {
#   img = loadImage('https://ksbmyk.github.io/sketch/images/20240602.png');
# }

# function setup() {
# createCanvas(500, 500, WEBGL);
# }

# function draw() {
#   background(220);

#   lights();
#   pointLight(color(255), 0, 10, -100);

#   ang += dir * 0.005;
#   if (ang >= QUARTER_PI || ang <= -HALF_PI) {
#     dir *= -1;
#   }

#   noStroke();
#   texture(img);
#   rotateX(ang);
#   rotateY(-frameCount * 0.005);
#   cylinder(70, 220, 24, 1, false);
# }
