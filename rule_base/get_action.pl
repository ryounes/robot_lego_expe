
% adding the data from the world _ current stat3


% % % % % % % % % % % % % % % % % % % %
% allMembers(L1,L2) checks if all elements of L1 are available in L2
% solve the sub_problem
isMemberOf(X,[X|_]):-!.
isMemberOf(X,[_|T]):- isMemberOf(X,T).

% iterate through 'L1' and ask if the member exists in 'L2'
allMembers([],_).
allMembers([H|T],L):- allMembers(T,L), isMemberOf(H,L).
% % % % % % % % % % % % % % % % % % % %
% add at the end of the list
add_tail([],X,[X]) :- !.
add_tail([H|T],X,[H|L]) :- add_tail(T,X,L),!.
% % % % % % % % % % % % % % % % % % % %
% get the intersection between two lists
inter([], _, []).

inter([H1|T1], L2, [H1|Res]) :-
    member(H1, L2),
    inter(T1, L2, Res).

inter([_|T1], L2, Res) :-
    inter(T1, L2, Res).
% % % % % % % % % % % % % % % % % % % %


% checking if the task is applicable in terms of visibility
task_applicable(Agent, Task) :- 
	before(Agent, Task, B4),
	all_completed_tasks(Comp_T),
	allMembers(B4, Comp_T).

% checking if the action is applicable
action_applicable(Action) :-
	precedency_tree(Action, Precd),
	all_applied_actions(App),
	allMembers(Precd, App).

% getting the list of all applicable (nonApplied) actions
get_all_applicable(Who, X) :- 
	agent(Who, _),
	reachable_actions(Who, Pend1),
	pending_actions(Pend2),
	inter(Pend1, Pend2, Res),
	get_applicable(Who, X, Res).

get_applicable(Who, [X|Apps],[X|Pend]):-
	action(X, _Type, _Color, _How, _Pos, Last_Task),
	action_applicable(X),
	task_applicable(Who, Last_Task),!,
	get_applicable(Who, Apps,Pend).

get_applicable(Who, Applicable,[X|Pend]):-
	action(X, _Type, _Color, _How, _Pos, _Last_Task),
	not(action_applicable(X)),!,
	get_applicable(Who, Applicable,Pend).

get_applicable(Who, Applicable,[X|Pend]):-
	action(X, _Type, _Color, _How, _Pos, Last_Task),
	not(task_applicable(Who, Last_Task)),!,
	get_applicable(Who, Applicable,Pend).

get_applicable(_Who, _Apps,[]):-!.

% getting the distance in XY axes
distance([X1,Y1,_Z1],[X2,Y2,_Z2],Dist) :- 
	Dist is sqrt((X2-X1)^2 + (Y2-Y1)^2).





% getting the closest action to the center
closest_to_center(Who, Action_List) :- 
	get_all_applicable(Who, All_applicable),
	get_closest(All_applicable, [0,0,0], _Recursive, Action_List).

% getting the closest action to previous
closest_to_previous(Who, Action_List, Last_action) :- 
	get_all_applicable(Who, All_applicable),
	action(Last_action, _Type, _Color, _How, Pos, _Last_Task),
	get_closest(All_applicable, Pos, _Recursive, Action_List).


% getting the closest action to previoius searching in the same task
closest_to_previous_inTask(Who, Action_List, Last_action) :- 
	action(Last_action, _Type, _Color, _How, Pos, Last_Task),
	get_all_applicable(Who, L1),
	hierarchy(Last_Task,L2),
	inter(L1,L2,All_applicable),
	get_closest(All_applicable, Pos, _Recursive, Action_List).




% given a list and XY coordonates, find the action closest to this one 

get_closest([], _POS, Minimums, Minimums):- 
	var(Minimums),
	Minimums = [-1],!.

get_closest([], _POS, Minimums, Minimums):- 
	nonvar(Minimums),!.

get_closest([A],POS, Action_List, Result):-
	add_tail(Action_List, A, Minimums),!,
	get_closest([],POS,Minimums, Result).

get_closest([A,B|Rest],POS, Action_List, Result):-
	action(A, _TypeA, _ColorA, _HowA, PosA, _Last_TaskA),
	action(B, _TypeB, _ColorB, _HowB, PosB, _Last_TaskB),
	distance(POS,PosA,Da),
	distance(POS,PosB,Db),
	Da = Db,
	add_tail(Action_List, B, Minimums),!,
	get_closest([A|Rest],POS,Minimums, Result).

get_closest([A,B|Rest],POS, Action_List, Result):-
	action(A, _TypeA, _ColorA, _HowA, PosA, _Last_TaskA),
	action(B, _TypeB, _ColorB, _HowB, PosB, _Last_TaskB),
	distance(POS,PosA,Da),
	distance(POS,PosB,Db),
	Da < Db,!,
	get_closest([A|Rest],POS,Action_List, Result).

get_closest([A,B|Rest],POS, Action_List, Result):-
	action(A, _TypeA, _ColorA, _HowA, PosA, _Last_TaskA),
	action(B, _TypeB, _ColorB, _HowB, PosB, _Last_TaskB),
	distance(POS,PosA,Da),
	distance(POS,PosB,Db),
	Db < Da,
	Action_List = [],!,
	get_closest([B|Rest],POS,Action_List, Result).

% % % % % % % % % % % % % % % % % % % %

% given a list and XY coordonates, find the action furthest to this one 

get_furthest([], _POS, Minimums, Minimums):- 
	var(Minimums),
	Minimums = [-1],!.

get_furthest([], _POS, Minimums, Minimums):- 
	nonvar(Minimums),!.

get_furthest([A],POS, Action_List, Result):-
	add_tail(Action_List, A, Minimums),!,
	get_furthest([],POS,Minimums, Result).

get_furthest([A,B|Rest],POS, Action_List, Result):-
	action(A, _TypeA, _ColorA, _HowA, PosA, _Last_TaskA),
	action(B, _TypeB, _ColorB, _HowB, PosB, _Last_TaskB),
	distance(POS,PosA,Da),
	distance(POS,PosB,Db),
	Da = Db,
	add_tail(Action_List, B, Minimums),!,
	get_furthest([A|Rest],POS,Minimums, Result).

get_furthest([A,B|Rest],POS, Action_List, Result):-
	action(A, _TypeA, _ColorA, _HowA, PosA, _Last_TaskA),
	action(B, _TypeB, _ColorB, _HowB, PosB, _Last_TaskB),
	distance(POS,PosA,Da),
	distance(POS,PosB,Db),
	Da > Db,!,
	get_furthest([A|Rest],POS,Action_List, Result).

get_furthest([A,B|Rest],POS, Action_List, Result):-
	action(A, _TypeA, _ColorA, _HowA, PosA, _Last_TaskA),
	action(B, _TypeB, _ColorB, _HowB, PosB, _Last_TaskB),
	distance(POS,PosA,Da),
	distance(POS,PosB,Db),
	Db > Da,
	Action_List = [],!,
	get_furthest([B|Rest],POS,Action_List, Result).

% % % % % % % % % % % % % % % % % % % %

% getting the furthest action from the agent
furthest_to_agent(Who, Action_List):-
	get_all_applicable(Who, All_applicable),
	agent(Who, Pos),
	get_furthest(All_applicable, Pos, _Recursive, Action_List).


% % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % %

% this is to get the next action 
% if it is the first action
get_action(Agent, Action_List, -1) :- 
	applied_actions(Agent, []), 
	closest_to_center(Agent, Action_List),!.


% else 
% this is the second action 
get_action(Agent, Action_List, Last_action) :- 
	first_action([Last_action]),
	all_applied_actions([Last_action]),
	furthest_to_agent(Agent, Action_List),!.


% if prev task was not done
get_action(Agent, Action_List, Last_action) :- 
	applied_actions(Agent, [Last_action|Rest]),
	action(Last_action, _Type, _Color, _How, _Pos, Last_Task),
	hierarchy(Last_Task,Subs),
	not(allMembers(Subs, [Last_action|Rest])),
	closest_to_previous_inTask(Agent, Action_List, Last_action),!.


% else

get_action(Agent, Action_List, Last_action) :- 
	applied_actions(Agent, [Last_action|Rest]),
	action(Last_action, _Type, _Color, _How, _Pos, Last_Task),
	hierarchy(Last_Task,Subs),
	allMembers(Subs, [Last_action|Rest]),
	furthest_to_agent(Agent, Action_List),!.

	% closest_to_previous(Agent, Action_List, Last_action),!.

% % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % %











