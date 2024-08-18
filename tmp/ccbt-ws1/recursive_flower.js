let  n = 5;
function setup() {
  createCanvas(200, 200);
  background(0);
  frameRate(1);
}

function draw() {
  background(0);

  stroke(255);
  strokeWeight(2);
  noFill();
  pattern(n);

  stroke(random(0,100), random(100, 255), 255);
  strokeWeight(1);
  //noFill();
	
  pattern(n);
  
  if (n === 7){
    n = 5;
  }else{
    n = n + 1;
  }
  
  //n = floor(random(5,9));
}


function pattern(n) {
  geometric(100, 100, width, n, floor(random(3,6)));
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