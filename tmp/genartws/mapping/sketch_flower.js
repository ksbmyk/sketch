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
  background(0); // 背景を完全に黒にする
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

// 個別Graphics管理クラス
class GraphicsLayer {
  constructor(size, index, shape) {
    //クラスの変更しないほうがいいプロパティ
    this.graphics = createGraphics(size, size);
    this.index = index;
    this.shape = shape;
    this.isActive = false;

    // 回転円パターン用の変数を初期化
    this.angle_offset = random(TWO_PI); // 各レイヤーで異なる初期角度
    this.hue_value = random(360); // ランダムな初期色相
    this.base_speed = 0.05 + random(-0.02, 0.02); // 基本速度
    this.speed = this.base_speed; // 現在の速度
    this.circle_count = 31;
    this.distance = size * 0.14; // グラフィックスサイズに応じて調整
    this.base_circle_size = size * 0.26; // グラフィックスサイズに応じて調整
    this.is_dark_mode = true; // ダークモード設定
    
    // グリッド設定（1=単体、2=2x2、3=3x3、4=4x4など）
    // ランダムに1〜4のグリッドサイズを選択
    this.gridSize = floor(random(1, 5));
    
    // 速度変化用の変数
    this.speed_phase = random(TWO_PI); // 速度変化の初期位相
    this.speed_freq = random(0.01, 0.03); // 速度変化の周波数
    this.speed_amplitude = random(0.5, 1.5); // 速度変化の振幅
    this.speed_pattern = floor(random(3)); // 0: sin波, 1: 加速減速, 2: ランダム変化
  }

  // このレイヤーの計算処理
  update() {
    // 速度変化の位相を更新
    this.speed_phase += this.speed_freq;
    
    // 速度パターンに応じて速度を変化させる
    switch(this.speed_pattern) {
      case 0: // sin波による滑らかな変化（時々停止）
        const sinValue = sin(this.speed_phase);
        // sin値が特定の範囲で速度を極端に落とす（擬似的な停止）
        if (abs(sinValue) < 0.1) {
          this.speed = this.base_speed * 0.01; // ほぼ停止
        } else {
          this.speed = this.base_speed * (1 + sinValue * this.speed_amplitude);
        }
        break;
        
      case 1: // 加速と減速を繰り返す（急激な変化）
        const cycle = this.speed_phase % TWO_PI;
        if (cycle < PI * 0.3) {
          // 急加速フェーズ
          this.speed = this.base_speed * (1 + pow(cycle / (PI * 0.3), 2) * this.speed_amplitude * 2);
        } else if (cycle < PI * 1.7) {
          // ゆっくり減速フェーズ
          this.speed = this.base_speed * (1 + cos((cycle - PI * 0.3) / (PI * 1.4) * PI) * this.speed_amplitude);
        } else {
          // 一時停止フェーズ
          this.speed = this.base_speed * 0.05;
        }
        break;
        
      case 2: // パルス的な動き（急に速くなったり遅くなったり）
        const pulsePhase = (this.speed_phase * 2) % TWO_PI;
        const pulse = pow(sin(pulsePhase), 8); // 8乗することで鋭いパルスを作る
        
        if (pulse > 0.5) {
          // パルス時は急加速
          this.speed = this.base_speed * (1 + pulse * this.speed_amplitude * 3);
        } else {
          // 通常時はゆっくり
          this.speed = this.base_speed * (0.3 + pulse);
        }
        break;
    }
    
    // 速度の範囲を制限（逆回転しないように）
    this.speed = max(this.speed, 0.001);
    
    // 角度を更新して回転させる（変化する速度を使用）
    this.angle_offset += this.speed;
    
    // 色相を徐々に変化させる（速度に応じて色変化速度も変える）
    this.hue_value = (this.hue_value + 0.2 + this.speed * 2) % 360;
  }

  // このレイヤーの描画処理
  draw() {
    let g = this.graphics;
    
    // カラーモードを毎フレーム設定
    g.push();
    g.colorMode(HSB, 360, 100, 100, 255);
    g.noStroke();
    
    // 背景を完全に黒にリセット（これで色の蓄積を防ぐ）
    g.background(0, 0, 0);
    
    // ブレンドモードを加算合成に設定（光る効果）
    g.blendMode(ADD);
    
    // グリッドのサイズ
    const gridSize = this.gridSize;
    const cellSize = g.width / gridSize;
    
    // グリッド状に複数のパターンを描画
    for (let row = 0; row < gridSize; row++) {
      for (let col = 0; col < gridSize; col++) {
        g.push();
        
        // 各セルの中心に移動
        const centerX = cellSize * (col + 0.5);
        const centerY = cellSize * (row + 0.5);
        g.translate(centerX, centerY);
        
        // 各セルごとに少し異なる色相と角度オフセット
        const cellIndex = row * gridSize + col;
        const localHue = (this.hue_value + cellIndex * 30) % 360;
        
        // セルごとに異なる速度変化を適用
        const cellSpeedModifier = 1 + sin(this.speed_phase + cellIndex * 0.5) * 0.3;
        
        // セルごとに回転方向を変える（チェッカーボードパターン）
        const direction = ((row + col) % 2 === 0) ? 1 : -1;
        const localAngleOffset = this.angle_offset * direction * cellSpeedModifier + cellIndex * 0.5;
        
        // 色を設定（HSBで指定）
        g.fill(localHue, 80, 100, 155);
        
        // スケールを調整（セルサイズに合わせて縮小）
        const scale = 1 / gridSize * 0.8; // 少し余白を持たせる
        
        // forループで円を繰り返し描画
        for (let i = 0; i < this.circle_count; i++) {
          const angle = (TWO_PI / this.circle_count) * i + localAngleOffset;
          
          // 円の中心座標を計算 (cos, sin)
          const x = cos(angle) * this.distance * scale;
          const y = sin(angle) * this.distance * scale;
          
          // iが偶数か奇数かで円のサイズを変更
          const size_modifier = (i % 2 === 0) ? g.width * 0.04 * scale : -g.width * 0.04 * scale;
          
          g.circle(x, y, (this.base_circle_size + size_modifier) * scale);
        }
        
        g.pop();
      }
    }
    
    // ブレンドモードを元に戻す
    g.blendMode(BLEND);
    g.pop();
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
