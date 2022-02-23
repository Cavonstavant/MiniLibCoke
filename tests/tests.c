#include <criterion/criterion.h>
#include <criterion/types.h>
#include <dlfcn.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>


void *handle = NULL;
size_t (*_strlen)(const char *s);
char *(*_strchr)(const char *s, int c);
char *(*_strrchr)(const char *s, int c);
void *(*_memset)(void *s, int c, size_t n);
void *(*_memcpy)(void *restrict dest, const void *restrict src, size_t n);
int (*_strcmp)(const char *s1, const char *s2);
int (*_strncmp)(const char *s1, const char *s2, size_t n);

char *get_lib_path(char *lib_name)
{
    char *lib_path = malloc(sizeof(char) * (strlen(lib_name) + 1040));
    lib_path = strcpy(lib_path, getcwd(NULL, 0));
    lib_path = strcat(lib_path, lib_name);
    return lib_path;
}

void setup(void)
{
    if (!handle){
        handle = dlopen(get_lib_path("/libasm.so"), RTLD_LAZY);
        if (!handle) {
            fprintf(stderr, "%s\n", dlerror());
            return;
        }
    }
}

void teardown(void)
{
    dlclose(handle);
}

Test(tests, test_strlen, .init=setup)
{
    char *str = "Hello World";
    char *error;

    _strlen = dlsym(handle, "strlen");
    if ((error = dlerror()) != NULL) {
        fprintf(stderr, "%s\n", error);
        return;
    }
    cr_assert(_strlen(str) == strlen(str));
    cr_assert(_strlen("") == strlen(""));
}

Test(test_strchr,  tests)
{
    char *str = "Hello World";
    char *error;

    _strchr = dlsym(handle, "strchr");
    if ((error = dlerror()) != NULL) {
        fprintf(stderr, "%s\n", error);
        return;
    }
    cr_assert_eq(_strchr(str, 'o'), strchr(str, 'o'));
}

Test(test_strcmp, tests)
{
    char *str = "Hello World";
    char *str1 = "World Hello";

    _strcmp = dlsym(handle, "strcmp");
    cr_assert_eq(_strcmp(str, str1), strcmp(str, str1), "excpected: %d, got: %d", strcmp(str, str1), _strcmp(str, str1));
}

Test(test_strrchr, tests)
{
    char *str = "Hello World";
    char *error;

    _strrchr = dlsym(handle, "strrchr");
    if ((error = dlerror()) != NULL) {
        fprintf(stderr, "%s\n", error);
        return;
    }
    cr_assert_eq(_strrchr(str, 'o'), strrchr(str, 'o'));
}

Test(test_memset, tests)
{
    char *str1 = malloc(sizeof(char) * 13);
    char *error;

    _memset = dlsym(handle, "memset");
    if ((error = dlerror()) != NULL) {
        fprintf(stderr, "%s\n", error);
        return;
    }
    cr_assert_eq(_memset(str1, 'a', 12), memset(str1, 'a', 12));
    cr_assert_str_eq(str1, "aaaaaaaaaaaa");
}

Test(test_memcpy, tests)
{
    char *str1 = malloc(sizeof(char) * 13);
    char *str2 = "Hello World";
    char *error;

    _memcpy = dlsym(handle, "memcpy");
    if ((error = dlerror()) != NULL) {
        fprintf(stderr, "%s\n", error);
        return;
    }
    cr_assert_eq(_memcpy(str1, str2, 12), memcpy(str1, str2, 12));
    cr_assert_str_eq(str1, "Hello World");
}

Test(test_strncpm, tests)
{
    char *str1 = "Hello Hello";
    char *str2 = "Hello World";
    char *error;

    _strncmp = dlsym(handle, "strncmp");
    if ((error = dlerror()) != NULL) {
        fprintf(stderr, "%s\n", error);
        return;
    }
    cr_assert_eq(_strncmp(str1, str2, 5), strncmp(str1, str2, 5));
}