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
reachable_actions(fred, [2,3,4,6,7,8,10,11,12,13,15,17]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

completed_tasks(fred, []).
applied_actions(fred, []).
all_applied_actions([]).
all_completed_tasks([]).
pending_actions([2,3,4,6,7,8,10,11,12,13,15,17]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

goal(bar, yellow, 'East-West', [0,2,0]).
goal(brick, yellow, 'East-West', [0,2,1]).
goal(cube, yellow, 'East-West', [0,2,2]).
goal(cube, blue, 'East-West', [-4,2,0]).
goal(cube, blue, 'East-West', [-4,2,1]).
goal(cube, blue, 'East-West', [-4,2,2]).
goal(cube, blue, 'East-West', [-4,-2,0]).
goal(cube, blue, 'East-West', [-4,-2,1]).
goal(cube, blue, 'East-West', [-4,-2,2]).
goal(cube, blue, 'East-West', [-4,-2,3]).
goal(bar, red, 'East-West', [-4,2,3]).
goal(bar, red, 'North-South', [-4,-2,4]).
plan_done(false).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

action(2, bar, yellow, 'East-West', [4,0,0], 1).
action(3, brick, yellow, 'East-West', [4,0,1], 1).
action(4, cube, yellow, 'East-West', [4,0,2], 1).
action(6, cube, blue, 'East-West', [0,0,0], 5).
action(7, cube, blue, 'East-West', [0,0,1], 5).
action(8, cube, blue, 'East-West', [0,0,2], 5).
action(10, cube, blue, 'East-West', [0,-4,0], 9).
action(11, cube, blue, 'East-West', [0,-4,1], 9).
action(12, cube, blue, 'East-West', [0,-4,2], 9).
action(13, cube, blue, 'East-West', [0,-4,3], 9).
action(15, bar, red, 'East-West', [0,0,3], 14).
action(17, bar, red, 'North-South', [0,-4,4], 16).

construction(structures).
task(1, staircase, 'size', neutral).
task(5, tower, 'size', neutral).
task(9, tower, 'size', neutral).
task(14, bridge, 'size', neutral).
task(16, bridge, 'size', neutral).
hierarchy(1, [2,3,4]).
hierarchy(5, [6,7,8]).
hierarchy(9, [10,11,12,13]).
hierarchy(14, [15]).
hierarchy(16, [17]).
before(fred, 9,[5,14]).
before(fred, 16,[5,14]).
before(fred, 1,[5]).
before(fred, 5,[]).
before(fred, 14,[]).

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
precedency_tree(10,[]).
precedency_tree(11,[10]).
precedency_tree(12,[11]).
precedency_tree(13,[12]).
precedency_tree(15,[4,8]).
precedency_tree(17,[13,15]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
