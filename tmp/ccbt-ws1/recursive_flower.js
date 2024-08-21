let n = 5;
let r1, r2;
let size = 100;
let grid = 4

function setup() {
  createCanvas(size * grid, size * grid);
  background(0);
  frameRate(30);
}

function draw() {
  
  if (frameCount % 20 === 0){
    background(0);

    for (let x = 0; x < width; x += size) {
      for (let y = 0; y < height; y += size) {

      [r1, r2] = getUniqueRandomPair(3, 6);
      stroke(255);
      strokeWeight(2);
      noFill();
      pattern(x, y, n, r1);

      stroke(random(0,100), random(100, 255), 255);
      strokeWeight(1);
      pattern(x, y, n, r2);

      n = floor(random(5, 9));
      }
    }

    // if (n === 8){
    //   n = 5;
    // }else{
    //   n = n + 1;
    // }
  }
}


function pattern(x, y, n, r) {
  geometric(x+size/2, y+size/2, size, n, r);
}

function geometric(x, y, radius, sides, depth) {
  if (depth == 0) return;
  
  beginShape();
  for (let i = 0; i < sides; i++) {
    let angle = map(i, 0, sides, 0, TWO_PI);
    let newX = x + cos(angle) * radius;
    let newY = y + sin(angle) * radius;
    vertex(newX, newY);
    
    let nextRadius = radius * 0.3;
    let nextX = x + cos(angle) * nextRadius;
    let nextY = y + sin(angle) * nextRadius;
    geometric(nextX, nextY, nextRadius, sides, depth - 1);
  }
  endShape(CLOSE);
}

function getUniqueRandomPair(min, max) {
  let value1, value2;
  
  do {
    value1 = floor(random(min, max + 1));
    value2 = floor(random(min, max + 1));
  } while (value1 === value2);
  
  return [value1, value2];
}