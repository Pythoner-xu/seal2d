#ifndef __seal__array__
#define __seal__array__

#include "../seal_base.h"


struct array;

struct  array* array_new(int cap);
void    array_free(struct array* a);

struct array* array_copy(struct array* self);

void    array_push_back(struct array* self, void* data);
void    array_remove(struct array* self, void* data);
void    array_set(struct array* self, size_t index, void* data);
void*   array_at(struct array* self, size_t index);
void    array_swap(struct array* self, int i, int j);

// if free is set to none-zero, it will call s_free to dealloc the memory
// allocated by the user.
void    array_clear(struct array* self, bool cleanup);
int     array_empty(struct array* self);
size_t  array_size(struct array* self);

void*   array_data(struct array* self);

void array_debug_print(struct array* self);

#endif