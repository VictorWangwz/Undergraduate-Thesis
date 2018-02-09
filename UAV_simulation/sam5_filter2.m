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

% Noise filtering function
% INPUT: state
% OUTPUT: filtered states

function out=sam5_filter2(in)

% global file for parameters
glob;

% ********* Operational Conditions *********
roll=in(1);     % [rad]
dotroll=in(2);  % [rad/s]
pitch=in(3);
dotpitch=in(4);
yaw=in(5);
dotyaw=in(6);
z=in(7);        % [m]
dotz=in(8);     % [m/s]
x=in(9);
dotx=in(10);
y=in(11);
doty=in(12);


global fIdx2; % index for filtering

global rolli_12;
global rolli_22;
global frolli2;
global frolli_12;
global frolli_22;

global dotrolli_12;
global dotrolli_22;
global fdotrolli2;
global fdotrolli_12;
global fdotrolli_22;

global pitchi_12;
global pitchi_22;
global fpitchi2;
global fpitchi_12;
global fpitchi_22;

global dotpitchi_12;
global dotpitchi_22;
global fdotpitchi2;
global fdotpitchi_12;
global fdotpitchi_22;

global yawi_12;
global yawi_22;
global fyawi2;
global fyawi_12;
global fyawi_22;

global dotyawi_12;
global dotyawi_22;
global fdotyawi2;
global fdotyawi_12;
global fdotyawi_22;

global zi_12;
global zi_22;
global fzi2;
global fzi_12;
global fzi_22;


rff=0;  % rotations filter flag (1=filter rotations, 0=do not filter)
rrff=0; % rotations rates ...
aff=0;  % altitude ...

% ********* ROTATIONS FILTER *********
if (rff==1)
    if (fIdx2 >= 5)
             
        rolli=roll;
%        frolli=((1/3)*(rolli+rolli_1+rolli_2)+frolli_1+frolli_2)/3;     % SAM5 filter (running average + lp filter)
%        frolli=((1/2)*(rolli+rolli_1)+frolli_1+frolli_2)/3;     % SAM5 filter (running average + lp filter)
        frolli=((1/2)*(rolli+rolli_12)+frolli_12)/2;     % SAM5 filter (running average + lp filter)
        
        pitchi=pitch;    
%        fpitchi=((1/3)*(pitchi+pitchi_1+pitchi_2)+fpitchi_1+fpitchi_2)/3;     % SAM5 filter (running average + lp filter)
%        fpitchi=((1/2)*(pitchi+pitchi_1)+fpitchi_1+fpitchi_2)/3;     % SAM5 filter (running average + lp filter)
        fpitchi=((1/2)*(pitchi+pitchi_12)+fpitchi_12)/2;     % SAM5 filter (running average + lp filter)
        
        
        yawi=yaw;    
%        fyawi=((1/3)*(yawi+yawi_1+yawi_2)+fyawi_1+fyawi_2)/3;     % SAM5 filter (running average + lp filter)
%        fyawi=((1/2)*(yawi+yawi_1)+fyawi_1+fyawi_2)/3;     % SAM5 filter (running average + lp filter)
        fyawi=((1/2)*(yawi+yawi_12)+fyawi_12)/2;     % SAM5 filter (running average + lp filter)
        
        rolli_22=rolli_12;  % DATA shifting
        rolli_12=rolli;
        frolli_22=frolli_12;
        frolli_12=frolli;
        
        pitchi_22=pitchi_12;
        pitchi_12=pitchi;
        fpitchi_22=fpitchi_12;
        fpitchi_12=fpitchi;

        yawi_22=yawi_12;
        yawi_12=yawi;
        fyawi_22=fyawi_12;
        fyawi_12=fyawi;
        
        out(1)=frolli;     % [rad]
        out(3)=fpitchi;
        out(5)=fyawi; 
    else
    out(1)=roll;     % [rad]
    out(3)=pitch;
    out(5)=yaw;
    end
else
out(1)=roll;     % [rad]
out(3)=pitch;
out(5)=yaw;
end

% ********* ROTATIONS RATES FILTER *********
if (rrff==1)
    if (fIdx2 >= 5)        
        dotrolli=dotroll;    
        fdotrolli=((1/2)*(dotrolli+dotrolli_12)+fdotrolli_12)/2;     % SAM5 filter (running average + lp filter)


        dotpitchi=dotpitch;    
        fdotpitchi=((1/2)*(dotpitchi+dotpitchi_12)+fdotpitchi_12)/2;     % SAM5 filter (running average + lp filter)        
        
        dotyawi=dotyaw;    
        fdotyawi=((1/2)*(dotyawi+dotyawi_12)+fdotyawi_12)/2;     % SAM5 filter (running average + lp filter)        
        
        dotrolli_22=dotrolli_12;  % DATA shifting
        dotrolli_12=dotrolli;
        fdotrolli_22=fdotrolli_12;
        fdotrolli_12=fdotrolli;

        dotpitchi_22=dotpitchi_12;
        dotpitchi_12=dotpitchi;
        fdotpitchi_22=fdotpitchi_12;
        fdotpitchi_12=fpitchi;

        dotyawi_22=dotyawi_12;
        dotyawi_12=dotyawi;
        fdotyawi_22=fdotyawi_12;
        fdotyawi_12=fdotyawi;
        
        out(2)=fdotrolli;     % [rad/s]
        out(4)=fdotpitchi;
        out(6)=fdotyawi;      
    else
    out(1)=dotroll;     % [rad]
    out(3)=dotpitch;
    out(5)=dotyaw;
    end
else
out(2)=dotroll;     % [rad/s]
out(4)=dotpitch;
out(6)=dotyaw;
end



% ********* ALTITUDE FILTER *********
if (aff==1)
    if (fIdx2 >= 5)        
        zi=z;    
        fzi=((1/2)*(zi+zi_12)+fzi_12)/2;     % SAM5 filter (running average + lp filter)
        
        zi_22=zi_1;  % DATA shifting
        zi_12=zi;
        fzi_22=fzi_12;
        fzi_12=fzi;
        
        out(7)=fzi;     % [m]        
    else
    out(7)=z;    
    end
else
out(7)=z;     % [m]    
end


fIdx2=fIdx2+1;    % index incrementation

% ********* REMAINING OUTPUTS (not filtered) *********  
out(8)=in(8);
out(9)=in(9);
out(10)=in(10);
out(11)=in(11);
out(12)=in(12);