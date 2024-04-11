function offload = Newton_method_offload(u,bid,offload,M,d_min,d_max)
global factor_sat D to_bs power_user R_B_i R_G_i ow
ow = 6000;
if bid < d_min
    offload = D(u);
elseif bid > d_max
    offload = 0;
elseif bid >= d_min && bid <= d_max
%     offload = offload +  0.001 * ((factor_sat/(1+offload)) * M) - to_bs * power_user/R_B_i - (1-to_bs) * power_user/R_G_i - bid; 
 a = (factor_sat/(1+offload))* M;
 b = -to_bs * power_user/R_B_i - (1 - to_bs) * power_user/R_G_i - bid;
 offload = offload + 0.001 * (a + b);
end
 if offload <= 0
     offload = 0;
 elseif offload >= D(u)
        offload = D(u);
        
 end

end