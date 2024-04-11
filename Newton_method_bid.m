function  bid = Newton_method_bid(u,bid,Z,M,d_min,d_max)
global factor_sat cpi_user complexity to_bs cpi_B

if bid < d_min
    bid = d_min;
elseif bid >d_max
    bid =d_max;
elseif bid>=d_min && bid<=d_max
%    Option 1(×)：  bid = bid + 0.001 * ((Z + bid)/2) * (1-(((Z + bid)^2)/(factor_sat * M * (Z + to_bs * complexity(u) * cpi_B + (1-to_bs) * complexity(u) * cpi_user))));
%    Option 2：
   bid = bid + 0.01 * (((factor_sat * M) * (Z + to_bs * complexity(u) * cpi_user + (1 - to_bs) * complexity(u) * cpi_B))/(Z + bid)^2);
end

end