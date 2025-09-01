//-------------------------------------
// プロジェクトの基本設定 ここから

let debugMode = false; //デバッグモード、NEORTにアップロード時はfalseにしてください

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

// GraphicsLayer配列の管理
let graphicsLayers = [];
let currentLayerIndex = 0;

// プロジェクトの基本設定 ここまで
//-------------------------------------

function setup() {
  createCanvasSetup();
  console.log("Setup完了 - active:", active);
  console.log("currentSize:", currentSize);
  createGraphicsLayers();
  console.log("GraphicsLayers作成完了 - 数:", graphicsLayers.length);

  if (!currentSize && active.shapes) {
    console.log("フルスクリーンモード - タイル数:", active.shapes.length);
    console.log("タイル例:", active.shapes[0]);

    // タイルの配置範囲を確認
    let minX = Infinity,
      maxX = -Infinity,
      minY = Infinity,
      maxY = -Infinity;
    active.shapes.forEach((shape) => {
      minX = min(minX, shape.img_x);
      maxX = max(maxX, shape.img_x + shape.w);
      minY = min(minY, shape.img_y);
      maxY = max(maxY, shape.img_y + shape.h);
    });
    console.log(`タイル配置範囲: X(${minX} to ${maxX}), Y(${minY} to ${maxY})`);
    console.log(`Canvasサイズ: ${width}x${height}`);
  }
}

function draw() {
  background(0, 20);
  drawDebugMode(); // デバッグ用LEDキューブのレイアウト参考画像の描画

  if (graphicsLayers.length > 0) {
    // レイヤーの計算・描画処理を実行
    for (let i = 0; i < graphicsLayers.length; i++) {
      let layer = graphicsLayers[i];
      layer.update();
      layer.draw();
    }

    // メインキャンバスに描画
    for (let i = 0; i < active.shapes.length; i++) {
      let shape = active.shapes[i];
      let layerIndex = shape.layerIndex || i; // フルスクリーンモードではlayerIndexを使用

      // 確実に0-5の範囲に制限
      layerIndex = layerIndex % 6;

      if (layerIndex < graphicsLayers.length) {
        let layer = graphicsLayers[layerIndex];

        if (shape.type === "rect") {
          image(
            layer.graphics,
            shape.img_x,
            shape.img_y,
            layer.graphics.width,
            layer.graphics.height
          );

          // デバッグ用：タイルの境界を描画
          if (debugMode) {
            noFill();
            stroke(255, 0, 0);
            strokeWeight(1);
            rect(
              shape.img_x,
              shape.img_y,
              layer.graphics.width,
              layer.graphics.height
            );
          } else {
            noStroke();
          }
        } else if (shape.type === "poly") {
          push();
          if (debugMode) {
            stroke(255, 0, 0);
          } else {
            noStroke();
          }
          clipPolygon(shape.points);
          drawingContext.clip();
          image(
            layer.graphics,
            shape.img_x,
            shape.img_y,
            layer.graphics.width,
            layer.graphics.height
          );
          pop();
        }
      } else {
        // デバッグ用：layerIndexが範囲外の場合
        if (debugMode && frameCount % 60 === 0) {
          // 1秒に1回のみ表示
          console.log(
            `警告: layerIndex ${layerIndex} が範囲外 (最大: ${
              graphicsLayers.length - 1
            }), shape:`,
            shape
          );
        }
      }
    }
  } else {
    // デバッグ用：GraphicsLayerが存在しない場合
    if (debugMode && frameCount % 60 === 0) {
      // 1秒に1回のみ表示
      console.log("警告: GraphicsLayerがない");
    }
  }
}

// 個別Graphics管理クラス（アラベスク模様版）
class GraphicsLayer {
  constructor(size, index, shape) {
    // クラスの変更しないほうがいいプロパティ
    this.graphics = createGraphics(size, size);
    this.index = index;
    this.shape = shape;
    this.isActive = false;
    
    // アラベスク模様用の設定
    this.colors = ["#f3f1eb", "#b2c0d2"];
    this.arabesqueOffset = random(TWO_PI); // 各面で異なる動きを作る
    this.rotationSpeed = random(0.002, 0.005); // 回転速度
    this.scaleSpeed = random(0.01, 0.02); // スケール変化速度
    
    // 初期描画
    this.initialized = false;
  }

  // このレイヤーの計算処理
  update() {
    // アニメーション用の値を更新
    this.arabesqueOffset += this.rotationSpeed;
  }

  // このレイヤーの描画処理
  draw() {
    let g = this.graphics;
    
    // 背景色を設定（少し透明度を持たせて軌跡を残す）
    g.push();
    g.fill(this.colors[1] + '20'); // 透明度を追加
    g.noStroke();
    g.rect(0, 0, g.width, g.height);
    g.pop();
    
    // 初回のみ背景を完全に塗りつぶす
    if (!this.initialized) {
      g.background(this.colors[1]);
      this.initialized = true;
    }
    
    // アラベスク模様を描画
    this.drawArabesquePattern(g);
    
    // 円のパターンを描画
    this.drawCirclePattern(g);
  }
  
  // アラベスク模様のパターン描画
  drawArabesquePattern(g) {
    g.push();
    g.stroke(this.colors[0]);
    g.strokeWeight(3); // 線を太くして見やすく
    g.noFill();
    
    // グラフィックスサイズに応じてパターン数を調整（大きめに設定）
    let gridSize = 3; // 3x3のグリッドに減らして大きく表示
    let spacing = g.width / (gridSize + 1);
    
    for (let i = 0; i <= gridSize; i++) {
      for (let j = 0; j <= gridSize; j++) {
        let x = spacing * (i + 0.5);
        let y = spacing * (j + 0.5);
        
        // アニメーション：サイズを時間で変化
        let animScale = 1 + sin(frameCount * this.scaleSpeed + i * 0.5 + j * 0.3) * 0.2;
        let radius = spacing * 0.8 * animScale; // 0.4から0.8に拡大
        
        // アニメーション：回転
        let rotation = this.arabesqueOffset + (i + j) * 0.1;
        
        this.arabesque(g, x, y, radius, 8, 5, rotation); // 深度を4から5に増やす
      }
    }
    g.pop();
  }
  
  // 円のパターン描画
  drawCirclePattern(g) {
    g.push();
    g.noStroke();
    g.fill(this.colors[0]);
    
    let gridSize = 3; // 3x3のグリッドに統一
    let spacing = g.width / (gridSize + 1);
    
    for (let i = 0; i <= gridSize; i++) {
      for (let j = 0; j <= gridSize; j++) {
        let x = spacing * (i + 0.5);
        let y = spacing * (j + 0.5);
        
        // アニメーション：円のサイズをパルス状に変化
        let pulseScale = 1 + sin(frameCount * 0.03 + i * 0.8 + j * 0.6) * 0.3;
        let circleSize = spacing * 0.15 * pulseScale; // 0.08から0.15に拡大
        
        g.circle(x, y, circleSize);
      }
    }
    g.pop();
  }
  
  // アラベスク模様の再帰的描画
  arabesque(g, x, y, radius, sides, depth, rotation = 0) {
    if (depth <= 0) return;
    
    g.push();
    g.translate(x, y);
    g.rotate(rotation);
    
    g.beginShape();
    for (let i = 0; i < sides; i++) {
      let angle = map(i, 0, sides, 0, TWO_PI);
      let new_x = cos(angle) * radius;
      let new_y = sin(angle) * radius;
      g.vertex(new_x, new_y);
      
      // 再帰的に小さなアラベスクを描画
      if (depth > 1) {
        let next_radius = radius * 0.5; // 0.35から0.5に拡大
        let next_x = cos(angle) * next_radius;
        let next_y = sin(angle) * next_radius;
        
        g.push();
        g.translate(next_x, next_y);
        g.rotate(-rotation * 2); // 逆回転で複雑な動きを作る
        this.arabesqueRecursive(g, 0, 0, next_radius * 0.7, sides, depth - 1); // 0.5から0.7に拡大
        g.pop();
      }
    }
    g.endShape(CLOSE);
    
    g.pop();
  }
  
  // 再帰用の補助メソッド
  arabesqueRecursive(g, x, y, radius, sides, depth) {
    if (depth <= 0) return;
    
    g.beginShape();
    for (let i = 0; i < sides; i++) {
      let angle = map(i, 0, sides, 0, TWO_PI);
      let new_x = x + cos(angle) * radius;
      let new_y = y + sin(angle) * radius;
      g.vertex(new_x, new_y);
    }
    g.endShape(CLOSE);
  }
  
  // レイヤーを削除
  remove() {
    if (this.graphics && this.graphics.remove) {
      this.graphics.remove();
    }
  }
  
  // アクティブ状態を切り替え
  toggleActive() {
    this.isActive = !this.isActive;
  }
}

// GraphicsLayer配列を作成
function createGraphicsLayers() {
  // 既存のLayersを削除
  removeGraphicsLayers();

  if (!active.spec) {
    console.log("createGraphicsLayers: active.specが未定義");
    return;
  }

  const graphicsSize = active.spec.size;
  console.log(
    "createGraphicsLayers: graphicsSize =",
    graphicsSize,
    "currentSize =",
    currentSize
  );

  if (!currentSize) {
    // フルスクリーンモードの場合は6個のGraphicsLayerを作成
    console.log("フルスクリーンモード - 6個のGraphicsLayerを作成");
    for (let i = 0; i < 6; i++) {
      const layer = new GraphicsLayer(graphicsSize, i, null);
      graphicsLayers.push(layer);
    }
  } else {
    // 通常モードの場合は形状数分のGraphicsLayerを作成
    const numShapes = active.shapes.length;
    console.log("通常モード -", numShapes, "個のGraphicsLayerを作成");
    for (let i = 0; i < numShapes; i++) {
      const layer = new GraphicsLayer(graphicsSize, i, active.shapes[i]);
      graphicsLayers.push(layer);
    }
  }

  console.log("createGraphicsLayers完了 - 作成数:", graphicsLayers.length);
}

// GraphicsLayer配列を削除
function removeGraphicsLayers() {
  graphicsLayers.forEach((layer) => {
    if (layer && layer.remove) {
      layer.remove();
    }
  });
  graphicsLayers = [];
  currentLayerIndex = 0;
}

// ウィンドウリサイズ時の処理
function windowResized() {
  // URLパラメータが設定されていない場合のみcanvasをリサイズ
  if (!currentSize || !CANVAS_SIZES[currentSize]) {
    resizeCanvas(windowWidth, windowHeight);
    console.log(`Canvasリサイズ: ${windowWidth}x${windowHeight}`);
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
    setActive(1);
  } else if (key === "2") {
    currentSize = "LED_CUBE2";
    setActive(2);
  } else if (key === "3") {
    currentSize = "LED_CUBE3";
    setActive(3);
  } else if (key === "4") {
    currentSize = ""; // フルスクリーンレイアウト
    setActive(4);
  }

  // GraphicsLayer配列の切り替え
  if (key === "1" || key === "2" || key === "3" || key === "4") {
    updateURLAndCanvas();
    // フルスクリーンモードの場合は少し遅延してGraphicsLayerを作成
    if (key === "4") {
      setTimeout(() => {
        createGraphicsLayers();
        console.log("4キー - GraphicsLayers作成完了:", graphicsLayers.length);
      }, 100);
    } else {
      createGraphicsLayers();
    }
  }

  // レイヤーの切り替え（左右矢印キー）
  if (keyCode === LEFT_ARROW) {
    if (graphicsLayers.length > 0) {
      currentLayerIndex =
        (currentLayerIndex - 1 + graphicsLayers.length) % graphicsLayers.length;
      console.log(
        `レイヤー切り替え: ${currentLayerIndex + 1}/${graphicsLayers.length}`
      );
    }
  }
  if (keyCode === RIGHT_ARROW) {
    if (graphicsLayers.length > 0) {
      currentLayerIndex = (currentLayerIndex + 1) % graphicsLayers.length;
      console.log(
        `レイヤー切り替え: ${currentLayerIndex + 1}/${graphicsLayers.length}`
      );
    }
  }

  // スペースキーで現在のレイヤーのアクティブ状態を切り替え
  if (key === " ") {
    if (graphicsLayers.length > 0 && graphicsLayers[currentLayerIndex]) {
      graphicsLayers[currentLayerIndex].toggleActive();
      console.log(
        `レイヤー ${currentLayerIndex + 1} のアクティブ状態を切り替え`
      );
    }
  }
  background(0);
}

// アクティブなLEDキューブを設定
function setActive(n) {
  if (n === 1) active = { shapes: LED_CUBE1, spec: CUBE_SPEC_1 };
  if (n === 2) active = { shapes: LED_CUBE2, spec: CUBE_SPEC_2 };
  if (n === 3) active = { shapes: LED_CUBE3, spec: CUBE_SPEC_3 };
  if (n === 4) {
    // フルスクリーン用の設定を動的に計算
    createFullscreenLayout();
    active = { shapes: LED_CUBE4, spec: CUBE_SPEC_4 };
    console.log("フルスクリーンモード設定完了:", active);

    // フルスクリーンモードの場合はGraphicsLayerを即座に作成
    setTimeout(() => {
      createGraphicsLayers();
      console.log(
        "setActive(4) - GraphicsLayers作成完了:",
        graphicsLayers.length
      );
    }, 50);
  }
}

//クエリパラメーターでLED_CUBEのサイズを変更
function createCanvasSetup() {
  // クエリパラメータからサイズを取得
  const urlParams = new URLSearchParams(window.location.search);
  const sizeParam = urlParams.get("size");
  if (sizeParam && CANVAS_SIZES[sizeParam]) {
    currentSize = sizeParam;
    // アクティブなLEDキューブを設定
    if (sizeParam === "LED_CUBE1") setActive(1);
    if (sizeParam === "LED_CUBE2") setActive(2);
    if (sizeParam === "LED_CUBE3") setActive(3);
  } else {
    // URLパラメータが指定されていない場合はフルスクリーンレイアウト
    currentSize = "";
  }
  createCanvasWithSize(); //キャンバスサイズの設定
  // フルスクリーンモードの場合はキャンバス作成後にレイアウトを設定
  if (!currentSize) {
    setActive(4);
  }
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

// ======== LEDキューブ形状処理ユーティリティ ========

// rect/polyをポリゴン配列に正規化
function toPolygon(item) {
  return item.type === "rect" ? rectToPoly(item) : item.points;
}

// 矩形をポリゴンに変換
const rectToPoly = ({ x, y, w, h }) => [
  [x, y],
  [x + w, y],
  [x + w, y + h],
  [x, y + h],
];

// クリッピング適用
function clipPolygon(poly) {
  push();
  fill(0, 0);
  beginShape();
  for (let i = 0; i < poly.length; i++) {
    vertex(poly[i][0], poly[i][1]);
  }
  endShape(CLOSE);
  pop();
}

// フルスクリーンレイアウトの作成
function createFullscreenLayout() {
  const screenWidth = windowWidth;
  const screenHeight = windowHeight;

  // 既存のデータをクリア
  LED_CUBE4 = [];
  CUBE_SPEC_4 = null;

  // Graphicsサイズを画面幅の1/4に固定
  const graphicsSize = screenWidth / 4;

  // 画面を覆い尽くす格子を計算
  const gridCols = ceil(screenWidth / graphicsSize);
  const gridRows = ceil(screenHeight / graphicsSize);

  // 格子状にタイルを作成（正しく敷き詰める）
  LED_CUBE4 = [];
  for (let row = 0; row < gridRows; row++) {
    for (let col = 0; col < gridCols; col++) {
      // ランダムにGraphicsLayerのインデックスを選択（0-5の範囲）
      const randomIndex = floor(random(6));

      LED_CUBE4.push({
        type: "rect",
        name: `tile_${row}_${col}`,
        x: col * graphicsSize,
        y: row * graphicsSize,
        w: graphicsSize,
        h: graphicsSize,
        img_x: col * graphicsSize,
        img_y: row * graphicsSize,
        layerIndex: randomIndex % 6, // 確実に0-5の範囲に制限
      });
    }
  }

  // デバッグ: layerIndexの範囲を確認
  let minLayerIndex = Infinity,
    maxLayerIndex = -Infinity;
  LED_CUBE4.forEach((tile) => {
    minLayerIndex = min(minLayerIndex, tile.layerIndex);
    maxLayerIndex = max(maxLayerIndex, tile.layerIndex);
  });
  console.log(
    `layerIndex範囲: ${minLayerIndex} - ${maxLayerIndex} (6個のGraphicsLayerを使用)`
  );

  // スペックを設定
  CUBE_SPEC_4 = {
    w: screenWidth,
    h: screenHeight,
    size: graphicsSize,
  };

  console.log(
    `フルスクリーンレイアウト作成: ${screenWidth}x${screenHeight}, 格子: ${gridCols}×${gridRows}, Graphicsサイズ: ${graphicsSize}, タイル数: ${LED_CUBE4.length}`
  );
}

// LEDキューブの形状定義
// LED_CUBE1 2000×1440
const CUBE_SPEC_1 = { w: 2000, h: 1440, size: 720 };
const LED_CUBE1 = [
  {
    type: "rect",
    name: "r1",
    x: 0,
    y: 0,
    w: 200,
    h: 720,
    img_x: -520,
    img_y: 0,
  },
  {
    type: "rect",
    name: "r2",
    x: 200,
    y: 0,
    w: 720,
    h: 720,
    img_x: 200,
    img_y: 0,
  },
  {
    type: "rect",
    name: "r3",
    x: 920,
    y: 0,
    w: 720,
    h: 720,
    img_x: 920,
    img_y: 0,
  },
  {
    type: "rect",
    name: "r4",
    x: 1640,
    y: 0,
    w: 360,
    h: 720,
    img_x: 1640,
    img_y: 0,
  },
  {
    type: "poly",
    name: "p1",
    points: [
      [560, 1439],
      [560, 1079],
      [200, 1079],
      [200, 720],
      [919, 720],
      [919, 1439],
      [560, 1439],
    ],
    img_x: 200,
    img_y: 720,
  },
];

// LED_CUBE2 1536×768
const CUBE_SPEC_2 = { w: 1536, h: 768, size: 384 };
const LED_CUBE2 = [
  { type: "rect", name: "r1", x: 0, y: 0, w: 384, h: 384, img_x: 0, img_y: 0 },
  {
    type: "rect",
    name: "r2",
    x: 384,
    y: 0,
    w: 384,
    h: 384,
    img_x: 384,
    img_y: 0,
  },
  {
    type: "rect",
    name: "r3",
    x: 768,
    y: 0,
    w: 384,
    h: 384,
    img_x: 768,
    img_y: 0,
  },
  {
    type: "rect",
    name: "r4",
    x: 1152,
    y: 0,
    w: 384,
    h: 384,
    img_x: 1152,
    img_y: 0,
  },
  {
    type: "rect",
    name: "r5",
    x: 384,
    y: 384,
    w: 384,
    h: 384,
    img_x: 384,
    img_y: 384,
  },
];

// LED_CUBE3 672×480
const CUBE_SPEC_3 = { w: 672, h: 480, size: 288 };
const LED_CUBE3 = [
  {
    type: "rect",
    name: "r1",
    x: 192,
    y: 0,
    w: 288,
    h: 288,
    img_x: 192,
    img_y: 0,
  },
  {
    type: "rect",
    name: "r2",
    x: 192,
    y: 288,
    w: 288,
    h: 192,
    img_x: 192,
    img_y: 288,
  },
  {
    type: "poly",
    name: "p1",
    points: [
      [64, 0],
      [192, 0],
      [192, 288],
      [0, 288],
      [0, 224],
      [96, 224],
      [96, 96],
      [64, 96],
    ],
    img_x: -96,
    img_y: 0,
  },
  {
    type: "poly",
    name: "p2",
    points: [
      [480, 287],
      [480, 0],
      [607, 0],
      [607, 95],
      [575, 95],
      [575, 224],
      [671, 224],
      [671, 287],
      [480, 287],
    ],
    img_x: 480,
    img_y: 0,
  },
];

// フルスクリーン用の設定（動的に計算）
let CUBE_SPEC_4 = null;
let LED_CUBE4 = null;

// 現在アクティブなLEDキューブの設定
let active = { shapes: LED_CUBE1, spec: CUBE_SPEC_1 };

// ユーティリティ ここまで
//-------------------------------------
