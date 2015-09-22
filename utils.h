//*****************************************************************************
//  POSIX look-a-like functions for Visual Studio
//*****************************************************************************

#ifndef S_ISDIR
#define S_ISDIR(mode)  (((mode) & S_IFMT) == S_IFDIR)
#endif

#ifndef round
double round( double d );
#endif

#ifndef trunc
double trunc(double d);
#endif

#ifndef isfinite
int isfinite(double x);
#endif