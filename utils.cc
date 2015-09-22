//*****************************************************************************
//  POSIX look-a-like functions for Visual Studio
//*****************************************************************************

#include "float.h"
#include "math.h"
#include "utils.h"

#ifndef round
double round( double d ){ return floor( d + 0.5 ); }
#endif

#ifndef trunc
double trunc(double d){ return (d>0) ? floor(d) : ceil(d) ; }
#endif

#ifndef isfinite
int isfinite(double x){ return _finite(x); }
#endif