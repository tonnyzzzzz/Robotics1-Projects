duck=RobotRaconteur.Connect('tcp://10.13.215.110:1234/DuckiebotServer.roastduckie/Duckiebot');

% Calibrate Direction to the front
k_theta=-2;   % direction gain
phi=10;       % initiate a degree
time=0;       % initiate time
while time ~= 3         % need to calibrate 3 time to make sure no error
    i=0;
    phi=0;
    while i<10      % 10 sum of the degree
        a=duck.lane_pose;       
        phi=phi+a.phi;
        i=i+1;
    end
    phi=phi/10;     % get average
    i=0; 
    w = k_theta*phi;
    duck.sendCmd(0,w/2.5);
    disp(phi);
    if abs(phi)<=0.1    % check average direction is front or not
        time = time + 1;
    end
end
duck.sendCmd(0,0);
