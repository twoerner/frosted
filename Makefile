-include kconfig/.config
#FAMILY?=lpc17xx
#ARCH?=seedpro
FAMILY?=stellaris
ARCH?=stellaris_qemu
CROSS_COMPILE?=arm-none-eabi-
CC:=$(CROSS_COMPILE)gcc
AS:=$(CROSS_COMPILE)as
CFLAGS:=-mcpu=cortex-m3 -mthumb -mlittle-endian -mthumb-interwork -Ikernel -DCORE_M3 -Iinclude -fno-builtin -ffreestanding -DKLOG_LEVEL=6
CFLAGS+=-Iarch/$(ARCH)/inc -Iport/$(FAMILY)/inc
PREFIX:=$(PWD)/build
LDFLAGS:=-gc-sections -nostartfiles -ggdb -L$(PREFIX)/lib 

#debugging
CFLAGS+=-ggdb

#optimization
#CFLAGS+=-Os

ASFLAGS:=-mcpu=cortex-m3 -mthumb -mlittle-endian -mthumb-interwork -ggdb
OBJS-y:=  port/$(FAMILY)/$(FAMILY).o	
APPS-y:= \
		apps/init.o apps/fresh.o

include port/$(FAMILY)/$(FAMILY).mk

all: image.bin

kernel/syscall_table.c: kernel/syscall_table_gen.py
	python2 $^

include/syscall_table.h: kernel/syscall_table.c

$(PREFIX)/lib/libkernel.a:
	make -C kernel

$(PREFIX)/lib/libfrosted.a:
	make -C libfrosted

image.bin: kernel.elf apps.elf
	$(CROSS_COMPILE)objcopy -O binary --pad-to=0x20000 kernel.elf $@
	$(CROSS_COMPILE)objcopy -O binary apps.elf apps.bin
	cat apps.bin >> $@


apps.elf: $(PREFIX)/lib/libfrosted.a $(APPS-y)
	$(CC) -o $@  $(APPS-y) -Tapps/apps.ld -lfrosted -lc -lfrosted -Wl,-Map,apps.map  $(LDFLAGS) $(CFLAGS) $(EXTRA_CFLAGS)


kernel.elf: $(PREFIX)/lib/libkernel.a $(OBJS-y)
	$(CC) -o $@   -Tport/$(FAMILY)/$(FAMILY).ld $(OBJS-y) -lkernel -Wl,-Map,kernel.map  $(LDFLAGS) $(CFLAGS) $(EXTRA_CFLAGS)

qemu: image.bin 
	qemu-system-arm -semihosting -M lm3s6965evb --kernel image.bin -serial stdio -S -s

qemu2: image.bin
	qemu-system-arm -semihosting -M lm3s6965evb --kernel image.bin -serial stdio

menuconfig:
	@$(MAKE) -C kconfig/ menuconfig -f Makefile.frosted

clean:
	@make -C kernel clean
	@make -C libfrosted clean
	@rm -f $(OBJS-y)
	@rm -f *.map *.bin *.elf
	@find . |grep "\.o" | xargs -x rm -f

