##
## EPITECH PROJECT, 2022
## bootstrap
## File description:
## Makefile
##

SRC_ASM := 	src/my_strlen.asm \
			src/my_strchr.asm \
			src/my_strrchr.asm

OBJ_ASM := 	$(SRC_ASM:.asm=.o)

ASM := nasm
CC := gcc

AFLAGS := -f elf64
CFLAGS := -shared

NAME := libasm.so

all: $(SRC_ASM) $(NAME)

$(NAME): $(OBJ_ASM)
	$(CC) $(CFLAGS) $(OBJ_ASM) -o $@

%.o: %.asm
	$(ASM) $(AFLAGS) $< -o $@

clean:
	$(RM) $(OBJ_ASM)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re