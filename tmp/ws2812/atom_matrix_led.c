#include "driver/rmt_tx.h"
#include "driver/rmt_encoder.h"
#include "esp_log.h"
#include "atom_matrix_led.h"

#define RMT_TX_GPIO_NUM 27
#define RMT_TX_RESOLUTION_HZ (10 * 1000 * 1000) // 10MHz (0.1us単位)

static const char *TAG = "ATOM_MATRIX_LED";

static rmt_channel_handle_t rmt_tx_channel = NULL;
static rmt_encoder_handle_t copy_encoder = NULL;

void atom_matrix_led_init(void)
{
    rmt_tx_channel_config_t tx_chan_config = {
        .gpio_num = RMT_TX_GPIO_NUM,
        .clk_src = RMT_CLK_SRC_DEFAULT,
        .mem_block_symbols = 64,  // 64シンボル分メモリ確保
        .resolution_hz = RMT_TX_RESOLUTION_HZ,
        .trans_queue_depth = 4,
    };
    ESP_ERROR_CHECK(rmt_new_tx_channel(&tx_chan_config, &rmt_tx_channel));
    ESP_ERROR_CHECK(rmt_enable(rmt_tx_channel));

    rmt_copy_encoder_config_t encoder_config = {};
    ESP_ERROR_CHECK(rmt_new_copy_encoder(&encoder_config, &copy_encoder));
}

void atom_matrix_led_send_pixel(uint8_t red, uint8_t green, uint8_t blue)
{
    rmt_symbol_word_t symbols[24];
    int idx = 0;
    uint8_t colors[3] = {green, red, blue};  // WS2812BはGRB順

    for (int c = 0; c < 3; c++) {
        for (int i = 7; i >= 0; i--) {
            if (colors[c] & (1 << i)) {
                symbols[idx].level0 = 1;
                symbols[idx].duration0 = 8;  // High 800ns
                symbols[idx].level1 = 0;
                symbols[idx].duration1 = 4;  // Low 400ns
            } else {
                symbols[idx].level0 = 1;
                symbols[idx].duration0 = 4;  // High 400ns
                symbols[idx].level1 = 0;
                symbols[idx].duration1 = 8;  // Low 800ns
            }
            idx++;
        }
    }

    rmt_transmit_config_t tx_config = {
        .loop_count = 0,
    };

    ESP_ERROR_CHECK(rmt_transmit(rmt_tx_channel, copy_encoder, symbols, sizeof(symbols), &tx_config));
    ESP_ERROR_CHECK(rmt_tx_wait_all_done(rmt_tx_channel, -1));
}
