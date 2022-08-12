

function [P_rec, P_pp, P_rec_pp] = Calc_MultiInv(P, params, S_inv)

for k = 1:params.os_indx
  
    P_sub_sample = P(k : params.os_indx : end, :,:,:,:);
    P_sub_sample = squeeze(P_sub_sample);

    
    [P_rec(k,:,:,:), P_pp(k,:,:,:), P_rec_pp(k,:,:,:)] = Calc_InvP(P_sub_sample, S_inv, params.N);
    % P_rec = P_rec - mean(P_rec,1);
%     figure; imagesc(P_rec_pp)
    k

end