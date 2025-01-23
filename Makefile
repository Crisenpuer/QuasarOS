ASM=nasm
CC=gcc
CC16=/usr/bin/watcom/binl/wcc
LD16=/usr/bin/watcom/binl/wlink

SRC_DIR=src
TOOLS_DIR=tools
BUILD_DIR=build

FLOPPY=floppy.img

FLOPPY_FILE=$(BUILD_DIR)/$(FLOPPY)

.PHONY: all floppy_image kernel bootloader clean always
.PHONY: tools_fat


#
# Floppy image
#
floppy_image: $(FLOPPY_FILE)

$(FLOPPY_FILE): bootloader kernel
	dd if=/dev/zero of=$(FLOPPY_FILE) bs=512 count=2880
	mkfs.fat -F 12 -n "VAGINA OS  " $(FLOPPY_FILE)
	dd if=$(BUILD_DIR)/boot.bin of=$(FLOPPY_FILE) conv=notrunc
	mcopy -i $(FLOPPY_FILE) $(BUILD_DIR)/cunt.bin "::CBL.BIN"
	mcopy -i $(FLOPPY_FILE) $(BUILD_DIR)/nutsack.bin "::NSK.BIN"
	mcopy -i $(FLOPPY_FILE) test.txt "::test.txt"




#
# Bootloader
#
bootloader: boot cunt

boot: $(BUILD_DIR)/boot.bin
$(BUILD_DIR)/boot.bin: always
	$(MAKE) -C $(SRC_DIR)/bootloader/boot BUILD_DIR=$(abspath $(BUILD_DIR))

cunt: $(BUILD_DIR)/cunt.bin
$(BUILD_DIR)/cunt.bin: always
	$(MAKE) -C $(SRC_DIR)/bootloader/cunt BUILD_DIR=$(abspath $(BUILD_DIR))


#
# Kernel
#
kernel: $(BUILD_DIR)/nutsack.bin

$(BUILD_DIR)/nutsack.bin: always
	$(MAKE) -C $(SRC_DIR)/nutsack BUILD_DIR=$(abspath $(BUILD_DIR))


#
# Tools
#
tools_fat: $(BUILD_DIR)/tools/fat
$(BUILD_DIR)/tools/fat: always tools/fat/fat.c
	mkdir -p $(BUILD_DIR)/tools
	$(CC) -g -o $(BUILD_DIR)/tools/fat $(TOOLS_DIR)/fat/fat.c


#
# Always
#
always:
	mkdir -p $(BUILD_DIR)

#
# Clean
#
clean:
	rm -rf $(BUILD_DIR)/*



#
# QEMU Start
#
run: $(FLOPPY_FILE)
	qemu-system-i386 -fda $(FLOPPY_FILE)

#
# Bochs start
#
debug: $(FLOPPY_FILE)
	bochs -f bochs.cfg