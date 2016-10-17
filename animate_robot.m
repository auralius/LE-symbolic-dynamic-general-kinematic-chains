%%
%--------------------------------------------------------------------------
function animate_robot(d, a, alpha, offset, type, base, x)
r = serial_arm_init(d, a, alpha, offset, type, base);
r = serial_arm_update(r);
r = serial_arm_plot(r);

view([0 0 1]);

filename = 'recorded.gif';

for i = 1 : 10 : length(x)
    for j = 1 : length(d)
        r = serial_arm_actuate_joint(r, j, x(i, (j*2)-1) );
    end
    r = serial_arm_update(r);
    r = serial_arm_plot(r);
    
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im, 256);
    if i == 1;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    
end
end