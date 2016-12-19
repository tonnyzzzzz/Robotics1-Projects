duck=RobotRaconteur.Connect('tcp://10.13.215.110:1234/DuckiebotServer.roastduckie/Duckiebot');
pause(10);

k_d=-2.5;       % d gain
k_theta=-2;     % phi gain

% Order 1
while 1         % constant checking the order location by using AR tag
    a = duck.april_tags;
    if isempty(a) == 0 && a{1,1}.id == 12 && a{1,1}.pos(1)<=0.7
        duck.sendCmd(0,0);  
        disp('Get Order 1');
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
        d=d/10+0.1;
        phi=phi/10;
        i=0;
        w = k_d*d + k_theta*phi;
        duck.sendCmd(0.05,w);
    end
end
pause(3);

% Do Delivery (Combination of close-loop and open-loop)
% 1.Open loop
duck.sendCmd(0,1);
pause(0.7);
duck.sendCmd(0.1,0);
pause(0.6);
a=duck.lane_pose; 
while abs(a.phi)<1.4
    a=duck.lane_pose; 
    duck.sendCmd(0,2);
    pause(0.1);
end
% 2.Back straight (Open loop)
duck.sendCmd(-0.40,0);
pause(1);
k_theta=-2;
duck.sendCmd(0,0);
pause(1);
% 3.Calibration direction and prepare to park (Close loop)
    i=0;
    phi=0;
    while i<10
        a=duck.lane_pose;
        phi=phi+a.phi;
        i=i+1;
    end
    phi=phi/10;
    i=0;
    w = k_theta*phi;
    duck.sendCmd(0,w/0.5);
    disp(phi);
% 4.Deliver (Open loop)
duck.sendCmd(-10,0);
pause(0.1);
duck.sendCmd(10,0);
pause(0.1);
disp('Roast Duck Order 1 Delivered!!');
duck.sendCmd(0,0);
pause(1);
% 5.Back to track(Open loop, then close loop)
duck.sendCmd(0.40,0);
pause(0.7);
duck.sendCmd(0,-0.7);
pause(1.2);
duck.sendCmd(0.1,0);
pause(0.5);
duck.sendCmd(0,0);

pause(2);

% Order 2
while 1     % constant checking the order location by using AR tag
    a = duck.april_tags;
    if isempty(a) == 0 && a{1,1}.id == 1 %.&& a{1,1}.pos(1)<=0.35
        duck.sendCmd(0,0);
        disp('Get Order 2!');
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
        d=d/10+0.12;
        phi=phi/10;
        i=0;
        w = k_d*d + k_theta*phi;
        duck.sendCmd(0.05,w);
    end
end
pause(2);

% Do Delivery (Combination of close-loop and open-loop)
% 1.Open loop
duck.sendCmd(0,1);
pause(0.7);
duck.sendCmd(0.1,0);
pause(0.6);
a=duck.lane_pose; 
while abs(a.phi)<1.4
    a=duck.lane_pose; 
    duck.sendCmd(0,2);
    pause(0.1);
end
% 2.Back straight (Open loop)
duck.sendCmd(-0.40,0);
pause(1);
k_theta=-2;
duck.sendCmd(0,0);
pause(1);
% 3.Calibration direction and prepare to park (Close loop)
    i=0;
    phi=0;
    while i<10
        a=duck.lane_pose;
        phi=phi+a.phi;
        i=i+1;
    end
    phi=phi/10;
    i=0;
    w = k_theta*phi;
    duck.sendCmd(0,w/0.5);
    disp(phi);
% 4.Deliver (Open loop)
duck.sendCmd(-10,0);
pause(0.1);
duck.sendCmd(10,0);
pause(0.1);
disp('Roast Duck Order 2 Delivered!!');
duck.sendCmd(0,0);
pause(1);
% 5.Back to track (Open loop, then close loop)
duck.sendCmd(0.40,0);
pause(0.7);
duck.sendCmd(0,-0.7);
pause(1.2);
duck.sendCmd(0.1,0);
pause(0.5);
duck.sendCmd(0,0);

pause(2);

% (No) Order 3

while 1     % constant checking the order location by using AR tag
    a = duck.april_tags;
    if isempty(a) == 0 && a{1,1}.id == 3 && a{1,1}.pos(1)<=0.5
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
        d=d/10+0.12;
        phi=phi/10;
        i=0;
        w = k_d*d + k_theta*phi;
        
        pause(0.1);
        duck.sendCmd(0.05,w);
    end
end
pause(2);
disp('No Order Here!');

% Calibrate Direction
k_d=-2.5;
k_theta=-2;
phi=10;
time=0;
while time ~= 3
    i=0;
    phi=0;
    while i<10
        a=duck.lane_pose;
        phi=phi+a.phi;
        i=i+1;
    end
    phi=phi/10;
    i=0;
    w = k_theta*phi;
   
    pause(0.1);
    duck.sendCmd(0,w/2.5);
    disp(phi);
    if abs(phi)<=0.1
        time = time + 1;
    end
end
% Keep shaking head
duck.sendCmd(0,0);
pause(1);
duck.sendCmd(0,1);
pause(0.5);
duck.sendCmd(0,-1);
pause(0.5);
duck.sendCmd(0,1);
pause(0.5);
duck.sendCmd(0,-1);
pause(0.5);
duck.sendCmd(0,1);
pause(0.5);
duck.sendCmd(0,-1);
pause(0.5);
duck.sendCmd(0,0);
% Close loop and keep going
while 1   
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
end
pause(3);

