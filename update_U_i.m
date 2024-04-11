function  U_i = update_U_i(u,satisfaction,M,E_tran_bs,E_tran_group,outcome)

U_i =  satisfaction(u) + M(u) - E_tran_bs(u) - E_tran_group(u) - outcome(u);

end

