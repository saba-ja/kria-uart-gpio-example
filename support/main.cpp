#include <cstdio>
// #include "xparameters.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "sleep.h"

int main() {

    // init_platform();
    while(1) {
        printf("Hello World\n\r");
        usleep(LED_DELAY);
    }
    // cleanup_platform();
    return 0;
}

#include "xparameters.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "sleep.h"

const int DELAY = 500000;
int main(void)
{
   while (1) {
        xil_printf("Hello World\r\n");
       usleep(DELAY);
   }
}

