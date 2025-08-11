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
  background(0);
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
    
    // 時間帯設定を取得
    this.timeSettings = this.getTimeBasedSettings();
    
    // 泡の配列と設定
    this.bubbles = [];
    this.bubbleCount = this.timeSettings.bubbleCount;
    
    // 泡を初期化
    this.initBubbles();
  }

  // 時間帯に基づく設定を取得
  getTimeBasedSettings() {
    let h = hour();
    
    let settings = {
      bubbleCount: 30,
      speedMultiplier: 1,
      hueRange: [170, 240],
      saturationRange: [60, 100],
      brightnessRange: [80, 100],
      // HSB形式で背景色を指定 [色相, 彩度, 明度]
      backgroundTopHSB: [220, 60, 15],   // デフォルト：暗い青
      backgroundBottomHSB: [220, 70, 8], // デフォルト：より暗い青
      wobbleMultiplier: 1,
      glowIntensity: 1,
      specialMode: null
    };
    
    // 朝（6:00-10:00）
    if (h >= 6 && h < 10) {
      settings.bubbleCount = random(25, 40);
      settings.speedMultiplier = 0.7;
      settings.hueRange = [20, 60]; // 暖色系（オレンジ〜黄色）
      settings.saturationRange = [70, 90];
      settings.brightnessRange = [85, 100];
      settings.backgroundTopHSB = [30, 40, 35];    // 朝焼けの上空（オレンジがかった）
      settings.backgroundBottomHSB = [25, 50, 20]; // 朝焼けの地平線
      settings.wobbleMultiplier = 0.8;
      settings.glowIntensity = 1.2;
      settings.specialMode = 'morning';
    }
    // 昼（10:00-16:00）
    else if (h >= 10 && h < 16) {
      settings.bubbleCount = random(40, 60);
      settings.speedMultiplier = 1.2;
      settings.hueRange = [180, 220]; // 青系〜シアン
      settings.saturationRange = [50, 80];
      settings.brightnessRange = [90, 100];
      settings.backgroundTopHSB = [200, 30, 70];   // 明るい昼の空
      settings.backgroundBottomHSB = [200, 25, 50]; // 少し暗めの青
      settings.wobbleMultiplier = 1.2;
      settings.glowIntensity = 0.8;
      settings.specialMode = 'noon';
    }
    // 夕方（16:00-20:00）
    else if (h >= 16 && h < 20) {
      settings.bubbleCount = random(30, 45);
      settings.speedMultiplier = 0.9;
      settings.hueRange = [270, 330]; // 紫〜赤紫
      settings.saturationRange = [80, 100];
      settings.brightnessRange = [70, 90];
      settings.backgroundTopHSB = [280, 50, 35];   // 夕焼けの空（紫がかった）
      settings.backgroundBottomHSB = [290, 60, 20]; // 深い紫
      settings.wobbleMultiplier = 1.5; // 夕方は横揺れを強調
      settings.glowIntensity = 1.5;
      settings.specialMode = 'evening';
    }
    // 夜（20:00-24:00）
    else if (h >= 20) {
      settings.bubbleCount = random(20, 35);
      settings.speedMultiplier = 0.5;
      settings.hueRange = [220, 280]; // 深い青〜紫
      settings.saturationRange = [70, 100];
      settings.brightnessRange = [60, 80];
      settings.backgroundTopHSB = [240, 70, 10];   // 夜空（深い青）
      settings.backgroundBottomHSB = [240, 80, 5]; // より暗い青
      settings.wobbleMultiplier = 0.6;
      settings.glowIntensity = 2.0; // 夜は光を強調
      settings.specialMode = 'night';
    }
    // 深夜（0:00-6:00）
    else {
      settings.bubbleCount = random(15, 25);
      settings.speedMultiplier = 0.3;
      settings.hueRange = [240, 260]; // インディゴ〜深い紫
      settings.saturationRange = [40, 70];
      settings.brightnessRange = [50, 70];
      settings.backgroundTopHSB = [250, 50, 8];    // 深夜の空（インディゴ）
      settings.backgroundBottomHSB = [250, 60, 3]; // ほぼ黒に近い
      settings.wobbleMultiplier = 0.4;
      settings.glowIntensity = 2.5;
      settings.specialMode = 'midnight';
    }
    
    return settings;
  }

  // 泡を初期化
  initBubbles() {
    this.bubbles = [];
    let settings = this.timeSettings;
    
    for (let i = 0; i < this.bubbleCount; i++) {
      this.bubbles.push({
        // 位置（初期位置はランダムに分散）
        x: random(this.graphics.width),
        y: random(this.graphics.height),
        
        // サイズ（時間帯によって調整）
        size: random(this.graphics.width / 45, this.graphics.width / 20) * 
              (settings.specialMode === 'midnight' ? 0.8 : 1),
        
        // 上昇速度
        speed: random(0.3, 1.5) * settings.speedMultiplier,
        
        // 横揺れの設定
        wobbleAmount: random(30, 60) * settings.wobbleMultiplier,
        wobbleSpeed: random(0.01, 0.04),
        wobbleOffset: random(TWO_PI),
        
        // 色と透明度
        hue: random(settings.hueRange[0], settings.hueRange[1]),
        saturation: random(settings.saturationRange[0], settings.saturationRange[1]),
        brightness: random(settings.brightnessRange[0], settings.brightnessRange[1]),
        opacity: random(150, 255)
      });
    }
  }

  // 時間変化をチェックして必要に応じて再初期化
  checkTimeChange() {
    let previousTimeMode = this.timeSettings.specialMode;
    this.timeSettings = this.getTimeBasedSettings();
    
    // 時間帯が変わったら泡を再初期化
    if (previousTimeMode !== this.timeSettings.specialMode) {
      this.bubbleCount = this.timeSettings.bubbleCount;
      this.initBubbles();
    }
  }

  // このレイヤーの計算処理
  update() {
    // 時間変化をチェック
    this.checkTimeChange();
    
    let settings = this.timeSettings;
    
    // 通常の泡の更新
    for (let bubble of this.bubbles) {
      // 上に移動
      bubble.y -= bubble.speed;
      
      // 時間帯による速度の動的調整
      if (settings.specialMode === 'noon') {
        // 昼は少し加速
        bubble.y -= sin(frameCount * 0.01) * 0.2;
      }
      
      // 画面上端を超えたら下から再出現
      if (bubble.y + bubble.size < 0) {
        bubble.y = this.graphics.height + bubble.size;
        bubble.x = random(this.graphics.width);
        // 色も時間帯に合わせて更新
        bubble.hue = random(settings.hueRange[0], settings.hueRange[1]);
        bubble.saturation = random(settings.saturationRange[0], settings.saturationRange[1]);
        bubble.brightness = random(settings.brightnessRange[0], settings.brightnessRange[1]);
      }
    }
  }

  // このレイヤーの描画処理
  draw() {
    let g = this.graphics;
    let settings = this.timeSettings;
    
    // 背景を時間帯に応じたグラデーション
    g.push();
    g.colorMode(HSB, 360, 100, 100);
    
    for (let i = 0; i <= g.height; i++) {
      let inter = map(i, 0, g.height, 0, 1);
      
      // HSB値を補間
      let h = lerp(settings.backgroundTopHSB[0], settings.backgroundBottomHSB[0], inter);
      let s = lerp(settings.backgroundTopHSB[1], settings.backgroundBottomHSB[1], inter);
      let b = lerp(settings.backgroundTopHSB[2], settings.backgroundBottomHSB[2], inter);
      
      g.stroke(h, s, b);
      g.line(0, i, g.width, i);
    }
    
    // 夜間は星を追加
    if (settings.specialMode === 'night' || settings.specialMode === 'midnight') {
      g.colorMode(RGB, 255);
      g.strokeWeight(1);
      for (let i = 0; i < 30; i++) {
        let starX = (i * 137 + frameCount * 0.01) % g.width;
        let starY = (i * 89) % g.height;
        let starBright = sin(frameCount * 0.05 + i) * 50 + 150;
        g.stroke(255, starBright);
        g.point(starX, starY);
      }
    }
    
    g.pop();
    
    // 泡を描画
    this.drawBubbles(g);
  }

  drawBubbles(g) {
    g.push();
    g.colorMode(HSB, 360, 100, 100, 255);
    g.blendMode(ADD);
    
    let settings = this.timeSettings;
    
    for (let bubble of this.bubbles) {
      // 横揺れを計算
      let wobbleX = sin(frameCount * bubble.wobbleSpeed + bubble.wobbleOffset) 
                    * bubble.wobbleAmount;
      let x = bubble.x + wobbleX;
      
      let currentSize = bubble.size;
      
      // 外側の大きな光彩
      g.noStroke();
      g.fill(bubble.hue, bubble.saturation * 0.5, bubble.brightness, 
             bubble.opacity * 0.15 * settings.glowIntensity);
      g.ellipse(x, bubble.y, currentSize * 2.5);

      // 中間の光彩
      g.fill(bubble.hue, bubble.saturation * 0.7, bubble.brightness, 
             bubble.opacity * 0.3 * settings.glowIntensity);
      g.ellipse(x, bubble.y, currentSize * 1.5);

      // メインの泡
      g.fill(bubble.hue, bubble.saturation, bubble.brightness, 
             bubble.opacity * 0.7);
      g.ellipse(x, bubble.y, currentSize);

      // 内側の輪郭
      g.stroke(bubble.hue, bubble.saturation * 0.3, 100, 
               bubble.opacity * 0.9);
      g.strokeWeight(2);
      g.noFill();
      g.ellipse(x, bubble.y, currentSize * 0.9);
    }
    
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
