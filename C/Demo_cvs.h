/*
 *  Demo_cvs.h
 *
 *  CVODES C prototype file for the functions defined in Demo_cvs.c
 *
 *  This file was generated by the program VFGEN (Version:2.4.1)
 *  Generated on 23-Apr-2019 at 11:13
 */

int Demo_vf(realtype, N_Vector, N_Vector, void *);
int Demo_jac(int, realtype,
                N_Vector, N_Vector,
                DlsMat, void *,
                N_Vector, N_Vector, N_Vector);
int Demo_jacp(int, realtype,
                N_Vector, N_Vector,
                DlsMat, void *,
                N_Vector, N_Vector, N_Vector);
int Demo_sens(int, realtype, N_Vector, N_Vector,
                int, N_Vector, N_Vector,
                void *, N_Vector, N_Vector);
int Demo_func(realtype, N_Vector, realtype *, void *);
int Demo_func_sens(realtype, N_Vector, N_Vector *, double *, void *);
