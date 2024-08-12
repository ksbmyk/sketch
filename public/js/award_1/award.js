let  n = 3;
function setup() {
	// Draw recursively polygons around a circle, gradually increasing the number of sides, and vary the depth of recursion randomly each time it is drawn. Arrange the patterns on the canvas.
  
	// Set up the canvas and initialize variables.
	createCanvas(600, 600);
  background("#335fa6");
	// Set the frame rate to 1 frames per second.
  frameRate(1);
}

function draw() {
	// Refresh the background color.
  background("#335fa6");
	
	// Set the stroke properties.
  stroke(255);
  strokeWeight(10);
  noFill();
	
	// Draw the arabesque pattern with a specified number of sides.
	arabesquePattern(n);
  
	// Change stroke color and weight.
  stroke("#7eaab7");
  strokeWeight(2);
  noFill();
	
	// Draw the arabesque pattern again with the same number of sides.
  arabesquePattern(n);
	
  // Set fill color and draw circles.
  noStroke();
  fill("#c7a964");
  circlePattern();
  
	// Increment or reset the number of sides for the next frame.
  if (n === 9){
    n = 3;
  }else{
    n = n + 1;
  }
}

function circlePattern() {
	// Draw a pattern of circles.
  for (let i = 0; i <= 8; i++) {
    for (let j = 0; j <= 8; j++) {
      circle(90 * i, 80 * j, 10);
    }
  }
}

function arabesquePattern(n) {
 // Draw an arabesque pattern with varying depth of recursion and number of sides determined.
	for (let i = 0; i <= 8; i++) {
    for (let j = 0; j <= 8; j++) {
      arabesque(90 * i, 80 * j, 100, n, floor(random(3,6)));
    }
  }
}

function arabesque(x, y, radius, sides, depth) {
	// Recursive function to draw an arabesque shape.
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
    arabesque(nextX, nextY, nextRadius, sides, depth - 1);
  }
  endShape(CLOSE);
}