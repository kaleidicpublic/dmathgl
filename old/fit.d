import core.stdc.stdint;

extern (C):

extern __gshared int mglFitPnts;
extern __gshared char[1024] mglFitRes;

HMDT mgl_fit_1 (HMGL gr, HCDT y, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
HMDT mgl_fit_2 (HMGL gr, HCDT z, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
HMDT mgl_fit_3 (HMGL gr, HCDT a, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
HMDT mgl_fit_xy (HMGL gr, HCDT x, HCDT y, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
HMDT mgl_fit_xyz (HMGL gr, HCDT x, HCDT y, HCDT z, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
HMDT mgl_fit_xyza (HMGL gr, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
HMDT mgl_fit_ys (HMGL gr, HCDT y, HCDT s, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
HMDT mgl_fit_xys (HMGL gr, HCDT x, HCDT y, HCDT s, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
HMDT mgl_fit_xyzs (HMGL gr, HCDT x, HCDT y, HCDT z, HCDT s, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
HMDT mgl_fit_xyzas (HMGL gr, HCDT x, HCDT y, HCDT z, HCDT a, HCDT s, const(char)* eq, const(char)* vars, HMDT ini, const(char)* opt);
const(char)* mgl_get_fit (HMGL gr);
int mgl_get_fit_ (uintptr_t* gr, char* out_, int len);
HMDT mgl_hist_x (HMGL gr, HCDT x, HCDT a, const(char)* opt);
HMDT mgl_hist_xy (HMGL gr, HCDT x, HCDT y, HCDT a, const(char)* opt);
HMDT mgl_hist_xyz (HMGL gr, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* opt);
void mgl_puts_fit (HMGL gr, double x, double y, double z, const(char)* prefix, const(char)* font, double size);
mreal mgl_get_fit_chi (...);
uintptr_t mgl_fit_1_ (uintptr_t* gr, uintptr_t* y, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_fit_2_ (uintptr_t* gr, uintptr_t* z, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_fit_3_ (uintptr_t* gr, uintptr_t* a, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_fit_xy_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_fit_xyz_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_fit_xyza_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_fit_ys_ (uintptr_t* gr, uintptr_t* y, uintptr_t* ss, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_fit_xys_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* ss, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_fit_xyzs_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* ss, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_fit_xyzas_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, uintptr_t* ss, const(char)* eq, const(char)* vars, uintptr_t* ini, const(char)* opt, int, int l, int n);
uintptr_t mgl_hist_x_ (uintptr_t* gr, uintptr_t* x, uintptr_t* a, const(char)* opt, int);
uintptr_t mgl_hist_xy_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* a, const(char)* opt, int);
uintptr_t mgl_hist_xyz_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* opt, int);
void mgl_puts_fit_ (uintptr_t* gr, mreal* x, mreal* y, mreal* z, const(char)* prefix, const(char)* font, mreal* size, int l, int n);
mreal mgl_get_fit_chi_ (...);