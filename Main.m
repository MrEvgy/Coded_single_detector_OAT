load('Suture_data_x4.mat')
L = size(P);
pos.y_gr_step = 0.5;                    % Grid step size = 1 mm grid.
pos.z_gr_step = 0.5;                    % Grid step size = 1 mm grid.
params.N_p = 41;                        % N is P*Q for the twin-prime method, this is P.

params.N_q = params.N_p + 2;
params.N = params.N_p * params.N_q;
params.os_y_meas = L(1)/params.N_q;     % Oversample in the continual scan direction.
params.os_z_meas = L(2)/params.N_p;     % Oversample in the second (z) direction.

view.line = 27;                         % Viewpoint for 2D plots.
view.col = 26;                          % Viewpoint for 2D plots.

[S, S_inv] = sMatTwinPrime(params.N_p); % Create S-matrix.
tic;
[L, P_rec, pos] = us_analysis(P, t, params, view, pos, S_inv);  % De-multiplexing.
rec_time = toc;
fprintf('De-multiplexing takes %d [sec].\n', rec_time)
P_rec = squeeze(P_rec);

%% Synograms in x-t and y-t planes

figure;
subplot(221); imagesc(t*1e6, 1:params.N_p, squeeze(1e3*P(view.line*params.os_y_meas,:,:))); title('P mux [mV]'); colorbar; colormap('gray');
xlabel('time [us]'); ylabel('element index');
subplot(222); imagesc(t*1e6, 1:params.N_q, squeeze(1e3*P(:,view.col*params.os_z_meas,:))); title('P mux [mV]'); colorbar; colormap('gray');
xlabel('time [us]'); ylabel('element index');
subplot(223); imagesc(t*1e6, 1:params.N_p, squeeze(1e3*P_rec(view.line*params.os_y_meas,:,:))); title('P rec [mV]'); colorbar; colormap('gray');
xlabel('time [us]'); ylabel('element index');
subplot(224); imagesc(t*1e6, 1:params.N_q, squeeze(1e3*P_rec(:,view.col*params.os_z_meas,:))); title('P rec [mV]'); colorbar; colormap('gray');
xlabel('time [us]'); ylabel('element index');