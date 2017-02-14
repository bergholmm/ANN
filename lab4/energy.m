function e = energy(W, x)
    e = -sum(sum(W*(x'*x)));
end