function [ Prawe ] = WektorPP( q, t, Wiezy, rows )
% Funkcja do wyznaczania prawych stron w rownaniu liniowym na predkosci qdot
% czyli minus pochodna wektora wiezow po czasie

Prawe = zeros(rows, 1);
wspolrzedne;
m=1;

for i=1:length(Wiezy)
    % wiezy dopisane
    if(lower(Wiezy(i).typ(1)) == 'd')
        if(lower(Wiezy(i).klasa(1)) == 'o')
            Prawe(m) = eval(Wiezy(i).dfoc);
            m=m+1;
        elseif(lower(Wiezy(i).klasa(1)) == 'p')
            Prawe(m) = eval(Wiezy(i).dfoc);
            m=m+1;
        end
    end
    % wiezy kienmatyczne
    if(lower(Wiezy(i).typ(1)) == 'k')
        if(lower(Wiezy(i).klasa(1)) == 'o')
            m=m+2;
        elseif(lower(Wiezy(i).klasa(1)) == 'p')
            m=m+2;
        end
    end
end

end

