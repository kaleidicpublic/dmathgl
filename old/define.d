import core.stdc.config;

extern (C):

alias double mreal;
alias <unimplemented> mdual;
alias <unimplemented> ddual;

extern __gshared ulong[16] mgl_mask_val;

enum _Anonymous_0
{
	mglCartesian = 0,
	mglPolar = 1,
	mglSpherical = 2,
	mglParabolic = 3,
	mglParaboloidal = 4,
	mglOblate = 5,
	mglProlate = 6,
	mglElliptic = 7,
	mglToroidal = 8,
	mglBispherical = 9,
	mglBipolar = 10,
	mglLogLog = 11,
	mglLogX = 12,
	mglLogY = 13
}

enum _Anonymous_1
{
	mglWarnNone = 0,
	mglWarnDim = 1,
	mglWarnLow = 2,
	mglWarnNeg = 3,
	mglWarnFile = 4,
	mglWarnMem = 5,
	mglWarnZero = 6,
	mglWarnLeg = 7,
	mglWarnSlc = 8,
	mglWarnCnt = 9,
	mglWarnOpen = 10,
	mglWarnLId = 11,
	mglWarnSize = 12,
	mglWarnFmt = 13,
	mglWarnTern = 14,
	mglWarnNull = 15,
	mglWarnSpc = 16,
	mglScrArg = 17,
	mglScrCmd = 18,
	mglScrLong = 19,
	mglScrStr = 20,
	mglWarnEnd = 21
}

double mgl_hypot (double x, double y);
size_t mgl_wcslen (const(dchar)* str);
void mgl_chrrgb (char id, float[3] rgb);
c_long mgl_have_color (const(char)* stl);
const(char)* mglchr (const(char)* str, char ch);
const(char)* mglchrs (const(char)* str, const(char)* chr);
void mgl_set_num_thr (int n);
void mgl_set_num_thr_ (int* n);
void mgl_test_txt (const(char)* str, ...);
void mgl_set_test_mode (int enable);
void mgl_strtrim (char* str);
void mgl_wcstrim (dchar* str);
void mgl_strlwr (char* str);
void mgl_wcslwr (dchar* str);
void mgl_wcstombs (char* dst, const(dchar)* src, int size);
void mgl_clear_fft (...);
void mgl_set_global_warn (const(char)* text);
void mgl_set_global_warn_ (const(char)* text, int);
const(char)* mgl_get_global_warn (...);
int mgl_get_global_warn_ (char* out_, int len);