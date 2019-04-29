function ddq = Przyspieszenie(q, dq, t, Wiezy, rows)
% Procedura do rozwiazywania zadania o przyspieszeniach
% Zadanie o polozeniu i predkosci musi byc rozwiazane wczesniej

MatJacob = MacierzJacobiego(q, t, Wiezy,rows);
gamma = Gamma(q, dq, t, Wiezy, rows);
ddq = MatJacob \ gamma;

end
