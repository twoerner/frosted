
ifeq ($(PICOTCP),y)
	CFLAGS+=-DCONFIG_PICOTCP -I$(PREFIX)/include -Ikernel/net/socket 
    PICO_OPTIONS=CROSS_COMPILE=arm-none-eabi- ARCH=cortexm3 RTOS=1 PREFIX=$(PREFIX) \
    		 DHCP_CLIENT=0 DHCP_SERVER=0 MDNS=0 DNS_SD=0 \
    			 OLSR=0 SLAACV4=0 SNTP_CLIENT=0 PPP=0 TFTP=0 \
				 AODV=0 \
				 EXTRA_CFLAGS="-DFROSTED -I$(PWD)/kernel -I$(PWD)/include -nostdlib -DPICO_PORT_CUSTOM"
    PICO_LIB:=$(PREFIX)/lib/libpicotcp.a

ifneq ($(CONFIG_PICOTCP_DEBUG),y)
  PICO_OPTIONS+=DEBUG=0
endif
ifneq ($(CONFIG_PICOTCP_IPV6),y)
  PICO_OPTIONS+=IPV6=0
endif
ifneq ($(CONFIG_PICOTCP_IPV4),y)
  PICO_OPTIONS+=IPV4=0
endif
ifneq ($(CONFIG_PICOTCP_TCP),y)
  PICO_OPTIONS+=TCP=0
endif
ifneq ($(CONFIG_PICOTCP_UDP),y)
  PICO_OPTIONS+=UDP=0
endif
ifneq ($(CONFIG_PICOTCP_DNS),y)
  PICO_OPTIONS+=DNS_CLIENT=0
endif
ifneq ($(CONFIG_PICOTCP_MCAST),y)
  PICO_OPTIONS+=MCAST=0
endif
ifneq ($(CONFIG_PICOTCP_NAT),y)
  PICO_OPTIONS+=NAT=0
endif
ifneq ($(CONFIG_PICOTCP_IPFILTER),y)
  PICO_OPTIONS+=IPFILTER=0
endif
    BUILD_PICO=make -C kernel/net/picotcp $(PICO_OPTIONS)
    BUILD_SOCK=make -C kernel/net/socket CFLAGS="$(CFLAGS) -I$(PREFIX)/build/include -I$(PWD)/kernel -I$(PWD)/include -DFROSTED -DCORTEX_M3 -DPICO_PORT_CUSTOM -nostdlib"
endif

