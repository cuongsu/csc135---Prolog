%Author: Cuong Su
%Date: December 7, 2015
% Description: These are the Prolog implementations for Homework 3, CSC
% 135.


%Problem 1: CatSibling
%Two people are catSiblings if they each own cats, and the two cats are
%siblings. "Siblings" are brothers(or sisters, or brother/sister).
catSibling(Person1,Person2) :-
	catowner(Person1,Cat1),
	catowner(Person2,Cat2),
	are_siblings(Cat1,Cat2).
are_siblings(Cat1,Cat2) :-
	catparent(Parent1,Cat1),
	catparent(Parent1,Cat2).
catowner(scott,c1).
catowner(gail,c2).
catparent(c3,c1).
catparent(c3,c2).

%Problem 2: listMins
%Compares numbers in a list and returns the smallest in a new list.
listMins([],_,[]).
listMins([Head1|Tail1],[Head2|Tail2],Ans) :-
	comparison(Head1,Head2,Small),
	listMins(Tail1,Tail2,Ans2),
	Ans = [Small|Ans2].
comparison(Head1,Head2,Ans) :-
	Head1 =< Head2,
	Ans = Head1.
comparison(Head1,Head2,Ans) :-
	Head2 < Head1,
	Ans = Head2.

%Problem 3: Crypto
%Each of the 10 different letters stands for a different digit. The aim is to find a substitution
%of digits for the letters such that all three of the above stated
%products are arithmetically correct.
crypto(P,H,A,R,E,D,L,I,O,S) :-
	Numbers = [0,1,2,3,4,5,6,7,8,9],
	Letters = [P,H,A,R,E,D,L,I,O,S],
	assign(Letters,Numbers),
	P*10000 + H*1000 + A*100 + R*10 + E*1 =:= P * I * (P*10+A) * (R*10+A),
	D*10000 + E*1000 + L*100 + A*10 + I*1 =:= (S*10+H) * (O*1000 + E*100 + O*10 + A*1),
	A*10000 + L*1000 + O*100 + R*10 + S*1 =:= H * (S*10+S) * (E*10+S) * (O*10+I).
assign([],_).
assign([LettersH|LettersT],NumbersList):-
        digitize(LettersH,NumbersList,NewList),
        assign(LettersT,NewList).
digitize(Letter, [Letter|NewList], NewList).
digitize(Letter, [NewListH|LettersT], [NewListH|NewListT]):- digitize(Letter, LettersT, NewListT).

%Problem 4: catFriends
%finds potentially compatible cats from a list of cats and their
%personal information.
catFriends(Cat1,Cat2) :-
	cat(Cat1,List1),
	cat(Cat2,List2),
	age(List1,List2),
	weight(List1,List2),
	hoursJumpingOrNapping(List1,List2).
age([Age1|_],[Age2|_]) :-
	Age is (abs(Age1-Age2)),
	Age =< 5.
weight([_,Weight1|_],[_,Weight2|_]) :-
	Weight is (abs(Weight1-Weight2)),
	Weight =< 2.
hoursNapping([_,_,Nap1|_],[_,_,Nap2|_]) :-
	Hoursn is (abs(Nap1-Nap2)),
	Hoursn =< 3.
hoursJumping([_,_,_,Jump1|_],[_,_,_,Jump2|_]) :-
	Hoursj is (abs(Jump1-Jump2)),
	Hoursj =< 1.
hoursJumpingOrNapping(List1,List2) :-
	hoursJumping(List1,List2);
	hoursNapping(List1,List2).
cat(natasha,[3,7,14,2]).
cat(prowler,[6,6,15,2]).

%Problem 5: overlap2
%takes two lists, and returns true if the lists have at least two
%elements in common.
overlap2([H1|T1],L2) :-
      overlapCounter([H1|T1],L2,A),
      A >= 2.
overlapCounter([H1|T1],L2,A) :-
	member(H1,L2),
	overlapCounter(T1,L2,A2),
	A is A2 + 1.
overlapCounter([H1|T1],L2,A) :-
	not(member(H1,L2)),
	overlapCounter(T1,L2,A2),
	A is A2 + 0.
overlapCounter([],_,0).
