# this makefile is to compile apps as a separate bFLT executable
#
#

# PATH CONFIG
FROSTED_PATH=..
PREFIX:=$(PWD)/build

# APPLICATION CONFIG
APPS-y += init_bflt.o fresh.o binutils.o stubs.o

# TOOLCHAIN CONFIG
CROSS_COMPILE?=arm-none-eabi-
CC:=$(CROSS_COMPILE)gcc
AS:=$(CROSS_COMPILE)as
AR:=$(CROSS_COMPILE)ar

# COMPILER FLAGS -- Includes
CFLAGS+=-I$(FROSTED_PATH)/include -I$(FROSTED_PATH)/include/libc -I$(FROSTED_PATH)/newlib/build/lib/arm-none-eabi/include
# COMPILER FLAGS -- Target CPU
CFLAGS+=-mthumb -mlittle-endian -mthumb-interwork -ffunction-sections -mcpu=cortex-m3
CFLAGS+=-DCORE_M3 -D__frosted__
# COMPILER FLAGS -- No gcc libraries
#CFLAGS+=-nostartfiles -fno-builtin -ffreestanding
# COMPILER FLAGS -- GOT/PIC
CFLAGS+=-fPIC -mlong-calls -fno-common -msingle-pic-base -mno-pic-data-is-text-relative
# Debugging
CFLAGS+=-ggdb

# LINKER FLAGS
LDFLAGS:=-L$(FROSTED_PATH)/build/lib -L$(FROSTED_PATH)/newlib/build/lib/arm-none-eabi/lib -gc-sections --specs=nano.specs
LDFLAGS+=-fPIC -mlong-calls -fno-common -Wl,-elf2flt

all: apps

apps: $(FROSTED_PATH)/build/lib/libfrosted.a $(APPS-y)
	$(CC) -o $@  $(APPS-y) -Telf2flt.ld -lfrosted \
		$(FROSTED_PATH)/newlib/build/lib/arm-none-eabi/lib/libc.a \
		$(FROSTED_PATH)/newlib/build/lib/arm-none-eabi/lib/libg.a \
		$(FROSTED_PATH)/newlib/build/lib/arm-none-eabi/lib/libm.a \
		-lfrosted -Wl,-Map,apps.map  $(LDFLAGS) $(CFLAGS) $(EXTRA_CFLAGS)

clean:
	@rm -f *.o
	@rm -f apps
	@rm -f apps.gdb
