all:
	ocamlc -c ToyProlog_Intepreter.ml
	ocamlyacc prolog_parser.mly
	ocamllex prolog_lexer.mll
	ocamlc -c prolog_parser.mli
	ocamlc -c prolog_parser.ml
	ocamlc -c prolog_lexer.ml
	ocamlc -c prolog_main.ml
	ocamlc -o my_prolog ToyProlog_Intepreter.cmo  prolog_lexer.cmo prolog_parser.cmo prolog_main.cmo 
	
clean:
	rm my_prolog *.cmo *.cmi *.mli prolog_lexer.ml prolog_parser.ml