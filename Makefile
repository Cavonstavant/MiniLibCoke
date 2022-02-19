##
## EPITECH PROJECT, 2022
## bootstrap
## File description:
## Makefile
##

SRC_ASM := 	src/my_strlen.asm \
			src/my_strchr.asm \
			src/my_strrchr.asm

T_STRC := tests/main.c

OBJ_ASM := 	$(SRC_ASM:.asm=.o)

ASM := nasm

AFLAGS := -f elf64
CFLAGS := -shared -fpic -g

LD := ld
GCC := gcc

NAME := libasm.so

all: $(SRC_ASM) $(NAME)

$(NAME): $(OBJ_ASM)
	$(LD) $(CFLAGS) $(OBJ_ASM) -o $@

%.o: %.asm
	$(ASM) $(AFLAGS) $< -o $@

clean:
	$(RM) $(OBJ_ASM)

fclean: clean
	$(RM) $(NAME)

re: fclean all

tests_run: re
	chmod +r libasm.so
	cp libasm.so tests/
	$(GCC) $(T_STRC) -ldl -o tests/main
	ls -lR
	./tests/main

.PHONY: all clean fclean re tests_run