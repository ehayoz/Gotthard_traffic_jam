function [  ] = optiFinder(  )
% Optimum Finder for:
%   - moveProb
%   - moveCorr

rounds = 10;             % how many times it should use same inputs (=> stable data)

%% moveProb
mp_start = .3;           % moveProb
mp_stop = .6;
mp_step = .05;

dataset = 2;
redLight_act = 0;
isAnimated = 0;

error_abs_M = zeros(1,round((mp_stop-mp_start)/mp_step+1));
error_abs_sum = 0;
u = 0;

set(0,'DefaultFigureVisible','off') % suppress bar graph output
for moveProb = mp_start:mp_step:mp_stop
    u = u+1;   
   for j = 1:rounds
       error_abs = NaSch_Datasets_v1(dataset, moveProb, redLight_act, isAnimated, 0);
       error_abs_sum = error_abs_sum + error_abs;
   end 
   error_abs_M(1,u) = error_abs_sum/rounds;   % calculate mean of absolute error
end

% diagram of different errors
set(0,'DefaultFigureVisible','on') % do not suppress following bar graph output
figure()
hold on;
title('optiFinder')
x = mp_start:mp_step:mp_stop;
y = error_abs_M;
xlabel('moveProb');
ylabel('Absolute Error');
bar(x,y, 'EdgeColor','g', 'FaceColor','g')
%{
%% moveCorr
mc_start = .00;
mc_stop = .1;
mc_step = .025;

moveProb = .525;
dataset = 2;
redLight_act = 0;
isAnimated = 0;

error_abs_M = zeros(1,round((mc_stop-mc_start)/mc_step+1));
error_abs_sum = 0;
u = 0;

set(0,'DefaultFigureVisible','off') % suppress bar graph output
for moveCorr = mc_start:mc_step:mc_stop
    u = u+1;
    
    for j = 1:rounds
        error_abs = NaSch_Datasets_v1(dataset, moveProb, redLight_act, isAnimated, moveCorr);
        error_abs_sum = error_abs_sum + error_abs;
    end
    
    error_abs_M(1,u) = error_abs_sum/rounds;   % calculate mean of absolute error
end

% diagram of different errors
set(0,'DefaultFigureVisible','on') % do not suppress following bar graph output
figure()
hold on;
title('optiFinder')
x = mc_start:mc_step:mc_stop;
y = error_abs_M;
xlabel('moveCorr');
ylabel('Absolute Error');
bar(x,y, 'EdgeColor','g', 'FaceColor','g')
%}
end