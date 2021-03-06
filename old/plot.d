import core.stdc.stdint;

extern (C):

void mgl_fplot (HMGL gr, const(char)* eqY, const(char)* pen, const(char)* opt);
void mgl_fplot_ (uintptr_t* gr, const(char)* fy, const(char)* stl, const(char)* opt, int ly, int ls, int lo);
void mgl_fplot_xyz (HMGL gr, const(char)* eqX, const(char)* eqY, const(char)* eqZ, const(char)* pen, const(char)* opt);
void mgl_fplot_xyz_ (uintptr_t* gr, const(char)* fx, const(char)* fy, const(char)* fz, const(char)* stl, const(char)* opt, int lx, int ly, int lz, int ls, int lo);
void mgl_radar (HMGL graph, HCDT a, const(char)* pen, const(char)* opt);
void mgl_radar_ (uintptr_t* gr, uintptr_t* a, const(char)* pen, const(char)* opt, int l, int lo);
void mgl_plot_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* pen, const(char)* opt);
void mgl_plot_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* pen, const(char)* opt, int, int);
void mgl_plot_xy (HMGL graph, HCDT x, HCDT y, const(char)* pen, const(char)* opt);
void mgl_plot_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_plot (HMGL graph, HCDT y, const(char)* pen, const(char)* opt);
void mgl_plot_ (uintptr_t* graph, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_tens_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT c, const(char)* pen, const(char)* opt);
void mgl_tens_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* c, const(char)* pen, const(char)* opt, int, int);
void mgl_tens_xy (HMGL graph, HCDT x, HCDT y, HCDT c, const(char)* pen, const(char)* opt);
void mgl_tens_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* c, const(char)* pen, const(char)* opt, int, int);
void mgl_tens (HMGL graph, HCDT y, HCDT c, const(char)* pen, const(char)* opt);
void mgl_tens_ (uintptr_t* graph, uintptr_t* y, uintptr_t* c, const(char)* pen, const(char)* opt, int, int);
void mgl_tape_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* pen, const(char)* opt);
void mgl_tape_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* pen, const(char)* opt, int, int);
void mgl_tape_xy (HMGL graph, HCDT x, HCDT y, const(char)* pen, const(char)* opt);
void mgl_tape_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_tape (HMGL graph, HCDT y, const(char)* pen, const(char)* opt);
void mgl_tape_ (uintptr_t* graph, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_boxplot_xy (HMGL graph, HCDT x, HCDT a, const(char)* pen, const(char)* opt);
void mgl_boxplot_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_boxplot (HMGL graph, HCDT a, const(char)* pen, const(char)* opt);
void mgl_boxplot_ (uintptr_t* graph, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_area_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* pen, const(char)* opt);
void mgl_area_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* pen, const(char)* opt, int, int);
void mgl_area_xy (HMGL graph, HCDT x, HCDT y, const(char)* pen, const(char)* opt);
void mgl_area_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_area (HMGL graph, HCDT y, const(char)* pen, const(char)* opt);
void mgl_area_ (uintptr_t* graph, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_region_3d (HMGL graph, HCDT x1, HCDT y1, HCDT z1, HCDT x2, HCDT y2, HCDT z2, const(char)* pen, const(char)* opt);
void mgl_region_3d_ (uintptr_t* graph, uintptr_t* x1, uintptr_t* y1, uintptr_t* z1, uintptr_t* x2, uintptr_t* y2, uintptr_t* z2, const(char)* pen, const(char)* opt, int, int);
void mgl_region_xy (HMGL graph, HCDT x, HCDT y1, HCDT y2, const(char)* pen, const(char)* opt);
void mgl_region_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y1, uintptr_t* y2, const(char)* pen, const(char)* opt, int, int);
void mgl_region (HMGL graph, HCDT y1, HCDT y2, const(char)* pen, const(char)* opt);
void mgl_region_ (uintptr_t* graph, uintptr_t* y1, uintptr_t* y2, const(char)* pen, const(char)* opt, int, int);
void mgl_stem_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* pen, const(char)* opt);
void mgl_stem_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* pen, const(char)* opt, int, int);
void mgl_stem_xy (HMGL graph, HCDT x, HCDT y, const(char)* pen, const(char)* opt);
void mgl_stem_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_stem (HMGL graph, HCDT y, const(char)* pen, const(char)* opt);
void mgl_stem_ (uintptr_t* graph, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_step_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* pen, const(char)* opt);
void mgl_step_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* pen, const(char)* opt, int, int);
void mgl_step_xy (HMGL graph, HCDT x, HCDT y, const(char)* pen, const(char)* opt);
void mgl_step_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_step (HMGL graph, HCDT y, const(char)* pen, const(char)* opt);
void mgl_step_ (uintptr_t* graph, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_bars_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, const(char)* pen, const(char)* opt);
void mgl_bars_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, const(char)* pen, const(char)* opt, int, int);
void mgl_bars_xy (HMGL graph, HCDT x, HCDT y, const(char)* pen, const(char)* opt);
void mgl_bars_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_bars (HMGL graph, HCDT y, const(char)* pen, const(char)* opt);
void mgl_bars_ (uintptr_t* graph, uintptr_t* y, const(char)* pen, const(char)* opt, int, int);
void mgl_barh_yx (HMGL graph, HCDT y, HCDT v, const(char)* pen, const(char)* opt);
void mgl_barh_yx_ (uintptr_t* graph, uintptr_t* y, uintptr_t* v, const(char)* pen, const(char)* opt, int, int);
void mgl_barh (HMGL graph, HCDT v, const(char)* pen, const(char)* opt);
void mgl_barh_ (uintptr_t* graph, uintptr_t* v, const(char)* pen, const(char)* opt, int, int);
void mgl_ohlc_x (HMGL graph, HCDT x, HCDT open, HCDT high, HCDT low, HCDT close, const(char)* pen, const(char)* opt);
void mgl_ohlc_x_ (uintptr_t* graph, uintptr_t* x, uintptr_t* open, uintptr_t* high, uintptr_t* low, uintptr_t* close, const(char)* pen, const(char)* opt, int, int);
void mgl_ohlc (HMGL graph, HCDT open, HCDT high, HCDT low, HCDT close, const(char)* pen, const(char)* opt);
void mgl_ohlc_ (uintptr_t* graph, uintptr_t* open, uintptr_t* high, uintptr_t* low, uintptr_t* close, const(char)* pen, const(char)* opt, int, int);
void mgl_chart (HMGL graph, HCDT a, const(char)* col, const(char)* opt);
void mgl_chart_ (uintptr_t* graph, uintptr_t* a, const(char)* col, const(char)* opt, int, int);
void mgl_error_exy (HMGL graph, HCDT x, HCDT y, HCDT ex, HCDT ey, const(char)* pen, const(char)* opt);
void mgl_error_exy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* ex, uintptr_t* ey, const(char)* pen, const(char)* opt, int, int);
void mgl_error_xy (HMGL graph, HCDT x, HCDT y, HCDT ey, const(char)* pen, const(char)* opt);
void mgl_error_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* ey, const(char)* pen, const(char)* opt, int, int);
void mgl_error (HMGL graph, HCDT y, HCDT ey, const(char)* pen, const(char)* opt);
void mgl_error_ (uintptr_t* graph, uintptr_t* y, uintptr_t* ey, const(char)* pen, const(char)* opt, int, int);
void mgl_mark_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT r, const(char)* pen, const(char)* opt);
void mgl_mark_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* r, const(char)* pen, const(char)* opt, int, int);
void mgl_mark_xy (HMGL graph, HCDT x, HCDT y, HCDT r, const(char)* pen, const(char)* opt);
void mgl_mark_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* r, const(char)* pen, const(char)* opt, int, int);
void mgl_mark_y (HMGL graph, HCDT y, HCDT r, const(char)* pen, const(char)* opt);
void mgl_mark_y_ (uintptr_t* graph, uintptr_t* y, uintptr_t* r, const(char)* pen, const(char)* opt, int, int);
void mgl_tube_xyzr (HMGL graph, HCDT x, HCDT y, HCDT z, HCDT r, const(char)* pen, const(char)* opt);
void mgl_tube_xyzr_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, uintptr_t* r, const(char)* pen, const(char)* opt, int, int);
void mgl_tube_xyr (HMGL graph, HCDT x, HCDT y, HCDT r, const(char)* pen, const(char)* opt);
void mgl_tube_xyr_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* r, const(char)* pen, const(char)* opt, int, int);
void mgl_tube_r (HMGL graph, HCDT y, HCDT r, const(char)* pen, const(char)* opt);
void mgl_tube_r_ (uintptr_t* graph, uintptr_t* y, uintptr_t* r, const(char)* pen, const(char)* opt, int, int);
void mgl_tube_xyz (HMGL graph, HCDT x, HCDT y, HCDT z, double r, const(char)* pen, const(char)* opt);
void mgl_tube_xyz_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, uintptr_t* z, mreal* r, const(char)* pen, const(char)* opt, int, int);
void mgl_tube_xy (HMGL graph, HCDT x, HCDT y, double r, const(char)* penl, const(char)* opt);
void mgl_tube_xy_ (uintptr_t* graph, uintptr_t* x, uintptr_t* y, mreal* r, const(char)* pen, const(char)* opt, int, int);
void mgl_tube (HMGL graph, HCDT y, double r, const(char)* pen, const(char)* opt);
void mgl_tube_ (uintptr_t* graph, uintptr_t* y, mreal* r, const(char)* pen, const(char)* opt, int, int);
void mgl_candle_xyv (HMGL gr, HCDT x, HCDT v1, HCDT v2, HCDT y1, HCDT y2, const(char)* pen, const(char)* opt);
void mgl_candle_xyv_ (uintptr_t* gr, uintptr_t* x, uintptr_t* v1, uintptr_t* v2, uintptr_t* y1, uintptr_t* y2, const(char)* pen, const(char)* opt, int, int);
void mgl_candle_yv (HMGL gr, HCDT v1, HCDT v2, HCDT y1, HCDT y2, const(char)* pen, const(char)* opt);
void mgl_candle_yv_ (uintptr_t* gr, uintptr_t* v1, uintptr_t* v2, uintptr_t* y1, uintptr_t* y2, const(char)* pen, const(char)* opt, int, int);
void mgl_candle (HMGL gr, HCDT v, HCDT y1, HCDT y2, const(char)* pen, const(char)* opt);
void mgl_candle_ (uintptr_t* gr, uintptr_t* y, uintptr_t* y1, uintptr_t* y2, const(char)* pen, const(char)* opt, int, int);