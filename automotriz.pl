%   declaracion de librerias para utilizar interfaz gráfica
:-use_module(library(pce)).
:-use_module(library(pce_style_item)).

%   Iniciar la interfaz grafica.
%   Botones, labels, y su posición dentro del dialog en pantalla.
inicio:-
%   Declaración
	new(Menu, dialog('Diagnostico Automotriz (Main Menu)', size(1000,1000))),
	new(L,label(nombre,'DA-LJRP v1.00.09')),
	new(@texto,label(nombre,'Realiza un nuevo diagnóstico para continuar')),
	new(@boton,button('realizar diagnóstico',message(@prolog,botones))),
	new(A,label(nombre,'Luis José Ruano Pérez 2690-12-4853')),
	new(Salir,button('SALIR',and(message(Menu, destroy),message(Menu,free)))),
	new(@respl,label(nombre,'')),

%   Posicionamiento
%   Se posicionaron dos elementos en x a 350 ya que el dialog no valida el size establecido, entonces esto alarga la ventana.
	send(Menu,append(L)),new(@btncarrera,button('¿Diagnostico?')),
	send(Menu,display,L,point(350,20)),
	send(Menu,display,A,point(40,360)),
	send(Menu,display,@texto,point(20,100)),
	send(Menu,display,@boton,point(85,150)),
	send(Menu,display,Salir,point(350,400)),
	send(Menu,display,@respl,point(20,130)),
	send(Menu,open).

%   Soluciones a las fallas de acuerdo a los resultados del diagnóstico

fallas('Cambio de Suspesión:
        El cambio de suspesión debe ser realizado en un taller,
        en el cual se deberá realizar el chequeo respectivo de
        amortiguadores.
        Esto es la razón también del desgaste anormal de llantas.'):-suspension,!.

fallas('Cambio de Aceite:
	1) Enciende el carro durante 5 o 10 minutos y luego apágalo.
	2) Encuentra el tapón de vaciado de aceite (debajo del propio motor).
	3) Situa un recipiente lo suficientemente grande debajo del tapón de vaciado (para no regar el aceite).
	4) Quita el tapón del vaciado.
	5) Deja salir todo el aceite del motor.
	6) Busca y quita el filtro de aceite.
	7) Lubrica el nuevo filtro y sustituye el anterior.
	8) Coloca de nuevo el tapón de vaciado.
	9) Busca el tapón de llenado de aceite (encima del motor, dentro del capo)
	10) LLena el deposito de aceite con aceite nuevo y limpio.'):-aceite,!.

fallas('verificar el estado actual de la bateria:
	primero abra el cofre y ubique la bateria del coche
        verifique si estan bien conctados los cables, arranque
	el coche, si no arranca entonces la bateria esta muerta
	para esto recarguela pase corriente con otro coche,
	en caso de no tener exito debera reemplazar la bateria'):-electronico,!.

fallas('llego la hora de cambiar tus pastillas de freno:
	si se escucha un chillido agudo al frenar es tiempo
        de cambiar las pastillas de los frenos, para ello hay
	que levantar con un gato hidraulico el lado del freno
	donde se va a cambiar, con una llave inglesa y una
	matraca aflojar los cubre pastillas y sacar las patillas
	antiguas y reponerlas con las nuevas, colocar todo en su
	lugar y bla bla bla. '):-frenos,!.

fallas('posiblemente tu auto pasara a mejor vida:
	esta luz puede indicar varias fallas en el sistema de la ECU,
	las pricipales son fallas de sensores, servicio de motor,
	catalizador, etc. si se cuenta con un escaner automotriz puede
	borrarse la falla pero esto no arregla el problema, para ello
	acuda con su mecanico certificado por los aliens.'):-computadora,!.

fallas('seguro subes demaciado el volumen:
	primero debes ubicar la bocina que no se escucha despues
        quitar o desatornillar el caparcete que protege la bocina
	y verificar que la bocina este bien conectado o tenga un cable
	quemado, dado uno de los casos deberas cambiar el cable
	o remplazar la bocina. Otro caso es verificar el estereo
	del auto si estan bien conectados los cables'):-sonido,!.


fallas('sin resultados! si los problemas persisten utilice un dispositivo
	alienigena con mas ram y 12 nucleos cpu:/').

% Preguntas para resolver los posibles problemas o fallas.
% falla
    %   Serie de preguntas
suspension:- revision_suspension,
	pregunta('¿Tiene problemas con sus frenos?'),
	pregunta('¿Existe rebote excesivo del carro?'),
	pregunta('¿Tiene su volante neutral y el auto gira?'),
	pregunta('¿Existe un desgaste anormal de las llantas? '),
	pregunta('¿El volante se mueve bastante y tiembla?').

frenos:- cambio_frenos,
	pregunta('¿Tiene problemas con sus frenos?'),
	pregunta('Cuando se frena ¿El carro hace un chillido?'),
	pregunta('¿Al frenar el carro demora en desacelerar? ').

aceite:- cambio_aceite,
	pregunta('¿Problemas de motor?'),
	pregunta('¿Su carro gasta más gasolina de lo debido?'),
	pregunta('¿El motor de su carro tiene menos fuerza que antes? '),
	pregunta('¿Su motor se escucha muy ruidoso? '),
	pregunta('¿Tiene problemas para arrancar el carro en frio?').

electronico:- bateria_agotada,
	pregunta('¿Problemas eléctricos?'),
	pregunta('¿Los silvines alumbran con poca fuerza?'),
	pregunta('¿El tablero no enciende?'),
	pregunta('¿El carro hace un sonido crackeante cuando enciende?'),
	pregunta('¿El auto no hace ningun tipo de sonido al girar la llave?'),
	pregunta('¿La bocina del carro suena baja o no suena?').


computadora:- check_egine,
	pregunta('la luz check egine se encendio en tu tablero?'),
	pregunta('la luz se mantiene encendida todo el tiempo?').

sonido:- cambio_bocina,
	pregunta('tienes problemas con alguna bocina?'),
	pregunta('la bocina no se escucha nada?'),
	pregunta('tu auto tiene suficiente bateria?').

%identificador de falla que dirige a las preguntas correspondientes

revision_suspension:-pregunta('¿Tiene problemas con sus frenos?'),!.
cambio_frenos:-pregunta('¿Tiene problemas con sus frenos?'),!.
cambio_aceite:-pregunta('¿Problemas de motor?'),!.
bateria_agotada:-pregunta('¿Problemas electricos?'),!.
cambio_bocina:-pregunta('tienes problemas con alguna bocina?'),!.
check_egine:-pregunta('la luz check egine se encendio en tu tablero?'),!.

% proceso del diagnostico basado en preguntas de si y no, cuando el
% usuario dice si, se pasa a la siguiente pregunta del mismo ramo, si
% dice que no se pasa a la pregunta del siguiente ramo
% (motor,frenos,etc.)

:-dynamic si/1,no/1.
preguntar(Problema):- new(Di,dialog('Diagnostico mecanico')),
     new(L2,label(texto,'Responde las siguientes preguntas')),
     new(La,label(prob,Problema)),
     new(B1,button(si,and(message(Di,return,si)))),
     new(B2,button(no,and(message(Di,return,no)))),

         send(Di,append(L2)),
	 send(Di,append(La)),
	 send(Di,append(B1)),
	 send(Di,append(B2)),

	 send(Di,default_button,si),
	 send(Di,open),get(Di,confirm,Answer),
	 write(Answer),send(Di,destroy),
	 ((Answer==si)->assert(si(Problema));
	 assert(no(Problema)),fail).

% cada vez que se conteste una pregunta la pantalla se limpia para
% volver a preguntar

pregunta(S):-(si(S)->true; (no(S)->false; preguntar(S))).
limpiar :- retract(si(_)),fail.
limpiar :- retract(no(_)),fail.
limpiar.

% proceso de eleccion de acuerdo al diagnostico basado en las preguntas
% anteriores

botones :- lim,
	send(@boton,free),
	send(@btncarrera,free),
	fallas(Falla),
	send(@texto,selection('la solucion es ')),
	send(@respl,selection(Falla)),
	new(@boton,button('inicia procedimiento mecanico',message(@prolog,botones))),
        send(Menu,display,@boton,point(40,50)),
        send(Menu,display,@btncarrera,point(20,50)),
limpiar.
lim :- send(@respl, selection('')).
