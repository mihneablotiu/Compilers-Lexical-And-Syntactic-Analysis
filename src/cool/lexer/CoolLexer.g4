lexer grammar CoolLexer;
tokens { ERROR }

@header{
    package cool.lexer;
}

@members{
    private void raiseError(String msg) {
        setText(msg);
        setType(ERROR);
    }
}

// Keywords
IF: [iI][fF];
THEN: [tT][hH][eE][nN];
ELSE: [eE][lL][sS][eE];
FI: [fF][iI];
CLASS: [cC][lL][aA][sS][sS];
INHERITS: [iI][nN][hH][eE][rR][iI][tT][sS];
IN: [iI][nN];
ISVOID: [iI][sS][vV][oO][iI][dD];
LET: [lL][eE][tT];
LOOP: [lL][oO][oO][pP];
POOL: [pP][oO][oO][lL];
WHILE: [wW][hH][iI][lL][eE];
CASE: [cC][aA][sS][eE];
ESAC: [eE][sS][aA][cC];
NEW: [nN][eE][wW];
OF: [oO][fF];
NOT: [nN][oO][tT];
TRUE: 't'[rR][uU][eE];
FALSE: 'f'[aA][lL][sS][eE];

// Special Characters
SEMICOLON: ';';
COLON: ':';
LBRACE: '{';
RBRACE: '}';
COMMA: ',';
ASSIGN: '<-';
DOT: '.';
AT: '@';
PLUS: '+';
MINUS: '-';
DIV: '/';
MULT: '*';
EQUAL: '=';
LT: '<';
LTE: '<=';
BRANCH: '=>';
LPAREN: '(';
RPAREN: ')';
TILDA: '~';

fragment UNESCAPED_NEWLINE: ~('\\')'\r\n' | ~('\\' | '\r')'\n';

STRING: '"' ('\\"' | .)*? ( EOF { raiseError("EOF in string constant"); }
                          | UNESCAPED_NEWLINE { raiseError("Unterminated string constant"); }
                          | '"' {
    String currentText = getText();

    if (currentText.contains(Character.toString((char) 0))) {
        raiseError("String contains null character");
        return;
    }

    String firstModification = currentText.substring(1, currentText.length() - 1).replace("\\n", String.valueOf('\n'))
                                                                                 .replace("\\t", String.valueOf('\t'))
                                                                                 .replace("\\f", String.valueOf('\f'))
                                                                                 .replace("\\b", String.valueOf('\b'));
    String finalString = firstModification.replaceAll("\\\\([\\s\\S])", "$1");

    if (finalString.length() > 1024) {
        raiseError("String constant too long");
    } else {
        setText(finalString);
    }
});


// Integers
fragment DIGIT: [0-9];
INTEGER: DIGIT+;

fragment LETTER: [a-z];
fragment CAPITALLETTER: [A-Z];

// Type Identifiers
TYPEID: CAPITALLETTER(CAPITALLETTER | LETTER | '_' | DIGIT)*;

// Object Identifiers
OBJECTID: LETTER(CAPITALLETTER | LETTER | '_' | DIGIT)*;

// Skippable
WS: [ \n\f\r\t]+ -> skip;

fragment NEW_LINE : '\r'?'\n';
LINE_COMMENT: '--' .*? (NEW_LINE | EOF) -> skip;
BLOCK_COMMENT
    : '(*'
      (BLOCK_COMMENT | .)*?
      ('*)' { skip(); } | EOF { raiseError("EOF in comment"); });

COMMENT_END: '*)' { raiseError("Unmatched *)"); };
OTHER: . { raiseError("Invalid character: " + getText()); };
