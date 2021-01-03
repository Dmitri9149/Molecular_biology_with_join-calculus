(* We are going to model biological viruses. This is the preliminary 
code for working with Multisets and HashTables.

  Why we may need it. We may model viruses and 
cells as 'bag of molecules'. So, we have to have a type of 'bag of molecules'. 
The possible good choice for the type is Multiset of molecules and HashTable of 
molecules. 
The very molecules we may model just by strings: "Hemmaglutenin" will mean influenza 
virus hemmagluteninn and "neurominidaza" -> corresponding molecule of the same virus. 
  Such way of modelling will increase readability, we hope. We may use just a numbers to 
count all molecules, or some short names, or may be there are much better natural 
structures for it, but firstly we will try with 'strings' type. 
  In this case the influensa virus will be just a channel virus(v) which keep 
the value v of type HashTable 'string' or Multiset 'string'. 
  And a cell will be channel cell(w) which keeps value w of same types. v and w will 
represent the bag of molecules for virus and cell. The molecules are processes, 
which may interact. Molecules m1 and m2 in the same hash table may interact and 
produce m3 : it will change the content of the hash table. 
  If a cell table has molecule 'docker' and virus has molecule 'spike' in table, 
the molecules may interact : virus will inject its table to the cell and the tables 
will be combined. The virus molecules will have all needed 'neighbours' in the new 
combined table to reproduce themselves, to colect the viral molecules in new_table and 
to bud from the cell the new_table inside the channel virus -> virus(new_table). 
The cycle is closed. 
  So, below some experiments with HashTables and Multisets types. We will check 
  how it works for us. 
*)

(* define the type mset -> multiset as list of tuples*)
type 'a mset = ('a * int) list;;

(* define fold_right function for future use with mset*)
let rec fold_right op lst init = match lst with
  | [] -> init
  | h::t -> op h (fold_right op t init)
;;

(* mult function -> returns 0 if e is not mset element, 
   othervise returns the number 
*)
let rec mult (xs : 'a mset) (e : 'a ) : int =
  match xs with
  [] -> 0
  | (el, ct)::t -> if el = e then ct else (mult t e)
;;

(* some tests with the functions*)

(* samle represents 'bag of moluculs' for influenza*)
let sample = [("hemagglutinin", 10000000000); ("neuraminidaza", 20)]
;;

(* find how many moleculs of "hemagglutinin" there are in the bag*)
let h_observe = mult sample "hemagglutinin"
;;

print_string "There are: "; print_int h_observe; 
print_string " hemagglutinins in sample.";
print_string "\n"
;;

let rec fold f a l =
  match l with
  [] -> a
  |h::t->fold f (f a h) t
;;

(*the sum of two multisets*)
let rec sum (xs : 'a mset) (ys : 'a mset) : ('a mset) =
  fold (fun acc (k, _) ->
  if (mult acc k) <> 0 then acc
  else (k, (mult xs k) + (mult ys k))::acc)
  [] (xs @ ys)
;;

(* some checking *)
let xs = [("prt1",20);("prt2",10)]
;;

let ys = [("prt1",30)]
;;

(* some printing of observables *)
let sum_xs_ys = sum xs ys 
;;
let prt1_observe_xs = mult xs "prt1"
;;
let prt1_observe_ys =mult ys "prt1"
;;
let prt2_observe_xs = mult xs "prt2"
;;
let prt2_observe_ys =mult ys "prt2"
;;
let prt1_observe_sum = mult sum_xs_ys "prt1"
;;
let prt2_observe_sum = mult sum_xs_ys "prt2"
;;

print_string "There are: "; print_int prt1_observe_xs;
print_string " prt1 in xs."; print_string "\n"
;;

print_string "There are: "; print_int prt2_observe_xs;
print_string " prt2 in xs."; print_string "\n"
;;

print_string "There are: "; print_int prt1_observe_ys;
print_string " prt1 in ys."; print_string "\n"
;;

print_string "There are: "; print_int prt2_observe_ys;
print_string " prt2 in ys."; print_string "\n"
;;

print_string "There are: "; print_int prt1_observe_sum;
print_string " prt1 in sum_xs_ys."; print_string "\n"
;;

print_string "There are: "; print_int prt2_observe_sum;
print_string " prt2 in sum_xs_ys."; print_string "\n"
;;
(* end of observables printing *)


(* we will construct simple 'cell' with 'receptor' to which 
virus may attach and penetrate to the 'cell'.  Penetration means 
the virus inject its multiset of moleculs-processes to the cell and the 
multisets are combined within the cell into one multiset of virus - cell 
molecules-processes 
*)

(* We will construct the 'influenza ' - like virus. At the beginning it will 
has 'Hg' - hemmaglutinin; 'Nd' - neuraminidaze and 'Mx' - matrix molecules, one 
sample of every molecule. *)

Infl_m_set = [("Hg",1);("Nd",1);("Mx",1)]
;;

Cell_m_set = [("Rc",10);("Others":10)]
;;

(* and we will define the simple reaction: our virus can not do too 
many at the stage: it will just inject all its proteins to the cell 
 Firstly we have to define a function for the 2 multisets interaction
 The first parameter is for virus, second for cell
 *)

 (* function to change element (key:number) of out multiset*)

 (* from https://stackoverflow.com/questions/26412993/ocaml-returning-full-list-after-change-to-element*)
let rec change key value dict =
  match dict with
    | [] -> (key, value)::dict (*Adding to the dictionary*)
    | (a,b) :: dict -> if compare a key = 0 then (a, value)::dict (*changing value*)
                      else (a,b)::change key value dict (*continue search*)
;;

(* let inter (a,b) = 
  let z = mult a "Hg" in  
  if z > 1 and mult b "Rc" > 1 begin let new_a = change "Hg" (z-1) a in 
  end *)




