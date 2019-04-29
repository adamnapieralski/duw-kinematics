function dq = Predkosc(q, t, Wiezy, rows)
% Procedura do rozwiazywania zadania o predkosci
% Zadanie o polozeniu musi byc rozwiazane wczesniej

MatJacob = MacierzJacobiego(q,t,Wiezy,rows);
PrawaStrona = WektorPP(q,t,Wiezy,rows);
dq = -MatJacob \ PrawaStrona;

end