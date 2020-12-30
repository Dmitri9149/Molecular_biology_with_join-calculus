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

type 'a mset = ('a * int) list;;

let rec fold_right op lst init = match lst with
  | [] -> init
  | h::t -> op h (fold_right op t init)
;;

let rec mult (xs : 'a mset) (e : 'a ) : int =
  match xs with
  [] -> 0
  | (el, ct)::t -> if el = e then ct else (mult t e)
;;
 
let sample = [("hemagglutinin", 10000000000); ("neuraminidaza", 20)]
;;

let h_observe = mult sample "hemagglutinin"
;;

print_int h_observe; print_string "\n"
;;


