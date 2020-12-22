def echo(x) = print_string "VVV"; 0;;
spawn echo(1);;
spawn echo(2);;
spawn echo(1);;
print_string "Hello world!\n";;

def fib(n) =
   if n <= 1 then reply 1 to fib
   else reply fib(n-1) + fib(n-2) to fib
;;

print_int (fib 10);;
print_string "\n";;

def succ(x) = print_int x; reply x+1 to succ;;


print_int(succ(100));;

def count(n) & inc() = count(n+1) & reply to inc
    or count(n) & get() = count(n) & reply n to get
;;

spawn count(0);;

print_int(get());

(* def a(x) = print_string "a+ a(";print_int(x);print_string")  a- a(";
print_int(x);print_string ") \n";
a(x);; 

spawn a(10);; *)

