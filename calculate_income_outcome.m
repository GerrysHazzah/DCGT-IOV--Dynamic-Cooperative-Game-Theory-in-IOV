function [income,outcome] = calculate_income_outcome(offload,bid)
global user_num 
outcome = zeros(1,user_num);

for u = 1 : user_num
    outcome(u) = offload(u) * bid(u);       
end

income(1) = sum(outcome);

end