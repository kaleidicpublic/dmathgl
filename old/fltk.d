import core.stdc.stdint;

extern (C):

HMGL mgl_create_graph_fltk (int function (HMGL, void*) draw, const(char)* title, void* par, void function (void*) load);
uintptr_t mgl_create_graph_fltk_ (const(char)* title, int);
int mgl_fltk_run (...);
int mgl_fltk_run_ (...);
int mgl_fltk_thr (...);