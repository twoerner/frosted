/*  
 *      This file is part of frosted.
 *
 *      frosted is free software: you can redistribute it and/or modify
 *      it under the terms of the GNU General Public License version 2, as 
 *      published by the Free Software Foundation.
 *      
 *
 *      frosted is distributed in the hope that it will be useful,
 *      but WITHOUT ANY WARRANTY; without even the implied warranty of
 *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *      GNU General Public License for more details.
 *
 *      You should have received a copy of the GNU General Public License
 *      along with frosted.  If not, see <http://www.gnu.org/licenses/>.
 *
 *      Authors: Daniele Lacamera, Maxime Vincent
 *
 */
#include "frosted.h"
#include "libopencm3/lm3s/usart.h"
#include "libopencm3/lm3s/nvic.h"

#ifdef CONFIG_DEVUART
#include "uart.h"
#endif

/* TODO: Move to libopencm3 when implemented */



void usart_set_baudrate(uint32_t usart, uint32_t baud)
{
    /* TODO */
    (void)usart;
    (void)baud;
}

void usart_set_databits(uint32_t usart, int bits)
{
    /* TODO */
    (void)usart;
    (void)bits;
}

void usart_set_stopbits(uint32_t usart, enum usart_stopbits sb)
{
    /* TODO */
    (void)usart;
    (void)sb;
}

void usart_set_parity(uint32_t usart, enum usart_parity par)
{
    /* TODO */
    (void)usart;
    (void)par;
}

void usart_set_mode(uint32_t usart, enum usart_mode mode)
{
    /* TODO */
    (void)usart;
    (void)mode;
}

void usart_set_flow_control(uint32_t usart, enum usart_flowcontrol fc)
{
    /* TODO */
    (void)usart;
    (void)fc;
}

void usart_enable(uint32_t usart)
{
       (void)usart;
}

void usart_disable(uint32_t usart)
{
       (void)usart;
}



#ifdef CONFIG_DEVUART
 static const struct uart_addr uart_addrs[] = { 
#ifdef CONFIG_USART_0
         {   
             .base = USART0_BASE, 
             .irq = NVIC_UART0_IRQ, 
         },
#endif
#ifdef CONFIG_USART_1
         { 
             .base = USART1_BASE, 
             .irq = NVIC_UART1_IRQ, 
         },
#endif
#ifdef CONFIG_USART_2
         { 
             .base = USART2_BASE, 
             .irq = NVIC_UART2_IRQ, 
         },
#endif         
 };
 
#define NUM_UARTS (sizeof(uart_addrs) / sizeof(struct uart_addr))
 #endif

 void machine_init(struct fnode * dev)
 {
     rcc_clock_setup_in_xtal_8mhz_out_50mhz();
#ifdef CONFIG_DEVUART
     uart_init(dev, uart_addrs, NUM_UARTS);
#endif

 }


