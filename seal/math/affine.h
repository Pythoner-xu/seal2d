#ifndef __seal__affine__
#define __seal__affine__

#include "../seal_base.h"

// [a, b, x]   [X]   [X']
// [c, d, y] * [Y] = [Y']
// [0, 0, 1]   [1]   [1 ]
struct affine {
    float a, b, c, d;
    float x, y;
};

struct affine* af_alloc();
void af_free(struct affine* af);

void af_identify(struct affine* af);

void af_srt(struct affine* af,
            float x, float y,
            float scale_x, float scale_y,
            float rotation);

void af_copy(struct affine* af, struct affine* other);

void af_set_translate(struct affine* af, float x, float y);
void af_set_scale(struct affine* af, float scale_x, float scale_y);
void af_set_rotation(struct affine* af, float rotate);

void af_concat(struct affine* m1, struct affine* m2);

void af_tostring(struct affine* af, char* buff);


#endif