

antwort(N, I, J, P, S, R) :- I=<N, J=<N, P1 is P * (sqrt(I/J) + 1), J1 is J + 1, antwort(N, I, J1, P1, S, R).
antwort(N, I, J, P, S, R) :-  I=<N, S1 is S + P,  I1 is I + 1, antwort(N, I1, 1, 1, S1, R).
antwort(N, I, J, P, S, S) :- I>N.
								 
y(N) :- antwort(N, 1, 1, 1, 0, R), write(R).
