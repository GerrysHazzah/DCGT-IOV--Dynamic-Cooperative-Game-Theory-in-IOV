function SLG_communication()
global f_i
for u = 1 % number of ECSPs  
    received_power = power_S / (distance ^ 2);
    % Determine whether the satellite can successfully receive the signal
    if received_power >= power_satellite
        disp('Satellite successfully receives signal from the ground station.');
        f_i = -1.007173642425937e+03;
    else
        disp('Satellite cannot receive signal from the ground station due to low power.');
    end
end

% Visualization of SLG and satellite communications
% show(sc);
% groundTrack(sc, "LeadTime", 1200);
% line([gs(1).Latitude, satelliteNode.Latitude], [gs(1).Longitude, satelliteNode.Longitude], 'Color', 'red');
% play(sc);

end


