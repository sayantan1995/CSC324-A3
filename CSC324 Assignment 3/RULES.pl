plane(p123, boeing747, 8).

plane(p124, boeing747, 4).

plane(p125, boeing747, 6).

plane(p126, boeing747, 1).

flight(f407, toronto, paris, p123).

flight(f408, paris, tokyo, p123).

flight(f409, tokyo, paris, p123).

flight(f410, paris, toronto, p123).

flight(f412, london, chicago, p124).

flight(f413, chicago, vancouver, p124).

flight(f414, vancouver, toronto, p124).

flight(f415, toronto, sydney, p125).

flight(f416, sydney, toronto, p125).

flight(f417, new_york, paris, p124).

flight(f418, new_york, paris, p125).

flight(f237, los_angeles, paris, p123).

passenger(s456_234_987, anna, toronto, 26).

passenger(s456_234_988, steve, toronto, 52).

passenger(s456_234_989, bruce, paris, 30).

passenger(s456_234_991, elliot, los_angeles, 10).

passenger(s456_234_993, brian, brampton, 32).

passenger(s456_234_994, goku, tokyo, 55).

passenger(s456_101_010, messi, barcelona, 29).

passenger(s456_234_995, raj, london, 30).

passenger(s456_234_916, artoo, brampton, 1).

booked(s456_234_987, f407, jan17, 500).

booked(s456_234_987, f408, jan18, 750).

booked(s456_234_988, f407, jan17, 500).

booked(s456_234_989, f407, jan17, 500).

booked(s456_234_989, f408, jan18, 750).

booked(s456_234_989, f410, jan23, 500).

booked(s456_234_989, f415, jan30, 750).

booked(s456_234_988, f417, feb12, 300).

booked(s456_234_987, f237, feb23, 750).

booked(s456_234_987, f237, feb23, 750).

booked(s456_234_991, f237, feb23, 500).

booked(s456_101_010, f237, feb23, 500).

booked(s456_234_994, f409, jan14, 500).

booked(s456_101_010, f410, mar12, 750).

booked(s456_234_916, f412, oct20, 750).

booked(s456_234_995, f413, oct20, 300).


/* Question 4 */

plane(p123, Model, Age).

plane(PNumber, boeing747, Age).

flight(Fnumber, new_york, paris, _).

flight(Fnumber, los_angeles, paris, _),
	booked(_, Fnumber, jan17, Price).

booked(Sin, f237, feb23, _),
	passenger(Sin, Name, _, _).


/* Question 5 */

sn(Sin, Name):- passenger(Sin, Name, _, _ ).

child(Sin, Name):- passenger(Sin, Name, _, Age),
				   Age < 12. 

nfd(Name, FlightNum, Date):- passenger(SIN, Name, _, _) ,
						     booked(SIN, FlightNum, Date, _ ).


sm(Sin,Model):- booked(SIN, FlightNum, _, _),
				flight(FlightNum, _, _, PlaneNum),
				plane(PlaneNum, Model, _).


ccca(City1, City2, City3, Age):- passenger(SIN, _, City1, _),
								 booked(SIN, FlightNum, _, _),
								 flight(Flightnum, City2, City3, PlaneNum),
								 plane(PlaneNum, _, PlaneAge), PlaneAge > Age.
					

/* Question 6 */

existsplane(PlaneNum):- plane(PlaneNum, _, _).

badflight(FlightNum):- flight(FlightNum, _, _, PlaneNum).

existsflight(City1, City2, Date):- flight(_,City1, City2, Date).

noflights(SIN1, SIN2, Date):- passenger(SIN1, _, City1, _),
							  passenger(SIN2, _, City2, _),
							  not existsflight(City1, City2, Date).
							  

serves(FlightNum, City):- flight(FlightNum, City, _, _).

serves(FlightNum, City):- flight(FlightNum, _, City, _).

notserved(Sin):- passenger(Sin, _, City, _),
				 not served(City);


/* Question 7*/			  

leaf(X).

node1(X, T1).

node2(X, T1, T2).

node3(X, T1, T2, T3).

max(X,Y,Z):- Z is X , X > Y .

max(X,Y,Z):- Z is Y, X < Y.


treeMax(leaf(X), X).

treeMax(node1(X, T), Z) :- treeMax(T, Y), max(X,Y,Z).

treeMax(node2(X, T1, T2), Z2) :- treeMax(T1, Y1), max(X, Y1, Z1),
								 treeMax(T2, Y2), max(Z1, Y2, Z2).



treeMax(node3(X, T1, T2, T3), Z3) :- treeMax(T1, Y1), max(X, Y1, Z1),
									 treeMax(T2, Y2), max(Z1, Y2, Z2),
									 treeMax(T3, Y3), max(Z2, Y3, Z3). 


treeRev(leaf(X), leaf(X)).

treeRev(node1(X, T), node1(X, RT)) :- treeRev(T, RT).

treeRev(node2(X, T1, T2), node2(X, RT2, RT1)) :- treeRev(T1, RT1), 
												 treeRev(T2, RT2).

treeRev(node3(X, T1, T2, T3), node2(X, RT3, RT2, RT1)) :- treeRev(T1, RT1),
														  treeRev(T2, RT2),
														  treeRev(T3, RT3).


countNodes(leaf(X), c(1, 0, 0, 0)).

countNodes(node1(X, T), c(N0, N1, N2, N3)) :- countNodes(T, c(N0, M1, N2, N3)),
											  N1 is M1 + 1.

countNodes(node2(X, T1, T2), c(N0, N1, N2, N3)) :- countNodes(T1, c(L0, L1, L2, L3)),
												   countNodes(T1, c(M0, M1, M2, M3)),
												   	N0 is L0 + M0, 
												   	N1 is L1 + M1,
												   	N2 is L2 + M2 + 1,
												   	N3 is L3 + M3.

countNodes(node3(X, T1, T2, T3), c(N0, N1, N2, N3)):- countNodes(T1, c(K0, K1, K2, K3)),
													  countNodes(T1, c(L0, L1, L2, L3)),
													  countNodes(T1, c(M0, M1, M2, M3)),
													  	N0 is K0 + L0 + M0,
													  	N1 is K1 + L1 + M1,
													  	N2 is K2 + L2 + M2,
													  	N3 is K3 + L3 + M3 + 1.


treeList(leaf(X), []).

treeList(node1(X, T), [X|L]):- treeList(T, L).

treeList(node2(X, T1, T2), [X|L12]):- treeList(T1, L1),
									  treeList(T2, L2),
									  append(L1, L2, L3).

treelist(node3(X, T1, T2, T3), L123):- treeList(T1, L1),
									   treeList(T2, L2),
									   treeList(T3, L3),
									   append(L1, L2, L12)
									   append(L12, L3, L123).

append([],L,L).

append([X|L1], L2, [X|:L3]) :- append(L1, L2, L3). 





