function  [Z,satisfaction,M] = update_sat_M(offload)
global user_num r_i_j  factor_sat social_externality to_bs R_B_i R_G_i power_user
[M,satisfaction,Z] = deal(zeros(1,user_num),zeros(1,user_num),zeros(1,user_num));

for u = 1 : user_num
    satisfaction(u) = factor_sat *2* log(1 + offload(u));
    Z(u) = to_bs * power_user / R_B_i + (1 - to_bs) * power_user / R_G_i; 
end

for u = 1 : user_num
    temp = 0;
    for v = 1 : user_num
       temp = temp + r_i_j(u,v) * satisfaction(v);
    end
    M(u) = social_externality * temp * satisfaction(u);
end


end