let fallingObjects = [];
let numObjects = 150;
let seasons = ["spring", "summer", "autumn", "winter"];
let seasonColors = {
  spring: [255, 182, 193],
  summer: [135, 206, 250],
  autumn: [204, 163, 0],
  winter: [0, 31, 63]
};

let seasonObjects = {
  spring: { char: '✿', rotates: true,  color: [255, 105, 180]},
  summer: { char: ';', rotates: false, color: [30, 144, 255]},
  autumn: { char: '♣', rotates: true, color: [204, 85, 0]},
  winter: { char: '*', rotates: false, color: [255, 255, 255]}
};

let currentSeasonIndex = 0;
let nextSeasonIndex = 1;
let lerpAmount = 0;
let totalFramesPerSeason = 600;
let objectsToRemove = [];

function setup() {
  createCanvas(600, 600);
  textAlign(CENTER, CENTER);
  initializeObjects();
}

function draw() {
  textSize(32);

// 色変化のタイミングを調整するための変数
let transitionThreshold = 0.5; // 0.5までのlerpAmountで色を維持する

// 季節を変えるコード
lerpAmount += 1 / totalFramesPerSeason;

// 序盤は現在の色を維持し、後半で次の色に変化
let adjustedLerpAmount;
if (lerpAmount < transitionThreshold) {
    adjustedLerpAmount = 0;  // 色を維持
} else {
    adjustedLerpAmount = map(lerpAmount, transitionThreshold, 1, 0, 1);  // 徐々に変化
}

// 背景色の設定
let currentSeasonColor = seasonColors[seasons[currentSeasonIndex]];
let nextSeasonColor = seasonColors[seasons[nextSeasonIndex]];
let bgColor = lerpColor(color(...currentSeasonColor), color(...nextSeasonColor), adjustedLerpAmount);
background(bgColor);

    // 季節が変わるタイミング
  if (lerpAmount >= 1) {
      lerpAmount = 0;
      currentSeasonIndex = (currentSeasonIndex + 1) % seasons.length;
      nextSeasonIndex = (currentSeasonIndex + 1) % seasons.length;
      addNewSeasonObjects();
  }
  
  // オブジェクトを表示
  for (let obj of fallingObjects) {
    obj.update();
    obj.display();
  }

  // 画面外のオブジェクトを削除する
  for (let obj of objectsToRemove) {
    let index = fallingObjects.indexOf(obj);
    if (index > -1) {
      fallingObjects.splice(index, 1);
    }
  }
  objectsToRemove = []; // 削除対象のリストをリセット
}

function initializeObjects() {
  let seasonInfo = seasonObjects[seasons[currentSeasonIndex]];
  
  for (let i = 0; i < numObjects; i++) {
    let x = random(width);
    let y = random(-height*1.5, 0);
    fallingObjects.push(new FallingObject(x, y, seasonInfo.char, seasonInfo.color, seasonInfo.rotates));
  }
}

function addNewSeasonObjects() {
  let seasonInfo = seasonObjects[seasons[currentSeasonIndex]];

  for (let i = 0; i < numObjects; i++) {
    let x = random(width);
    let y = random(-height*1.5, 0);
    fallingObjects.push(new FallingObject(x, y, seasonInfo.char, seasonInfo.color, seasonInfo.rotates));
  }
}

class FallingObject {
  constructor(x, y, char, color, rotates) {
    this.x = x;
    this.y = y;
    this.char = char;
    this.color = color;
    this.rotates = rotates;
    this.rotation = rotates ? random(TWO_PI) : 0;
    this.speed = random(2, 6);
    this.size = char === '*' ? 50 : 32;
    this.variation = rotates ? random(-2, 2) : 0;
  }

  update() {
    this.y += this.speed;
    this.x += this.variation;
    if (this.rotates) {
      this.rotation += 0.05;
    }
    if (this.isOutOfScreen()) {
      objectsToRemove.push(this);
    }
  }

  display() {
    push();
    translate(this.x, this.y);
    rotate(this.rotation);
    fill(this.color);
    textSize(this.size);
    text(this.char, 0, 0);
    pop();
  }

  isOutOfScreen() {
    return this.y > height;
  }
}
