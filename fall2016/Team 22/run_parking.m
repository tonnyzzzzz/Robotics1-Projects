duck=RobotRaconteur.Connect('tcp://10.13.215.110:1234/DuckiebotServer.roastduckie/Duckiebot');

% Parking function
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
% back straight
duck.sendCmd(-0.40,0);
pause(1);
k_theta=-2;
phi=10;
time=0;
duck.sendCmd(0,0);
pause(1);

% calibration
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
    if abs(phi)<=0.1
        time = time + 1;
    end

% Delivery
duck.sendCmd(-10,0);
pause(0.1);
duck.sendCmd(10,0);
pause(0.1);
disp('Roast Duck Delivered!!');
duck.sendCmd(0,0);
pause(1);

% Back to track
duck.sendCmd(0.40,0);
pause(0.7);
duck.sendCmd(0,-0.7);
pause(1.2);
duck.sendCmd(0.1,0);
pause(0.5);
duck.sendCmd(0,0);


