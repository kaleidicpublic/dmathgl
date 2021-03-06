import core.stdc.stdint;

extern (C):

void mgl_text_xyz (HMGL gr, HCDT x, HCDT y, HCDT z, const(char)* text, const(char)* font, const(char)* opt);
void mgl_text_xyz_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* text, const(char)* font, const(char)* opt, int, int l, int n);
void mgl_textw_xyz (HMGL gr, HCDT x, HCDT y, HCDT z, const(dchar)* text, const(char)* font, const(char)* opt);
void mgl_text_xy (HMGL gr, HCDT x, HCDT y, const(char)* text, const(char)* font, const(char)* opt);
void mgl_text_xy_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, const(char)* text, const(char)* font, const(char)* opt, int, int l, int n);
void mgl_textw_xy (HMGL gr, HCDT x, HCDT y, const(dchar)* text, const(char)* font, const(char)* opt);
void mgl_text_y (HMGL gr, HCDT y, const(char)* text, const(char)* font, const(char)* opt);
void mgl_text_y_ (uintptr_t* gr, uintptr_t* y, const(char)* text, const(char)* font, const(char)* opt, int, int l, int n);
void mgl_textw_y (HMGL gr, HCDT y, const(dchar)* text, const(char)* font, const(char)* opt);
void mgl_cont_gen (HMGL gr, double val, HCDT a, HCDT x, HCDT y, HCDT z, const(char)* stl);
void mgl_contf_gen (HMGL gr, double v1, double v2, HCDT a, HCDT x, HCDT y, HCDT z, const(char)* stl);
void mgl_cont_xy_val (HMGL gr, HCDT v, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_cont_xy_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_cont_val (HMGL gr, HCDT v, HCDT z, const(char)* sch, const(char)* opt);
void mgl_cont_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_cont_xy (HMGL gr, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_cont_xy_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_cont (HMGL gr, HCDT z, const(char)* sch, const(char)* opt);
void mgl_cont_ (uintptr_t* gr, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contf_xy_val (HMGL gr, HCDT v, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contf_xy_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contf_val (HMGL gr, HCDT v, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contf_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contf_xy (HMGL gr, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contf_xy_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contf (HMGL gr, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contf_ (uintptr_t* gr, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contd_xy_val (HMGL gr, HCDT v, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contd_xy_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contd_val (HMGL gr, HCDT v, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contd_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contd_xy (HMGL gr, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contd_xy_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contd (HMGL gr, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contd_ (uintptr_t* gr, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contv_xy_val (HMGL gr, HCDT v, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contv_xy_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contv_val (HMGL gr, HCDT v, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contv_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contv_xy (HMGL gr, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contv_xy_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_contv (HMGL gr, HCDT z, const(char)* sch, const(char)* opt);
void mgl_contv_ (uintptr_t* gr, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_axial_xy_val (HMGL gr, HCDT v, HCDT x, HCDT y, HCDT a, const(char)* sch, const(char)* opt);
void mgl_axial_xy_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* x, uintptr_t* y, uintptr_t* a, const(char)* sch, const(char)* opt, int, int);
void mgl_axial_val (HMGL gr, HCDT v, HCDT a, const(char)* sch, const(char)* opt);
void mgl_axial_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* a, const(char)* sch, const(char)* opt, int, int);
void mgl_axial_xy (HMGL gr, HCDT x, HCDT y, HCDT a, const(char)* sch, const(char)* opt);
void mgl_axial_xy_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* a, const(char)* sch, const(char)* opt, int, int);
void mgl_axial (HMGL gr, HCDT a, const(char)* sch, const(char)* opt);
void mgl_axial_ (uintptr_t* gr, uintptr_t* a, const(char)* sch, const(char)* opt, int, int);
void mgl_torus (HMGL gr, HCDT r, HCDT z, const(char)* col, const(char)* opt);
void mgl_torus_ (uintptr_t* gr, uintptr_t* r, uintptr_t* z, const(char)* pen, const(char)* opt, int, int);
void mgl_grid3_xyz (HMGL gr, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* stl, double sVal, const(char)* opt);
void mgl_grid3_xyz_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_grid3 (HMGL gr, HCDT a, const(char)* stl, double sVal, const(char)* opt);
void mgl_grid3_ (uintptr_t* gr, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_dens3_xyz (HMGL gr, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* stl, double sVal, const(char)* opt);
void mgl_dens3_xyz_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_dens3 (HMGL gr, HCDT a, const(char)* stl, double sVal, const(char)* opt);
void mgl_dens3_ (uintptr_t* gr, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_cont3_xyz_val (HMGL gr, HCDT v, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* sch, double sVal, const(char)* opt);
void mgl_cont3_xyz_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_cont3_val (HMGL gr, HCDT v, HCDT a, const(char)* sch, double sVal, const(char)* opt);
void mgl_cont3_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_cont3_xyz (HMGL gr, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* sch, double sVal, const(char)* opt);
void mgl_cont3_xyz_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_cont3 (HMGL gr, HCDT a, const(char)* sch, double sVal, const(char)* opt);
void mgl_cont3_ (uintptr_t* gr, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_contf3_xyz_val (HMGL gr, HCDT v, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* sch, double sVal, const(char)* opt);
void mgl_contf3_xyz_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_contf3_val (HMGL gr, HCDT v, HCDT a, const(char)* sch, double sVal, const(char)* opt);
void mgl_contf3_val_ (uintptr_t* gr, uintptr_t* v, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_contf3_xyz (HMGL gr, HCDT x, HCDT y, HCDT z, HCDT a, const(char)* sch, double sVal, const(char)* opt);
void mgl_contf3_xyz_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);
void mgl_contf3 (HMGL gr, HCDT a, const(char)* sch, double sVal, const(char)* opt);
void mgl_contf3_ (uintptr_t* gr, uintptr_t* a, const(char)* sch, mreal* sVal, const(char)* opt, int, int);