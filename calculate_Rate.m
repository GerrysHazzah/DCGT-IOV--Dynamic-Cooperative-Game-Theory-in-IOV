function  [R_B_i] = calculate_Rate(dis_user_bs )
global bs_num user_num power_user

Gain_B_i = zeros(bs_num , user_num);
R_B_i = zeros(bs_num , user_num);

fading_component =20;  %！！！
path_loss = -sqrt(2);     %！！！
N0 = 100;       %！！！
W_B = 40;  %基站信道带宽


for b = 1 : bs_num
    for u = 1 : user_num
        Gain_B_i(b,u) = fading_component * ((dis_user_bs(b,u)/200) ^ path_loss);
    end

end

for b = 1 : bs_num
    for u = 1 : user_num
        R_B_i(b,u) = W_B * log2( 1 + power_user * Gain_B_i(b,u)^2 / N0);       
    end
end




end
