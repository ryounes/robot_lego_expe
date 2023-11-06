:- dynamic(shape/2).
:- dynamic(table_x/1).
:- dynamic(table_y/1).
:- dynamic(marker/3).
:- dynamic(num_of_agents/1).
:- dynamic(agent/2).
:- dynamic(reachable_actions/2).
:- dynamic(completed_tasks/2).
:- dynamic(applied_actions/2).
:- dynamic(all_applied_actions/1).
:- dynamic(all_completed_tasks/1).
:- dynamic(pending_actions/1).
:- dynamic(observed/4).
:- dynamic(plan_done/1).
:- dynamic(action/6).
:- dynamic(task/4).
:- dynamic(hierarchy/2).
:- dynamic(before/3).
:- dynamic(precedency_tree/2).
:- dynamic(first_action/1).
:- dynamic(fake_first_action/1).


% % % % % % % % % % % % % % % %


first_action([]).

fake_first_action([]).

shape(ramp,[2,2,1]).
shape(cube,[2,2,1]).
shape(brick,[4,2,1]).
shape(bar,[6,2,1]).
table_x(12).
table_y(24).
marker(-1, cross, [0,0,0]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

num_of_agents(1).
agent(fred, [0,-15,15]).
reachable_actions(fred, [2,3,4,6,7,8,14,18,19,20,22,23,24,27]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

completed_tasks(fred, []).
applied_actions(fred, []).
all_applied_actions([]).
all_completed_tasks([]).
pending_actions([2,3,4,6,7,8,14,18,19,20,22,23,24,27]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

plan_done(false).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

action(2, cube, red, 'East-West', [0,0,0], 1).
action(3, cube, red, 'East-West', [0,0,1], 1).
action(4, cube, red, 'East-West', [0,0,2], 1).

action(6, brick, red, 'East-West', [4,0,0], 5).
action(7, brick, red, 'East-West', [4,0,1], 5).
action(8, brick, red, 'East-West', [4,0,2], 5).

action(14, bar, red, 'East-West', [0,0,3], 13).

action(18, bar, yellow, 'North-South', [0,-6,0], 17).
action(19, brick, yellow, 'North-South', [0,-4,1], 17).
action(20, cube, yellow, 'North-South', [0,-2,2], 17).

action(22, cube, blue, 'East-West', [6,-4,0], 21).
action(23, cube, blue, 'East-West', [6,-4,1], 21).
action(24, cube, blue, 'East-West', [6,-4,2], 21).

action(27, bar, yellow, 'North-South', [6,-4,3], 26).

construction(structures).
task(1, tower, 'size', neutral).
task(5, wall, 'size', neutral).
task(13, bridge, 'size', neutral).
task(17, staircase, 'size', neutral).
task(21, tower, 'size', neutral).
task(26, bridge, 'size', neutral).

hierarchy(1, [2,3,4]).
hierarchy(5, [6,7,8]).
hierarchy(13, [14]).
hierarchy(17, [18,19,20]).
hierarchy(21, [22,23,24]).
hierarchy(26, [27]).

before(fred, 1,[]).
before(fred, 5,[17]).
before(fred, 13,[1,5]).
before(fred, 17,[1]).
before(fred, 21,[17]).
before(fred, 26,[21]).

dummy([]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

precedency_tree(2,[]).
precedency_tree(3,[2]).
precedency_tree(4,[3]).
precedency_tree(6,[]).
precedency_tree(7,[6]).
precedency_tree(8,[7]).
precedency_tree(14,[4,8]).

precedency_tree(18,[]).
precedency_tree(19,[18]).
precedency_tree(20,[19]).

precedency_tree(22,[]).
precedency_tree(23,[22]).
precedency_tree(24,[23]).
precedency_tree(27,[24,8]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
