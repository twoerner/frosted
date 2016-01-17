#
# Makefile for PicoTCP as Linux TCP/IP replacement.
#
-include ../../kconfig/.config

CFLAGS-y += -I net/tcpip/picotcp/include -I net/tcpip/picotcp/modules -I net/tcpip

OBJS-$(CONFIG_PICOTCP)     += net/tcpip/af_inet.o \
			net/tcpip/netdev.o \
			net/tcpip/core.o \
			net/tcpip/ioctl.o \
			net/tcpip/proc.o

OBJS-$(CONFIG_PICOTCP)     += net/tcpip/picotcp/stack/pico_device.o \
			net/tcpip/picotcp/stack/pico_frame.o \
			net/tcpip/picotcp/stack/pico_protocol.o \
			net/tcpip/picotcp/stack/pico_socket.o \
			net/tcpip/picotcp/stack/pico_socket_multicast.o \
			net/tcpip/picotcp/stack/pico_stack.o \
			net/tcpip/picotcp/stack/pico_tree.o 

OBJS-$(CONFIG_PICOTCP_IPV4) 		+= net/tcpip/picotcp/modules/pico_ipv4.o net/tcpip/picotcp/modules/pico_ipfilter.o
OBJS-$(CONFIG_PICOTCP_IPV6) 		+= net/tcpip/picotcp/modules/pico_ipv6.o net/tcpip/picotcp/modules/pico_icmp6.o net/tcpip/picotcp/modules/pico_ipv6_nd.o
OBJS-$(CONFIG_PICOTCP_DEVLOOP) 	+= net/tcpip/picotcp/modules/pico_dev_loop.o
OBJS-$(CONFIG_PICOTCP_ETH) 		+= net/tcpip/picotcp/modules/pico_arp.o
OBJS-$(CONFIG_PICOTCP_TCP) 		+= net/tcpip/picotcp/modules/pico_tcp.o net/tcpip/picotcp/modules/pico_socket_tcp.o
OBJS-$(CONFIG_PICOTCP_UDP) 		+= net/tcpip/picotcp/modules/pico_udp.o net/tcpip/picotcp/modules/pico_socket_udp.o
OBJS-$(CONFIG_PICOTCP_MULTICAST) += net/tcpip/picotcp/modules/pico_igmp.o
OBJS-$(CONFIG_PICOTCP_NAT) 		+= net/tcpip/picotcp/modules/pico_nat.o
OBJS-$(CONFIG_PICOTCP_ICMP4) 	+= net/tcpip/picotcp/modules/pico_icmp4.o
OBJS-$(CONFIG_PICOTCP_DNS_CLIENT)+= net/tcpip/picotcp/modules/pico_dns_client.o net/tcpip/picotcp/modules/pico_dns_common.o


