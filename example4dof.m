function example4dof()
clc
clear all
close all

n = 4;

alpha = [0 0 0 0];
offset = [0 0 0 0];
d = [0 0 0 0];
a = [1 1 1 1];
base = [0; 0; 0];
type = ['r', 'r', 'r', 'r'];

disp('Finding solutions...');
solutions = compute_dynamics(n, a, d, alpha, offset);

init_t = 0;
final_t = 4;
dt = 0.01;     % Keep in mind that ode23 function is a variable step solver!
N = (final_t - init_t) / dt;
t_span = linspace(init_t, final_t, N);
x0 = [-pi/4; 0; 0; 0; 0; 0; 0; 0];

M = [1; 1; 1; 1];
B = [0.5; 0.5; 0.5; 0.5];
u = [0; 0; 0; 0];

disp('Simulating the dynamics...');
[t,x] = ode23(@simulate_dynamics, t_span, x0, [], n, u, M, B, solutions, final_t);

animate_robot(d, a, alpha, offset, type, base, x);

end

