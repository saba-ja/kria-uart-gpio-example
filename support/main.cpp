#include "sleep.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#include <iostream>
#include <string>
#include "xscugic.h"
#include "xil_exception.h"

const u16 GPIO_LED_DEVICE_ID = XPAR_AXI_GPIO_0_DEVICE_ID;
const u32 LED_CHANNEL = 1;
const u32 BTN_CHANNEL = 2;

XGpio gpioInst; /* The Instance of the GPIO Driver */

int main(void) {
  int status;
  status = XGpio_Initialize(&gpioInst, GPIO_LED_DEVICE_ID);
  if (status != XST_SUCCESS) {
    xil_printf("Gpio Initialization Failed\r\n");
    return XST_FAILURE;
  }
  // Set LEDs direction to outputs
  XGpio_SetDataDirection(&gpioInst, LED_CHANNEL, 0x0);

  while (1) {
    std::cout << "\nEnter command: ";
    char ch;
    ch = getchar();
    putchar(ch);

    // Process the command
    if (ch == '0') {
      std::cout << std::endl << "Turning OFF all LEDs" << std::endl;
      XGpio_DiscreteWrite(&gpioInst, LED_CHANNEL, 0x0);
    } else if (ch == '1') {
      std::cout << std::endl << "Turning ON LED 1" << std::endl;
      XGpio_DiscreteWrite(&gpioInst, LED_CHANNEL, 0x1);
    } else if (ch == '2') {
      std::cout << std::endl << "Turning ON LED 2" << std::endl;
      XGpio_DiscreteWrite(&gpioInst, LED_CHANNEL, 0x2);
    } else if (ch == '3') {
      std::cout << std::endl << "Turning ON LED 3" << std::endl;
      XGpio_DiscreteWrite(&gpioInst, LED_CHANNEL, 0x4);
    } else if (ch == '4') {
      std::cout << std::endl << "Turning ON all LEDs" << std::endl;
      XGpio_DiscreteWrite(&gpioInst, LED_CHANNEL, 0x7);
    } else {
      std::cout << std::endl << "Invalid command" << std::endl;
    }
  }

  return 0;
}

