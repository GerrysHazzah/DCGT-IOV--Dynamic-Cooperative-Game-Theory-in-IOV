function [E_tran_bs,E_tran_group,E_com_bs,E_com_group] = calculate_energy(offload)
global bs_num user_num power_user complexity cpi_user R_B_i R_G_i to_bs cpi_B
[E_tran_bs,E_tran_group] = deal(zeros(bs_num,user_num),zeros(bs_num,user_num));
[E_com_bs,E_com_group] = deal(zeros(bs_num,1),zeros(bs_num,1));

for u = 1 : user_num    
    E_tran_bs(1,u) = offload(u) * to_bs * power_user / R_B_i;
    E_tran_group(1,u) = offload(u) * (1 - to_bs) * power_user / R_G_i;
end


for u = 1 : user_num
    E_com_bs(1,u) =  offload(u) * to_bs * cpi_B * complexity(u);
    E_com_group(1,u)  =  offload(u) * (1 - to_bs) * complexity(u) * cpi_user;
end



% for b = 1 : bs_num
%     for u = 1 :user_num
%         if user(u).select == b
%             t_tran_B_i(b,u) = offload_D(u) / R_B_i(b,u);
%             t_com_B_i(b,u) = offload_D(u) * user(u).complexity / bs(b).com_res; 
%         else
%             t_tran_B_i(b,u) = 0;
%             t_com_B_i(b,u) = 0;    
%         end
%       
%     end
% end

end
