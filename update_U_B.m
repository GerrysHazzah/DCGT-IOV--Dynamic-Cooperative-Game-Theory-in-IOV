function  [U_B] = update_U_B(b,income,E_com_bs,E_com_group)


U_B(b,1) = income - sum(E_com_bs(b,1)) - sum(E_com_group(b,1));



end