%% quedaEn(lugar, lugar)
quedaEn(venezuela, america).
quedaEn(argentina, america).
quedaEn(patagonia, argentina).
quedaEn(aula522, utn). % Sí, un aula es un lugar!
quedaEn(utn, buenosAires).
quedaEn(buenosAires, argentina).

nacioEn(dani, buenosAires).
nacioEn(alf, buenosAires).
nacioEn(nico, buenosAires).

haceTarea(dani, tomarExamen(paradigmaLogico, aula522), fecha(10, 8, 2019), aula522).
haceTarea(dani, hacerGol(primeraDivision), fecha(10, 8, 2019), buenosAires).
haceTarea(alf, hacerDiscurso(utn, 0), fecha(11, 8, 2019), utn).

nuncaSalioDeCasa(Persona):- nacioEn(Persona, Lugar), forall(haceTarea(Persona, _, _, OtroLugar), mismoLugar(OtroLugar, Lugar)).

mismoLugar(Lugar, Lugar).

nuncaSalioDeCasaConNot(Persona):- nacioEn(Persona, Lugar), not((haceTarea(Persona,_, _, OtroLugar), OtroLugar \= Lugar)).


esEstresante(Tarea):-haceTarea(_, Tarea, _, Lugar), pertenece(Lugar, argentina), cumpleCondicionesEstresante(Tarea).

cumpleCondicionesEstresante(hacerDiscurso(_, Cantidad)):-Cantidad > 30000.
cumpleCondicionesEstresante(tomarExamen(Tema, _)):- esComplejo(Tema).
cumpleCondicionesEstresante(hacerGol(_)).

pertenece(Lugar, OtroLugar):- quedaEn(Lugar, OtroLugar).
pertenece(Lugar, OtroLugar):- quedaEn(Lugar, Lugar2), pertenece(Lugar2, OtroLugar).

esComplejo(paradigmaLogico).
esComplejo(analisisMatematico).

calificacionTrabajador(Persona, Calificacion):- persona(Persona), calificarSegun(Persona,  Calificacion).

calificarSegun(Persona, zen):- forall(haceTarea(Persona, Tarea, _, _), not(esEstresante(Tarea))).
calificarSegun(Persona, loco):- forall(haceTarea(Persona, Tarea, fecha(_, _, 2019), _), esEstresante(Tarea)).
calificarSegun(Persona, sabio):- realizaTareaEstresante(Persona, Tarea), not((realizaTareaEstresante(Persona, OtraTarea), OtraTarea \= Tarea)).

realizaTareaEstresante(Persona, Tarea):- haceTarea(Persona, Tarea, _, _), esEstresante(Tarea).

masChapita(Persona):- cantidadTareaEstresantes(Persona, Cantidad), 
forall(cantidadTareaEstresantes(_, OtraCantidad), Cantidad >= OtraCantidad).

cantidadTareaEstresantes(Persona, Cantidad):- persona(Persona), 
findall(Tarea, realizaTareaEstresante(Persona, Tarea), Lista), length(Lista, Cantidad).

persona(Persona):- haceTarea(Persona, _, _, _).




