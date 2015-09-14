#include <cstdio>
#include <string>
#include <sstream>
#include "../include/bmi.h"

#include "globals.h"
#include "dune_evolution.h"

double current = 0;
int arr1[2][3] =
  {
    { 3, 2, 1},
    { 6, 4, 2}
  };

/* Store callback */
Logger logger = NULL;

/* Logger function */
void _log(Level level, std::string msg);

/*! Class handling parameter file.  */
dunepar m_para;

/*!  New top-level simulation object  */
evolution *m_evol;

extern "C" {
  BMI_API int initialize(const char *config_file)
  {
    std::ostringstream msg;
    int argc = 2;
    char *argv[] = { "./Dune", (char*)config_file, NULL };

    // parse parameters file
    m_para.scan(argc, argv);
                
    // initialise global parameter object
    duneglobals::initialise(m_para);

    // initialise simulation object
    m_evol = new dune_evol_3d(m_para);

    return 0;
  }

  BMI_API int update(double dt)
  {
    m_evol->step();
    current += 1;
    return 0;
  }

  BMI_API int finalize()
  {
    return 0;
  }

  BMI_API void get_start_time(double *t)
  {
    int Nt0 = m_para.getrequired<int>("Nt0");
    double dt_max = m_para.getdefault("dt_max", 0.0);
    
    *t = Nt0 * dt_max;
  }

  BMI_API void get_end_time(double *t)
  {
    int Nt = m_para.getrequired<int>("Nt");
    double dt_max = m_para.getdefault("dt_max", 0.0);
    
    *t =  Nt * dt_max
;
  }

  BMI_API void get_current_time(double *t)
  {
    double dt_max = m_para.getdefault("dt_max", 0.0);
    
    *t = current * dt_max;
  }

  BMI_API void get_var(const char *name, void **ptr)
  {
    *ptr = &arr1;
  }

  BMI_API void set_logger(Logger callback)
  {
    Level level = INFO;
    std::string msg = "Logging attached to cxx model";
    logger = callback;
    logger(level, msg.c_str());
  }
}

void _log(Level level, std::string msg) {
  if (logger != NULL) {
    logger(level, msg.c_str());
  }
}

// placeholder function, all dll's need a main.. in windows only
#if defined _WIN32
void main()
{
}
#endif
