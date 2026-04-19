# ===== Compiler =====
CC = gcc

# ===== Flags =====
CFLAGS = -Iinclude

# ===== Folders =====
SRC_DIR = src
OBJ_DIR = obj

# ===== Source files =====
SRC = $(wildcard $(SRC_DIR)/*.c)

# ===== Object files =====
OBJ = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC))

# ===== Output =====
TARGET = main.exe

# ===== Default =====
all: $(TARGET)

# ===== Link =====
$(TARGET): $(OBJ)
	$(CC) $^ -o $@

# ===== Compile =====
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# ===== Clean =====
clean:
	rm -rf $(OBJ_DIR) $(TARGET)

.PHONY: all clean
