TARGET = target

GCC = gcc
GXX = g++
GCCFLAGS = -std=c17
GXXFLAGS = -std=c++20
WARFLAGS = -Wall -Wextra
LIBFLAGS = 
DEBFLAGS = -g3 -ggdb3 -O0

SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin
SRCS    := $(shell find $(SRC_DIR) -name *.cpp -or -name *.c)
OBJS    := $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

default:$(TARGET)

$(TARGET):$(OBJS)
	@echo "$^ -> $(BIN_DIR)/$@"
	@$(GXX) -o "$(BIN_DIR)/$(TARGET)" $(OBJS) $(DEBFLAGS) $(WARFLAGS) $(GXXFLAGS) $(LIBFLAGS)

$(OBJ_DIR)/%.o:$(SRC_DIR)/%.cpp
	@echo "$^ -> $@"
	@mkdir -p "$(shell dirname "$@")"
	@$(GXX) -c -o "$@" "$^" $(DEBFLAGS) $(WARFLAGS) $(GXXFLAGS) $(LIBFLAGS)

$(OBJ_DIR)/%.o:$(SRC_DIR)/%.c
	@echo "$^ -> $@"
	@mkdir -p "$(shell dirname "$@")"
	@$(GCC) -c -o "$@" "$^" $(DEBFLAGS) $(WARFLAGS) $(GCCFLAGS) $(LIBFLAGS)

clean:
	@rm -fr $(OBJ_DIR)/* $(BIN_DIR)/$(TARGET)

run:
	@cd $(BIN_DIR) && ./$(TARGET)

.PHONY:clean run
