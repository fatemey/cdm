#include <stdio.h>
#include <string.h>
#include <cstring>
#include "../include/bmi.h"

#include "globals.h"
#include "dune_evolution.h"

double dtmax = 0;
int nt0 = 0;
int nt = 0;
int nx = 0;
int ny = 0;
double *arr;

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
    char *argv [] = { const_cast<char*>("./Dune"),
                      const_cast<char*>(config_file), NULL };

    // parse parameters file
    m_para.scan(argc, argv);
                
    // initialise global parameter object
    duneglobals::initialise(m_para);

    // initialise simulation object
    m_evol = new dune_evol_3d(m_para);

    // store dimensions
    nt0 = m_para.getrequired<int>("Nt0");
    nt = m_para.getrequired<int>("Nt");
    nx = m_para.getrequired<int>("NX");
    ny = m_para.getrequired<int>("NY");
    dtmax = m_para.getdefault("dt_max", 1.0);

    // allocate data array
    arr = new double[nx*ny];

    return 0;
  }

  BMI_API int update(double dt)
  {
    if (dt < -1)
      m_evol->jump(dt);
    if (dt == -1)
      m_evol->step();
    else
      m_evol->step(dt);
    return 0;
  }

  BMI_API int finalize()
  {
    return 0;
  }

  BMI_API void get_start_time(double *t)
  {
    *t = nt0 * dtmax;
  }

  BMI_API void get_end_time(double *t)
  {
    *t =  nt * dtmax;
  }

  BMI_API void get_current_time(double *t)
  {
    *t = m_evol->time();
  }

  BMI_API void get_var_shape(const char *name, int shape[MAXDIMS])
  {
    shape[0] = nx;
    shape[1] = ny;
  }

  BMI_API void get_var_rank(const char *name, int *rank)
  {
    *rank = 2;
  }
  
  BMI_API void get_var_type(const char *name, char *type)
  {
    strncpy(type, "double", MAXSTRINGLEN);
  }

  BMI_API void get_var(const char *name, void **ptr)
  {
    // get var data
    m_evol->get_array(name, arr);

    // create reference
    *ptr = &*arr;
  }
  
  BMI_API void set_var(const char *name, const void *ptr)
  {
    int i;

    // copy pointer
    //memcpy(arr, ptr, sizeof(arr)); // why doesn't this work?!
    for (i=0; i<nx*ny; i++) {
      arr[i] = ((double*)ptr)[i];
    }

    // set var data
    m_evol->set_array(name, arr);
  }

  BMI_API void inq_compound(const char *name)
  {
    // pass
  }

  BMI_API void inq_compound_field(const char *name, int *field)
  {
    // pass
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
