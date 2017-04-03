% trial error in sys_v1

%%
%run system as normal

%%
% run inner loop

sim('trial_main_sys_v1_in')

%% plots inner loop

figure(),   % u control actions
subplot(2,2,1),
    plot(u_woutg.time, u_woutg.signals.values(:,1),...
         u_out_2.time, u_out_2.signals.values(:,1) )
subplot(2,2,2),
    plot(u_woutg.time, u_woutg.signals.values(:,2),...
         u_out_2.time, u_out_2.signals.values(:,2) )
subplot(2,2,3), global param
    plot(u_woutg.time, u_woutg.signals.values(:,3)+param.m*param.g,...
         u_out_2.time, u_out_2.signals.values(:,3) )
subplot(2,2,4),
    plot(u_woutg.time, u_woutg.signals.values(:,4),...
         u_out_2.time, u_out_2.signals.values(:,4) )

     
figure(),%angles
subplot(2,1,1),
    plot(casee_angles.time, casee_angles.signals.values(:,1) )
subplot(2,1,2),
    plot(casee_angles.time, casee_angles.signals.values(:,2) )

