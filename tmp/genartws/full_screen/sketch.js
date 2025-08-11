//-------------------------------------
// プロジェクトの基本設定 ここから

let debugMode = true; //デバッグモード、NEORTにアップロード時はfalseにしてください

// キャンバスサイズの設定
const CANVAS_SIZES = {
  LED_CUBE1: { width: 2000, height: 1440 },
  LED_CUBE2: { width: 1536, height: 768 },
  LED_CUBE3: { width: 672, height: 480 },
};

// LEDキューブのレイアウト参考画像
let image1, image2, image3;

// 現在のLEDキューブのサイズ
let currentSize = "";

// プロジェクトの基本設定 ここまで
//-------------------------------------

let grid_size;
let x;
let y;

function setup() {
  createCanvasSetup();
  grid_size = height/10;
  x = 0;
  y = 0;
  background(0);
  frameRate(5); 
}

function draw() {
  // background(220);
  // drawDebugMode(); // デバッグ用LEDキューブのレイアウト参考画像の描画

  // draw()が実行されるたびに、パターンを1つ描画する
  draw_pattern(x, y, grid_size);

  // 次の描画位置に移動する
  x += grid_size;
  if (x >= width) {
    x = 0;
    y += grid_size;
  }

  // キャンバス全体を描画し終えたら、座標をリセットする
  if (y >= height) {
    // 画面全体を新しい背景色でリセット
    background(0);
    // 座標を最初に戻す
    x = 0;
    y = 0;
  }
}

function draw_pattern(x, y, size) {
  let colors = [
    color(random(100, 200), random(150, 255), random(200, 255)),
    color(random(50, 150), random(100, 200), random(150, 255)),
    color(random(200, 255), random(200, 255), random(240, 255))
  ];
  
  let pattern = floor(random(4));
  noStroke();
  switch (pattern) {
    case 0:
      fill(colors[0]);
      triangle(x, y, x + size, y, x, y + size);
      fill(colors[1]);
      triangle(x + size, y, x + size, y + size, x, y + size);
      break;
    case 1:
      fill(colors[1]);
      triangle(x + size, y, x + size, y + size, x, y);
      fill(colors[2]);
      triangle(x, y, x, y + size, x + size, y + size);
      break;
    case 2:
      fill(colors[0]);
      rect(x, y, size, size / 2);
      fill(colors[2]);
      rect(x, y + size / 2, size, size / 2);
      break;
    case 3:
      fill(colors[1]);
      rect(x, y, size / 2, size);
      fill(colors[0]);
      rect(x + size / 2, y, size / 2, size);
      break;
  }
}

//-------------------------------------
// ユーティリティ ここから

// レイアウト参考画像の読み込み
function preload() {
  // 画像を読み込む（ファイルが存在しない場合エラー回避）
  if (debugMode) {
    try {
      image1 = loadImage(
        "images/LED_CUBE1.png",
        function () {
          console.log("LED_CUBE1.png 読み込み成功");
        },
        function () {
          console.log("LED_CUBE1.png が不明");
        }
      );
    } catch (e) {
      console.log("LED_CUBE1.png の読み込みをスキップ");
    }

    try {
      image2 = loadImage(
        "images/LED_CUBE2.png",
        function () {
          console.log("LED_CUBE2.png 読み込み成功");
        },
        function () {
          console.log("LED_CUBE2.png が不明");
        }
      );
    } catch (e) {
      console.log("LED_CUBE2.png の読み込みをスキップ");
    }

    try {
      image3 = loadImage(
        "images/LED_CUBE3.png",
        function () {
          console.log("LED_CUBE3.png 読み込み成功");
        },
        function () {
          console.log("LED_CUBE3.png が不明");
        }
      );
    } catch (e) {
      console.log("LED_CUBE3.png の読み込みをスキップ");
    }
  }
}

// レイアウト参考画像の描画（draw関数内）
function drawDebugMode() {
  if (debugMode) {
    if (image1 && image1.width > 0 && currentSize === "LED_CUBE1") {
      image(image1, 0, 0, width, height);
    } else if (image2 && image2.width > 0 && currentSize === "LED_CUBE2") {
      image(image2, 0, 0, width, height);
    } else if (image3 && image3.width > 0 && currentSize === "LED_CUBE3") {
      image(image3, 0, 0, width, height);
    }
  }
}

// キーボードでLED_CUBEのサイズを変更（1-4キー）
function keyPressed() {
  // キーボードでサイズを切り替え
  if (key === "1") {
    currentSize = "LED_CUBE1";
  } else if (key === "2") {
    currentSize = "LED_CUBE2";
  } else if (key === "3") {
    currentSize = "LED_CUBE3";
  } else if (key === "4") {
    currentSize = ""; // URLパラメータを空にする
  }
  if (key === "1" || key === "2" || key === "3" || key === "4") {
    updateURLAndCanvas();
  }
}

//クエリパラメーターでLED_CUBEのサイズを変更
function createCanvasSetup() {
  // クエリパラメータからサイズを取得
  const urlParams = new URLSearchParams(window.location.search);
  const sizeParam = urlParams.get("size");
  if (sizeParam && CANVAS_SIZES[sizeParam]) {
    currentSize = sizeParam;
  }
  createCanvasWithSize(); //キャンバスサイズの設定
}

//URLParamsを更新してキャンバスサイズを変更
function updateURLAndCanvas() {
  // URLパラメータを更新
  const url = new URL(window.location);
  if (currentSize) {
    url.searchParams.set("size", currentSize);
  } else {
    url.searchParams.delete("size"); // sizeパラメータを完全に削除
  }
  window.history.replaceState({}, "", url);

  createCanvasWithSize(); // キャンバスサイズを変更
}

//キャンバスサイズの設定
function createCanvasWithSize() {
  let size;
  if (currentSize && CANVAS_SIZES[currentSize]) {
    size = CANVAS_SIZES[currentSize];
  } else {
    // URLパラメータが設定されていない場合はwindowWidthとwindowHeightを使用
    size = { width: windowWidth, height: windowHeight };
  }
  // 既存のキャンバスを削除
  if (window.canvas) {
    window.canvas.remove();
  }
  // キャンバスを作成
  pixelDensity(1);
  createCanvas(size.width, size.height);
  console.log(
    `Canvasサイズ変更 : ${currentSize || "screen"} (${size.width}x${
      size.height
    })`
  );
}

// ウィンドウリサイズ時の処理
function windowResized() {
  // URLパラメータが設定されていない場合のみcanvasをリサイズ
  if (!currentSize || !CANVAS_SIZES[currentSize]) {
    resizeCanvas(windowWidth, windowHeight);
    console.log(`Canvasリサイズ: ${windowWidth}x${windowHeight}`);
  }
}

// ユーティリティ ここまで
//-------------------------------------
