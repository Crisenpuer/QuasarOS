BUILD_DIR?=build/
ASM?=nasm
CC16?=/usr/bin/watcom/binl/wcc
LD16?=/usr/bin/watcom/binl/wlink

CFLAGS16?=-f obj
ASMFLAGS?=-4 -d3 -s -wx -ms -zl -zq

SOURCES_C=$(wildcard *.c)
SOURCES_ASM=$(wildcard *.asm)
OBJECTS_C=$(wildcard %.c, $(BUILD_DIR)/cunt/c/%.obj, $(SOURCES_C))
OBJECTS_ASM=$(wildcard %.asm, $(BUILD_DIR)/cunt/asm/%.obj, $(SOURCES_C))


.PHONY: all cunt clean always

all: cunt

cunt: $(BUILD_DIR)/cunt.bin

$(BUILD_DIR)/cunt.bin: $OBJECTS_ASM $OBJECTS_C
	$(LD16) NAME $(BUILD_DIR)/cunt.bin FILE \{ $(OBJECTS_ASM) $(OBJECTS_C) \} OPTION MAP=$(BUILD_DIR)/cunt.map @linker.lnk

$(BUILD_DIR)/cunt/c/%.obj: %.c always
	$(CC16) $(CFLAGS16) -fo=$@ $<

$(BUILD_DIR)/cunt/asm/%.obj: %.asm always
	$(ASM) $(ASMFLAGS) -o $@ $<


always:
	mkdir -p $(BUILD_DIR)/cunt/c
	mkdir -p $(BUILD_DIR)/cunt/asm


clean:
	rm -f $(BUILD_DIR)/cunt.bin