CFLAGS = -fno-PIC -m32 -g
LDFLAGS = -nostdinc -nostdlib -no-pie -m32
AS = nasm
ASFLAGS = -f elf32

.DEFAULT_GOAL: all

.PHONY: all clean

all: name

name: name.o start.o puts.o
	#$(CC) $(LDFLAGS) -o $@ $^
	ld -m elf_i386 -o $@ $^

name.o: name.c

start.o: start.asm
	$(AS) $(ASFLAGS) -o $@ $<

puts.o: puts.asm
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	-rm -f name name.o start.o puts.o
	-rm -f *~
