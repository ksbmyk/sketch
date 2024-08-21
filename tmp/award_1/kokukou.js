
let c1;
let c2;
let c3;
function setup() {
  createCanvas(600, 600);
  frameRate(0.5);
  c1 = color(random(255), random(255), random(255));
  c2 = color(random(255), random(255), random(255));
  c3 = color(random(255), random(255), random(255));
}

function draw() {
  if (frameCount % 4 === 0) {
    c1 = color(random(255), random(255), random(255));
    c2 = color(random(255), random(255), random(255));
    c3 = color(random(255), random(255), random(255));
  }
  
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
artist, Software Engineer