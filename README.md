# MakeFile
Học cách buid gcc trong C với MakeFile (đã biết 1 chút về tạo `.o`  bằng gcc)

Đây chỉ là phần cơ bản thôi vì 2026 rồi ai còn dùng MakeFile nữa.

Chú ý nếu gặp lỗi `missing separator.  Stop.` thì xóa khoảng trắng đi thay khoảng trắng bằng `Tab`. Nếu không hiểu thì AI :)

<br>

## MakeFile là gì?
- Biên dịch `.h` `.c` nhanh gọn lẹ
- Thay vì gõ:
```bash
gcc src/main.c src/button.c src/light.c -o main.exe -I include
```
trong đó: `-I include` là tìm `.h` trong `/include` nếu bạn để `.h` ở cùng `.c` thì có thế viết `-I.`
- Bạn chỉ cần:
```bash
make
```


<br>

## Cách build
### 1. Cấu trúc cơ bản
```Makefile
target: dependencies
    command
```
Ví dụ `Makefile`:
```Makefile
build:
	gcc src/main.c src/button.c src/light.c -o main.exe -I include
```
Chạy:
```bash
make build
```
hoặc
```
make
```

### 2. Biến trong Makefile
Ví dụ (kết quả giống chương trình ở phía trên):
```Makefile
CC = gcc
TARGET = main.exe
SRC = src/main.c src/button.c src/light.c
CFLAGS = -I include

build:
    $(CC) $(SRC) -o $(TARGET) $(CFLAGS)

```

### 3. Một số kí tự

a. `$@` = Target phần bên trái dấu `:`
```Makefile
main.exe: main.o
	gcc main.o -o $@
```
=> `$@` = `main.exe`

b. `$<` = dependency đầu tiên bên phải `:`
```Makefile
main.exe: main.o button.o light.o
	gcc $^ -o $@
```
=> `$<` = `src/main.c`

  c. `$^` = tất cả dependency bên phải `:`

```Makefile
main.exe: main.o button.o light.o
	gcc $^ -o $@
```
=> `$^` = `main.o button.o light.o`

d. `%` = patten

```Makefile
obj/%.o: src/%.c
```
Nghĩa là:
```
src/main.c → obj/main.o
src/light.c → obj/light.o
```

### 4. `Wildcard` và `Patsubst`
a. `wildcard`
- `wildcard` dùng để quét thư mục và lấy ra danh sách các file khớp với một mẫu nào đó (thường là đuôi `.c`). Ví dụ:
```Makefile
SRC = $(wildcard src/*.c) main.c
```
=> Nếu trong thư mục src có `button.c` và `light.c`, biến `SRC` sẽ tự động trở thành: `src/button.c src/light.c main.c`. Bạn không cần gõ tay nữa!

b. `patsubst`
- `patsubst` dùng để đổi đuôi file hoặc đổi đường dẫn của một danh sách file. Trong C, ta thường dùng nó để chuyển danh sách file nguồn `.c` thành danh sách file đối tượng `.o`.

```
OBJ = $(patsubst %.c, %.o, $(SRC))
```
=> Nó sẽ lấy tất cả các file trong `SRC`, file nào đuôi `.c` thì đổi thành đuôi `.o`: 

main.c → main.o

src/button.c → src/button.o
### 5. `Target` phổ biến
1. `all`
   
   ```Makefile
   all: build
   ```
   chỉ cần gõ `make` là chạy `build`
2. `clean`

Làm sạch `.o` `.exe` để nó không bị lỗi thôi
```Makefile
clean:
    rm -f *.o
```
Nếu chẳng may ta có file `clean.h` thì ta dùng:
```Makefile
.PHONY: clean
clean:
    rm -f *.o $(TARGET)
```
hoặc
```Makefile
.PHONY: clean all
```

## Kết quả:
``` Makefile
# ===== Compiler =====
CC = gcc

# ===== Flags =====
CFLAGS = -Wall -Wextra -Iinclude

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
```