function [user_loc,power_user,offload,local,complexity,D,cpi_user] = initial_USER
global user_num
local = zeros(1,user_num);
user_loc = [[50,0];[120,0];[160,0];[210,0];[280,0]];
power_user = 1;
offload = [10,10,10,10,10];
complexity = [2,2,2,2,2];
D = [20,20,20,20,20];
cpi_user = 15;
for u = 1 : user_num
    local(u) = D(u) - offload(u);
    vehicleID=1;
    position=0;
    lane=1; % the lane vehicle running on, start from 1
    direction='East'; % 'East' or 'West'
end

function obj=brake(obj,deceleration)
    obj.speed=max(obj.speed-deceleration,0); % min speed is 0m/s
end

function obj=changeLane(obj,new_lane)
    obj.lane=new_lane;
end




% user = struct;
% for u = 1 : 2
%     user(u).loc(1) =user_pos(u,1);
%     user(u).loc(2) =user_pos(u,2);
% end
% 
% for u = 3 : 5
%     user(u).loc(1) = user_pos(u,1);
%     user(u).loc(2) = user_pos(u,2);
% end
% 
% 
% for u = 1 : user_num
%     user(u).id = u;
%     user(u).p = 0.1;
%     user(u).offload = 0.6;
%     user(u).local = 1 - user(u).offload;
%     user(u).D = 15;    % randi([10, 20]);
%     user(u).complexity = 2.5; 
%     user(u).com_res = 10;
%     user(u).satisfaction = 0;
%     user(u).cpi = 15;
% 
% 
% 
% 
% end

end