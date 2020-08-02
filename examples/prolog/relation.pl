man(arjun).
man(pandu).
man(bheem).
man(yudhistir).
woman(kunti).
woman(madri).
parent(arjun, pandu).
parent(arjun, kunti).
parent(bheem, pandu).
parent(bheem, kunti).
parent(yudhistir, pandu).
parent(yudhistir, kunti).

parent(nakul, pandu).
parent(nakul, madri).
parent(sahadev, pandu).
parent(sahadev, madri).

%%% Facts end here %%%%%%%%%%%%%%%%%%%

mother(X,Y)  :- woman(Y), parent(X,Y).
father(X,Y)  :- man(Y), parent(X,Y).
brother(X,Y) :- dif(X,Y), father(X,Z), father(Y,Z), mother(X,M), mother(Y,M).

%% Exercise
%%
%% What happens when the brother definition does not have dif
%% Write a half brother relation similar to brother.
