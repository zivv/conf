#include <Python.h>

PyObject* wrap_func(PyObject* self, PyObject* args) {
  Py_INCREF(Py_None);
  return Py_None;
}

static PyMethodDef methods[] = {
  {"func", wrap_func, METH_VARARGS, "describtion"},
  {NULL, NULL}
};

PyMODINIT_FUNC initmodule() {
  PyObject* m;
  m = Py_InitModule("module", methods);
}
