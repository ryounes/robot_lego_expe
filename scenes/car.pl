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

shape(ramp,[3,2,1]).
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
reachable_actions(fred, [2,4,6,7,8,9,11]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

completed_tasks(fred, []).
applied_actions(fred, []).
all_applied_actions([]).
all_completed_tasks([]).
pending_actions([2,4,6,7,8,9,11]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %


goal(cube, blue, 'East-West', [0,0,0]).
goal(cube, blue, 'East-West', [-6,0,0]).
goal(bar, red, 'East-West', [-8,0,1]).
goal(bar, red, 'East-West', [-2,0,1]).
goal(ramp, red, 'East-West', [2,0,2]).
goal(bar, red, 'East-West', [-5,0,2]).
goal(ramp, red, 'East-West', [-8,0,3]).

plan_done(false).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

action(2, cube, blue, 'East-West', [0,0,0], 1).
action(4, cube, blue, 'East-West', [-6,0,0], 3).
action(6, bar, red, 'East-West', [-8,0,1], 5).
action(7, bar, red, 'East-West', [-2,0,1], 5).
action(8, ramp, red, 'East-West', [1,0,2], 5).
action(9, bar, red, 'East-West', [-5,0,2], 5).
action(11, ramp, red, 'East-West', [-1,0,3], 5).

construction(car).
task(1, wheel, 'size', neutral).
task(3, wheel, 'size', neutral).
task(5, body, 'size', neutral).
hierarchy(1, [2]).
hierarchy(3, [4]).
hierarchy(5, [6,7,8,9,11]).
before(fred, 1,[]).
before(fred, 3,[]).
before(fred, 5,[1,3]).

dummy([]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

precedency_tree(2,[]).
precedency_tree(4,[]).
precedency_tree(6,[4]).
precedency_tree(7,[2]).
precedency_tree(8,[7]).
precedency_tree(9,[6,7,8]).
precedency_tree(11,[8,9]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
