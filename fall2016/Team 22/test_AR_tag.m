cam = RobotRaconteur.Connect('tcp://localhost:2355/WebcamServer/Webcam');
img = cam.SnapShot();

while 1
    a = duck.april_tags;
    if isempty(a) == 0 && a{1,1}.id == 12
        duck.sendCmd(0,0);
        break
    else
        duck.sendCmd(0.05,0);
    end
end
duck.sendCmd(0,0);