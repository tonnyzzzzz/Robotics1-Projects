% Test d of duckiebot before on real road
i=1;
s=0;
while i<100     % test by average of 100 times
    a=duck.lane_pose;
    s=s+a.d-0.1;
    i=i+1;
end
s=s/100;

% Test phi of duckiebot before on real road
i=1;
s=0;
while i<100     % test by average of 100 times
    a=duck.lane_pose;
    s=s+a.phi;
    i=i+1;
end
s=s/100;
