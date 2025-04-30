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
static uint32_t rmt_max_bytes = UINT32_MAX;

static size_t
encoder_callback(const void *data, size_t data_size,
  size_t symbols_written, size_t symbols_free, rmt_symbol_word_t *symbols, bool *done, void *arg)
{
  // デバッグログを追加
  printf("encoder_callback: data=%p, size=%zu, symbols_written=%zu, symbols_free=%zu, symbols=%p, done=%p\n",
         data, data_size, symbols_written, symbols_free, symbols, done);
  
         if (!data || !symbols || !done) {
    printf("Error: Null pointer detected in encoder_callback\n");
    return 0;  // 防御的リターン
  }

  if (symbols_free < 8) {
    printf("Error: Not enough symbols_free (%zu) in encoder_callback\n", symbols_free);
    return 0;
  }

  size_t data_pos = symbols_written / 8;
  printf("Data position: %zu, Data size: %zu\n", data_pos, data_size);

  if (data_pos >= data_size) {
    // 送信済み → リセットシンボルを送る（1シンボル分必要）
    if (symbols_free < 1) {
      printf("Error: Not enough symbols_free for reset symbol\n");
      *done = false;
      return 0;
    }
    symbols[0] = (rmt_symbol_word_t){
      .level0 = 0,
      .duration0 = (uint16_t)((float)rmt_symbol_dulation.reset_ns * RMT_RESOLUTION_HZ / 1000000000),
      .level1 = 0,
      .duration1 = (uint16_t)((float)rmt_symbol_dulation.reset_ns * RMT_RESOLUTION_HZ / 1000000000),
    };
    *done = true;
    printf("Reset symbol sent\n");
    return 1;
  }

  // 1バイト分送信（8シンボル必要）
  if (symbols_free < 8) {
    printf("Error: Not enough symbols_free for 1 byte transmission\n");
    *done = false;
    return 0;
  }

  const uint8_t *data_bytes = (const uint8_t *)data;
  uint8_t byte = data_bytes[data_pos];
  printf("Transmitting byte: 0x%02x\n", byte);

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
  printf("encoder_callback: symbols_written=%zu, symbols_free=%zu, data_pos=%zu, data_size=%zu\n",
    symbols_written, symbols_free, data_pos, data_size);
  printf("8 symbols written for byte: 0x%02x\n", byte);
  return 8;
}

int
RMT_init(uint32_t gpio, RMT_symbol_dulation_t *rsd, uint32_t max_pixels)
{
  if (max_pixels > 0) {
    rmt_max_bytes = max_pixels * 3; // 1 LED = 3 バイト
  }

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
  if (nbytes > rmt_max_bytes) {
    printf("Error: Data size exceeds maximum allowed bytes\n");

    return -1;
  }

  // 1 チャンクで送信可能な最大バイト数を計算
  const uint32_t max_symbols = RMT_MEM_BLOCK_SYMBOLS; // 設定されたシンボル数
  const uint32_t max_bytes_per_chunk = max_symbols / 8; // 1 バイト = 8 シンボル
  uint32_t offset = 0;
  rmt_transmit_config_t tx_config = {
    .loop_count = 0,
  };

  while (offset < nbytes) {
    uint32_t remaining = nbytes - offset;
    uint32_t send_size = remaining > max_bytes_per_chunk ? max_bytes_per_chunk : remaining;
  
    printf("RMT_write: offset=%lu, send_size=%lu, remaining=%lu\n", offset, send_size, remaining);
  
    esp_err_t ret = rmt_transmit(rmt_channel, rmt_encoder, buffer + offset, send_size, &tx_config);
    if (ret != ESP_OK) {
      printf("Error: rmt_transmit failed\n");
      return -1;
    }
  
    offset += send_size;
  }
  
  // すべて送った後に待機
  esp_err_t ret = rmt_tx_wait_all_done(rmt_channel, portMAX_DELAY);
  if (ret != ESP_OK) {
    printf("Error: rmt_tx_wait_all_done failed\n");
    return -1;
  }

  return 0;
}