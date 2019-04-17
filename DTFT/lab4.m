%% lab4.m
clear
delete(allchild(0));
w = linspace(-pi, pi, 11);
%x = sequence([1 4 3 -2 6], -1);
x = sequence([1 5 2 -1 4 1], -2);

%% Problem #1: Even, Odd

test_lab4('even(x)');
test_lab4('odd(x)');
test_lab4('trim(plus(even(x), odd(x)))');
%% Problem #2: DTFT
x = sequence([1 1 1], -1);
test_lab4('dtft(x, w)');

% Simple impulse Caution! check your answer for this.
% It should be a sequence.
x = sequence(1, 0);
test_lab4('dtft(x, w)');

%x = sequence([1 4 3 -2 6], -1)
x = sequence([1 5 2 -1 4 1], -2);
test_lab4('dtft(x, w)');

%% Problem #3: Real and Imaginary
x = sequence([1 1 1], -1);
test_lab4('dtft2(x, w)');

%x = sequence([1 4 3 -2 6], -1);
x = sequence([1 5 2 -1 4 1], -2);
test_lab4('dtft2(x, w)');

%% Problem #4: Magnitude and Phase
test_lab4('mag_phase(dtft2(x, w))');

%% Problem #5 Plotting
w = linspace(-pi, pi, 1001);
plot_magph(x, w);

% This is a purely real and even function.
% What can you say about the phase?
% Specifically why is it either 0 or pi?
x = sequence([1 1 1], -1);
set(figure, 'Color', 'w');
plot_magph(x, w);

% This is a purely real and odd function.
% What can you say about the phase?
% Specifically why is it either +pi/2 or -pi/2?
x = sequence([-1 0 1], -1);
set(figure, 'Color', 'w');
plot_magph(x, w);

% Here are a series of pulse functions.
% What happens to the magnitude of the transform as the pulse gets broader?
% You may note that the phase 'chatters' between +pi and -pi at some values of w.
% This doesn't look nice and it's confusing. How could you fix this in your plot_magph
% program so that the phase doesn't chatter? No biggie if you can't.
% (Hint: it has something to do with a very small imaginary part...).

x = sequence(ones(1, 5), -2);
set(figure, 'Color', 'w');
plot_magph(x, w)

x = sequence(ones(1, 21), -10);
set(figure, 'Color', 'w');
plot_magph(x, w)

x = sequence(ones(1, 101), -50);
set(figure, 'Color', 'w');
plot_magph(x, w)

%% Print programs
disp(' ')
disp('--- dtft.m --------------------------------')
type('dtft')
disp('--- dtft2.m -------------------------------')
type('dtft2')
disp('--- mag_phase.m ---------------------------')
type('mag_phase')
disp('--- plot_magph.m --------------------------')
type('plot_magph')

