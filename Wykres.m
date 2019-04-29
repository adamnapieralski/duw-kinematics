function [] = printGraphs(obj)
%   Funkcja do wykorzystania przez uzytkownika koncowego
%   wyswietlajaca wykresy przebiegow polozen, predkosci i przyspieszen
%   dla okreslonego punktu
%   Wejscie:
%   obj - symbol czlonu (wtedy podana ma byc liczba) / punktu (litera np.
%           'A') ktorego przebiegi chce sie otrzymac

    Obliczenia;

    if isnumeric(obj)
        figure();
        subplot(3, 1, 1);
        plot(T(1,:), Q((obj-1)*3+1:(obj-1)*3 + 3, :))
        legend('x', 'y', '\phi');
        subplot(3, 1, 2);
        plot(T(1,:), DQ((obj-1)*3+1:(obj-1)*3 + 3, :))
         legend('dx', 'dy', 'd\phi');
        subplot(3, 1, 3);
        plot(T(1,:), DDQ((obj-1)*3+1:(obj-1)*3 + 3, :))
         legend('ddx', 'ddy', 'dd\phi');
    else
        for i=1:length(Wiezy)
            if(Wiezy(i).punkt==obj)
                figure();
                subplot(3, 1, 1);
                plot(T(1,:), P(2*i-1:2*i,:));
                legend('x', 'y');
                subplot(3, 1, 2);
                plot(T(1,:), DP(2*i-1:2*i,:));
                legend('dx', 'dy')
                subplot(3, 1, 3);
                plot(T(1,:), DDP(2*i-1:2*i,:));
                legend('ddx', 'ddy');
            end  
        end
        disp('Brak danego obiektu');
        
    end
end

