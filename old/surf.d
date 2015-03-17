import core.stdc.stdint;

extern (C):

void mgl_fsurf (HMGL graph, const(char)* fz, const(char)* stl, const(char)* opt);
void mgl_fsurf_ (uintptr_t* graph, const(char)* fz, const(char)* stl, const(char)* opt, int, int, int);
void mgl_fsurf_xyz (HMGL graph, const(char)* fx, const(char)* fy, const(char)* fz, const(char)* stl, const(char)* opt);
void mgl_fsurf_xyz_ (uintptr_t* graph, const(char)* fx, const(char)* fy, const(char)* fz, const(char)* stl, const(char)* opt, int, int, int, int, int);
void mgl_grid_xy (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* stl, const(char)* opt);
void mgl_grid_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* stl, const(char)* opt, int, int);
void mgl_grid (HMGL graph, HCDT a, const(char)* stl, const(char)* opt);
void mgl_grid_ (uintptr_t* graph, uintptr_t* a, const(char)* stl, const(char)* opt, int, int);
void mgl_mesh_xy (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_mesh_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_mesh (HMGL graph, HCDT z, const(char)* sch, const(char)* opt);
void mgl_mesh_ (uintptr_t* graph, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_fall_xy (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_fall_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_fall (HMGL graph, HCDT z, const(char)* sch, const(char)* opt);
void mgl_fall_ (uintptr_t* graph, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_belt_xy (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_belt_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_belt (HMGL graph, HCDT z, const(char)* sch, const(char)* opt);
void mgl_belt_ (uintptr_t* graph, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_surf_xy (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_surf_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_surf (HMGL graph, HCDT z, const(char)* sch, const(char)* opt);
void mgl_surf_ (uintptr_t* graph, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_dens_xy (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_dens_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_dens (HMGL graph, HCDT z, const(char)* sch, const(char)* opt);
void mgl_dens_ (uintptr_t* graph, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_boxs_xy (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_boxs_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_boxs (HMGL graph, HCDT z, const(char)* sch, const(char)* opt);
void mgl_boxs_ (uintptr_t* graph, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_tile_xy (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* sch, const(char)* opt);
void mgl_tile_xy_ (uintptr_t* gr, uintptr_t* x, uintptr_t* y, uintptr_t* a, const(char)* sch, const(char)* opt, int, int);
void mgl_tile (HMGL graph, HCDT z, const(char)* sch, const(char)* opt);
void mgl_tile_ (uintptr_t* graph, uintptr_t* z, const(char)* sch, const(char)* opt, int, int);
void mgl_tiles_xy (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT r, const(char)* sch, const(char)* opt);
void mgl_tiles_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* c, const(char)* sch, const(char)* opt, int, int);
void mgl_tiles (HMGL graph, HCDT z, HCDT r, const(char)* sch, const(char)* opt);
void mgl_tiles_ (uintptr_t* graph, uintptr_t* z, uintptr_t* r, const(char)* sch, const(char)* opt, int, int);
void mgl_surfc_xy (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT c, const(char)* sch, const(char)* opt);
void mgl_surfc_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* c, const(char)* sch, const(char)* opt, int, int);
void mgl_surfc (HMGL graph, HCDT z, HCDT c, const(char)* sch, const(char)* opt);
void mgl_surfc_ (uintptr_t* graph, uintptr_t* z, uintptr_t* c, const(char)* sch, const(char)* opt, int, int);
void mgl_surfa_xy (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT c, const(char)* sch, const(char)* opt);
void mgl_surfa_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* c, const(char)* sch, const(char)* opt, int, int);
void mgl_surfa (HMGL graph, HCDT z, HCDT c, const(char)* sch, const(char)* opt);
void mgl_surfa_ (uintptr_t* graph, uintptr_t* z, uintptr_t* c, const(char)* sch, const(char)* opt, int, int);
void mgl_stfa_xy (HMGL graph, HCDT x, HCDT y, HCDT re, HCDT im, int dn, const(char)* sch, const(char)* opt);
void mgl_stfa_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* re, uintptr_t* im, int* dn, const(char)* sch, const(char)* opt, int, int);
void mgl_stfa (HMGL graph, HCDT re, HCDT im, int dn, const(char)* sch, const(char)* opt);
void mgl_stfa_ (uintptr_t* graph, uintptr_t* re, uintptr_t* im, int* dn, const(char)* sch, const(char)* opt, int, int);
void mgl_map_xy (HMGL graph, HCDT x, HCDT y, HCDT a, HCDT b, const(char)* sch, const(char)* opt);
void mgl_map_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* a, uintptr_t* b, const(char)* sch, const(char)* opt, int, int);
void mgl_map (HMGL graph, HCDT a, HCDT b, const(char)* sch, const(char)* opt);
void mgl_map_ (uintptr_t* graph, uintptr_t* a, uintptr_t* b, const(char)* sch, const(char)* opt, int, int);