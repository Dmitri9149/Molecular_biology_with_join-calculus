(*  The molecular cell biology is about comminicating agents. 
And not about 1..2..3 agents (server ..client) with unique name ServerA and ClientB, 
but about communication of millions of servers with millions of clients. 
The molecular cell biology is about scaling. 
It is also about staging. 
The one cell is cell. The n cell we may describe by cell(n) : as value n sent on 
channel with name cell.
Cell may be in different satates: a, b, c....; we may write cell(n,s), where 
n is number of cells at stage s. 

    Big part of molecular cell biology we may understand by considering 
two communicating cells at some stages. Let us say cell(a) & cell(b). 
All we have to do in many cases, just to determine function which takes 
two parameters a_before, b_before  and return two new values : a_after, b_after. 

    Now when we spawn cell(a_before) & cell(b_before) we will see all the future 
dynamics of the two cells. 
When we spawn cell(a) & cell(b) & cell(d) we will see (one of the many possible!) 
future dynamics of the three cells , which is determened by 
pairvise communication of two cells. In more comples situations the dynamics 
may be determened by three communicating cells : 
def cell(a) & cell(b) & cell(c) = ........
This situation really happens in communication of T lymphocyte, B lymphocyte and 
Macrophage. 
    The join calculus is very good for such systems. The culculus is as fundamental as lambda 
calculus, and (my opinion) is undervalued. 
Unfortunatelly the implementations of the join calcululs  
(here we use JoCaml implementation) have some deviations from the original 
internal 'chamical abstract machine' compiler of join calculus. 
For example the JoCaml language we use here does not allow two same names 
in the process definition: 

def cell & cell = ........ is not allowed. 

    It is very pity, because it means the chemical reaction of water formation is 
not allowed too....

def h & h & o = w .... is not possible. 

==============================================================
def h() & h() = h()
;;

File "super_bacteria.ml", line 50, characters 4-5:
Error: Variable h is bound several times in this matching
================================================================

    We will have to make some tricks to overcome the limitation in some cases.

    Let us describe a cell which is super bacteria. There is environment env(n), 
where n is a number of 'food quants' ; we have m cells at the beginning => 
cell(m). Bacterias consume food from environment and proliferate : 
a 'food quant' from environment is transformed to new bacteria (cell(n) -> cell(n+1))

    Why we name it 'super bacteria' ? Because the only constrain to the 
reproduction of the cell are 'food quants'. No any other constrains. Moreover, 
if there is no 'food quants' the cells stay alive indefinitelly. 
    The cells in (human) bodies are under very strong 'social' constrains. 
There are to be 'food quants' for cell to proliferate, no nutrition -> no 
proliferation. But there are also many constrains from cells environment. 
Proliferation may happens only:
    In particular place of environment -> named space constrains; 
    If there is 'demand' from the environment for the particular 
    cell proliferation -> there is to be 'scaling' demand for the type of 
    service the cell offer;
    If the cell is considered as 'normal', environment can not detect an anomaly 
    for the cell (immune system 'says OK').
    There are no inhibitory signals of some kind (for some reasons) from environment 
    for the particular cell or cell type. 

    Malicious cells brake the constrains. But it happens not in one moment: 
there are many constrains and they are broken in several steps. This is backward 
process to the cell 'socialization' : we move back to the unconstrained 
'super backteria'. 
    The code below is to describe the interaction of this kind. 

*)

(* pattern match on the values of channels ('messages') to 
determine the communication betveen a cell and environment  
The first value is for 'food quants' on channel 'env'; 
the second value is for the number of cells on the channel 'cell'
*)

(* describe what happens with the 'food quants' in the interaction *)
let left x = 
    match x with 
    |(0,m) -> 0 
    |(m,0) -> (* if there are no cells, 'food quants' can not be consumed*)
    |(n,m) -> n-1

(*what happens with number of cells within the interaction*)
let right x =
    match x with 
    |(0,m) -> m
    |(n,0) -> 0
    |(n,m) -> m+1

(* We need some observables to monitore what happens in the system, 
because we can not print channel with  values directly *)
let observe_env x = 
    print_string " env = "; print_int x; print_string "\n" 

let observe_cell y = 
    print_string "cell = "; print_int y; print_string "\n"

    
(* cell consume 'food quant' from env and increase in quantity; 
in case of negative nubers print error message and make 
all the system as null process*)
def env(x) & cell(y) = 
    if x >= 0 && y >= 0 then begin 
        observe_env x; 
        observe_cell y;
        env(left(x,y)) & cell(right(x,y)) end 
    else begin print_string "not a real life parameters"; 
        print_string "\n"; 0 end
    

(* Start system with 10 'food quants' and 5 bacerias *)

spawn env(10) & cell(5)


(* The channels are asynchronous, we 'do not know' when communication will 
happens, time scale is determined by compiler and by other processes on our system. 
For some prints happens we have to delay the same thread running for long 
enought time. If still no printing: increse the delay time.
*)
Thread.delay 0.0005 


(*
The possible output from the program : 
~>/mol_biol$ ./a.out
 env = 10
cell = 5
 env = 9
cell = 6
 env = 8
cell = 7
 env = 7
cell = 8
 env = 6
cell = 9
 env = 5
cell = 10
 env = 4
cell = 11
 env = 3
cell = 12
 env = 2
cell = 13
 env = 1
cell = 14
 env = 0
cell = 15
 env = 0
cell = 15
 env = 0
cell = 15
 env = 0
cell = 15
 env = 0
cell = 15
 env = 0
cell = 15
 env = 0
cell = 15
 env = 0
cell = 15
 env = 0
cell = 15
 env = 0
cell = 15
 env = 0
cell = 15
~>/mol_biol$ 
*)

(*  and if we spawn env with negative values:

spawn env(-10) & cell(5)
;;
Thread.delay 0.0005 
;;
```
~>/mol_biol$ jocamlc super_bacteria.ml
~>/mol_biol$ ./a.out
not a real life parameters
~>/mol_biol$
```
*)