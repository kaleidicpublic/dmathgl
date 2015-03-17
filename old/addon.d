import core.stdc.stdio;
import core.stdc.config;

extern (C):

double mgl_gauss_rnd (...);
void mgl_fft_freq (double* freq, c_long nn);
void mgl_strcls (char* str);
c_long mgl_strpos (const(char)* str, char* fnd);
c_long mgl_chrpos (const(char)* str, char fnd);
char* mgl_fgetstr (FILE* fp);
void mgl_fgetpar (FILE* fp, const(char)* str, ...);
int mgl_istrue (char ch);
void mgl_test (const(char)* str, ...);
void mgl_info (const(char)* str, ...);
FILE* mgl_next_data (const(char)* fname, int p);