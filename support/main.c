#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "sleep.h"

int main(void)
{
   init_platform();
   while (1) {
      xil_printf("Hello World\r\n");
      usleep(500000);
   }
   cleanup_platform();
}

