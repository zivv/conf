#include <Python.h>

PyObject* wrap_Func(PyObject* self, PyObject* args) {
  Py_INCREF(Py_None);
  return Py_None;
}

static PyMethodDef methods[] = {
  {"func", wrap_Func, METH_VARARGS, "describtion"},
  {NULL, NULL}
};

PyMODINIT_FUNC initmodule() {
  Py_InitModule("module", methods);
}
