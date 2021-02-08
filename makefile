BUILD_DIR := build

ifeq ($(OS),Windows_NT)
CMAKE_GENERATOR := "MinGW Makefiles"
else
CMAKE_GENERATOR := "Unix Makefiles"
endif

all:
	cmake . -B$(BUILD_DIR) -G $(CMAKE_GENERATOR)
	make -C $(BUILD_DIR) -j $(NUMBER_OF_PROCESSORS) --no-print-directory

clean:
ifeq ($(OS),Windows_NT)
	@if exist $(BUILD_DIR) rmdir /s /q $(BUILD_DIR)
else
	@rm -rf $(BUILD_DIR)
endif
