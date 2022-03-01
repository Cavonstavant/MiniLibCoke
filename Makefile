##
## EPITECH PROJECT, 2022
## bootstrap
## File description:
## Makefile
##

SRC_ASM := 	src/my_strlen.asm \
			src/my_strchr.asm \
			src/my_strrchr.asm \
			src/my_memset.asm \
			src/my_memcpy.asm \
			src/my_strcmp.asm \
			src/my_strncmp.asm \
			src/my_strcasecmp.asm

T_STRC := tests/tests.c

OBJ_ASM := 	$(SRC_ASM:.asm=.o)

ASM := nasm

AFLAGS := -f elf64 -g
CFLAGS := -shared -fpic -g -fno-builtin

LD := ld
GCC := gcc

NAME := libasm.so

all: $(SRC_ASM) $(NAME)

$(NAME): $(OBJ_ASM)
	$(LD) $(CFLAGS) $(OBJ_ASM) -o $@
	cp $@ tests/

%.o: %.asm
	$(ASM) $(AFLAGS) $< -o $@

clean:
	$(RM) $(OBJ_ASM)

fclean: clean
	$(RM) $(NAME)
	$(RM) tests/$(NAME)

re: fclean all

tests_run: re
	$(GCC) -g $(T_STRC) -ldl -lcriterion -o tests/main
	./tests/main

.PHONY: all clean fclean re tests_run