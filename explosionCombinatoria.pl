entretenimiento(cine).
entretenimiento(teatro).
entretenimiento(pool).
entretenimiento(parqueTematico).
costo(cine, 30).
costo(teatro, 40).
costo(pool, 15).
costo(parqueTematico, 50).

entretenimientos(MontoDinero, Lugares):- findall(Entre, entretenimiento(Entre), ListaEntrenimientos), 
combinatoria(MontoDinero, ListaEntrenimientos, Lugares).

combinatoria(_, [], []).
combinatoria(Monto, [Entretenimiento|Resto], [Entretenimiento| Lista]):- costo(Entretenimiento, Costo), 
    Monto >= Costo, Disponible is Monto - Costo, combinatoria(Disponible, Resto, Lista).
combinatoria(Monto, [_|Resto], Lista):- combinatoria(Monto, Resto, Lista).
