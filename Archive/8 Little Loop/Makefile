BUILD_NAME := quest.exe
SRC_NAME := run.asm

BUILD_DIR := 
SRC_DIR := 

BUILD := $(BUILD_DIR)$(BUILD_NAME)
SRC := $(SRC_DIR)$(SRC_NAME)

$(BUILD): $(SRC) $(BUILD_DIR) *.asm
	@nasm -f win32 -s $(SRC) -o $(SRC).obj && \
	ld $(SRC).obj -lkernel32 -entry=TheVeryBeginning -subsystemconsole -o $(BUILD) && \
	rm $(SRC).obj && \
	echo Rebuilt!

$(BUILD_DIR):
	@mkdir $@

.PHONY: clean
clean:

.PHONY: play
play: $(BUILD)
	@cmd /C start $(BUILD)
