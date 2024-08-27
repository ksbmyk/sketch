
let c1, c2, c3;

function setup() {
  createCanvas(600, 600);
  frameRate(0.5);
  colorMode(HSB, 360, 100, 100);
  [c1, c2, c3] = setColor();
}

function draw() {
  [c1, c2, c3] = setColor();

  background(c1);
  noFill();

  stroke(c2);
  strokeWeight(10);
  diamondPattern();
  
  stroke(c3);
  strokeWeight(2);
  diamondPattern(); 
}

function diamondPattern() {
  for (let i = 0; i <= 8; i++) {
    for (let j = 0; j <= 8; j++) {
      diamond(80 * i, 80 * j, 100, floor(random(3, 6)));
    }
  }
}

function diamond(x, y, radius, depth) {
  if (depth == 0) return;
  
  beginShape();
  for (let i = 0; i < 4; i++) {
    let angle = map(i, 0, 4, 0, TWO_PI);
    let newX = x + cos(angle) * radius;
    let newY = y + sin(angle) * radius;
    vertex(newX, newY);
    
    let nextRadius = radius * 0.3;
    let nextX = x + cos(angle) * nextRadius;
    let nextY = y + sin(angle) * nextRadius;
    diamond(nextX, nextY, nextRadius, depth - 1);
  }
  endShape(CLOSE);
}

function setColor(){
 let baseHue = random([50, 100, 150, 200, 250, 300, 350]);
  // let baseHue = 50, 100, 150, 200, 250, 300, 350;
  console.log(baseHue);
 let saturation = 80; 
 let brightness = 90;
  let color1 = color(baseHue, saturation, brightness);

  // 120度ずらしてトライアドカラーを生成
  // let color2 = color((baseHue + 120) % 360, saturation, brightness);
  // let color3 = color((baseHue + 240) % 360, saturation, brightness);

    let color2 = color((baseHue + 30) % 360, saturation, brightness - 50);
  let color3 = color((baseHue - 30 + 360) % 360, saturation, brightness);

  
  return [color1, color2, color3]
}
