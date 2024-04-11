function satelliteNode = initialSatelliteNode(altitude, inclination, eccentricity, a_P, r_A,power_S)
global BS 
% startTime = datetime(2020, 6, 2, 8, 23, 0);
% stopTime = startTime + hours(5);
% sampleTime = 60;
% sc = satelliteScenario(startTime, stopTime, sampleTime);

% Create Low-Earth Orbit satellite node
altitude = 1000; 
inclination = 55; 
eccentricity = 0.001;
a_P = 100;  % argumentPerigee
r_A = 175;  % rightAscension
power_S = 500;
satelliteNode = createSatelliteNode(altitude, inclination, eccentricity, a_P, r_A,power_S);
sat = satellite(sc,"threeSatelliteConstellation.tle");

addNode(sc, satelliteNode);
show(sc);
groundTrack(sc, "LeadTime", 1200);

time = datetime(2020, 6, 2, 12, 30, 0);
pos = nodePosition(sc, satelliteNode, time, "CoordinateFrame", "geographic");
disp(pos);

% Adding ground station(ECSP)
%groundStationNames = {'Madrid Deep Space Communications Complex', 'Canberra Deep Space Communications Complex'};
%latitudes = [40.43139, -35.40139];
%longitudes = [-4.24806, 148.98167];

for i = 1:length(BS)
    gs = groundStation(sc, 'Name', BS{i}, 'Latitude', latitudes(i), 'Longitude', longitudes(i));
end

% Return angle and distance
% time = datetime(2020, 6, 2, 12, 30, 0);
% [azimuth, elevation, range] = aer(gs(1), satelliteNode, time);
% disp(['Azimuth: ', num2str(azimuth), ', Elevation: ', num2str(elevation), ', Range: ', num2str(range)]);
show(sat)
end
%% Visualization of satellite scenes
%play(sc);
