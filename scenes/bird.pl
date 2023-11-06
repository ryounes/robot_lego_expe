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
reachable_actions(fred, [2,3,5,7,8,9,11,13,15]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

completed_tasks(fred, []).
applied_actions(fred, []).
all_applied_actions([]).
all_completed_tasks([]).
pending_actions([2,3,5,7,8,9,11,13,15]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %


goal(2, ramp, red, 'East-West', [0,0,0]).
goal(3, cube, red, 'East-West', [-2,0,0]).
goal(5, cube, yellow, 'East-West', [-1,0,1]).
goal(7, brick, yellow, 'East-West', [-1,0,2]).
goal(8, bar, yellow, 'East-West', [-3,0,3]).
goal(9, brick, yellow, 'East-West', [-1,0,4]).
goal(11, cube, yellow, 'East-West', [1,0,5]).
goal(13, ramp, red, 'East-West', [1,0,6]).
goal(15, cube, yellow, 'East-West', [1,0,7]).
plan_done(false).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

action(2, ramp, red, 'East-West', [0,0,0], 1).
action(3, cube, red, 'East-West', [-2,0,0], 1).
action(5, cube, yellow, 'East-West', [-1,0,1], 4).
action(7, brick, yellow, 'East-West', [-1,0,2], 6).
action(8, bar, yellow, 'East-West', [-3,0,3], 6).
action(9, brick, yellow, 'East-West', [-1,0,4], 6).
action(11, cube, yellow, 'East-West', [1,0,5], 10).
action(13, ramp, red, 'East-West', [1,0,6], 12).
action(15, cube, yellow, 'East-West', [1,0,7], 14).

construction(bird).
task(1, foot, 'size', neutral).
task(4, leg, 'size', neutral).
task(6, body, 'size', neutral).
task(10, neck, 'size', neutral).
task(12, beak, 'size', neutral).
task(14, head, 'size', neutral).
hierarchy(1, [2,3]).
hierarchy(4, [5]).
hierarchy(6, [7,8,9]).
hierarchy(10, [11]).
hierarchy(12, [13]).
hierarchy(14, [15]).
before(fred, 1,[]).
before(fred, 4,[]).
before(fred, 6,[]).
before(fred, 10,[]).
before(fred, 12,[]).
before(fred, 14,[]).

dummy([]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %

precedency_tree(2,[]).
precedency_tree(3,[]).
precedency_tree(5,[2,3]).
precedency_tree(7,[5]).
precedency_tree(8,[7]).
precedency_tree(9,[8]).
precedency_tree(11,[9]).
precedency_tree(13,[11]).
precedency_tree(15,[13]).

% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % %
