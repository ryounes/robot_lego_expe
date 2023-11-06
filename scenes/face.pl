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
reachable_actions(fred, [2,4,6,7,8,10,12]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

completed_tasks(fred, []).
applied_actions(fred, []).
all_applied_actions([]).
all_completed_tasks([]).
pending_actions([2,4,6,7,8,10,12]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

plan_done(false).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

action(2, cube, blue, 'East-West', [0,0,0], 1).
action(4, cube, blue, 'East-West', [-4,0,0], 3).

action(6, cube, red, 'East-West', [-6,-4,0], 5).
action(7, bar, red, 'East-West', [-4,-6,0], 5).
action(8, cube, red, 'East-West', [2,-4,0], 5).

action(10, brick, yellow, 'East-West', [0,4,0], 9).
action(12, brick, yellow, 'East-West', [-6,4,0], 11).

construction(face).
task(1, eye, 'size', neutral).
task(3, eye, 'size', neutral).
task(5, mouth, 'size', neutral).
task(9, eyebrow, 'size', neutral).
task(11, eyebrow, 'size', neutral).

hierarchy(1, [2]).
hierarchy(3, [4]).
hierarchy(5, [6,7,8]).
hierarchy(9, [10]).
hierarchy(11, [12]).

before(fred, 1,[]).
before(fred, 3,[1]).
before(fred, 5,[3]).
before(fred, 9,[5]).
before(fred, 11,[9]).

dummy([]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

precedency_tree(2,[]).
precedency_tree(4,[]).
precedency_tree(6,[]).
precedency_tree(7,[]).
precedency_tree(8,[]).
precedency_tree(10,[]).
precedency_tree(12,[]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
