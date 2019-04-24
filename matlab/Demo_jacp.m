%
% Demo_jacp.m
%
% This MATLAB function computes the Jacobian with respect to the parameters
% of the vector field defined in Demo_vf.m.
%
% This file was generated by the program VFGEN (Version:2.4.1)
% Generated on 23-Apr-2019 at 11:13
%
%
function jacp_ = Demo_jacp(t,x_,p_)
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
    jacp_ = zeros(3,17);
    jacp_(1,1) = (AB-B_ConservedConst+ABC)*u*(AB+AC-A_ConservedConst+ABC);
    jacp_(1,2) = -AB;
    jacp_(1,5) = AB*(AC+ABC-C_ConservedConst);
    jacp_(1,6) = ABC;
    jacp_(1,13) = (AB-B_ConservedConst+ABC)*kf_R0*(AB+AC-A_ConservedConst+ABC);
    jacp_(1,15) = -AB*kf_R2;
    jacp_(1,16) = -u*kf_R0*(AB+AC-A_ConservedConst+ABC);
    jacp_(1,17) = -(AB-B_ConservedConst+ABC)*u*kf_R0;
    jacp_(2,3) = (AB+AC-A_ConservedConst+ABC)*(AC+ABC-C_ConservedConst);
    jacp_(2,4) = -AC;
    jacp_(2,7) = (AB-B_ConservedConst+ABC)*AC;
    jacp_(2,8) = ABC;
    jacp_(2,15) = -kf_R1*(AB+AC-A_ConservedConst+ABC);
    jacp_(2,16) = -kf_R3*AC;
    jacp_(2,17) = -kf_R1*(AC+ABC-C_ConservedConst);
    jacp_(3,5) = -AB*(AC+ABC-C_ConservedConst);
    jacp_(3,6) = -ABC;
    jacp_(3,7) = -(AB-B_ConservedConst+ABC)*AC;
    jacp_(3,8) = -ABC;
    jacp_(3,15) = AB*kf_R2;
    jacp_(3,16) = kf_R3*AC;
