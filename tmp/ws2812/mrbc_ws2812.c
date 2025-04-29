#include <mrubyc.h>
#include "ws2812.h"

static void c_ws2812_send_pixel(mrb_vm *vm, mrb_value *v, int argc)
{
  uint8_t red = GET_INT_ARG(1);
  uint8_t green = GET_INT_ARG(2);
  uint8_t blue = GET_INT_ARG(3);

  ws2812_send_pixel(red, green, blue);
}

void mrbc_init_class_ws2812(void)
{
  ws2812_init();

  struct RClass *cls = mrbc_define_class(0, "WS2812", mrbc_class_object);
  mrbc_define_method(0, cls, "send_pixel", c_ws2812_send_pixel);
}