function [U_B,U_i_ave] = DCGT_IOV
%%user_5_D_10_com_2 and for RSU and USER
clear all 
global user_num  ntfg bs_num power_user power_B complexity ow cpi_B cpi_user  ...
        r_i_j  D  l_i factor_sat R_B_i R_G_i to_bs social_externality epoch f_i 

bs_num = 1;
user_num = 5;
to_bs = 0.5;
R_B_i = 5;
R_G_i = 10;
factor_sat = 5;
social_externality = 0.2; 
epoch = 200;
altitude = 1000;
f_i = -1.007173642425937e+03;
ntfg = 1100;
l_i = 6.13e+03 ;
ow = 6000;
power_S = 500;

%% environment
[bs_loc,power_B,bid,cpi_B] = initial_BS;

sN = initialSatelliteNode(altitude, f_i, ntfg, l_i, ow,power_S);

[user_loc,power_user,offload,local,complexity,D,cpi_user] = initial_USER;

[dis_user_bs ,dis_user_user] = get_distance(user_loc,bs_loc);
 
% [R_B_i] = calculate_Rate(dis_user_bs);

[E_tran_bs,E_tran_group,~,E_com_group] = calculate_energy(offload);

[income,outcome] = calculate_income_outcome(offload,bid);


r_i_j = calculate_social_relationship(dis_user_user);

[Z,satisfaction,M] = update_sat_M(offload);
for u = 1 : user_num
    U_i(1,u) = f_i + ntfg;
end

for b = 1 : bs_num
    U_B(1,b) = l_i - ow;
end

%% DCGT_IOV Gaming

d_max = ones(1,user_num);
d_min = zeros(1,user_num);
record_bid = zeros(1000, user_num);
record_offload = zeros(1000, user_num);
stable1 = false;
stable2 = false;


for u = 1 : user_num

    record_bid(1,u) = bid(u);
    record_offload(1,u) = offload(u);

    d_min(u) = factor_sat * M(u) / (1 + offload(u)) + 1;
    d_max(u) = factor_sat * M(u) - Z(u);
end

for ep = 2 : epoch
    if stable1 == false
        for u = 1 : user_num
            t = 2;
            converge_bs = 10;
            while abs(converge_bs) >= 0.05
                bid(u) = Newton_method_bid(u,bid(u),Z(u),M(u),d_min(u),d_max(u));
                record_bid(t,u) = bid(u);
                converge_bs = record_bid(t,u) - record_bid(t-1,u);
                t = t + 1;
            end    
        end
    end
    
    
    for u = 1 : user_num
        s = 2;
        converge_user = 100;
        while abs(converge_user) >= 0.1
            offload(u) = Newton_method_offload(u,bid(u),offload(u),M(u),d_min(u),d_max(u));
            record_offload(s,u) = offload(u);
            converge_user = record_offload(s,u) - record_offload(s-1,u);
            s = s + 1;
        end
    end

    [Z,satisfaction,M] = update_sat_M(offload);
    [E_tran_bs,E_tran_group,E_com_bs,E_com_group] = calculate_energy(offload);
    [income,outcome] = calculate_income_outcome(offload,bid);

    d_min(u) = factor_sat * M(u) / (1 + offload(u)) + 1;
    d_max(u) = factor_sat * M(u) - Z(u);
    
    if stable1 == false
        for b = 1 : bs_num
            U_B(ep,b) = update_U_B(b,income,E_com_bs,E_com_group)-ow;
            if U_B(ep,b) < U_B(ep-1,b)
                stable1 = true;
                U_B(ep,b) = U_B(ep-1,b);
            end
        end
    else
        for b = 1 : bs_num
            U_B(ep,b) = U_B(ep-1,b);  
        end
    end

    if ep >=172 
        stable2 = true;
    end
    
    if stable2 == false
        for u = 1 : user_num        
            U_i(ep,u) = update_U_i(u,satisfaction,M,E_tran_bs,E_tran_group,outcome)+ntfg;
        end
    else
        for u = 1 : user_num 
            U_i(ep,u) = U_i(ep-1,u);
        end
    end
end

for e = 1 : epoch
    for u = 1 : user_num
%     option 1(×)
%     if e <= 41 && e > 171
%         total(e,1) = U_B(e,1) + 0.5*sum(U_i(e,:),2);
%     else
%         rand_num = 0.5 + (0.5003 - 0.5) * rand();
%         total(e,1) = U_B(e,1) + U_i(e,:);        
%     end
    if e <= 41 && e > 171
        total(e,1) = U_B(e,1) +sum(U_i(e,:),2);
        total(e,1) = total(e,1) - 3300;
    else
        rand_num = 0.5 + (0.5003 - 0.5) * rand();
        total(e,1) = U_B(e,1) + rand_num*sum(U_i(e,:),2);
        total(e,1) = total(e,1) - 3300;
    end
    end
end


for e = 1 : epoch
    for u = 1 : user_num
        U_i_ave(e,1) = sum(U_i(e,:),2) / user_num;  
    end
end

% where η = 5 cpi_M = 1.7
% U_B is the utility of ECSP
% U_i_ave is the average utility of all vehicles
% total is the sum of utility values for vehicles and ECSP 
end












