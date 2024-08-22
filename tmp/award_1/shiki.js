let fallingObjects = [];
let numObjects = 60;
let seasons = ["spring", "summer", "autumn", "winter"];
let seasonColors = {
  spring: [0, 0, 0], // 春色 (ピンク)
  summer: [255, 182, 193], // 夏色 (空色)
  autumn: [135, 206, 250], // 秋色 (オレンジ)
  winter: [255, 204, 0] // 冬色 (黒)
};

let seasonObjects = {
  spring: { char: '🌸', rotates: true },
  summer: { char: '💧', rotates: false },
  autumn: { char: '🍁', rotates: true },
  winter: { char: '❄️', rotates: true }
};

let currentSeasonIndex = 0;
let nextSeasonIndex = 1;
let lerpAmount = 0;
let totalFramesPerSeason = 500;
let objectsToRemove = [];

function setup() {
  createCanvas(600, 600);
  textAlign(CENTER, CENTER);
  initializeObjects();
}

function draw() {
  textSize(32);
  // 背景色の設定
  let currentSeasonColor = seasonColors[seasons[currentSeasonIndex]];
  let nextSeasonColor = seasonColors[seasons[nextSeasonIndex]];

  let adjustedLerpAmount = lerpAmount;

  let bgColor = lerpColor(color(...currentSeasonColor), color(...nextSeasonColor), adjustedLerpAmount);
  background(bgColor);

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

  // 徐々に次の季節へ
  lerpAmount += 1 / totalFramesPerSeason;
  if (lerpAmount >= 1) {
    lerpAmount = 0;
    currentSeasonIndex = (currentSeasonIndex + 1) % seasons.length;
    nextSeasonIndex = (currentSeasonIndex + 1) % seasons.length;
    addNewSeasonObjects();
  }
}

function initializeObjects() {
  let seasonInfo = seasonObjects[seasons[currentSeasonIndex]];
  
  for (let i = 0; i < numObjects; i++) {
    let x = random(width);
    let y = random(-height, 0);
    fallingObjects.push(new FallingObject(x, y, seasonInfo.char, seasonInfo.rotates));
  }
}

function addNewSeasonObjects() {
  let seasonInfo = seasonObjects[seasons[currentSeasonIndex]];

  // 新しい季節のオブジェクトを追加（古いオブジェクトは落ち切るまで残る）
  for (let i = 0; i < numObjects; i++) {
    let x = random(width);
    let y = random(-height, 0);
    fallingObjects.push(new FallingObject(x, y, seasonInfo.char, seasonInfo.rotates));
  }
}

// FallingObjectクラスを定義
class FallingObject {
  constructor(x, y, char, rotates) {
    this.x = x;
    this.y = y;
    this.char = char;
    this.rotates = rotates;
    this.rotation = rotates ? random(TWO_PI) : 0;  // 回転しない場合は0に固定
    this.speed = random(2, 5);
  }

  update() {
    this.y += this.speed;
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
    rotate(this.rotation);  // rotatesがfalseならrotationは0なので回転しない
    text(this.char, 0, 0);
    pop();
  }

  // オブジェクトが画面外に出たかどうかをチェックする
  isOutOfScreen() {
    return this.y > height;
  }

}
