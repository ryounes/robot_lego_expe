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
reachable_actions(fred, [2,3,4,6,7,8,10,12,13,14,15,16]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

completed_tasks(fred, []).
applied_actions(fred, []).
all_applied_actions([]).
all_completed_tasks([]).
pending_actions([2,3,4,6,7,8,10,12,13,14,15,16]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

plan_done(false).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

action(2, cube, yellow, 'East-West', [0,0,0], 1).
action(3, cube, yellow, 'East-West', [0,0,1], 1).
action(4, cube, yellow, 'East-West', [0,0,2], 1).

action(6, cube, yellow, 'East-West', [-4,0,0], 5).
action(7, cube, yellow, 'East-West', [-4,0,1], 5).
action(8, cube, yellow, 'East-West', [-4,0,2], 5).

action(10, bar, yellow, 'East-West', [-4,0,3], 9).

action(12, brick, red, 'East-West', [-3,0,4], 11).
action(13, ramp, red, 'East-West', [-6,0,4], 11).
action(14, ramp, red, 'East-West', [1,0,4], 11).
action(15, ramp, red, 'East-West', [-1,0,5], 11).
action(16, ramp, red, 'East-West', [-4,0,5], 11).

construction(house).
task(1, tower, 'size', neutral).
task(5, tower, 'size', neutral).
task(9, bridge, 'size', neutral).
task(11, roof, 'size', neutral).

hierarchy(1, [2,3,4]).
hierarchy(5, [6,7,8]).
hierarchy(9, [10]).
hierarchy(11, [12,13,14,15,16]).
before(fred, 1,[]).
before(fred, 5,[1]).
before(fred, 9,[1,5]).
before(fred, 11,[9]).

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
precedency_tree(10,[8,4]).
precedency_tree(12,[10]).
precedency_tree(13,[12]).
precedency_tree(14,[12]).
precedency_tree(15,[12,14]).
precedency_tree(16,[15]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

