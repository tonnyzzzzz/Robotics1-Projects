duck=RobotRaconteur.Connect('tcp://10.13.215.110:1234/DuckiebotServer.roastduckie/Duckiebot');

k_d=-2.5;
k_theta=-3;
while 1
    a = duck.april_tags;  % Read the tag informantion 
    if isempty(a) == 0 && a{1,1}.id == 12 && a{1,1}.pos(1)<=0.6  % Whether the duckiebot see the right tag and whether the tag is close to duckiebot
        duck.sendCmd(0,0);        
        break
    else       
        i=0;
        d=0;
        phi=0;
        while i<10
            a=duck.lane_pose;
            d=d+a.d;
            phi=phi+a.phi;
            i=i+1;
        end
        d=d/10+0.08;
        phi=phi/10;
        i=0;
        w = k_d*d + k_theta*phi;
        duck.sendCmd(0.05,w);
    end
end

pause(1);

% Move to the left traffic lane
i=0;
while i<1
    if i<0.5   % Ture left with unconstant speed 
        duck.sendCmd(0,1.5*(i)+1.7);
        pause(0.011);
        disp(1.5*(i)+2.5);
    else       % Turn right with unconstant speed
        duck.sendCmd(0,-(1.5*(i-0.5)+1.7));
        pause(0.011)
        disp(-(1.5*(i-0.5)+2.5))
    end
        duck.sendCmd(0.1,0);
        pause(0.02);
    i=i+0.01;
end
duck.sendCmd(0.3,0);
pause(0.6);

% Back to the right traffic lane
i=1;
while i>0.6
    if i>0.7   % Turn right with unconstant speed           
        duck.sendCmd(0,-(1.5*(i-0.5)));
        pause(0.008);
        disp(-(1.5*(i-0.5)+1.5));
    else   %Turn left with unconstant speed
        duck.sendCmd(0,1.5*(0.7-i)+1.5);
        pause(0.01);
        disp(-(1.5*(i-0.5)+1.5));
    end
        duck.sendCmd(0.2,0);
        pause(0.06);
    i=i-0.01;
end
duck.sendCmd(0,0);
pause(0.3);

% Keep going

i=0;
d=0;
phi=0;
while i<10
     a=duck.lane_pose;
     d=d+a.d;
     phi=phi+a.phi;
     i=i+1;
end
d=d/10+0.12;
phi=phi/10;
i=0;
w = k_d*d + k_theta*phi;
duck.sendCmd(0.05,w);
disp('end');
pause(2);
duck.sendCmd(0,0);