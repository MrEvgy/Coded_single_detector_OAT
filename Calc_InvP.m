function [P_rec, P_pp, P_rec_pp] = Calc_InvP(P, S_inv, N) % Calculate P_rec

L = size(P);
dim = length(L);

P_rec = reshape(S_inv * reshape(P, N,[]), L);

P_pp = squeeze(range(P, dim)); % Range of original signal
P_rec_pp = squeeze(range(P_rec, dim)); % Range of recovered signal

% f_cent = 1e6;
% [freq,  FFT_1M_rec] = Calc_FFT_1M(DAQ_dt, L_DAQ, X_vec, P_rec, f_cent); % FFT at 1MHz

end
