#include "stdlib.h"

double* get_load() {
  double* loadavg;
  int load;
  loadavg = (double*)calloc(sizeof(double), 3);
  getloadavg(loadavg, 3);
  return loadavg;
}
