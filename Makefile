# AVR Makefile

# Targets:
#
#	all:
#	flash:
#	clean:

# Source and include
BUILD_DIR=build
SRCS=$(wildcard src/*.c)
OBJS=$(SRCS:%.c=build/%.o)
INC=-I ./inc

# Project configuration
PRJ=main
PRJ_BUILD=$(BUILD_DIR)/$(PRJ)

# MCU Configuration
MCU=
CLK=
PRG=

# TODO: compiler, tools, and rules