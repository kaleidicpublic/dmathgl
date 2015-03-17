import core.stdc.stdint;

extern (C):

void mgl_surf3_xyz_val (HMGL graph, double Val, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* stl, const(char)* opt);
void mgl_surf3_xyz_val_ (uintptr_t* graph, mreal* Val, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3_val (HMGL graph, double Val, HCDT a, const(char)* stl, const(char)* opt);
void mgl_surf3_val_ (uintptr_t* graph, mreal* Val, uintptr_t* a, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* stl, const(char)* opt);
void mgl_surf3_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3 (HMGL graph, HCDT a, const(char)* stl, const(char)* opt);
void mgl_surf3_ (uintptr_t* graph, uintptr_t* a, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3a_xyz_val (HMGL graph, double Val, HCDT x, HCDT y, HCDT z, HCDT a, HCDT b, const(char)* stl, const(char)* opt);
void mgl_surf3a_xyz_val_ (uintptr_t* graph, mreal* Val, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, uintptr_t* b, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3a_val (HMGL graph, double Val, HCDT a, HCDT b, const(char)* stl, const(char)* opt);
void mgl_surf3a_val_ (uintptr_t* graph, mreal* Val, uintptr_t* a, uintptr_t* b, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3a_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT a, HCDT b, const(char)* stl, const(char)* opt);
void mgl_surf3a_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, uintptr_t* b, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3a (HMGL graph, HCDT a, HCDT b, const(char)* stl, const(char)* opt);
void mgl_surf3a_ (uintptr_t* graph, uintptr_t* a, uintptr_t* b, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3c_xyz_val (HMGL graph, double Val, HCDT x, HCDT y, HCDT z, HCDT a, HCDT b, const(char)* stl, const(char)* opt);
void mgl_surf3c_xyz_val_ (uintptr_t* graph, mreal* Val, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, uintptr_t* b, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3c_val (HMGL graph, double Val, HCDT a, HCDT b, const(char)* stl, const(char)* opt);
void mgl_surf3c_val_ (uintptr_t* graph, mreal* Val, uintptr_t* a, uintptr_t* b, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3c_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT a, HCDT b, const(char)* stl, const(char)* opt);
void mgl_surf3c_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, uintptr_t* b, const(char)* stl, const(char)* opt, int, int);
void mgl_surf3c (HMGL graph, HCDT a, HCDT b, const(char)* stl, const(char)* opt);
void mgl_surf3c_ (uintptr_t* graph, uintptr_t* a, uintptr_t* b, const(char)* stl, const(char)* opt, int, int);
void mgl_cloud_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* stl, const(char)* opt);
void mgl_cloud_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* stl, const(char)* opt, int, int);
void mgl_cloud (HMGL graph, HCDT a, const(char)* stl, const(char)* opt);
void mgl_cloud_ (uintptr_t* graph, uintptr_t* a, const(char)* stl, const(char)* opt, int, int);
void mgl_beam_val (HMGL graph, double Val, HCDT tr, HCDT g1, HCDT g2, HCDT a, double r, const(char)* stl, int norm);
void mgl_beam_val_ (uintptr_t* gr, mreal* val, uintptr_t* tr, uintptr_t* g1, uintptr_t* g2, uintptr_t* a, mreal* r, const(char)* sch, int* norm, int l);
void mgl_beam (HMGL graph, HCDT tr, HCDT g1, HCDT g2, HCDT a, double r, const(char)* stl, int norm, int num);
void mgl_beam_ (uintptr_t* gr, uintptr_t* tr, uintptr_t* g1, uintptr_t* g2, uintptr_t* a, mreal* r, const(char)* sch, int* norm, int* num, int l);