%{
	open ToyProlog_Intepreter
%}


%token END SEMICOLON COMMA IF L_PAR R_PAR 
%token <int>INTEGER 
%token <string>CONS 
%token <string>VAR 
%token <bool>BOOL
%token PLUS MINUS MUL DIV MOD EXP EQUAL NOT_EQ
%token GRE LESS GEQ LEQ GOAL CUT EOF

%start main 
%type <ToyProlog_Intepreter.clause> main

%%



main:
      clausee END {$1}
    | GOAL goal END {Fact(Head(Func(P_sym(Sym("goal",0 ),[$2]))))}
    | EOF {Fact(Head(Func(P_sym(Sym("file_end",0 ),[])))) }
;
clausee:
     atomm { Fact(Head($1)) }
    | atomm IF body { (Rule(Head($1),Body($3))) }
;
atomm:
      CONS L_PAR termlist R_PAR { Func(P_sym(Sym($1,List.length $3),$3)) }
	| L_PAR atomm R_PAR {$2}
;
term:
     CONS { Func(P_sym(Sym($1,0),[]))}
    | VAR { V(X($1)) }
    | CONS L_PAR termlist R_PAR { Func(P_sym(Sym($1,(List.length $3)),$3))}
;
termlist:
     term     { [$1] }
    | term COMMA termlist { $1::$3 }
;
body:
     atomm   { [$1] }
    | atomm COMMA body       { $1::$3 } 
;
goal:
	CONS L_PAR termlist R_PAR { Func(P_sym(Sym($1,List.length $3),$3))}
;