%viveEn(rata, restaurante)
viveEn(remy, gusteaus).
viveEn(emille, chezMilleBar).
viveEn(django, pisseriaJeSuis).


%sabeCocinar(nombre, comida, experiencia)
sabeCocinar(linguini, ratatoullie, 3).
sabeCocinar(linguini, sopa, 5).
sabeCocinar(colette, salmonAsado, 9).
sabeCocinar(horst, ensaladaRusa, 8).

%trabajaEn(persona, lugar)
trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(skinner, gusteaus).
trabajaEn(amelie, cafeDes2Moulins).

%1
estaEnMenu(Plato, Restaurante):- sabeCocinar(Cocinero, Plato, _), 
trabajaEn(Cocinero, Restaurante).

%2
cocinaBien(Cocinero, Plato):- sabeCocinar(Cocinero, Plato, Experiencia), 
Experiencia>7.
cocinaBien(Cocinero, Plato):- sabeCocinar(Cocinero, Plato, _),
 tieneTutor(Cocinero, Tutor), cocinaBien(Tutor, Plato).
cocinaBien(remy, Plato):- sabeCocinar(_, Plato, _).

%tieneTutor(Cocinero, Tutor)
tieneTutor(linguini, Rata):-   viveEn(Rata, Lugar), trabajaEn(linguini, Lugar).
tieneTutor(amelie, skinner).

%3
esChef(Cocinero, Restaurante):- trabajaEn(Cocinero,Restaurante), 
cumpleCondiciones(Cocinero, Restaurante).

cumpleCondiciones(Cocinero, Restaurante):- forall(estaEnMenu(Plato, Restaurante), 
cocinaBien(Cocinero, Plato)).
cumpleCondiciones(Cocinero, _):-totalExperiencia(Cocinero, Total), 
Total > 20.

totalExperiencia(Cocinero, Total):- 
    findall(Experiencia, sabeCocinar(Cocinero,_, Experiencia), ListaEsperiencias), 
    sumlist(ListaEsperiencias, Total).

%4
encargada(Persona, Plato, Restaurante):- 
    experienciaEnRestaurante(Persona, Plato, Restaurante, Experiencia), 
    forall(experienciaEnRestaurante(_, Plato, Restaurante, OtraExperiencia), 
    OtraExperiencia =< Experiencia).

experienciaEnRestaurante(Persona, Plato, Restaurante, Experiencia):-
    trabajaEn(Persona, Restaurante), sabeCocinar(Persona, Plato, Experiencia). 

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(30)).

esSaludable(NombrePlato):- plato(NombrePlato, TipoPlato), cantCalorias(TipoPlato, Calorias), Calorias < 75.

cantCalorias(entrada(Ingredientes), TotalCalorias):- length(Ingredientes, Cantidad), TotalCalorias is Cantidad * 15.
cantCalorias(principal(Guarnicion, Minutos), TotalCalorias):- caloriasGuarnicion(Guarnicion, Calorias), TotalCalorias is Calorias + (5*Minutos).
cantCalorias(postre(Calorias), Calorias).


caloriasGuarnicion(papasFritas, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0).

reseniaPositiva(Critico, Restaurante):-restaurante(Restaurante), not(viveEn(_, Restaurante)), criterioCritico(Critico, Restaurante).

criterioCritico(antonEgo,Restaurante):- esEspecialista(Restaurante, ratatoullie).
criterioCritico(cormillot, Restaurante):-forall(cocinaEn(Restaurante, Plato), esSaludable(Plato)).
criterioCritico(martiniano, Restaurante):- esChef(Cocinero, Restaurante), not((esChef(OtroCocinero, Restaurante), Cocinero \= OtroCocinero)).

esEspecialista(Restaurante,Comida):- forall(esChef(Cocinero, Restaurante), cocinaBien(Cocinero, Comida)).
cocinaEn(Restaurante, Plato):-sabeCocinar(Persona, Plato, _), trabajaEn(Persona, Restaurante).








