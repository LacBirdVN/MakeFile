CC = gcc
TARGET = main.exe
SRC = src/main.c src/button.c src/light.c
CFLAGS = -I include

app:
	$(CC) $(SRC) -o $(TARGET) $(CFLAGS)

.PHONY: clean
clean:
	rm -f *.o $(TARGET)