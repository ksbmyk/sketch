#include <mrubyc.h>
#include "atom_matrix_led.h"

static void c_atom_matrix_led_send_pixel(mrb_vm *vm, mrb_value *v, int argc)
{
  uint8_t red = GET_INT_ARG(1);
  uint8_t green = GET_INT_ARG(2);
  uint8_t blue = GET_INT_ARG(3);

  atom_matrix_led_send_pixel(red, green, blue);
}

void mrbc_init_class_atom_matrix_led(void)
{
  atom_matrix_led_init();

  struct RClass *cls = mrbc_define_class(0, "AtomMatrixLED", mrbc_class_object);
  mrbc_define_method(0, cls, "send_pixel", c_atom_matrix_led_send_pixel);
}