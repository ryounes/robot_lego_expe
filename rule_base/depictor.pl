% once we have the action
% we check the styles
% generate the "how_where" variants

% adding the available styles
:-include('style.pl').
:-include('context.pl').

% a description of how to place an object vis_a_vis the old one
:-include('relative_list.pl').

% % % % % % % % % % % % % % % % % % % %
% add at the end of the list
add_tail([],X,[X]) :- !.
add_tail([H|T],X,[H|L]) :- add_tail(T,X,L),!.

% add at the beginning of the list
add_head(Tail, Head, [Head| Tail]).
% % % % % % % % % % % % % % % % % % % %



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % %
% depict_absolute_x
depict_absolute_x(Action, Sentence):-
	action(Action, _Type, _Color, _How, [Px, _Py, _Pz], _Last_Task),
	Px =< 0,
	table_x(Size_x),
	Free is Size_x + Px,
	atomic_concat('W', Free, Sentence).

depict_absolute_x(Action, Sentence):-
	action(Action, Type, _Color, 'East-West', [Px, _Py, _Pz], _Last_Task),
	shape(Type, [X,_Y,_Z]),
	Px > 0,
	table_x(Size_x),
	Free is Size_x - Px - X,
	atomic_concat('E', Free, Sentence).

depict_absolute_x(Action, Sentence):-
	action(Action, Type, _Color, 'North-South', [Px, _Py, _Pz], _Last_Task),
	shape(Type, [_Y,X,_Z]),
	Px > 0,
	table_x(Size_x),
	Free is Size_x - Px - X,
	atomic_concat('E', Free, Sentence).

% depict_absolute_y
depict_absolute_y(Action, Sentence):-
	action(Action, _Type, _Color, _How, [_Px, Py, _Pz], _Last_Task),
	Py =< 0,
	table_y(Size_y),
	Free is Size_y + Py,
	atomic_concat('S', Free, Sentence).

depict_absolute_y(Action, Sentence):-
	action(Action, Type, _Color, 'East-West', [_Px, Py, _Pz], _Last_Task),
	shape(Type, [_X,Y,_Z]),
	Py > 0,
	table_y(Size_y),
	Free is Size_y - Py - Y,
	atomic_concat('N', Free, Sentence).

depict_absolute_y(Action, Sentence):-
	action(Action, Type, _Color, 'North-South', [_Px, Py, _Pz], _Last_Task),
	shape(Type, [Y,_X,_Z]),
	Py > 0,
	table_y(Size_y),
	Free is Size_y - Py - Y,
	atomic_concat('N', Free, Sentence).
% % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % %

% getting the distance in XY axes
distance([X1,Y1,_Z1],[X2,Y2,_Z2],Dist) :- 
	Dist is sqrt((X2-X1)^2 + (Y2-Y1)^2).

% % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % %

get_best_rel_task(Action, [], Best_rel_task, Best_rel_task):-
	var(Best_rel_task),
	Best_rel_task = [-1],!.

get_best_rel_task(Action, [], Best_rel_task, Best_rel_task):-
	nonvar(Best_rel_task),!.

get_best_rel_task(Action, [A], [], Best_rel_task):-
	add_tail([], A, Minimums),!,
	get_best_rel_task(Action, [], Minimums, Best_rel_task),!.

get_best_rel_task(Action, [A], [B], Best_rel_task):-
	hierarchy(A, Subs1),
	get_all_task_positions(Subs1, [W1, E1, S1, N1]),
	T1_x is (E1 + W1)/2,
	T1_y is (N1 + S1)/2,

	hierarchy(B, Subs2),
	get_all_task_positions(Subs2, [W2, E2, S2, N2]),
	T2_x is (E2 + W2)/2,
	T2_y is (N2 + S2)/2,

	action(Action, Rel_Type, _Rel_Color, _Rel_How, [Px, Py, _Pz], _Task),
	shape(Rel_Type,[Dimx,Dimy,Dimz]),
	Ax is Dimx/2 + Px,
	Ay is Dimy/2 + Py,
	
	distance([T1_x, T1_y, _Z1], [Ax, Ay, _Pz], D1),
	distance([T2_x, T2_y, _Z2], [Ax, Ay, _Pz], D2),

	D1 < D2,
	get_best_rel_task(Action, [], [A], Best_rel_task),!.


get_best_rel_task(Action, [A], [B], Best_rel_task):-
	hierarchy(A, Subs1),
	get_all_task_positions(Subs1, [W1, E1, S1, N1]),
	T1_x is (E1 + W1)/2,
	T1_y is (N1 + S1)/2,

	hierarchy(B, Subs2),
	get_all_task_positions(Subs2, [W2, E2, S2, N2]),
	T2_x is (E2 + W2)/2,
	T2_y is (N2 + S2)/2,

	action(Action, Rel_Type, _Rel_Color, _Rel_How, [Px, Py, _Pz], _Task),
	shape(Rel_Type,[Dimx,Dimy,Dimz]),
	Ax is Dimx/2 + Px,
	Ay is Dimy/2 + Py,
	
	distance([T1_x, T1_y, _Z1], [Ax, Ay, _Pz], D1),
	distance([T2_x, T2_y, _Z2], [Ax, Ay, _Pz], D2),

	D1 = D2,
	get_best_rel_task(Action, [], [B], Best_rel_task),!.



get_best_rel_task(Action, [A], [B], Best_rel_task):-
	hierarchy(A, Subs1),
	get_all_task_positions(Subs1, [W1, E1, S1, N1]),
	T1_x is (E1 + W1)/2,
	T1_y is (N1 + S1)/2,

	hierarchy(B, Subs2),
	get_all_task_positions(Subs2, [W2, E2, S2, N2]),
	T2_x is (E2 + W2)/2,
	T2_y is (N2 + S2)/2,

	action(Action, Rel_Type, _Rel_Color, _Rel_How, [Px, Py, _Pz], _Task),
	shape(Rel_Type,[Dimx,Dimy,Dimz]),
	Ax is Dimx/2 + Px,
	Ay is Dimy/2 + Py,
	
	distance([T1_x, T1_y, _Z1], [Ax, Ay, _Pz], D1),
	distance([T2_x, T2_y, _Z2], [Ax, Ay, _Pz], D2),

	D1 > D2,
	get_best_rel_task(Action, [], [B], Best_rel_task),!.

get_best_rel_task(Action, [A,B|Rest], Action_List, Best_rel_task):-
	hierarchy(A, Subs1),
	get_all_task_positions(Subs1, [W1, E1, S1, N1]),
	T1_x is (E1 + W1)/2,
	T1_y is (N1 + S1)/2,

	hierarchy(B, Subs2),
	get_all_task_positions(Subs2, [W2, E2, S2, N2]),
	T2_x is (E2 + W2)/2,
	T2_y is (N2 + S2)/2,

	action(Action, Rel_Type, _Rel_Color, _Rel_How, [Px, Py, _Pz], _Task),
	shape(Rel_Type,[Dimx,Dimy,Dimz]),
	Ax is Dimx/2 + Px,
	Ay is Dimy/2 + Py,
	
	distance([T1_x, T1_y, _Z1], [Ax, Ay, _Pz], D1),
	distance([T2_x, T2_y, _Z2], [Ax, Ay, _Pz], D2),

	D1 = D2,

	% #add_tail(Action_List, B, Minimums),!,
	get_best_rel_task(Action, [A|Rest], Minimums, Best_rel_task),!.

get_best_rel_task(Action, [A,B|Rest], Action_List, Best_rel_task):-
	hierarchy(A, Subs1),
	get_all_task_positions(Subs1, [W1, E1, S1, N1]),
	T1_x is (E1 + W1)/2,
	T1_y is (N1 + S1)/2,

	hierarchy(B, Subs2),
	get_all_task_positions(Subs2, [W2, E2, S2, N2]),
	T2_x is (E2 + W2)/2,
	T2_y is (N2 + S2)/2,

	action(Action, Rel_Type, _Rel_Color, _Rel_How, [Px, Py, _Pz], _Task),
	shape(Rel_Type,[Dimx,Dimy,Dimz]),
	Ax is Dimx/2 + Px,
	Ay is Dimy/2 + Py,
	
	distance([T1_x, T1_y, _Z1], [Ax, Ay, _Pz], D1),
	distance([T2_x, T2_y, _Z2], [Ax, Ay, _Pz], D2),

	D1 > D2,

	Action_List = [],!,
	get_best_rel_task(Action, [B|Rest], Action_List, Best_rel_task),!.

get_best_rel_task(Action, [A,B|Rest], Action_List, Best_rel_task):-
	hierarchy(A, Subs1),
	get_all_task_positions(Subs1, [W1, E1, S1, N1]),
	T1_x is (E1 + W1)/2,
	T1_y is (N1 + S1)/2,

	hierarchy(B, Subs2),
	get_all_task_positions(Subs2, [W2, E2, S2, N2]),
	T2_x is (E2 + W2)/2,
	T2_y is (N2 + S2)/2,

	action(Action, Rel_Type, _Rel_Color, _Rel_How, [Px, Py, _Pz], _Task),
	shape(Rel_Type,[Dimx,Dimy,Dimz]),
	Ax is Dimx/2 + Px,
	Ay is Dimy/2 + Py,
	
	distance([T1_x, T1_y, _Z1], [Ax, Ay, _Pz], D1),
	distance([T2_x, T2_y, _Z2], [Ax, Ay, _Pz], D2),

	D1 < D2,
	get_best_rel_task(Action, [A|Rest], Action_List, Best_rel_task),!.



% % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % %

get_best_LR_task(Action, [], Action_List, Best_rel_task):-fail,!.

get_best_LR_task(Action, [A|Rest], Action_List, A) :-
	hierarchy(A, Subs1),
	get_all_task_positions(Subs1, [W1, E1, S1, N1]),

	get_all_action_positions(Action, [W2, E2, S2, N2]),

	map_LR([W1, E1, S1, N1], [W2, E2, S2, N2], List),

	(member('align_Ouest', [List]); member('align_Est', [List]); member('coller_Est_Ouest', [List]); member('coller_Ouest_Est', [List])),!.

get_best_LR_task(Action, [A|Rest], Action_List, Best_rel_task):-
	get_best_LR_task(Action, Rest, Action_List, Best_rel_task),!.

% % % % % % % % % % % % % % % % % % % %

get_best_UD_task(Action, [], Action_List, Best_rel_task):-fail,!.

get_best_UD_task(Action, [A|Rest], Action_List, A):-
	hierarchy(A, Subs1),
	get_all_task_positions(Subs1, [W1, E1, S1, N1]),

	get_all_action_positions(Action, [W2, E2, S2, N2]),

	map_UD([W1, E1, S1, N1], [W2, E2, S2, N2], List),

	(member('align_Nord', [List]); member('align_Sud', [List]); member('coller_Sud_Nord', [List]); member('coller_Nord_Sud', [List])),!.

get_best_UD_task(Action, [A|Rest], Action_List, Best_rel_task):-
	get_best_UD_task(Action, Rest, Action_List, Best_rel_task),!.




% % % % % % % % % % % % % % % % % % % %
% depict
% % % % % % % % % % % % % % % % % % % %
% absolute
depict(Action, _Relative, absolute, _Context, Sentence):-
	style(absolute),
	depict_absolute_x(Action, Sx),
	depict_absolute_y(Action, Sy),
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], _Task),
	atomic_concat('L', Pz, Res),
	add_head([], Res, A),
	add_head(A, Sy, B),
	add_head(B, Sx, Sentence).
% % % % % % % % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % %
% realtive to structure

% only way it to do it when changing a task and positionning on the floor
depict(Action, Rel_Action, relative, with, Sentence):-
	context(with),
	style(relative),
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], Task),
	task(Task, _name2, _info2, _How2),
	Pz = 0,
	action(Rel_Action, _Rel_Type, _Rel_Color, _Rel_How, [_Rel_Px, _Rel_Py, _Rel_Pz], Last_Task),
	task(Last_Task, _name1, _info1, _How1),
	Last_Task \= Task,

	all_completed_tasks(Best_rel_task),
	length(Best_rel_task,1),
	
	Best_rel_task = [Only_one],

	hierarchy(Only_one, Subs),
	get_all_task_positions(Subs, [W1, E1, S1, N1]),
	get_all_action_positions(Action, [W2, E2, S2, N2]),

	map_sentence([W1, E1, S1, N1], [W2, E2, S2, N2], List),
	add_tail(List, Only_one, Sentence),!.


depict(Action, Rel_Action, relative, with, Sentence):-
	context(with),
	style(relative),
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], Task),
	task(Task, _name2, _info2, _How2),
	Pz = 0,
	action(Rel_Action, _Rel_Type, _Rel_Color, _Rel_How, [_Rel_Px, _Rel_Py, _Rel_Pz], Last_Task),
	task(Last_Task, _name1, _info1, _How1),
	Last_Task \= Task,

	all_completed_tasks(Comp_tasks),
	length(Comp_tasks,Length),
	Length > 1,
	
	get_best_rel_task(Action, Comp_tasks, _Best_rel_task, [Best_rel_task]),
	
	hierarchy(Best_rel_task, Subs),
	get_all_task_positions(Subs, [W1, E1, S1, N1]),
	get_all_action_positions(Action, [W2, E2, S2, N2]),

	map_sentence([W1, E1, S1, N1], [W2, E2, S2, N2], List),

	(member('centre_North-West', List); member('centre_East-West', List)),

	add_tail(List, Best_rel_task, Sentence),!.


depict(Action, Rel_Action, relative, with, Sentence):-
	context(with),
	style(relative),
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], Task),
	task(Task, _name2, _info2, _How2),
	Pz = 0,
	action(Rel_Action, _Rel_Type, _Rel_Color, _Rel_How, [_Rel_Px, _Rel_Py, _Rel_Pz], Last_Task),
	task(Last_Task, _name1, _info1, _How1),
	Last_Task \= Task,

	all_completed_tasks(Comp_tasks),
	length(Comp_tasks,Length),
	Length > 1,
	
	get_best_UD_task(Action, Comp_tasks, _Best_rel_task_UD, Best_rel_task_UD),
	get_best_LR_task(Action, Comp_tasks, _Best_rel_task_LR, Best_rel_task_LR),
	
	hierarchy(Best_rel_task_UD, Subs_UD),
	get_all_task_positions(Subs_UD, [W1_UD, E1_UD, S1_UD, N1_UD]),
	hierarchy(Best_rel_task_LR, Subs_LR),
	get_all_task_positions(Subs_LR, [W1_LR, E1_LR, S1_LR, N1_LR]),

	get_all_action_positions(Action, [W2, E2, S2, N2]),

	map_LR([W1_LR, E1_LR, S1_LR, N1_LR], [W2, E2, S2, N2], Sent1),
	map_UD([W1_UD, E1_UD, S1_UD, N1_UD], [W2, E2, S2, N2], Sent2),
	Sentence = [Sent1, Best_rel_task_LR, Sent2, Best_rel_task_UD],!.

depict(Action, Rel_Action, relative, with, Sentence):-
	context(with),
	style(relative),
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], Task),
	task(Task, _name2, _info2, _How2),
	Pz = 0,
	action(Rel_Action, _Rel_Type, _Rel_Color, _Rel_How, [_Rel_Px, _Rel_Py, _Rel_Pz], Last_Task),
	task(Last_Task, _name1, _info1, _How1),
	Last_Task \= Task,

	all_completed_tasks(Comp_tasks),
	length(Comp_tasks,Length),
	Length > 1,
	
	get_best_rel_task(Action, Comp_tasks, _Best_rel_task, [Best_rel_task]),
	
	hierarchy(Best_rel_task, Subs),
	get_all_task_positions(Subs, [W1, E1, S1, N1]),
	get_all_action_positions(Action, [W2, E2, S2, N2]),

	map_sentence([W1, E1, S1, N1], [W2, E2, S2, N2], List),

	add_tail(List, Best_rel_task, Sentence),!.

% % % % % % % % % % % % % % % % % % % %


% % % % % % % % % % % % % % % % % % % %
% relative to element
depict(Action, Rel_Action, relative, _Context, Sentence):-
	style(relative),
	Rel_Action = -1,
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], _Task),
	relative_list(Action, Rel_Action, Sentence).

depict(Action, Rel_Action, relative, _Context, Sentence):-
	style(relative),
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], _Task),
	Pz = 0,
	action(Rel_Action, _Rel_Type, _Rel_Color, _Rel_How, [_Rel_Px, _Rel_Py, _Rel_Pz], _Last_Task),
	relative_list(Action, Rel_Action, Sentence),!.

% same level reletive to previous
depict(Action, Rel_Action, relative, _Context, Sentence):-
	style(relative),
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], _Task),
	action(Rel_Action, _Type1, _Color1, _How1, [_Px1, _Py1, Pz], _Task1),
	relative_list(Action, Rel_Action, Sentence),!.
% same level reletive to previous

depict(Action, _Rel_Action, relative, _Context, Sentence):-
	style(relative),
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], _Task),
	Pz \= 0,
	precedency_tree(Action, [X]),
	add_head([X], 'above', Sentence).

depict(Action, _Rel_Action, relative, _Context, Sentence):-
	style(relative),
	action(Action, _Type, _Color, _How, [_Px, _Py, Pz], _Task),
	Pz \= 0,
	precedency_tree(Action, [A,B|List]),
	add_head([A,B|List], 'covering', Sentence).
% % % % % % % % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % %
% topographical
depict(_Action, _Relative, topographical, _Context, Sentence):-
	style(topographical),
	Sentence = 'Not yet Implemented'.
% % % % % % % % % % % % % % % % % % % %
