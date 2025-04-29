#ifndef ATOM_MATRIX_LED_H
#define ATOM_MATRIX_LED_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void atom_matrix_led_init(void);
void atom_matrix_led_send_pixel(uint8_t red, uint8_t green, uint8_t blue);

#ifdef __cplusplus
}
#endif

#endif // ATOM_MATRIX_LED_H