(*  Cells in multicellular body are at different stages of differentiation. 
The reason is the cells are living not for their own but for the purpose of the 
body in which every cell has a special function: cells are services of some kind. 
Erythrocytes supply oxigen, Lymphocytes are fighting with diversehostile agent, 
Marcophages utilize the garbige. 
  Cells may be at different states and the states are organized in 
structures like forests : colelction of trees. So, cell may start at the root
a tree and move thought the states -> it differentiates. The leafs of the trees 
correspond to more mature cells. At a stage there are usually several choices, what 
will be the next step for the cell. The choice is governed by a current demand for 
a cell service. The erythrocytes are lymphocytes are originated from the same 
pregenitor stemm cell in the bone marrow. The reason is the two services are very 
linked actually. In situations when we more erithrocytes we are actually are 
in need of more lymphocytes, and vise versa. And the actual 
proportion depend on situation and is regulated by production of special 
molecules ('factors') , which are produced by cells which detect 
the current situation and express it is molecular form. By 'molecular form' we 
mean vector of consentrations of 'factors'. Dofferent vectors -> correspond 
to different 'demands' for cell services. The demand will shape the 'motion' of 
cells throught differentiation tree from stemm cells to mature forms: services. 
  We may (at the beginning) to mark the states by natural numbers. 
If we have a cell at stage i -> cell(i) -> we have a set of next 
possible stages for the cell(i): next(i). It is a set. We may assume, 
the environment determines at the 'quantum' level the transition. 
To differentiate a cell has to get a 'quantum' of differentiation (special 
moleculs), all 'quants' are molecules or collection of moleculs, of course. 
To come from i -> to j : there is to be demand for it, and if there is demand, 
the environment has and may supply the 'i->j' quant. There are cells 
in environment which keep quant 'i->j'.
  So,  the environment is a collection of cells in different states too. The picture 
may become quite complicated, because in addition to the stages at 
differentiation tree there might be additional states at every stage, which 
correspond to the current local conditions at particular site at tissue. 

  The numbering of states is convenient in some cases, but usually we have to mark states 
in accordance with the 'nature' of the state set, which is not an easy task 
(to choose an appropriate state marking). 
  Let us consider firstly simple cases, then go to more complex.
*)

(*define natural numbers type, it will be out set of states*)


type nat = Vacuum | Rise of nat
;;
(*we use symmetrical function, because we would like to model identical cells*)
(*let five1 = (Rise(Rise(Rise(Rise(Rise(Vacuum)))))) *)

let interact x = 
  match x with 
  |(Vacuum, Vacuum) -> (Vacuum, Vacuum)
  |(Vacuum, z) -> (Vacuum,z)
  |(z,Vacuum) -> (z,Vacuum)
  |(Rise c , Rise m) -> (Rise (Rise c), Rise (Rise m))
;;


def c0(x) & c1(y) = print_string "  interact  "; c0(match interact(x,y) with (a,b)-> a) & c1(match interact(x,y) with (a,b)-> b)
;;

spawn c0(Rise Vacuum) & c1(Rise Vacuum)
;;

Thread.delay 0.0005







