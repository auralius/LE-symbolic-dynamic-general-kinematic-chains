%%
%--------------------------------------------------------------------------
function animate_robot(d, a, alpha, offset, type, base, x)
r = serial_arm_init(d, a, alpha, offset, type, base);
r = serial_arm_update(r);
r = serial_arm_plot(r);
view([0 0 1]);

for i = 1 : 10: length(x)
    for j = 1 : length(d)
        r = serial_arm_actuate_joint(r, j, x(i, (j*2)-1) );
    end
    r = serial_arm_update(r);
    r = serial_arm_plot(r);
end
end