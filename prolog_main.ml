open ToyProlog_Intepreter


let table = 
	try
	    let filename = Sys.argv.(1) in 
	    let file = open_in filename in
	    let lexbuf = Lexing.from_channel file in
	    let rec createTable acc = 
	    	(* Printf.printf "hello"; *)
	      let result =Prolog_parser.main Prolog_lexer.token lexbuf in
	    	(* Printf.printf "hello"; *)
	        match result with 
	        (Fact(Head(Func(P_sym(Sym("file_end",0 ),[]))))) -> acc
	        | _ -> (createTable (result::acc)) 
	      in 
	    (* (printTable(createTable [])); *)
	    (createTable [])
	  with
	  |_->Printf.printf "Something Went Wrong";[]
;;

let _ = 
  Printf.printf "?-"; flush stdout;
  let lexbuf = Lexing.from_channel stdin in
    while true do
      let result = Prolog_parser.main Prolog_lexer.token lexbuf in
        match result with 
        (Fact(Head(Func(P_sym(Sym("exit",0 ),[]))))) -> Printf.printf "EXITING\n";flush stdout; exit 0
        |(Fact(Head(Func(P_sym(Sym("goal",0 ),goal_list))))) -> (run (Prog(table)) (Goal(goal_list)));Printf.printf "\n?-"; flush stdout;
        | _-> Printf.printf "INVALID INPUT GOAL\n";Printf.printf "\n?-"; flush stdout;
    done
;;