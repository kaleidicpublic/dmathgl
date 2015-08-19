import core.stdc.stdint;

extern (C):

HMGL mgl_create_graph_qt (int function (HMGL, void*) draw, const(char)* title, void* par, void function (void*) load);
uintptr_t mgl_create_graph_qt_ (const(char)* title, int);
int mgl_qt_run (...);
int mgl_qt_run_ (...);