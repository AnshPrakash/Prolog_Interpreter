{
open Prolog_parser
}

rule token = parse
  | ['.']                                           {END}
  | [';']                                           {SEMICOLON}
  | [',']                                           {COMMA}
  | [':']['-']                                      {IF}
  | ['(']                                           {L_PAR}
  | [')']                                           {R_PAR}
  | ['0'-'9']+  as int_str                          {INTEGER(int_of_string int_str)}
  | ['a'-'z']['0'-'9''A'-'B''a'-'z''_'''']* as str  {CONS(str)}
  | ['A'-'Z']['0'-'9''A'-'B''a'-'z''_'''']* as var  {VAR(var)}
  | [' ' '\t']                                      {token lexbuf }              
  | ['\n' ]                                         {token lexbuf }
  | ['+']                                           {PLUS}
  | ['-']                                           {MINUS}
  | ['*']                                           {MUL}
  | ['/']                                           {DIV}
  | ['?']['-']                                      {GOAL}
  | ['%']                                           {MOD}
  | ['^']                                           {EXP}
  | "true"                                          {BOOL(true)}
  | "false"                                         {BOOL(false)}
  | ['=']                                           {EQUAL}
  | "\\="                                           {NOT_EQ}
  | ['>']                                           {LESS}
  | ['<']                                           {GRE}
  | ['<']['=']                                      {LEQ}
  | ['>']['=']                                      {GEQ}
  | ['!']                                           {CUT}
  | eof                                             {EOF}

(*
{
let main () = begin
          try
            let filename=Sys.argv.(1) in
            let file_handle=open_in filename in 
            let lexbuf = Lexing.from_channel file_handle in
            while true do
              let result = token lexbuf in
                match result with 
                |PLUS         ->
                |END          ->
                |SEMICOLON    ->
                |COMMA        ->
                |IF           ->
                |L_PAR        ->
                |R_PAR        ->
                |INTEGER(n)   ->
                |CONS(s)      ->
                |VAR(s)       ->
                |MINUS        ->
                |DIV          ->
                |MOD          ->
                |BOOL(t)      ->
                |EQUAL        ->
                |GRE          ->
                |LESS         -> 
                |GEQ          -> 
                |LEQ          ->
                |GOAL         ->
                |_            ->  Printf.printf "I got a token\n"
            done
          with Eof -> exit 0
end ;;

main();;
}
*)