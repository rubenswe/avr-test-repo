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
# m4809 = ATmega4809
MCU=m4809
# Default 20MHz
CLK=20000000
# using xplained pro dev board
# JTAG mode?
PRG=xplainedpro

# Compiler flags
CFLAGS=-std=c11 -Wall -Wextra Werror -mmcu=$(MCU) -DF_CPU=$(CLK)
OPT_FLAGS=-O0 -g -DDEBUG

# Compiler and utility tools
OBJCOPY=avr-objcopy
CC=avr-gcc

# Rules

all: $(PRJ_BUILD).elf

$(PRJ_BUILD).elf: $(OBJS)
	$(CC) -o $@ $^ $(INC) $(CFLAGS) $(OPT_FLAGS) $(MCU_FLAGS)
	$(OBJCOPY) -j .text -j .data -O ihex $@ $(PRJ_BUILD).hex
	$(OBJCOPY) -j .text -j .data -O binary $@ $(PRJ_BUILD).bin



build/%.o: %.c
	mkdir -p build/src
	$(CC) -c -o $@ $(INC) $(CFLAGS) $(OPT_FLAGS) $(MCU_FLAGS) $<

release: OPT_FLAGS=-O2 -DNDEBUG
release: $(PRJ_BUILD).elf

flash:
	avrdude -c $(PRG) -p $(MCU) -U flash:w:$(PRJ_BUILD).hex:i

flash-debug:
	avrdude -c $(PRG) -p $(MCU) -U flash:w:$(PRJ_BUILD).elf:e

clean:
	rm -rf build

.PHONY = clean, release, flash, flash-debug