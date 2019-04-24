%
% Demo_jac.m
%
% This MATLAB function computes the Jacobian of the vector field
% defined in Demo_vf.m.
%
% This file was generated by the program VFGEN (Version:2.4.1)
% Generated on 23-Apr-2019 at 11:13
%
%
function jac_ = Demo_jac(t,x_,p_)
    S = 1.0E-6;
    inv_tau = 1000.0;
    AB         = x_(1);
    AC         = x_(2);
    ABC        = x_(3);
    kf_R0      = p_(1);
    kr_R0      = p_(2);
    kf_R1      = p_(3);
    kr_R1      = p_(4);
    kf_R2      = p_(5);
    kr_R2      = p_(6);
    kf_R3      = p_(7);
    kr_R3      = p_(8);
    kf_R4      = p_(9);
    kr_R4      = p_(10);
    kf_R5      = p_(11);
    kr_R5      = p_(12);
    u          = p_(13);
    t_on       = p_(14);
    C_ConservedConst = p_(15);
    B_ConservedConst = p_(16);
    A_ConservedConst = p_(17);
    jac_ = zeros(3,3);
    jac_(1,1) = u*kf_R0*(AB+AC-A_ConservedConst+ABC)+kf_R2*(AC+ABC-C_ConservedConst)+(AB-B_ConservedConst+ABC)*u*kf_R0-kr_R0;
    jac_(1,2) = AB*kf_R2+(AB-B_ConservedConst+ABC)*u*kf_R0;
    jac_(1,3) = AB*kf_R2+u*kf_R0*(AB+AC-A_ConservedConst+ABC)+(AB-B_ConservedConst+ABC)*u*kf_R0+kr_R2;
    jac_(2,1) = kf_R1*(AC+ABC-C_ConservedConst)+kf_R3*AC;
    jac_(2,2) = -kr_R1+kf_R1*(AB+AC-A_ConservedConst+ABC)+(AB-B_ConservedConst+ABC)*kf_R3+kf_R1*(AC+ABC-C_ConservedConst);
    jac_(2,3) = kf_R1*(AB+AC-A_ConservedConst+ABC)+kr_R3+kf_R1*(AC+ABC-C_ConservedConst)+kf_R3*AC;
    jac_(3,1) = -kf_R2*(AC+ABC-C_ConservedConst)-kf_R3*AC;
    jac_(3,2) = -AB*kf_R2-(AB-B_ConservedConst+ABC)*kf_R3;
    jac_(3,3) = -AB*kf_R2-kr_R3-kf_R3*AC-kr_R2;

