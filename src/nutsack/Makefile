BUILD_DIR?=build/
ASM?=nasm

.PHONY: all clean

all: nutsack

nutsack: $(BUILD_DIR)/nutsack.bin

$(BUILD_DIR)/nutsack.bin:
	$(ASM) nutsack.asm -f bin -o $(BUILD_DIR)/nutsack.bin

clean:
	rm -f $(BUILD_DIR)/nutsack.bin