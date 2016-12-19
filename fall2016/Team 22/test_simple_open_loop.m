duck=RobotRaconteur.Connect('tcp://10.13.215.110:1234/DuckiebotServer.roastduckie/Duckiebot');

% Open Loop

w = 0.5*1-1*pi;
duck.sendCmd(0,-0.5);
pause(1);
duck.sendCmd(0,-2);
pause(1);
duck.sendCmd(0.5,0);
pause(0.7);
duck.sendCmd(0,0);