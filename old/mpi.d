import core.stdc.stdint;

extern (C):

void mgl_mpi_send (HMGL gr, int id);
void mgl_mpi_send_ (uintptr_t* gr, int* id);
void mgl_mpi_recv (HMGL gr, int id);
void mgl_mpi_recv_ (uintptr_t* gr, int* id);