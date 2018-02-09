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

function out=sam5_filter1(in)

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


global fIdx1; % index for filtering

global rolli_11;
global rolli_21;
global frolli1;
global frolli_11;
global frolli_21;

global dotrolli_11;
global dotrolli_21;
global fdotrolli1;
global fdotrolli_11;
global fdotrolli_21;

global pitchi_11;
global pitchi_21;
global fpitchi1;
global fpitchi_11;
global fpitchi_21;

global dotpitchi_11;
global dotpitchi_21;
global fdotpitchi1;
global fdotpitchi_11;
global fdotpitchi_21;

global yawi_11;
global yawi_21;
global fyawi1;
global fyawi_11;
global fyawi_21;

global dotyawi_11;
global dotyawi_21;
global fdotyawi1;
global fdotyawi_11;
global fdotyawi_21;

global zi_11;
global zi_21;
global fzi1;
global fzi_11;
global fzi_21;


rff=0;  % rotations filter flag (1=filter rotations, 0=do not filter)
rrff=0; % rotations rates ...
aff=0;  % altitude ...

% ********* ROTATIONS FILTER *********
if (rff==1)
    if (fIdx1 >= 5)
             
        rolli=roll;
%        frolli=((1/3)*(rolli+rolli_1+rolli_2)+frolli_1+frolli_2)/3;     % SAM5 filter (running average + lp filter)
%        frolli=((1/2)*(rolli+rolli_1)+frolli_1+frolli_2)/3;     % SAM5 filter (running average + lp filter)
        frolli=((1/2)*(rolli+rolli_11)+frolli_11)/2;     % SAM5 filter (running average + lp filter)
        
        pitchi=pitch;    
%        fpitchi=((1/3)*(pitchi+pitchi_1+pitchi_2)+fpitchi_1+fpitchi_2)/3;     % SAM5 filter (running average + lp filter)
%        fpitchi=((1/2)*(pitchi+pitchi_1)+fpitchi_1+fpitchi_2)/3;     % SAM5 filter (running average + lp filter)
        fpitchi=((1/2)*(pitchi+pitchi_11)+fpitchi_11)/2;     % SAM5 filter (running average + lp filter)
        
        
        yawi=yaw;    
%        fyawi=((1/3)*(yawi+yawi_1+yawi_2)+fyawi_1+fyawi_2)/3;     % SAM5 filter (running average + lp filter)
%        fyawi=((1/2)*(yawi+yawi_1)+fyawi_1+fyawi_2)/3;     % SAM5 filter (running average + lp filter)
        fyawi=((1/2)*(yawi+yawi_11)+fyawi_11)/2;     % SAM5 filter (running average + lp filter)
        
        rolli_21=rolli_11;  % DATA shifting
        rolli_11=rolli;
        frolli_21=frolli_11;
        frolli_11=frolli1;
        
        pitchi_21=pitchi_11;
        pitchi_11=pitchi;
        fpitchi_21=fpitchi_11;
        fpitchi_11=fpitchi;

        yawi_21=yawi_11;
        yawi_11=yawi;
        fyawi_21=fyawi_11;
        fyawi_11=fyawi;
        
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
    if (fIdx1 >= 5)        
        dotrolli=dotroll;    
        fdotrolli=((1/2)*(dotrolli+dotrolli_11)+fdotrolli_11)/2;     % SAM5 filter (running average + lp filter)


        dotpitchi=dotpitch;    
        fdotpitchi=((1/2)*(dotpitchi+dotpitchi_11)+fdotpitchi_11)/2;     % SAM5 filter (running average + lp filter)        
        
        dotyawi=dotyaw;    
        fdotyawi=((1/2)*(dotyawi+dotyawi_11)+fdotyawi_11)/2;     % SAM5 filter (running average + lp filter)        
        
        dotrolli_21=dotrolli_11;  % DATA shifting
        dotrolli_11=dotrolli;
        fdotrolli_21=fdotrolli_11;
        fdotrolli_11=fdotrolli;

        dotpitchi_21=dotpitchi_11;
        dotpitchi_11=dotpitchi;
        fdotpitchi_21=fdotpitchi_11;
        fdotpitchi_11=fpitchi;

        dotyawi_21=dotyawi_11;
        dotyawi_11=dotyawi;
        fdotyawi_21=fdotyawi_11;
        fdotyawi_11=fdotyawi;
        
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
    if (fIdx1 >= 5)        
        zi=z;    
        fzi=((1/2)*(zi+zi_11)+fzi_11)/2;     % SAM5 filter (running average + lp filter)
        
        zi_21=zi_1;  % DATA shifting
        zi_11=zi;
        fzi_21=fzi_1;
        fzi_11=fzi;
        
        out(7)=fzi;     % [m]        
    else
    out(7)=z;    
    end
else
out(7)=z;     % [m]    
end


fIdx1=fIdx1+1;    % index incrementation

% ********* REMAINING OUTPUTS (not filtered) *********  
out(8)=in(8);
out(9)=in(9);
out(10)=in(10);
out(11)=in(11);
out(12)=in(12);