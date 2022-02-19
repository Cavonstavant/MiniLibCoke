#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

size_t (*_strlen)(const char *s);
char *(*_strchr)(const char *s, int c);
char *(*_strrchr)(const char *s, int c);
void *(*_memset)(void *s, int c, size_t n);

int main(void)
{
    void *handle;
    char *error;
    char *str = "Hello World";
    char *str1 = malloc(sizeof(char) * 12);

    handle = dlopen("../libasm.so", RTLD_LAZY);
    if (!handle) {
        fprintf(stderr, "%s\n", dlerror());
        return 1;
    }
    dlerror();
    _strlen = dlsym(handle, "strlen");
    _strchr = dlsym(handle, "strchr");
    _strrchr = dlsym(handle, "strrchr");
    _memset = dlsym(handle, "memset");
    if ((error = dlerror()) != NULL) {
        fprintf(stderr, "%s\n", error);
        return 1;
    }
    _memset(str1, 'a', 12);
    printf("str adress: %p\n", str);
    printf("%d\n", (*_strlen)(str));
    printf("_strchr(str, 'o'): %s\n", (*_strchr)(str, 'o'));
    printf("strrchr(str, 'o'): %s\n", (*_strrchr)(str, 'o'));
    printf("_strchr(str, 'x'): %p\n", (*_strchr)(str, 'x'));
    printf("_memset(str, 'a', 12): %s\n", str1);
    return 0;
}