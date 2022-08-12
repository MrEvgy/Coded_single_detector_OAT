function [L, P_rec, pos] = us_analysis(P, t_vec, params, view, pos, S_inv)

    L = size(P);
    
    time.t = t_vec;
    time.dt = time.t(2) - time.t(1);
    time.fs = 1/time.dt;
    
    view_col = view.col * params.os_z_meas;              % Chose a value at the center, only for visualization
    view_line = view.line * params.os_y_meas;            % Chose a value at the center, only for visualization

    [pos.Z_gr, pos.Y_gr] = meshgrid(pos.z_gr, pos.y_gr);
    
    % Sampled grid positions
    pos.z_sm = linspace(pos.z_gr(1), pos.z_gr(end), params.N_p * params.os_z_meas);
    pos.y_sm = linspace(pos.y_gr(1), pos.y_gr(end), params.N_q * params.os_y_meas);
    [pos.Z_sm, pos.Y_sm] = meshgrid(pos.z_sm, pos.y_sm);

    %% Invert
    for m = 1:params.os_z_meas
        for n = 1:params.os_y_meas  
            P_sub_sample(n,m,:,:,:) = squeeze(P((n:params.os_y_meas:end), (m:params.os_z_meas:end), :)); 
            P_rec_os(n,m,:,:,:) = Calc_InvP(squeeze(P_sub_sample(n,m,:,:,:)), S_inv, params.N);
            disp(['z=', num2str(m), '/', num2str(params.os_z_meas), ', y=', num2str(n), '/', num2str(params.os_y_meas)]);
        end
    end
    P_rec_os_flip = flip(P_rec_os,1);
    P_rec_os_flip = flip(P_rec_os_flip,2);
    P_rec_os_flip = permute(P_rec_os_flip, [1 3 2 4 5]);
    P_rec = reshape(P_rec_os_flip, L);
     
end
