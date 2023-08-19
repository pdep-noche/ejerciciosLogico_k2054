%creeEn(Persona, Personaje)
creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).
creeEn(juan, conejoDePascua).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).


%quiere(Persona, TipoDeSueño)
quiere(gabriel, ganarLoteria([5,9])).
quiere(gabriel, futbolista(arsenal)).
quiere(juan, cantante(100000)).
quiere(macarena, cantante(10000)).

esAmbiciosa(Persona):-  sumaTotalDificultades(Persona, Total), Total > 20.

sumaTotalDificultades(Persona, Total):- persona(Persona), 
    findall(Dificultad, dificultad(Persona, Dificultad), ListaDificultades), 
    sumlist(ListaDificultades, Total).

dificultad(Persona, Dificultad):-quiere(Persona, Suenio),
    nivelDificultad(Suenio, Dificultad).

nivelDificultad(cantante(CantDiscos),6):- CantDiscos > 500000.
nivelDificultad(cantante(CantDiscos), 4):- CantDiscos =< 500000.
nivelDificultad(ganarLoteria(Numeros), Dificultad):- length(Numeros,Cant), 
            Dificultad is Cant * 10.
nivelDificultad(futbolista(Equipo), 3):-equipoChico(Equipo).
nivelDificultad(futbolista(Equipo), 16):-not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).

persona(Persona):- creeEn(Persona, _).

tieneQuimica(Personaje, Persona):-creeEn(Persona, Personaje), 
cumpleCondiciones(Persona, Personaje).

cumpleCondiciones(Persona, campanita):- dificultad(Persona, Dificultad), 
Dificultad < 5.

cumpleCondiciones(Persona, Personaje):- Personaje \= campanita, 
todosLosSueniosPuros(Persona), not(esAmbiciosa(Persona)).

todosLosSueniosPuros(Persona):- forall(quiere(Persona, Suenio), esPuro(Suenio)).

esPuro(futbolista()).
esPuro(cantante(Discos)):- Discos < 200000.


puedeAlegrar(Personaje, Persona):-quiere(Persona, _), 
tieneQuimica(Personaje, Persona),  cumpleCondicionesParaAlegrar(Personaje).


cumpleCondicionesParaAlegrar(Personaje):- not(enfermo(Personaje)).
cumpleCondicionesParaAlegrar(Personaje):- backup(Personaje, Backup), 
cumpleCondicionesParaAlegrar(Backup).

backup(Personaje, OtroPersonaje):- amigo(Personaje, OtroPersonaje).
backup(Personaje, OtroPersonaje):- amigo(Personaje, Backup), 
    backup(Backup, OtroPersonaje).


amigo(campanita, reyesMagos).
amigo(campanita, conejoDePascua).
amigo(conejoDePascua, cavenaghi).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoDePascua).




