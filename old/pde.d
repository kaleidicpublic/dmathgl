import core.stdc.stdint;

extern (C):

HADT mgl_pde_solve_c (HMGL gr, const(char)* ham, HCDT ini_re, HCDT ini_im, mreal dz, mreal k0, const(char)* opt);
uintptr_t mgl_pde_solve_c_ (uintptr_t* gr, const(char)* ham, uintptr_t* ini_re, uintptr_t* ini_im, mreal* dz, mreal* k0, const(char)* opt, int, int);
HMDT mgl_pde_solve (HMGL gr, const(char)* ham, HCDT ini_re, HCDT ini_im, mreal dz, mreal k0, const(char)* opt);
uintptr_t mgl_pde_solve_ (uintptr_t* gr, const(char)* ham, uintptr_t* ini_re, uintptr_t* ini_im, mreal* dz, mreal* k0, const(char)* opt, int, int);
HADT mgl_qo2d_solve_c (const(char)* ham, HCDT ini_re, HCDT ini_im, HCDT ray, mreal r, mreal k0, HMDT xx, HMDT yy);
HADT mgl_qo2d_func_c (ddual function (mreal, mreal, mreal, mreal, mreal, void*) ham, void* par, HCDT ini_re, HCDT ini_im, HCDT ray, mreal r, mreal k0, HMDT xx, HMDT yy);
uintptr_t mgl_qo2d_solve_c_ (const(char)* ham, uintptr_t* ini_re, uintptr_t* ini_im, uintptr_t* ray, mreal* r, mreal* k0, uintptr_t* xx, uintptr_t* yy, int);
HMDT mgl_qo2d_solve (const(char)* ham, HCDT ini_re, HCDT ini_im, HCDT ray, mreal r, mreal k0, HMDT xx, HMDT yy);
HMDT mgl_qo2d_func (ddual function (mreal, mreal, mreal, mreal, mreal, void*) ham, void* par, HCDT ini_re, HCDT ini_im, HCDT ray, mreal r, mreal k0, HMDT xx, HMDT yy);
uintptr_t mgl_qo2d_solve_ (const(char)* ham, uintptr_t* ini_re, uintptr_t* ini_im, uintptr_t* ray, mreal* r, mreal* k0, uintptr_t* xx, uintptr_t* yy, int);
HADT mgl_qo3d_solve_c (const(char)* ham, HCDT ini_re, HCDT ini_im, HCDT ray, mreal r, mreal k0, HMDT xx, HMDT yy, HMDT zz);
HADT mgl_qo3d_func_c (ddual function (mreal, mreal, mreal, mreal, mreal, mreal, mreal, void*) ham, void* par, HCDT ini_re, HCDT ini_im, HCDT ray, mreal r, mreal k0, HMDT xx, HMDT yy, HMDT zz);
uintptr_t mgl_qo3d_solve_c_ (const(char)* ham, uintptr_t* ini_re, uintptr_t* ini_im, uintptr_t* ray, mreal* r, mreal* k0, uintptr_t* xx, uintptr_t* yy, uintptr_t* zz, int);
HMDT mgl_qo3d_solve (const(char)* ham, HCDT ini_re, HCDT ini_im, HCDT ray, mreal r, mreal k0, HMDT xx, HMDT yy, HMDT zz);
HMDT mgl_qo3d_func (ddual function (mreal, mreal, mreal, mreal, mreal, mreal, mreal, void*) ham, void* par, HCDT ini_re, HCDT ini_im, HCDT ray, mreal r, mreal k0, HMDT xx, HMDT yy, HMDT zz);
uintptr_t mgl_qo3d_solve_ (const(char)* ham, uintptr_t* ini_re, uintptr_t* ini_im, uintptr_t* ray, mreal* r, mreal* k0, uintptr_t* xx, uintptr_t* yy, uintptr_t* zz, int);
HMDT mgl_ode_solve (void function (const(mreal)*, mreal*, void*) func, int n, const(mreal)* x0, mreal dt, mreal tmax, void* par);
HMDT mgl_ode_solve_str (const(char)* func, const(char)* var, HCDT x0, mreal dt, mreal tmax);
HMDT mgl_ode_solve_ex (void function (const(mreal)*, mreal*, void*) func, int n, const(mreal)* x0, mreal dt, mreal tmax, void* par, void function (mreal*, const(mreal)*, void*) bord);
HMDT mgl_ray_trace (const(char)* ham, mreal x0, mreal y0, mreal z0, mreal px, mreal py, mreal pz, mreal dt, mreal tmax);
uintptr_t mgl_ray_trace_ (const(char)* ham, mreal* x0, mreal* y0, mreal* z0, mreal* px, mreal* py, mreal* pz, mreal* dt, mreal* tmax, int);
HMDT mgl_jacobian_2d (HCDT x, HCDT y);
uintptr_t mgl_jacobian_2d_ (uintptr_t* x, uintptr_t* y);
HMDT mgl_jacobian_3d (HCDT x, HCDT y, HCDT z);
uintptr_t mgl_jacobian_3d_ (uintptr_t* x, uintptr_t* y, uintptr_t* z);