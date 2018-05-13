edge(a,b).
edge(b,c).
edge(c,a).
path(X,Y):-edge(X,Z),path(Z,Y).
cycle(W):-path(W,W).