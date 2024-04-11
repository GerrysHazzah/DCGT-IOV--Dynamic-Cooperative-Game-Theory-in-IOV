function [dis_user_bs,dis_user_user] = get_distance(user_loc,bs_loc)
global user_num bs_num

dis_user_bs = zeros(bs_num,user_num);
dis_user_user = zeros(user_num,user_num);
distance = @(x,y)sqrt((x(1)-y(1))^2 + (x(2)-y(2))^2); 
for i = 1:user_num
    for j = 1:bs_num
       dis_user_bs(j,i) = distance(user_loc(i,:),bs_loc(j,:));
    end
end

for i = 1:user_num
    for j = 1:user_num
       dis_user_user(j,i) = distance(user_loc(i,:),user_loc(j,:));
    end
end


end