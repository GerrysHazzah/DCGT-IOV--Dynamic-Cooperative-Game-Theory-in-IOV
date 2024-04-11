function r_i_j = calculate_social_relationship(dis_user_user)
global user_num

[~,index] =  sort(dis_user_user,2);

weight = zeros(1,user_num);
r_i_j =zeros(user_num,user_num);

H = user_num + 1 ;
for i= 1 : (H -1)
    weight(i)= 1 - i/H;
end

for i = 1 : user_num
    for j = 1 : user_num
        r_i_j(i,j) = weight(index(i,j));
    end
end

end