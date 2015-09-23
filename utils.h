//*****************************************************************************
//  POSIX look-a-like functions for Visual Studio
//*****************************************************************************

#ifdef _MSC_VER
#define S_ISDIR(mode)  (((mode) & S_IFMT) == S_IFDIR)
double round( double d );
double trunc(double d);
int isfinite(double x);
#endif
