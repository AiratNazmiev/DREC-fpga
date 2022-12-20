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

#include "../nios_vga_bsp/system.h"
#include <stdio.h>
#include <stdint.h>
#include <altera_avalon_sgdma.h>
#include <altera_avalon_sgdma_descriptor.h>
#include <altera_avalon_sgdma_regs.h>
#include "Font5x7.h"
#include "altera_up_avalon_parallel_port.h"

#define VIDEO_H 480
#define VIDEO_W 640
#define VIDEO_SIZE ((alt_u32)(VIDEO_H * VIDEO_W )+1)

alt_sgdma_dev* dma;
alt_sgdma_descriptor ds[6];
alt_u8 *fb;
alt_u8 dma_chain_len=0;
alt_up_parallel_port_dev *keys;
alt_u8 frame;

void dma_callback(void *context){
	for(alt_u8 i=0;i<dma_chain_len;i++) {
		if (!(ds[i].control & ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK)){
				ds[i].control |= ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK;
				ds[i].actual_bytes_transferred = 0;
				if(i==0)
					frame++;
		}
	}
}

void vga_pattern(){
	alt_u8 *tfb;
	tfb = fb;
	for(alt_u32 i=0; i < VIDEO_H; i++)
		for(alt_u32 j=0; j < VIDEO_W; j++){
			if ((i < 10) || (i>VIDEO_H-10) || (j < 10) || (j>VIDEO_W-10))
				*tfb = 0xff; else
					*tfb = 0;//(i << 5) | ((j<<3)&0x1C);
			tfb++;
		}
}

void putch(alt_u16 x, alt_u16 y, alt_u8 ch, alt_u8 color){
	alt_u8 *tfb;
	tfb = fb;
	tfb += y*VIDEO_W + x;
	ch -=0x20;
	for(alt_u8 i=0;i<8;i++){
		for(alt_u8 j=0;j<5;j++) {
			if (Font5x7[ch*5+j] & (1<<i)) *tfb = color;
			tfb++;
		}
		tfb += VIDEO_W-5;
	}
}

void putstr(alt_u16 x, alt_u16 y, char *ch, alt_u8 color){
	while (*ch) {
		putch(x,y,(alt_u8)*ch, color);
		ch++;
		x+=6;
	}
}

int main()
{
	dma =  alt_avalon_sgdma_open("/dev/sgdma_0");
	keys =  alt_up_parallel_port_open_dev("/dev/parallel_port_0");
	fb = SDRAM_CONTROLLER_0_BASE;
	frame = 0;
	alt_u8 tframe=0;
	alt_u32 i,j;
	alt_u32 l;
	alt_u16 x,y,c=0;
	i = 0;
	j = 0;
	while (j<VIDEO_SIZE){
		l = VIDEO_SIZE - j > 0xFFFF ? 0xFFFF : VIDEO_SIZE - j;
		alt_avalon_sgdma_construct_mem_to_stream_desc(&ds[i], &ds[i+1], (alt_u32*)(fb+j), l, 0, i==0 ? 1: 0, i == 0 ? 1 : 0, 0);
		i++;
		j+=l;
	}
	i--;
	ds[i].next = (alt_u32*)&ds[0];
	dma_chain_len = i+1;

 	alt_avalon_sgdma_register_callback(dma, dma_callback, ALTERA_AVALON_SGDMA_CONTROL_IE_DESC_COMPLETED_MSK | ALTERA_AVALON_SGDMA_CONTROL_IE_GLOBAL_MSK, NULL);

	vga_pattern();
	putstr(40,20,"Hello from NIOS II", 0xff);
	putstr(40,30,"Blue", 0x03);
	putstr(40,40,"Green", 0x07 << 2);
	putstr(40,50,"Red", 0x07 << 5);

	x = 150;
	y = 100;


	alt_avalon_sgdma_do_async_transfer(dma, &ds[0]);

	while(1) {
		l = alt_up_parallel_port_read_data(keys);
		if (frame!=tframe){
			tframe = frame;
			if (!(l&1)){
				fb[y*VIDEO_W + x] = c;
				if (x<VIDEO_W) x++;
				c = fb[y*VIDEO_W + x];
				fb[y*VIDEO_W + x] = 0xff;
			}
			if (!(l&2)){
				fb[y*VIDEO_W + x] = c;
				if (x>0) x--;
				c = fb[y*VIDEO_W + x];
				fb[y*VIDEO_W + x] = 0xff;
			}
			if (!(l&4)){
				fb[y*VIDEO_W + x] = c;
				if (y<VIDEO_H) y++;
				c = fb[y*VIDEO_W + x];
				fb[y*VIDEO_W + x] = 0xff;
			}
			if (!(l&8)){
				fb[y*VIDEO_W + x] = c;
				if (y>0) y--;
				c = fb[y*VIDEO_W + x];
				fb[y*VIDEO_W + x] = 0xff;
			}
		}


		asm("br . + 4");

	}
}
