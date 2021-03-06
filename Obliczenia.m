% Skrypt rozwiazujacy zadanie
% 1. Pusta struktura do przechowywania wiezow w postaci og�nej
 Wiezy = struct('typ',{},... % dopisanych czy kinematyczny - k/d
   'klasa',{},... % para postepowa czy obrotowa p/o
   'bodyi',{},... % numer pierwszego ciala
   'bodyj',{},... % numer drugiego ciala
   'sA',{},... % wektor sA w itym ukladzie
   'sB',{},... % wektor sB w jotym ukladzie
   'phi0',{},... % kat phi0 (nie u�ywane dla pary obrotowej)
   'pros',{},... % wersor prostopadly do osi ruchu w ukladzie jotym (nie u�ywane dla pary obrotowej)
   'foc',{},... % funkcja od czasu dla wiezow dopisanych
   'dfoc',{},... % pochodna funkcji od czasu dla wiezow dopisanych
   'ddfoc',{},...% druga pochodna funkcji od czasu dla wiezow dopisanych
   'punkt',{}); % nazwa punktu


% Wczytanie danych dotyczacych wiezow odpowiednich dla danego mechanizmu
Dane;

% Inicjalizacja zmiennej do wyznaczania liczby rownan wiezow 
rows = 0;

% q = [c1; c2; c3; c4; c5; c6; c7; c8; c9; c10]; 

% liczba par kinematycznych - obrotowych
lparko=0;

% zliczenie ilosci wierszy (ilosci rownan wiezow w ukladzie) po wiezach
for k=1:length(Wiezy)
    % jesli wiezy dopisane
    if(lower(Wiezy(k).typ(1)) == 'd')
        % jesli obrotowe
        if(lower(Wiezy(k).klasa(1)) == 'o')
            rows = rows + 1;
        % jesli postepowe
        elseif(lower(Wiezy(k).klasa(1)) == 'p')
            rows = rows + 1;
        else
            error(['Blad w danej "klasa" dla wiezu nr ', num2str(k)]);
        end
    % jesli wiezy kinematyczne
    elseif(lower(Wiezy(k).typ(1)) == 'k')
        % jesli obrotowe
        if(lower(Wiezy(k).klasa(1)) == 'o')
            rows = rows + 2;
            lparko=lparko+1; 
        % jesli postepowe
        elseif(lower(Wiezy(k).klasa(1)) == 'p')
            rows = rows + 2;
        else
            error(['Blad w danej "klasa" dla wiezu nr ', num2str(k)]);
        end
    else
        error(['Blad w danej "typ" dla wiezu nr ', num2str(k)]);
    end
end

% zapisanie wyliczonych danych o mechanizmie w czasie
[T,Q,DQ,DDQ] = Mechanizm(Wiezy, rows);

% przebiegow punktow charakterystycznych
P = zeros(2*lparko, length(ZakresCzasu));
DP = zeros(2*lparko, length(ZakresCzasu));
DDP = zeros(2*lparko, length(ZakresCzasu));
tempXY=zeros(2, 1);
lroz=1;

% polozenia
for i=ZakresCzasu
    for k=1:lparko
        tempXY=[Q((Wiezy(k).bodyj-1)*3+1,lroz); Q((Wiezy(k).bodyj-1)*3+2,lroz)] + RotMat(Q((Wiezy(k).bodyj-1)*3+3,lroz))*Wiezy(k).sB;
        P(2*k-1,lroz)=tempXY(1);
        P(2*k,lroz)=tempXY(2);
    end
    lroz=lroz+1;
end

% predkosci
lroz=1;
for i=ZakresCzasu
    for k=1:lparko
        tempXY=[DQ((Wiezy(k).bodyj-1)*3+1,lroz); DQ((Wiezy(k).bodyj-1)*3+2,lroz)]+Omega*RotMat(Q((Wiezy(k).bodyj-1)*3+3,lroz))*Wiezy(k).sB*DQ((Wiezy(k).bodyj-1)*3+3,lroz);
        DP(2*k-1,lroz)=tempXY(1);
        DP(2*k,lroz)=tempXY(2);
    end
    lroz=lroz+1;
end

% przyspieszenia
lroz=1;
for i=ZakresCzasu
    for k=1:lparko
    tempXY=[DDQ((Wiezy(k).bodyj-1)*3+1,lroz); DDQ((Wiezy(k).bodyj-1)*3+2,lroz)]-RotMat(Q((Wiezy(k).bodyj-1)*3+3,lroz))*Wiezy(k).sB*(DQ((Wiezy(k).bodyj-1)*3+3,lroz))^2+Omega*RotMat(Q((Wiezy(k).bodyj-1)*3+3,lroz))*Wiezy(k).sB*DDQ((Wiezy(k).bodyj-1)*3+3,lroz);
    DDP(2*k-1,lroz)=tempXY(1);
    DDP(2*k,lroz)=tempXY(2);
    end
    lroz=lroz+1;
end
