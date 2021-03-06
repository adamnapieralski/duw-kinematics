function [T,Q,DQ,DDQ]=Mechanizm(Wiezy, rows)

% Rozwiazanie zadania kinematyki o polozeniu, predkosci i przyspieszeniu 
%   dla mechanizmu opisanego w zadaniu
% Wejscie:
%   Wiezy - struktura wiezow w mechanizmie
%   rows - liczba rownan wiezow
% Wyjscie:
%   T   - tablica do zapisu kolejnych chwil.
%   Q   - tablica do zapisu rozwiazan zadania o polozeniu w kolejnych chwilach.
%   DQ  - tablica do zapisu rozwiazan zadania o predkosci w kolejnych chwilach.
%   DDQ - tablica do zapisu rozwiazan zadania o przyspieszeniu w kolejnych chwilach.
% Przyblizenie startowe (gdy brak rozwiazania z poprzedniej chwili)

wspolrzedne; % zaladowanie wspolrzednych charakterystycznych
Dane; %zaladowanie danych

% wektor wspolrzednych absolutnych
q = [c1; c2; c3; c4; c5; c6; c7; c8; c9; c10];   
    
dq = zeros(size(q));
ddq = zeros(size(q));

lroz = 0; % Licznik rozwiazan (sluzy do numerowania kolumn w tablicach z wynikami)

Q = zeros(size(q,1), length(ZakresCzasu));
DQ = zeros(size(Q));
DDQ = zeros(size(Q));
T = zeros(size(Q));

% Rozwiazywanie zadań kinematyki w kolejnych chwilach t
for t=ZakresCzasu
    % Zadanie o polozeniu. 
    %  rozwiazanie z poprzedniej chwili jest przybliżeniem poczatkowym w chwili kolejnej, 
    %  powiększone o skladniki wynikajace z obliczonej prędkości i przyspieszenia
    %  (na podstawie 3 pierwszych wyrazow rozwiniecia q w szereg Taylora w otoczeniu danego czasu t).
    q0 = q + dq*dt + 0.5*ddq*dt*dt;
    q = NewRaph(q0,t,Wiezy,rows); 
    
    % Zadanie o predkosciach
    dq = Predkosc(q, t, Wiezy, rows);
    
    % Zadanie o przyspieszeniach
    %qddot=MacierzJacobiego(q,t,Wiezy,rows)\Gamma(q,qdot,t,Wiezy,rows);  % Zadanie o przyspieszeniu
    ddq = Przyspieszenie(q, dq, t, Wiezy, rows);
    
    % Zapis do tablic gromadzacych wyniki
    lroz = lroz+1;
    T(1,lroz) = t;
    Q(:,lroz) = q;
    DQ(:,lroz) = dq;
    DDQ(:,lroz) = ddq;
end