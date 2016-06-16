-include kconfig/.config
FROSTED:=$(PWD)
FLASH_ORIGIN?=0x0
FLASH_SIZE?=256K
CFLAGS+=-DFLASH_ORIGIN=$(FLASH_ORIGIN)

ifneq ($(V),1)
   Q:=@
   #Do not print "Entering directory ...".
   MAKEFLAGS += --no-print-directory
endif

-include rules/config.mk
include  rules/arch.mk
include  rules/picotcp.mk
include  rules/userspace.mk

#debugging
CFLAGS+=-ggdb3

#optimization
#CFLAGS+=-Os

# minimal kernel
OBJS-y:= kernel/frosted.o \
		 kernel/vfs.o \
		 kernel/systick.o \
		 kernel/drivers/device.o \
		 kernel/mpu.o				\
		 kernel/fpb.o				\
		 kernel/string.o			\
		 kernel/sys.o				\
		 kernel/locks.o				\
		 kernel/semaphore.o			\
		 kernel/mutex.o				\
		 kernel/tasklet.o			\
		 kernel/scheduler.o			\
		 kernel/syscall_table.o		\
		 kernel/malloc.o			\
		 kernel/module.o			\
		 kernel/poll.o				\
		 kernel/cirbuf.o			\
		 kernel/term.o				\
		 kernel/bflt.o				\
		 kernel/getaddrinfo.o		\
		 kernel/kprintf.o			\
		 kernel/pipe.o

# device drivers 
OBJS-$(MEMFS)+= kernel/drivers/memfs.o
OBJS-$(XIPFS)+= kernel/drivers/xipfs.o
CFLAGS-$(MEMFS)+=-DCONFIG_MEMFS

OBJS-$(FATFS)+= kernel/fatfs.o
CFLAGS-$(FAT32)+=-DCONFIG_FAT32
CFLAGS-$(FAT16)+=-DCONFIG_FAT16

OBJS-$(SYSFS)+= kernel/drivers/sysfs.o
CFLAGS-$(SYSFS)+=-DCONFIG_SYSFS

OBJS-$(DEVNULL)+= kernel/drivers/null.o
CFLAGS-$(DEVNULL)+=-DCONFIG_DEVNULL

OBJS-$(SOCK_UNIX)+= kernel/drivers/socket_un.o
CFLAGS-$(SOCK_UNIX)+=-DCONFIG_SOCK_UNIX

OBJS-$(PICOTCP)+= kernel/drivers/socket_in.o
CFLAGS-$(PICOTCP)+=-DCONFIG_PICOTCP
CFLAGS-$(CONFIG_PICOTCP_LOOP)+="-DCONFIG_PICOTCP_LOOP"

CFLAGS-$(TCPIP_MEMPOOL_YN)+=-DCONFIG_TCPIP_MEMPOOL=$(TCPIP_MEMPOOL)

OBJS-$(DEVL3GD20)+= kernel/drivers/l3gd20.o
CFLAGS-$(DEVL3GD20)+=-DCONFIG_DEVL3GD20

OBJS-$(DEVLSM303DLHC)+= kernel/drivers/lsm303dlhc.o
CFLAGS-$(DEVLSM303DLHC)+=-DCONFIG_DEVLSM303DLHC

OBJS-$(DEVSPI)+= kernel/drivers/stm32f4_spi.o
CFLAGS-$(DEVSPI)+=-DCONFIG_DEVSTM32F4SPI

OBJS-$(DEVF4I2C)+= kernel/drivers/stm32f4_i2c.o
CFLAGS-$(DEVF4I2C)+=-DCONFIG_DEVSTM32F4I2C

OBJS-$(DEVF4ETH)+= kernel/drivers/stm32fx_eth.o
CFLAGS-$(DEVF4ETH)+=-DCONFIG_DEVSTMETH

OBJS-$(DEVF7ETH)+= kernel/drivers/stm32fx_eth.o
CFLAGS-$(DEVF7ETH)+=-DCONFIG_DEVSTMETH

OBJS-$(DEVUART)+= kernel/drivers/uart.o
CFLAGS-$(DEVUART)+=-DCONFIG_DEVUART

OBJS-$(DEVFRAMEBUFFER)+= kernel/framebuffer.o kernel/drivers/stm32f7_ltdc.o
CFLAGS-$(DEVFRAMEBUFFER)+=-DCONFIG_DEVFRAMEBUFFER

OBJS-$(DEVGPIO)+=kernel/drivers/gpio.o
CFLAGS-$(DEVGPIO)+=-DCONFIG_DEVGPIO

OBJS-$(DEVSTM32F4DMA)+=kernel/drivers/stm32f4_dma.o
CFLAGS-$(DEVSTM32F4DMA)+=-DCONFIG_DEVSTM32F4DMA
		 
OBJS-$(DEVSTM32SDIO)+=kernel/drivers/stm32_sdio.o 
CFLAGS-$(DEVSTM32SDIO)+=-DCONFIG_DEVSTM32SDIO

OBJS-$(DEVF4EXTI)+=kernel/drivers/stm32f4_exti.o
CFLAGS-$(DEVF4EXTI)+=-DCONFIG_DEVSTM32F4EXTI

OBJS-$(DEVADC)+=kernel/drivers/stm32f4_adc.o
CFLAGS-$(DEVADC)+=-DCONFIG_DEVSTM32F4ADC

OBJS-$(DEVTIM)+=kernel/drivers/stm32f4_tim.o
CFLAGS-$(DEVTIM)+=-DCONFIG_DEVSTM32F4TIM

OBJS-$(DEVRNG)+=kernel/drivers/random.o
CFLAGS-$(DEVRNG)+=-DCONFIG_RNG

OBJS-$(DEV_USB_ETH)+=kernel/drivers/usb_ethernet.o
CFLAGS-$(DEV_USB_ETH)+=-DCONFIG_DEV_USB_ETH
CFLAGS-$(DEV_USB_ETH)+=-DCONFIG_USB_DEFAULT_IP=\"$(USB_DEFAULT_IP)\"
CFLAGS-$(DEV_USB_ETH)+=-DCONFIG_USB_DEFAULT_NM=\"$(USB_DEFAULT_NM)\"
CFLAGS-$(DEV_USB_ETH)+=-DCONFIG_USB_DEFAULT_GW=\"$(USB_DEFAULT_GW)\"

CFLAGS-$(DEVF4ETH)+=-DCONFIG_DEV_ETH
CFLAGS-$(DEVF4ETH)+=-DCONFIG_ETH_DEFAULT_IP=\"$(ETH_DEFAULT_IP)\"
CFLAGS-$(DEVF4ETH)+=-DCONFIG_ETH_DEFAULT_NM=\"$(ETH_DEFAULT_NM)\"
CFLAGS-$(DEVF4ETH)+=-DCONFIG_ETH_DEFAULT_GW=\"$(ETH_DEFAULT_GW)\"

OBJS-$(MACH_STM32F407Discovery)+=kernel/$(BOARD)/stm32f407discovery.o 
OBJS-$(MACH_STM32F405Pyboard)+=kernel/$(BOARD)/stm32f405pyboard.o 
OBJS-$(MACH_STM32F4x1Discovery)+=kernel/$(BOARD)/stm32f4x1discovery.o 
OBJS-$(MACH_STM32F429Discovery)+=kernel/$(BOARD)/stm32f429discovery.o 
OBJS-$(MACH_STM32F746Discovery)+=kernel/$(BOARD)/stm32f746discovery.o kernel/$(BOARD)/stm32f746discovery_sdram.o
OBJS-$(MACH_STM32F746Nucleo144)+=kernel/$(BOARD)/stm32f746nucleo-144.o
OBJS-$(MACH_LPC1768MBED)+=kernel/$(BOARD)/lpc1768mbed.o
OBJS-$(MACH_SEEEDPRO)+=kernel/$(BOARD)/lpc1768mbed.o
OBJS-$(MACH_LPC1679XPRESSO)+=kernel/$(BOARD)/lpc1769xpresso.o
OBJS-$(MACH_LM3S6965EVB)+=kernel/$(BOARD)/lm3s6965evb.o


LIB-y:=
LIB-$(PICOTCP)+=$(PREFIX)/lib/libpicotcp.a
LIB-y+=kernel/libopencm3/lib/libopencm3_$(BOARD).a

CFLAGS+=$(CFLAGS-y)

SHELL=/bin/bash
APPS_START = 0x20000
PADTO = $$(($(FLASH_ORIGIN)+$(APPS_START)))

all: image.bin

kernel/syscall_table.c: kernel/syscall_table_gen.py
	@python2 $^

$(PREFIX)/lib/libpicotcp.a:
	echo $(BUILD_PICO)
	$(BUILD_PICO)
	@pwd

syscall_table.c: kernel/syscall_table.c

syscall_table.h: syscall_table.c

.PHONY: FORCE

kernel.img: kernel.elf
	@export PADTO=`python2 -c "print ( $(KFLASHMEM_SIZE) * 1024) + int('$(FLASH_ORIGIN)', 16)"`;	\
	$(CROSS_COMPILE)objcopy -O binary --pad-to=$$PADTO kernel.elf $@

apps.img: $(USERSPACE)
	@make -C $(USERSPACE) FROSTED=$(PWD) FAMILY=$(FAMILY) ARCH=$(ARCH)

image.bin: kernel.img apps.img
	cat kernel.img apps.img > $@

kernel/libopencm3/lib/libopencm3_$(BOARD).a:
	make -C kernel/libopencm3 FP_FLAGS="-mfloat-abi=soft" PREFIX=arm-frosted-eabi V=1

kernel/$(BOARD)/$(BOARD).ld: kernel/$(BOARD)/$(BOARD).ld.in
	export KRAMMEM_SIZE_B=`python2 -c "print '0x%X' % ( $(KRAMMEM_SIZE) * 1024)"`;	\
	export KFLASHMEM_SIZE_B=`python2 -c "print '0x%X' % ( $(KFLASHMEM_SIZE) * 1024)"`;	\
	export RAM_SIZE_B=`python2 -c "print '0x%X' % ( $(RAM_SIZE) * 1024)"`;	\
	cat $^ | sed -e "s/__FLASH_ORIGIN/$(FLASH_ORIGIN)/g" | \
			 sed -e "s/__KFLASHMEM_SIZE/$$KFLASHMEM_SIZE_B/g" | \
			 sed -e "s/__RAM_BASE/$(RAM_BASE)/g" |\
			 sed -e "s/__KRAMMEM_SIZE/$$KRAMMEM_SIZE_B/g" |\
			 sed -e "s/__RAM_SIZE/$$RAM_SIZE_B/g" \
			 >$@

kernel.elf: $(LIB-y) $(OBJS-y) kernel/$(BOARD)/$(BOARD).ld
	@$(CC) -o $@   -Tkernel/$(BOARD)/$(BOARD).ld -Wl,--start-group $(OBJS-y) $(LIB-y) -Wl,--end-group \
		-Wl,-Map,kernel.map  $(LDFLAGS) $(CFLAGS) $(EXTRA_CFLAGS)


	
qemu: image.bin
	qemu-system-arm -semihosting -M lm3s6965evb --kernel image.bin -serial stdio -S -gdb tcp::3333

qemu2: image.bin
	qemu-system-arm -semihosting -M lm3s6965evb --kernel image.bin -serial stdio

menuconfig:
	@$(MAKE) -C kconfig/ menuconfig -f Makefile.frosted

config:
	@$(MAKE) -C kconfig/ config -f Makefile.frosted

malloc_test:
	@gcc -o malloc.test kernel/malloc.c -DCONFIG_KRAM_SIZE=4

libclean:
	@make -C kernel/libopencm3 clean

clean:
	@rm -f malloc.test
	@rm -f  kernel/$(BOARD)/$(BOARD).ld
	@make -C $(USERSPACE) clean
	@rm -f $(OBJS-y)
	@rm -f *.map *.bin *.elf *.img
	@rm -f kernel/$(BOARD)/$(BOARD).ld
	@find . |grep "\.o" | xargs -x rm -f
	@rm -rf build
	@rm -f tags
	@rm -f kernel/syscall_table.c
	@rm -f syscall_table.c

