function solutions = compute_dynamics(n, a, d, alpha, offset)

% Dynamic of a kinematic chain, given by DH-parameters.

%% Mass
M = sym('M', [1 n]);
B = sym('B', [1 n]);
syms g;
G = [0 g 0];

%% Symbolic stuffs
theta = sym('theta', [n 1]);
dtheta = sym('dtheta', [n 1]);
ddtheta = sym('ddtheta', [n 1]);
u = sym('u', [n 1]);

dTdq =  sym('dTdq%d', [n 1]);
dVdq =  sym('dVdq%d', [n 1]);
dTdqdot =  sym('dTdq%ddot', [n 1]);
dPdqdot =  sym('dPdq%ddot', [n 1]);

%% DH transformation
T = eye(4,4);
for j = 1 : n
    ct = cos(theta(j)+offset(j));
    st = sin(theta(j)+offset(j));
    ca = cos(alpha(j));
    sa = sin(alpha(j));
    
    T = T * [ ct    -st*ca   st*sa     a(j)*ct ; ...
        st    ct*ca    -ct*sa    a(j)*st ; ...
        0     sa       ca        d(j)    ; ...
        0     0        0         1       ];
    
    x(:, j) = T(1:3, 4);
end

%% Velocity
v = zeros(3, n);
for i = 1 : n
    v = v + fulldiff(x, theta(i));
end

x = simplify(x);
v = simplify(v);

%% Kinetic. potential, dissipative energy
T = sum(0.5 * M .* sum(v.^2)); % Kinetic
V = sum(M(j)* G * x);            % Potential
P = sum(0.5 * B .* sum(v.^2)); % Dissipative

T = simplify(T);
V = simplify(V);
P = simplify(P);



%% Lagrange-Euler implementation
for j = 1 : n
    ddtdTdqdot = zeros(n, 1);
    
    dTdqdot(j) = diff(T, dtheta(j));
    dTdq(j) = diff(T, theta(j));
    dVdq(j) = diff(V, theta(j));
    dPdqdot(j) = diff(P, dtheta(j));
    
    for i = 1 :n
        ddtdTdqdot = ddtdTdqdot + ...
            diff(dTdqdot(j), theta(i)) * dtheta(i) + ...
            diff(dTdqdot(j), dtheta(i)) * ddtheta(i);
    end
    
    eq(j) = simplify( ddtdTdqdot(j) - dVdq(j) + dTdq(j) - u(j) + dPdqdot(j));
end

allvar = symvar(ddtheta);

%% Solve it
if n == 1
    solutions = simplify(solve(eq, allvar));
else
    solutions_ = solve(eq,allvar);
    for i = 1 : n
        solutions(i) = simplify(getfield(solutions_, char(allvar(i))));
    end
end








