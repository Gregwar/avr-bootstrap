
SOURCES := main.c 
TARGET := atmega328p
PORT := /dev/ttyACM0
FREQ := 16000000
FLAGS := -mmcu=$(TARGET) -DF_CPU=$(FREQ) -Os
OBJECTS := $(addprefix build/,$(subst .c,.o,$(SOURCES)))

all: build/firmware.bin

clean:
	rm -rf build

build/%.o: %.c
	@mkdir -p build
	avr-gcc $(FLAGS) $< -c -o $@

build/firmware.elf: $(OBJECTS)
	avr-gcc $(FLAGS) $(OBJECTS) -o build/firmware.elf

build/firmware.bin: build/firmware.elf
	avr-objdump -D build/firmware.elf > build/firmware.s
	avr-objcopy -O binary build/firmware.elf build/firmware.bin
	avr-size build/firmware.elf

install: build/firmware.bin
	avrdude -P $(PORT) -c arduino -p $(TARGET) -U flash:w:build/firmware.bin

