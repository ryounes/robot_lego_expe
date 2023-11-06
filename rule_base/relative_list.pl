% add at the end of the list
add_tail([],X,[X]) :- !.
add_tail([H|T],X,[H|L]) :- add_tail(T,X,L),!.

% mapping list

% relative to a marker

marker_map_sentence([W1, E1, S1, N1], [W2, E2, S2, N2], Sentence):-
	marker_map_LR([W1, E1, S1, N1], [W2, E2, S2, N2], Sent1),
	marker_map_UD([W1, E1, S1, N1], [W2, E2, S2, N2], Sent2),
	Sentence = [Sent1,Sent2].


% left_right
marker_map_LR([W2, _E1, _S1, _N1], [W2, _E2, _S2, _N2], Sentence):-
	Sentence = 'None_LR',!.

marker_map_LR([W1, _E1, S1, N1], [_W2, E2, S1, N1], Sentence):-
	W1 = E2,
	Sentence = 'side_Ouest',!.

marker_map_LR([_W1, E1, S1, N1], [W2, _E2, S1, N1], Sentence):-
	W2 = E1,
	Sentence = 'side_Est',!.

marker_map_LR([W1, _E1, _S1, _N1], [W2, _E2, _S2, _N2], Sentence):-
	W1 > W2,
	Tmp is W1 - W2,
	atomic_concat('décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Ouest', Sentence),!.

marker_map_LR([W1, _E1, _S1, _N1], [W2, _E2, _S2, _N2], Sentence):-
	W1 < W2,
	Tmp is W2 - W1,
	atomic_concat('décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Est', Sentence),!.


% up_down
marker_map_UD([_W1, _E1, S1, _N1], [_W2, _E2, S1, _N2], Sentence):-
	Sentence = 'None_UD',!.

marker_map_UD([W1, E1, S1, _N1], [W1, E1, _S2, N2], Sentence):-
	S1 = N2,
	Sentence = 'side_Sud',!.

marker_map_UD([W2, E2, _S1, N1], [W2, E2, S2, _N2], Sentence):-
	S2 = N1,
	Sentence = 'side_Nord',!.

marker_map_UD([_W1, _E1, S1, _N1], [_W2, _E2, S2, _N2], Sentence):-
	S1 > S2,
	Tmp is S1 - S2,
	atomic_concat('décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Sud', Sentence),!.

marker_map_UD([_W1, _E1, S1, _N1], [_W2, _E2, S2, _N2], Sentence):-
	S1 < S2,
	Tmp is S2 - S1,
	atomic_concat('décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Nord', Sentence),!.

% corners
map_sentence([_W1, W2, N2, _N1], [W2, _E2, _S2, N2], ['coin_Sud-Est']) :- !.
map_sentence([_W1, W2, _S1, S2], [W2, _E2, S2, _N2], ['coin_Nord-Est']) :- !.
map_sentence([E2, _E1, N2, _N1], [_W2, E2, _S2, N2], ['coin_Sud-Ouest']) :- !.
map_sentence([E2, _E1, _S1, S2], [_W2, E2, S2, _N2], ['coin_Nord-Ouest']) :- !.

map_sentence([W1, E1, S1, N1], [W2, E2, S2, N2], Sentence):-
	map_LR([W1, E1, S1, N1], [W2, E2, S2, N2], Sent1),
	map_UD([W1, E1, S1, N1], [W2, E2, S2, N2], Sent2),
	Sentence = [Sent1,Sent2].


% left_right
map_LR([W2, E2, _S1, _N1], [W2, E2, _S2, _N2], 'None_LR').

map_UD([_W1, _E1, S2, N2], [_W2, _E2, S2, N2], 'None_UD').

map_UD([_W1, _E1, _S1, N1], [_W2, _E2, S2, _N2], Sentence):-
	N1 = S2,
	Sentence = 'coller_Sud_Nord',!.
map_UD([_W1, _E1, S1, _N1], [_W2, _E2, _S2, N2], Sentence):-
	S1 = N2,
	Sentence = 'coller_Nord_Sud',!.


map_LR([W1, E1, _S1, _N1], [W2, E2, _S2, _N2], Sentence):-
	E1 + W1 =:= W2 + E2,
	Sentence = 'centre_North-South',!.

map_UD([_W1, _E1, S1, N1], [_W2, _E2, S2, N2], Sentence):-
	S1 + N1 =:= S2 + N2,
	Sentence = 'centre_East-West',!.

map_LR([_W1, E1, _S1, _N1], [W2, _E2, _S2, _N2], Sentence):-
	E1 = W2,
	Sentence = 'coller_Ouest_Est',!.
map_LR([W1, _E1, _S1, _N1], [_W2, E2, _S2, _N2], Sentence):-
	W1 = E2,
	Sentence = 'coller_Est_Ouest',!.



map_LR([W2, E1, _S1, _N1], [W2, E2, _S2, _N2], Sentence):-
	E1 \= E2,
	Sentence = 'align_Ouest',!.
map_LR([W1, E2, _S1, _N1], [W2, E2, _S2, _N2], Sentence):-
	W1 \= W2,
	Sentence = 'align_Est',!.

map_LR([W1, E1, _S1, _N1], [W2, _E2, _S2, _N2], Sentence):-
	W2 > W1,
	W2 < E1,
	Tmp is W2 - W1,
	atomic_concat('faces_Ouest+décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Est', Sentence),!.

map_LR([W1, E1, _S1, _N1], [_W2, E2, _S2, _N2], Sentence):-
	E2 > W1,
	E2 < E1,
	Tmp is E1 - E2,
	atomic_concat('faces_Est+décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Ouest', Sentence),!.

map_LR([W1, E1, _S1, _N1], [W2, E2, _S2, _N2], Sentence):-
	W2 > W1,
	E2 < E1,
	Tmp is E1 - E2,
	atomic_concat('faces_Est+décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Est', Sentence),!.

map_LR([W1, E1, _S1, _N1], [W2, E2, _S2, _N2], Sentence):-
	W2 < W1,
	E2 > E1,
	Tmp is W1 - W2,
	atomic_concat('faces_Ouest+décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Est', Sentence),!.

map_LR([_W1, E1, _S1, _N1], [W2, _E2, _S2, _N2], Sentence):-
	W2 > E1,
	Tmp is W2 - E1,
	atomic_concat('libre_',Tmp, Tmp2),
	atomic_concat(Tmp2, '_Est', Sentence),!.

map_LR([W1, _E1, _S1, _N1], [_W2, E2, _S2, _N2], Sentence):-
	W1 > E2,
	Tmp is W1 - E2,
	atomic_concat('libre_',Tmp, Tmp2),
	atomic_concat(Tmp2, '_Ouest', Sentence),!.


% up_down

map_UD([_W1, _E1, S2, N1], [_W2, _E2, S2, N2], Sentence):-
	N1 \= N2,
	Sentence = 'align_Sud',!.
map_UD([_W1, _E1, S1, N2], [_W2, _E2, S2, N2], Sentence):-
	S1 \= S2,
	Sentence = 'align_Nord',!.

map_UD([_W1, _E1, S1, N1], [_W2, _E2, S2, _N2], Sentence):-
	S2 > S1,
	S2 < N1,
	Tmp is S2 - S1,
	atomic_concat('faces_Sud+décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Nord', Sentence),!.

map_UD([_W1, _E1, S1, N1], [_W2, _E2, _S2, N2], Sentence):-
	N2 > S1,
	N2 < N1,
	Tmp is N1 - N2,
	atomic_concat('faces_Nord+décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Sud', Sentence),!.

map_UD([_W1, _E1, S1, N1], [_W2, _E2, S2, N2], Sentence):-
	S2 < S1,
	N2 > N1,
	Tmp is N2 - N1,
	atomic_concat('faces_Nord+décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Nord', Sentence),!.

map_UD([_W1, _E1, S1, N1], [_W2, _E2, S2, N2], Sentence):-
	S2 > S1,
	N2 < N1,
	Tmp is S2 - S1,
	atomic_concat('faces_Sud+décalé_', Tmp, Res1),
	atomic_concat(Res1, '_Nord', Sentence),!.

map_UD([_W1, _E1, _S1, N1], [_W2, _E2, S2, _N2], Sentence):-
	S2 > N1,
	Tmp is S2 - N1,
	atomic_concat('libre_',Tmp, Tmp2),
	atomic_concat(Tmp2, '_Nord', Sentence),!.

map_UD([_W1, _E1, S1, _N1], [_W2, _E2, _S2, N2], Sentence):-
	S1 > N2,
	Tmp is S1 - N2,
	atomic_concat('libre_',Tmp, Tmp2),
	atomic_concat(Tmp2, '_Sud', Sentence),!.




% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% calculation the 4 corner positions of an action
% -1 if it is the central marker
get_all_action_positions(Action, [Min_x, Max_x, Min_y, Max_y]):-
	marker(Action, _Pa, _Name),
	Min_x is -1,
	Min_y is -1,
	Max_x is 1,
	Max_y is 1.

get_all_action_positions(Action, [Min_x, Max_x, Min_y, Max_y]):-
	action(Action, Type, _Color, 'East-West', [Px, Py, _Pz], _Task),
	shape(Type, [Dim_x, Dim_y, _Z]),
	Min_x is Px,
	Min_y is Py,
	Max_x is Px + Dim_x,
	Max_y is Py + Dim_y.

get_all_action_positions(Action, [Min_x, Max_x, Min_y, Max_y]):-
	action(Action, Type, _Color, 'North-South', [Px, Py, _Pz], _Task),
	shape(Type, [Dim_y, Dim_x, _Z]),
	Min_x is Px,
	Min_y is Py,
	Max_x is Px + Dim_x,
	Max_y is Py + Dim_y.

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

min(A,B, Res):-
	A < B,
	Res is A.

min(A,B, Res):-
	A = B,
	Res is A.

min(A,B, Res):-
	A > B,
	Res is B.

max(A,B, Res):-
	A >= B,
	Res is A.

max(A,B, Res):-
	A < B,
	Res is B.

% calculation the 4 corner convex positions of a task


get_all_task_positions(Subs, [Min_x, Max_x, Min_y, Max_y]):-
	get_min_x(Subs, Min_x),
	get_max_x(Subs, Max_x),
	get_min_y(Subs, Min_y),
	get_max_y(Subs, Max_y).

get_min_x([X], Min_x):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	Min_x = Act_min_x1,!.

get_min_x([X,Y], Min_x):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	min(Act_min_x1, Act_min_x2, Min_x),!.

get_min_x([X,Y|Subs], Min_x):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	Act_min_x1 < Act_min_x2, 
	get_min_x([X|Subs], Min_x).

get_min_x([X,Y|Subs], Min_x):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	Act_min_x1 >= Act_min_x2, 
	get_min_x([Y|Subs], Min_x).


get_max_x([X], Max_x):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	Max_x = Act_max_x1,!.

get_max_x([X,Y], Max_x):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	max(Act_max_x1, Act_max_x2, Max_x),!.

get_max_x([X,Y|Subs], Max_x):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	Act_max_x1 < Act_max_x2, 
	get_max_x([Y|Subs], Max_x).

get_max_x([X,Y|Subs], Max_x):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	Act_max_x1 >= Act_max_x2, 
	get_max_x([X|Subs], Max_x).



get_min_y([X], Min_y):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	Min_y = Act_min_y1,!.

get_min_y([X,Y], Min_y):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	min(Act_min_y1, Act_min_y2, Min_y),!.

get_min_y([X,Y|Subs], Min_y):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	Act_min_y1 < Act_min_y2, 
	get_min_y([X|Subs], Min_y).

get_min_y([X,Y|Subs], Min_y):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	Act_min_y1 >= Act_min_y2, 
	get_min_y([Y|Subs], Min_y).


get_max_y([X], Max_y):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	Max_y = Act_max_y1,!.

get_max_y([X,Y], Max_y):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	max(Act_max_y1, Act_max_y2, Max_y),!.

get_max_y([X,Y|Subs], Max_y):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	Act_max_y1 < Act_max_y2, 
	get_max_y([Y|Subs], Max_y).

get_max_y([X,Y|Subs], Max_y):-
	get_all_action_positions(X, [Act_min_x1, Act_max_x1, Act_min_y1, Act_max_y1]),
	get_all_action_positions(Y, [Act_min_x2, Act_max_x2, Act_min_y2, Act_max_y2]),
	Act_max_y1 >= Act_max_y2, 
	get_max_y([X|Subs], Max_y).




% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

relative_list(Action, -1, List):-
	get_all_action_positions(-1, [W1, E1, S1, N1]),
	get_all_action_positions(Action, [W2, E2, S2, N2]),
	marker_map_sentence([W1, E1, S1, N1], [W2, E2, S2, N2], Sentence),
	add_tail(Sentence, -1, List),!.


relative_list(Action, Rel_Action, List):-
	Rel_Action \= -1,
	get_all_action_positions(Rel_Action, [W1, E1, S1, N1]),
	get_all_action_positions(Action, [W2, E2, S2, N2]),
	map_sentence([W1, E1, S1, N1], [W2, E2, S2, N2], Sentence),
	add_tail(Sentence, Rel_Action, List),!.

