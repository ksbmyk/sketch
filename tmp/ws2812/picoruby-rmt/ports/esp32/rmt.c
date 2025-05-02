#include "driver/rmt_tx.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "../../include/rmt.h"

#define RMT_RESOLUTION_HZ (10000000)
#define RMT_MEM_BLOCK_SYMBOLS (64)
#define RMT_TRANS_QUEUE_DEPTH (4)

static rmt_channel_handle_t rmt_channel = NULL;
static rmt_encoder_handle_t rmt_encoder = NULL;
static RMT_symbol_dulation_t rmt_symbol_dulation;

static size_t
encoder_callback(const void *data, size_t data_size,
  size_t symbols_written, size_t symbols_free, rmt_symbol_word_t *symbols, bool *done, void *arg)
{
  // デバッグログを追加
  // printf("encoder_callback start: data=%p, size=%zu, symbols_written=%zu, symbols_free=%zu, symbols=%p, done=%p\n",
  //        data, data_size, symbols_written, symbols_free, symbols, done);
  // DEBUG_PRINT("encoder_callback Start\n");
  if (!data || !symbols || !done) {
    return 0;  // 防御的リターン
  }


  size_t data_pos = symbols_written / 8;
  printf("data_size=%zu, symbols_written=%zu, symbols_free=%zu, symbols=%p, data_pos=%zu\n",
         data_size, symbols_written, symbols_free, symbols, data_pos);
  if (data_pos >= data_size) {
    // 送信済み → リセットシンボルを送る（1シンボル分必要）
    if (symbols_free < 1) {
      // DEBUG_PRINT("Error: Not enough symbols_free for reset symbol\n");
      *done = false;
      return 0;
    }

    // ここで範囲チェックを追加
    // if (rmt_symbol_dulation.reset_ns <= 0) {
    //   DEBUG_PRINT("Error: Invalid reset_ns value (%ld), using default value\n", rmt_symbol_dulation.reset_ns);
    //   rmt_symbol_dulation.reset_ns = 1000000;  // デフォルトの値（適切なナノ秒に設定）
    // }

    int ns = rmt_symbol_dulation.reset_ns;
    if (ns <= 0 || ns > 60000) {  // 例: 上限10ms
      printf("Error: Invalid reset_ns value (%d), using default value\n", ns);
      ns = 60000;
    }
    uint16_t duration = (uint16_t)((float)ns * RMT_RESOLUTION_HZ / 1000000000);
    if (duration == 0) {
      printf("Warning: Calculated duration is zero, forcing minimum value 1\n");
      duration = 1;
    }
    printf("Reset symbol duration: %d ns, calculated duration: %d\n", ns, duration);
    // symbols[0] = (rmt_symbol_word_t){
    //   .level0 = 0,
    //   .duration0 = (uint16_t)((float)rmt_symbol_dulation.reset_ns * RMT_RESOLUTION_HZ / 1000000000),
    //   .level1 = 0,
    //   .duration1 = (uint16_t)((float)rmt_symbol_dulation.reset_ns * RMT_RESOLUTION_HZ / 1000000000),
    // };
    symbols[0] = (rmt_symbol_word_t){
      .level0 = 0,
      .duration0 = duration,
      .level1 = 0,
      .duration1 = duration,
    };
    *done = true;
    return 1;
  }

  // // 1バイト分送信（8シンボル必要）
  // if (symbols_free < 8) {
  //   // printf("Error: Not enough symbols_free for 1 byte transmission\n");
  //   *done = false;
  //   return 0;
  // }

  const uint8_t *data_bytes = (const uint8_t *)data;
  uint8_t byte = data_bytes[data_pos];

  for (int i = 0; i < 8; ++i) {
    symbols[i] = (byte & (0x80 >> i)) ? (rmt_symbol_word_t){
      .level0 = 1,
      .duration0 = (uint16_t)((float)rmt_symbol_dulation.t1h_ns * RMT_RESOLUTION_HZ / 1000000000),
      .level1 = 0,
      .duration1 = (uint16_t)((float)rmt_symbol_dulation.t1l_ns * RMT_RESOLUTION_HZ / 1000000000),
    } : (rmt_symbol_word_t){
      .level0 = 1,
      .duration0 = (uint16_t)((float)rmt_symbol_dulation.t0h_ns * RMT_RESOLUTION_HZ / 1000000000),
      .level1 = 0,
      .duration1 = (uint16_t)((float)rmt_symbol_dulation.t0l_ns * RMT_RESOLUTION_HZ / 1000000000),
    };
  }

  return 8;
}

int
RMT_init(uint32_t gpio, RMT_symbol_dulation_t *rsd)
{

  if (gpio >= GPIO_NUM_MAX) return -1;

  rmt_symbol_dulation = *rsd;

  rmt_tx_channel_config_t tx_chan_config = {
    .clk_src = RMT_CLK_SRC_DEFAULT,
    .gpio_num = gpio,
    .mem_block_symbols = RMT_MEM_BLOCK_SYMBOLS, // 固定値
    .resolution_hz = RMT_RESOLUTION_HZ,
    .trans_queue_depth = RMT_TRANS_QUEUE_DEPTH,
  };
  esp_err_t ret = rmt_new_tx_channel(&tx_chan_config, &rmt_channel);
  if (ret != ESP_OK) {
    return -1;
  }

  const rmt_simple_encoder_config_t simple_encoder_cfg = {
    .callback = encoder_callback
  };
  ret = rmt_new_simple_encoder(&simple_encoder_cfg, &rmt_encoder);
  if(ret != ESP_OK) {
    return -1;
  }

  ret = rmt_enable(rmt_channel);
  if (ret != ESP_OK) {
    return -1;
  }

  return 0;
}

int
RMT_write(uint8_t *buffer, uint32_t nbytes)
{
  // 1 チャンクで送信可能な最大バイト数を計算
  // const uint32_t max_symbols = RMT_MEM_BLOCK_SYMBOLS - 1; // 最後にリセット用の1シンボルを予約
  // const uint32_t max_symbols = (RMT_MEM_BLOCK_SYMBOLS > 8) ? RMT_MEM_BLOCK_SYMBOLS - 8 : RMT_MEM_BLOCK_SYMBOLS;

  // const uint32_t max_symbols = RMT_MEM_BLOCK_SYMBOLS ; // 設定されたシンボル数
  // const uint32_t max_bytes_per_chunk = max_symbols / 8; // 1 バイト = 8 シンボル
  // uint32_t offset = 0;
  rmt_transmit_config_t tx_config = {
    .loop_count = 0,
  };


// 送信データがある限り、3バイトずつ分割して送信する
// 送信するデータ（可変サイズのデータ）
uint8_t *data = buffer;  // 送信するデータバッファ
size_t data_size = nbytes;

// 24ビット（3バイト）単位で送信、最大48ビット（6バイト）を一度に送信
// const uint32_t chunk_size = 3;  // 1チャンクは3バイト（24ビット） RMT_MEM_BLOCK_SYMBOLS - 8 / 8 ?
const uint32_t max_chunk_size = 6;  // 最大チャンクサイズ（6バイト）

// データの残り部分がある限り送信し続ける
for (size_t offset = 0; offset < data_size; offset += max_chunk_size) {
    size_t send_size = (data_size - offset <= max_chunk_size) ? (data_size - offset) : max_chunk_size;

    // チャンク送信
    esp_err_t ret = rmt_transmit(rmt_channel, rmt_encoder, data + offset, send_size, &tx_config);
    if (ret != ESP_OK) {
        printf("Error: rmt_transmit failed\n");
        return -1;
    }

    // 送信完了を待つ
    ret = rmt_tx_wait_all_done(rmt_channel, portMAX_DELAY);
    if (ret != ESP_OK) {
        printf("Error: rmt_tx_wait_all_done failed\n");
        return -1;
    }

    printf("Sent chunk %zu bytes, offset = %zu\n", send_size, offset);
}

  return 0;
}