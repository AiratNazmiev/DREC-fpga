/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include "../lect4_led_bsp/system.h"
#include <stdio.h>
#include <stdint.h>
#include <altera_avalon_sgdma.h>
#include <altera_avalon_sgdma_descriptor.h>
#include <altera_avalon_sgdma_regs.h>

#define LEDS_LEN 512
alt_sgdma_dev* dma;
alt_sgdma_descriptor ds1, ds2, ds3,ds4;
alt_u8 leds[LEDS_LEN];

alt_u8 binary_pattern[]={0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};


void dma_callback(void *context){
	if (!(ds1.control & ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK)){
		ds1.control |= ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK;
		ds1.actual_bytes_transferred = 0;
	}
	if (!(ds2.control & ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK)){
		ds2.control |= ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK;
		ds2.actual_bytes_transferred = 0;
	}
	if (!(ds3.control & ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK)){
			ds3.control |= ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK;
			ds3.actual_bytes_transferred = 0;
	}
	if (!(ds4.control & ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK)){
			ds4.control |= ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK;
			ds4.actual_bytes_transferred = 0;
	}

	/*alt_avalon_sgdma_stop(dma);
	alt_avalon_sgdma_construct_mem_to_stream_desc(&ds1, &ds2, (alt_u32*) &leds[0], LEDS_LEN, 0, 1, 1, 0);
	alt_avalon_sgdma_do_async_transfer(dma, &ds1);*/
}

int main()
{
 // printf("Hello from Nios II!\n");
	for(int i=0; i<LEDS_LEN; i+=4){
		leds[i + 0] = binary_pattern[(i>>(2 + 0)) & 0xF];
		leds[i + 1] = binary_pattern[(i>>(2 + 1)) & 0xF];
		leds[i + 2] = binary_pattern[(i>>(2 + 2)) & 0xF];
		leds[i + 3] = binary_pattern[(i>>(2 + 3)) & 0xF];
	}
	dma =  alt_avalon_sgdma_open("/dev/sgdma_0");

	alt_avalon_sgdma_construct_mem_to_stream_desc(&ds1, &ds2, (alt_u32*) &leds[0], LEDS_LEN/2, 0, 1, 1, 0);
	alt_avalon_sgdma_construct_mem_to_stream_desc(&ds2, &ds3, (alt_u32*) &leds[LEDS_LEN/2], LEDS_LEN/2, 0, 1, 1, 0);
	alt_avalon_sgdma_construct_mem_to_stream_desc(&ds3, &ds4, (alt_u32*) &leds[0], LEDS_LEN/2, 0, 1, 1, 0);
	alt_avalon_sgdma_construct_mem_to_stream_desc(&ds4, &ds1, (alt_u32*) &leds[LEDS_LEN/2], LEDS_LEN/2, 0, 1, 1, 0);
	ds1.control |= ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK;

	alt_avalon_sgdma_register_callback(dma, dma_callback, ALTERA_AVALON_SGDMA_CONTROL_IE_DESC_COMPLETED_MSK | ALTERA_AVALON_SGDMA_CONTROL_IE_GLOBAL_MSK, NULL);
	alt_avalon_sgdma_do_async_transfer(dma, &ds1);
	//alt_avalon_sgdma_start(dma);
	//alt_avalon_sgdma_stop(dma);
	while(1) {
		asm("br . + 4");
	};


  return 0;
}
