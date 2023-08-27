function setup() {
    createCanvas(400, 400);
    background('#001e46');
    blendMode(OVERLAY);
    createLoop({duration:3, gif:true});
}

function draw() {
    noStroke();
    fill('#aac8ff');
    ellipse(random(0, 400), random(0, 400), 30);

}
