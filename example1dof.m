function example1dof()
clc
clear all
close all

n = 1;

alpha = [0];
offset = [0];
d = [0];
a = [1];
base = [0; 0; 0];
type = ['r'];

disp('Finding solutions...');
solutions = compute_dynamics(n, a, d, alpha, offset);

init_t = 0;
final_t = 10;
dt = 0.1;     % Keep in mind that ode23 function is a variable step solver!
N = (final_t - init_t) / dt;
t_span = linspace(init_t, final_t, N);
x0 = [0 0]';

M = 1;
B = 0.5;
u = 0;

disp('Simulating the dynamics...');
[t,x] = ode23(@simulate_dynamics, t_span, x0, [], n, u, M, B, solutions);

animate_robot(d, a, alpha, offset, type, base, x);

end


