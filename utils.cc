//*****************************************************************************
//  POSIX look-a-like functions for Visual Studio
//*****************************************************************************

#include "float.h"
#include "math.h"
#include "utils.h"

#ifdef _MSC_VER
double round( double d ){ return floor( d + 0.5 ); }
double trunc(double d){ return (d>0) ? floor(d) : ceil(d) ; }
int isfinite(double x){ return _finite(x); }
#endif
