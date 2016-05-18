%option noyywrap
%option yylineno
%x INTS INSTRUCTIONS READ WRITE ARRAYS

%%
<INTS,READ,WRITE>[a-z]+     { yylval.s = strdup(yytext); return VAR; }

<INITIAL>Int          { BEGIN INTS; return Int; }
<INTS>,               { return yytext[0]; }
<INTS>;               { BEGIN INITIAL; return yytext[0]; }
<INTS>[ \t\n]*        { }

<INITIAL>Ints               { BEGIN ARRAYS; return Ints; }
<ARRAYS>,                   { return yytext[0]; }
<ARRAYS>;                   { BEGIN INITIAL; return yytext[0]; }
<ARRAYS>[ \t\n]*            { }
<ARRAYS>[A-Za-z]+\[[0-9]+\] { yylval.s = strdup(yytext); return VAR; }
<ARRAYS>[A-Za-z]+\[[0-9]+\]\[[0-9]+\] { yylval.s = strdup(yytext); return VAR; }

<INITIAL>START        { BEGIN INSTRUCTIONS; return START; }
<INSTRUCTIONS>STOP    { BEGIN INITIAL; return STOP; }
<INSTRUCTIONS>[ \t\n] { }

<INSTRUCTIONS>RD      { BEGIN READ; return RD; }
<READ>[()]            { return yytext[0]; }
<READ>;               { BEGIN INSTRUCTIONS; return yytext[0]; }
<READ>[ \t\n]         { }

<INSTRUCTIONS>WR      { BEGIN WRITE; return WR; }
<WRITE>[()]           { return yytext[0]; }
<WRITE>;              { BEGIN INSTRUCTIONS; return yytext[0]; }
<WRITE>[ \t\n]        { }

<*>.|\n               { }
%%
