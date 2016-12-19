duck=RobotRaconteur.Connect('tcp://10.13.215.110:1234/DuckiebotServer.roastduckie/Duckiebot');
% Stop Sign
pause(10);
k_d=-2.4;  % Set feed back gain
k_theta=-2.5;
while 1
    a = duck.april_tags;  % Read the tag information
    if isempty(a) == 0 && a{1,1}.id == 1 && a{1,1}.pos(1)<=0.37  % Whether duckiebot see the right tag and find the distance between tag and duckiebot
        duck.sendCmd(0,0);  % Stop the duckiebot      
        break
    else  % Not the right tag, keep going
        i=0;
        d=0;
        phi=0;
        while i<10
            a=duck.lane_pose;  % Read the position informantion between lane and duckiebot
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
duck.sendCmd(0,0);
pause(5);

% Shake head
duck.sendCmd(0,1);
pause(0.5);
duck.sendCmd(0,-1);
pause(0.5);
duck.sendCmd(0,-1);
pause(0.5);
duck.sendCmd(0,1);
pause(0.5);
duck.sendCmd(0,0);
disp('Good');
pause(1);

% Keep going
while 1
i=0;
d=0;
phi=0;
     while i<10
         a=duck.lane_pose;  % Read the position information between lane and duckiebot
         d=d+a.d;
         phi=phi+a.phi;
         i=i+1;
     end
     d=d/10+0.12;
     phi=phi/10;
     i=0;
     w = k_d*d + k_theta*phi;
     duck.sendCmd(0.05,w);       
end
