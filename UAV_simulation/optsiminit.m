% BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
% FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
% OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
% PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
% OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
% TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
% PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
% REPAIR OR CORRECTION.
% 
%   12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
% WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
% REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
% INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
% OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
% TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
% YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
% PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGES.
% SIMINIT Initialization of global variables

%clear all;
clc;

global des_x1;
global des_y1;
global des_x2;
global des_y2;
global des_x3;
global des_y3;
global des_x4;
global des_y4;
global des_x5;
global des_y5;
global des_x6;
global des_y6;

global for_v1;
global for_v2 ;
global for_v3;
global for_v4 ;
global for_v5;
global for_v6;

load matlab1 des_x1 des_y1 des_x2 des_y2 des_x3 des_y3 des_x4 des_y4 des_x5 des_y5 des_x6 des_y6 for_v1 for_v2 for_v3 for_v4 for_v5 for_v6 ;  


global x1_11;    % old integrator value
global x2_11;    % old integrator value
global x3_11;    % old integrator value

global x1_12;    % old integrator value
global x2_12;    % old integrator value
global x3_12;    % old integrator value

global x1_13;    % old integrator value
global x2_13;    % old integrator value
global x3_13;    % old integrator value

global x1_14;    % old integrator value
global x2_14;    % old integrator value
global x3_14;    % old integrator value

global x1_15;    % old integrator value
global x2_15;    % old integrator value
global x3_15;    % old integrator value

global x1_16;    % old integrator value
global x2_16;    % old integrator value
global x3_16;    % old integrator value

global Om_old1; % old residual speed
global Om_old2;
global Om_old3;
global Om_old4;
global Om_old5;
global Om_old6;

global fIdx1; % index for filtering
global fIdx2; % index for filtering
global fIdx3; % index for filtering
global fIdx4; % index for filtering
global fIdx5; % index for filtering
global fIdx6; % index for filtering

global rolli_11; % contains old values of the variables to be filtered in sam5_filter.m
global rolli_21;
global frolli1;
global frolli_11;
global frolli_21;

global rolli_12; % contains old values of the variables to be filtered in sam5_filter.m
global rolli_22;
global frolli2;
global frolli_12;
global frolli_22;

global rolli_13; % contains old values of the variables to be filtered in sam5_filter.m
global rolli_23;
global frolli3;
global frolli_13;
global frolli_23;

global rolli_14; % contains old values of the variables to be filtered in sam5_filter.m
global rolli_24;
global frolli4;
global frolli_14;
global frolli_24;

global rolli_15; % contains old values of the variables to be filtered in sam5_filter.m
global rolli_25;
global frolli5;
global frolli_15;
global frolli_25;

global rolli_16; % contains old values of the variables to be filtered in sam5_filter.m
global rolli_26;
global frolli6;
global frolli_16;
global frolli_26;

global dotrolli_11;
global dotrolli_21;
global fdotrolli1;
global fdotrolli_11;
global fdotrolli_21;

global dotrolli_16;
global dotrolli_26;
global fdotrolli6;
global fdotrolli_16;
global fdotrolli_26;

global dotrolli_12;
global dotrolli_22;
global fdotrolli2;
global fdotrolli_12;
global fdotrolli_22;

global dotrolli_13;
global dotrolli_23;
global fdotrolli3;
global fdotrolli_13;
global fdotrolli_23;

global dotrolli_14;
global dotrolli_24;
global fdotrolli4;
global fdotrolli_14;
global fdotrolli_24;

global dotrolli_15;
global dotrolli_25;
global fdotrolli5;
global fdotrolli_15;
global fdotrolli_25;

global pitchi_11;
global pitchi_21;
global fpitchi1;
global fpitchi_11;
global fpitchi_21;

global pitchi_12;
global pitchi_22;
global fpitchi2;
global fpitchi_12;
global fpitchi_22;

global pitchi_13;
global pitchi_23;
global fpitchi3;
global fpitchi_13;
global fpitchi_23;

global pitchi_14;
global pitchi_24;
global fpitchi4;
global fpitchi_14;
global fpitchi_24;

global pitchi_15;
global pitchi_25;
global fpitchi5;
global fpitchi_15;
global fpitchi_25;

global pitchi_16;
global pitchi_26;
global fpitchi6;
global fpitchi_16;
global fpitchi_26;

global dotpitchi_11;
global dotpitchi_21;
global fdotpitchi1;
global fdotpitchi_11;
global fdotpitchi_21;

global dotpitchi_12;
global dotpitchi_22;
global fdotpitchi2;
global fdotpitchi_12;
global fdotpitchi_22;

global dotpitchi_13;
global dotpitchi_23;
global fdotpitchi3;
global fdotpitchi_13;
global fdotpitchi_23;

global dotpitchi_14;
global dotpitchi_24;
global fdotpitchi4;
global fdotpitchi_14;
global fdotpitchi_24;

global dotpitchi_15;
global dotpitchi_25;
global fdotpitchi5;
global fdotpitchi_15;
global fdotpitchi_25;

global dotpitchi_16;
global dotpitchi_26;
global fdotpitchi6;
global fdotpitchi_16;
global fdotpitchi_26;

global yawi_11;
global yawi_21;
global fyawi1;
global fyawi_11;
global fyawi_21;

global yawi_12;
global yawi_22;
global fyawi2;
global fyawi_12;
global fyawi_22;

global yawi_13;
global yawi_23;
global fyawi3;
global fyawi_13;
global fyawi_23;

global yawi_14;
global yawi_24;
global fyawi4;
global fyawi_14;
global fyawi_24;

global yawi_15;
global yawi_25;
global fyawi5;
global fyawi_15;
global fyawi_25;

global yawi_16;
global yawi_26;
global fyawi6;
global fyawi_16;
global fyawi_26;

global dotyawi_11;
global dotyawi_21;
global fdotyawi1;
global fdotyawi_11;
global fdotyawi_21;

global dotyawi_12;
global dotyawi_22;
global fdotyawi2;
global fdotyawi_12;
global fdotyawi_22;

global dotyawi_13;
global dotyawi_23;
global fdotyawi3;
global fdotyawi_13;
global fdotyawi_23;

global dotyawi_14;
global dotyawi_24;
global fdotyawi4;
global fdotyawi_14;
global fdotyawi_24;

global dotyawi_15;
global dotyawi_25;
global fdotyawi5;
global fdotyawi_15;
global fdotyawi_25;

global dotyawi_16;
global dotyawi_26;
global fdotyawi6;
global fdotyawi_16;
global fdotyawi_26;

global zi_11;
global zi_21;
global fzi1;
global fzi_11;
global fzi_21;

global zi_12;
global zi_22;
global fzi2;
global fzi_12;
global fzi_22;

global zi_13;
global zi_23;
global fzi3;
global fzi_13;
global fzi_23;

global zi_14;
global zi_24;
global fzi4;
global fzi_14;
global fzi_24;

global zi_15;
global zi_25;
global fzi5;
global fzi_15;
global fzi_25;

global zi_16;
global zi_26;
global fzi6;
global fzi_16;
global fzi_26;
% global dotzi_1;
% global dotzi_2;
% global fdotzi;
% global fdotzi_1;
% global fdotzi_2;

% INITIALIZATIONS


x1_11=0;
x2_11=0;
x3_11=0;

x1_12=0;
x2_12=0;
x3_12=0;

x1_13=0;
x2_13=0;
x3_13=0;

x1_14=0;
x2_14=0;
x3_14=0;

x1_15=0;
x2_15=0;
x3_15=0;

x1_16=0;
x2_16=0;
x3_16=0;

Om_old1=0;
Om_old2=0;
Om_old3=0;
Om_old4=0;
Om_old5=0;
Om_old6=0;

fIdx1=0; % index for filtering
fIdx2=0; % index for filtering
fIdx3=0; % index for filtering
fIdx4=0; % index for filtering
fIdx5=0; % index for filtering
fIdx6=0; % index for filtering

rolli_11=0;
rolli_21=0;
frolli1=0;
frolli_11=0;
frolli_21=0;

rolli_12=0;
rolli_22=0;
frolli2=0;
frolli_12=0;
frolli_22=0;

rolli_13=0;
rolli_23=0;
frolli3=0;
frolli_13=0;
frolli_23=0;

rolli_14=0;
rolli_24=0;
frolli4=0;
frolli_14=0;
frolli_24=0;

rolli_15=0;
rolli_25=0;
frolli5=0;
frolli_15=0;
frolli_25=0;

rolli_16=0;
rolli_26=0;
frolli6=0;
frolli_16=0;
frolli_26=0;

dotrolli_11=0;
dotrolli_21=0;
fdotrolli1=0;
fdotrolli_11=0;
fdotrolli_21=0;

dotrolli_12=0;
dotrolli_22=0;
fdotrolli2=0;
fdotrolli_12=0;
fdotrolli_22=0;

dotrolli_13=0;
dotrolli_23=0;
fdotrolli3=0;
fdotrolli_13=0;
fdotrolli_23=0;

dotrolli_14=0;
dotrolli_24=0;
fdotrolli4=0;
fdotrolli_14=0;
fdotrolli_24=0;

dotrolli_15=0;
dotrolli_25=0;
fdotrolli5=0;
fdotrolli_15=0;
fdotrolli_25=0;

dotrolli_16=0;
dotrolli_26=0;
fdotrolli6=0;
fdotrolli_16=0;
fdotrolli_26=0;

pitchi_11=0;
pitchi_21=0;
fpitchi1=0;
fpitchi_11=0;
fpitchi_21=0;

pitchi_12=0;
pitchi_22=0;
fpitchi2=0;
fpitchi_12=0;
fpitchi_22=0;

pitchi_13=0;
pitchi_23=0;
fpitchi3=0;
fpitchi_13=0;
fpitchi_23=0;

pitchi_14=0;
pitchi_24=0;
fpitchi4=0;
fpitchi_14=0;
fpitchi_24=0;

pitchi_15=0;
pitchi_25=0;
fpitchi5=0;
fpitchi_15=0;
fpitchi_25=0;

pitchi_16=0;
pitchi_26=0;
fpitchi6=0;
fpitchi_16=0;
fpitchi_26=0;

dotpitchi_11=0;
dotpitchi_21=0;
fdotpitchi1=0;
fdotpitchi_11=0;
fdotpitchi_21=0;

dotpitchi_12=0;
dotpitchi_22=0;
fdotpitchi2=0;
fdotpitchi_12=0;
fdotpitchi_22=0;

dotpitchi_13=0;
dotpitchi_23=0;
fdotpitchi3=0;
fdotpitchi_13=0;
fdotpitchi_23=0;

dotpitchi_14=0;
dotpitchi_24=0;
fdotpitchi4=0;
fdotpitchi_14=0;
fdotpitchi_24=0;

dotpitchi_15=0;
dotpitchi_25=0;
fdotpitchi5=0;
fdotpitchi_15=0;
fdotpitchi_25=0;

dotpitchi_16=0;
dotpitchi_26=0;
fdotpitchi6=0;
fdotpitchi_16=0;
fdotpitchi_26=0;

yawi_11=0;
yawi_21=0;
fyawi1=0;
fyawi_11=0;
fyawi_21=0;

yawi_12=0;
yawi_22=0;
fyawi2=0;
fyawi_12=0;
fyawi_22=0;

yawi_13=0;
yawi_23=0;
fyawi3=0;
fyawi_13=0;
fyawi_23=0;

yawi_14=0;
yawi_24=0;
fyawi4=0;
fyawi_14=0;
fyawi_24=0;

yawi_15=0;
yawi_25=0;
fyawi5=0;
fyawi_15=0;
fyawi_25=0;

yawi_16=0;
yawi_26=0;
fyawi6=0;
fyawi_16=0;
fyawi_26=0;

dotyawi_11=0;
dotyawi_21=0;
fdotyawi1=0;
fdotyawi_11=0;
fdotyawi_21=0;

dotyawi_12=0;
dotyawi_22=0;
fdotyawi2=0;
fdotyawi_12=0;
fdotyawi_22=0;

dotyawi_13=0;
dotyawi_23=0;
fdotyawi3=0;
fdotyawi_13=0;
fdotyawi_23=0;

dotyawi_14=0;
dotyawi_24=0;
fdotyawi4=0;
fdotyawi_14=0;
fdotyawi_24=0;

dotyawi_15=0;
dotyawi_25=0;
fdotyawi5=0;
fdotyawi_15=0;
fdotyawi_25=0;

dotyawi_16=0;
dotyawi_26=0;
fdotyawi6=0;
fdotyawi_16=0;
fdotyawi_26=0;

zi_11=0;
zi_21=0;
fzi1=0;
fzi_11=0;
fzi_21=0;

zi_12=0;
zi_22=0;
fzi2=0;
fzi_12=0;
fzi_22=0;

zi_13=0;
zi_23=0;
fzi3=0;
fzi_13=0;
fzi_23=0;

zi_14=0;
zi_24=0;
fzi4=0;
fzi_14=0;
fzi_24=0;

zi_15=0;
zi_25=0;
fzi5=0;
fzi_15=0;
fzi_25=0;

zi_16=0;
zi_26=0;
fzi6=0;
fzi_16=0;
fzi_26=0;
% dotzi_1=0;
% dotzi_2=0;
% fdotzi=0;
% fdotzi_1=0;
% fdotzi_2=0;


disp('Done initializing')