function x_dot = simulate_dynamics(t, x, n, u, M, solutions)

theta_sym = sym('theta', [n 1]);
dtheta_sym = sym('dtheta', [n 1]);
u_sym = sym('u', [n 1]);
M_sym = sym('M%d', [n 1]);
g_sym = sym('g');

from = [];
to = x;

for i = 1 : n
    from = [from; theta_sym(i); dtheta_sym(i)]; 
end

from = [from; u_sym(1:n); M_sym(1:n); g_sym];
to = [to; u(1:n); M(1:n); -9.8];

temp = subs(solutions, num2cell(from), num2cell(to));

x_dot = zeros(2*n, 1);
j = 1;
for i = 1 : n
    x_dot(j) = x(i*2);
    x_dot(j+1) = temp(i);
    j = j + 2;
end

end