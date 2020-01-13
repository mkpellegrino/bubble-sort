CPP_FLAGS=-arch x86_64 -m64
DEBUG=-g -DDEBUG
OPT=-O3
GCCSTACK=-mpreferred-stack-boundary=32
CLANGSTACK=-fdiagnostics-show-option
BIN_DIR=./
LIB_DIR=./
LST_DIR=./
INCLUDES=/usr/local/Cellar/gcc/8.2.0/include/

all:	clean optimized debug

release:clean optimized debug slim

optimized: 
	nasm -f macho64 bubble_sort_character.asm -o $(BIN_DIR)bubble_sort_character_a.o
	nasm -f macho64 bubble_sort_double.asm -o $(BIN_DIR)bubble_sort_double_a.o
	nasm -f macho64 bubble_sort_int.asm -o $(BIN_DIR)bubble_sort_int_a.o
	nasm -f macho64 bubble_sort_float.asm -o $(BIN_DIR)bubble_sort_float_a.o
	g++ -c -DDEBUG $(CLANGSTACK) $(OPT) $(CPP_FLAGS) bubble_sort.cpp -o $(BIN_DIR)bubble_sort_c.o
	g++ -Wl,-no_pie $(CLANGSTACK) $(CPP_FLAGS) $(OPT) $(BIN_DIR)bubble_sort_c.o $(BIN_DIR)bubble_sort_character_a.o $(BIN_DIR)bubble_sort_float_a.o $(BIN_DIR)bubble_sort_double_a.o $(BIN_DIR)bubble_sort_int_a.o -o $(BIN_DIR)bubble_sort
	strip -no_uuid -A -u -S -X -N -x $(BIN_DIR)bubble_sort

debug:
	nasm -f macho64 -g -DDEBUG -l $(BIN_DIR)bubble_sort_character_a.lst bubble_sort_character.asm -o $(BIN_DIR)bubble_sort_character_a-dbg.o
	nasm -f macho64 -g -DDEBUG -l $(BIN_DIR)bubble_sort_double_a.lst bubble_sort_double.asm -o $(BIN_DIR)bubble_sort_double_a-dbg.o
	nasm -f macho64 -g -DDEBUG -l $(BIN_DIR)bubble_sort_int_a.lst bubble_sort_int.asm -o $(BIN_DIR)bubble_sort_int_a-dbg.o
	nasm -f macho64 -g -DDEBUG -l $(BIN_DIR)bubble_sort_float_a.lst bubble_sort_float.asm -o $(BIN_DIR)bubble_sort_float_a-dbg.o
	g++ -c $(DEBUG) $(CPP_FLAGS) bubble_sort.cpp -o $(BIN_DIR)bubble_sort_c-dbg.o 
	g++ -Wl,-no_pie $(DEBUG) $(BIN_DIR)bubble_sort_c-dbg.o $(BIN_DIR)bubble_sort_character_a-dbg.o $(BIN_DIR)bubble_sort_double_a-dbg.o $(BIN_DIR)bubble_sort_float_a-dbg.o $(BIN_DIR)bubble_sort_int_a-dbg.o -o $(BIN_DIR)bubble_sort-dbg
	dsymutil $(BIN_DIR)bubble_sort-dbg

test:
	g++ sizeof.cpp $(DEBUG) $(CPP_FLAGS) -o $(BIN_DIR)sizeof

sandbox:
	nasm -f macho64 -g -DDEBUG -l $(BIN_DIR)sandbox_a.lst sandbox.asm -o $(BIN_DIR)sandbox_a-dbg.o

clean : 
	rm -fR $(BIN_DIR)bubble_sort
	rm -fR $(BIN_DIR)bubble_sort-dbg
	rm -fR $(BIN_DIR)sizeof
	rm -fR $(BIN_DIR)sandbox_a-dbg.o
	rm -fR $(BIN_DIR)sandbox_a.o
	rm -fR $(BIN_DIR)sandbox_a.lst



slim:
	rm -fR $(LIB_DIR)*.o 
	rm -fR $(BIN_DIR)bubble_sort-dbg.dSYM
	rm -fR $(BIN_DIR)bubble_sort-ld
	rm -fR $(BIN_DIR)*.lst

