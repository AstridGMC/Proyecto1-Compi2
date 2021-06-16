/* parser generated by jison 0.4.18 */
/*
  Returns a Parser object of the following structure:

  Parser: {
    yy: {}
  }

  Parser.prototype: {
    yy: {},
    trace: function(),
    symbols_: {associative list: name ==> number},
    terminals_: {associative list: number ==> name},
    productions_: [...],
    performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate, $$, _$),
    table: [...],
    defaultActions: {...},
    parseError: function(str, hash),
    parse: function(input),

    lexer: {
        EOF: 1,
        parseError: function(str, hash),
        setInput: function(input),
        input: function(),
        unput: function(str),
        more: function(),
        less: function(n),
        pastInput: function(),
        upcomingInput: function(),
        showPosition: function(),
        test_match: function(regex_match_array, rule_index),
        next: function(),
        lex: function(),
        begin: function(condition),
        popState: function(),
        _currentRules: function(),
        topState: function(),
        pushState: function(condition),

        options: {
            ranges: boolean           (optional: true ==> token location info will include a .range[] member)
            flex: boolean             (optional: true ==> flex-like lexing behaviour where the rules are tested exhaustively to find the longest match)
            backtrack_lexer: boolean  (optional: true ==> lexer regexes are tested in order and for each matching regex the action code is invoked; the lexer terminates the scan when a token is returned by the action code)
        },

        performAction: function(yy, yy_, $avoiding_name_collisions, YY_START),
        rules: [...],
        conditions: {associative list: name ==> set},
    }
  }


  token location info (@$, _$, etc.): {
    first_line: n,
    last_line: n,
    first_column: n,
    last_column: n,
    range: [start_number, end_number]       (where the numbers are indexes into the input string, regular zero-based)
  }


  the parseError function receives a 'hash' object with these members for lexer and parser errors: {
    text:        (matched text)
    token:       (the produced terminal token, if any)
    line:        (yylineno)
  }
  while parser (grammar) errors will also provide these members, i.e. parser errors deliver a superset of attributes: {
    loc:         (yylloc)
    expected:    (string describing the set of expected tokens)
    recoverable: (boolean: TRUE when the parser has a error recovery rule available for this particular error)
  }
*/
var gramarxml = (function(){
    var o=function(k,v,o,l){for(o=o||{},l=k.length;l--;o[k[l]]=v);return o},$V0=[1,17],$V1=[1,20],$V2=[1,15],$V3=[1,18],$V4=[1,21],$V5=[1,22],$V6=[1,23],$V7=[1,24],$V8=[5,9,24,26,35,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55],$V9=[1,31],$Va=[18,24,35],$Vb=[1,43],$Vc=[1,45],$Vd=[1,46],$Ve=[1,47],$Vf=[1,48],$Vg=[1,49],$Vh=[1,50],$Vi=[1,51],$Vj=[1,52],$Vk=[1,53],$Vl=[1,54],$Vm=[1,55],$Vn=[1,56],$Vo=[1,57],$Vp=[1,42],$Vq=[1,44],$Vr=[24,26,52,53],$Vs=[2,48],$Vt=[1,59],$Vu=[9,24,26,35,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57],$Vv=[18,24,26,35,52,53],$Vw=[9,24,26,35,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55],$Vx=[1,69],$Vy=[1,70],$Vz=[10,16,18,19,20,21,24,26,35,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55],$VA=[24,26,35,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57],$VB=[56,57];
    var parser = {trace: function trace () { },
        yy: {},
        symbols_: {"error":2,"S":3,"XML_GRAMAR":4,"EOF":5,"ENCABEZADO":6,"ABRIR_ELEMENTO":7,"CONTENIDO_ELEMENTO":8,"menosque":9,"c_interroga":10,"xml":11,"version":12,"igual":13,"QUOTES":14,"TIPO_DATO":15,"encoding":16,"FORMAT":17,"masque":18,"UTF":19,"ASCII":20,"ISO":21,"ELEMENTOS":22,"ELEMENTO":23,"identificador":24,"inicoment":25,"menos":26,"ETIQUETA":27,"COMENTARIO":28,"ATRIBUTOS":29,"CIERRE_ELEMENTO":30,"ATRIBUTO":31,"C_ATRIBUTO":32,"TIPOCONTENIDO":33,"CONTENIDO_ETIQUETA":34,"div":35,"C_TEXTO":36,"TIPO":37,"SIGNOS":38,"SPECIALCHARS":39,"lessthan":40,"graterthan":41,"ampersand":42,"simplequote":43,"doublequote":44,"colon":45,"underscore":46,"corder":47,"corizq":48,"parder":49,"parizq":50,"ptcoma":51,"decimal":52,"entero":53,"mas":54,"por":55,"comilla":56,"apostrofe":57,"$accept":0,"$end":1},
        terminals_: {2:"error",5:"EOF",9:"menosque",10:"c_interroga",11:"xml",12:"version",13:"igual",16:"encoding",18:"masque",19:"UTF",20:"ASCII",21:"ISO",24:"identificador",25:"inicoment",26:"menos",35:"div",40:"lessthan",41:"graterthan",42:"ampersand",43:"simplequote",44:"doublequote",45:"colon",46:"underscore",47:"corder",48:"corizq",49:"parder",50:"parizq",51:"ptcoma",52:"decimal",53:"entero",54:"mas",55:"por",56:"comilla",57:"apostrofe"},
        productions_: [0,[3,2],[4,3],[6,15],[17,1],[17,1],[17,1],[22,2],[22,1],[22,1],[23,2],[7,2],[7,4],[8,1],[8,1],[27,2],[27,1],[29,2],[29,1],[31,5],[32,2],[32,1],[30,6],[30,5],[30,2],[28,4],[28,3],[36,2],[36,1],[34,2],[34,1],[37,1],[37,1],[33,1],[33,1],[33,1],[39,1],[39,1],[39,1],[39,1],[39,1],[39,1],[39,1],[39,1],[39,1],[39,1],[39,1],[39,1],[15,1],[15,1],[15,1],[38,1],[38,1],[38,1],[38,1],[14,1],[14,1]],
        performAction: function anonymous(yytext, yyleng, yylineno, yy, yystate /* action[1] */, $$ /* vstack */, _$ /* lstack */) {
        /* this == yyval */

            var $0 = $$.length - 1;
            switch (yystate) {
            case 1:
            this.$ = $$[$0-1]; return this.$; 
            break;
            case 2:
            this.$ = new ObjetoNodo($$[$0-1],'', null,$$[$0],_$[$0-2].first_line, _$[$0-2].first_column); 
            break;
            case 3:
            this.$ = new ObjetoNodo($$[$0-11],'', null,$$[$0-13],_$[$0-14].first_line, _$[$0-14].first_column); 
            break;
            case 7: case 17: case 20: case 29:
            $$[$0-1].push($$[$0]); this.$ = $$[$0-1];
            break;
            case 8: case 18: case 21: case 30:
            this.$ = [$$[$0]]; 
            break;
            case 9:
            console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); 
            break;
            case 10:
            this.$ = new ObjetoNodo($$[$0-1],'', null,$$[$0],_$[$0-1].first_line, _$[$0-1].first_column); 
            break;
            case 11: case 13: case 16: case 31: case 32: case 33: case 34: case 35:
            this.$ = $$[$0] 
            break;
            case 12:
            this.$ = 'comentario' 
            break;
            case 14:
            this.$ = null 
            break;
            case 15:
            this.$ = new ObjetoNodo('','',$$[$0-1] ,$$[$0],_$[$0-1].first_line, _$[$0-1].first_column); 
            break;
            case 19:
            this.$ = new Atributo($$[$0-4],$$[$0-1],_$[$0-4].first_line, _$[$0-4].first_column); 
            break;
            case 22:
            this.$ = new ObjetoNodo($$[$0-1],'', null,$$[$0-4],_$[$0-5].first_line, _$[$0-5].first_column); 
            break;
            case 23:
            this.$ = new ObjetoNodo($$[$0-1],'', null,null,_$[$0-4].first_line, _$[$0-4].first_column); 
            break;
            case 36:
            this.$ = new ObjetoNodo($$[$0],'<',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 37:
            this.$ = new ObjetoNodo($$[$0],'>',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 38:
            this.$ = new ObjetoNodo($$[$0],'&',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 39:
            this.$ = new ObjetoNodo($$[$0],'\'',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 40:
            this.$ = new ObjetoNodo($$[$0],'"',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 41:
            this.$ = new ObjetoNodo($$[$0],':',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 42:
            this.$ = new ObjetoNodo($$[$0],'_',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 43:
            this.$ = new ObjetoNodo($$[$0],'{',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 44:
            this.$ = new ObjetoNodo($$[$0],'}',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 45:
            this.$ = new ObjetoNodo($$[$0],'(',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 46:
            this.$ = new ObjetoNodo($$[$0],')',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 47:
            this.$ = new ObjetoNodo($$[$0],';',null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 48: case 51: case 52: case 53: case 54: case 55: case 56:
            this.$ = new ObjetoNodo($$[$0],$$[$0],null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            case 49: case 50:
            this.$ = new ObjetoNodo(Number($$[$0]),Number($$[$0]),null,null,_$[$0].first_line, _$[$0].first_column); 
            break;
            }
        },
        table: [{3:1,4:2,6:3,9:[1,4]},{1:[3]},{5:[1,5]},{7:6,9:[1,7]},{10:[1,8]},{1:[2,1]},{8:9,15:19,18:$V0,24:$V1,26:$V2,27:10,28:11,29:12,30:13,31:16,35:$V3,36:14,52:$V4,53:$V5},{24:$V6,25:$V7},{11:[1,25]},{5:[2,2]},o($V8,[2,13]),o($V8,[2,14]),{18:$V0,24:[1,28],30:26,31:27,35:$V3},o($V8,[2,16]),{15:30,24:$V9,26:[1,29],52:$V4,53:$V5},{26:[1,32]},o($Va,[2,18]),{7:41,9:[1,34],15:38,23:37,24:$V9,26:$Vb,33:36,34:33,35:$Vc,37:35,38:39,39:40,40:$Vd,41:$Ve,42:$Vf,43:$Vg,44:$Vh,45:$Vi,46:$Vj,47:$Vk,48:$Vl,49:$Vm,50:$Vn,51:$Vo,52:$V4,53:$V5,54:$Vp,55:$Vq},{18:[1,58]},o($Vr,[2,28]),o($Vr,$Vs,{13:$Vt}),o($Vu,[2,49]),o($Vu,[2,50]),o($Vv,[2,11]),{26:[1,60]},{12:[1,61]},o($V8,[2,15]),o($Va,[2,17]),{13:$Vt},{26:[1,62]},o($Vr,[2,27]),o($Vu,$Vs),{18:[1,63]},{7:41,9:[1,64],15:38,23:37,24:$V9,26:$Vb,33:36,35:$Vc,37:65,38:39,39:40,40:$Vd,41:$Ve,42:$Vf,43:$Vg,44:$Vh,45:$Vi,46:$Vj,47:$Vk,48:$Vl,49:$Vm,50:$Vn,51:$Vo,52:$V4,53:$V5,54:$Vp,55:$Vq},{24:$V6,25:$V7,35:[1,66]},o($Vw,[2,30]),o($Vw,[2,31]),o($Vw,[2,32]),o($Vu,[2,33]),o($Vu,[2,34]),o($Vu,[2,35]),{8:67,15:19,18:$V0,24:$V1,26:$V2,27:10,28:11,29:12,30:13,31:16,35:$V3,36:14,52:$V4,53:$V5},o($Vu,[2,51]),o($Vu,[2,52]),o($Vu,[2,53]),o($Vu,[2,54]),o($Vu,[2,36]),o($Vu,[2,37]),o($Vu,[2,38]),o($Vu,[2,39]),o($Vu,[2,40]),o($Vu,[2,41]),o($Vu,[2,42]),o($Vu,[2,43]),o($Vu,[2,44]),o($Vu,[2,45]),o($Vu,[2,46]),o($Vu,[2,47]),o($V8,[2,24]),{14:68,56:$Vx,57:$Vy},{26:[1,71]},{13:[1,72]},{18:[1,73]},o($V8,[2,26]),{24:$V6,25:$V7,35:[1,74]},o($Vw,[2,29]),{24:[1,75]},o($Vw,[2,10]),{15:38,24:$V9,26:$Vb,32:76,33:77,35:$Vc,38:39,39:40,40:$Vd,41:$Ve,42:$Vf,43:$Vg,44:$Vh,45:$Vi,46:$Vj,47:$Vk,48:$Vl,49:$Vm,50:$Vn,51:$Vo,52:$V4,53:$V5,54:$Vp,55:$Vq},o($Vz,[2,55]),o($Vz,[2,56]),o($Vv,[2,12]),{14:78,56:$Vx,57:$Vy},o($V8,[2,25]),{24:[1,79]},{18:[1,80]},{14:81,15:38,24:$V9,26:$Vb,33:82,35:$Vc,38:39,39:40,40:$Vd,41:$Ve,42:$Vf,43:$Vg,44:$Vh,45:$Vi,46:$Vj,47:$Vk,48:$Vl,49:$Vm,50:$Vn,51:$Vo,52:$V4,53:$V5,54:$Vp,55:$Vq,56:$Vx,57:$Vy},o($VA,[2,21]),{15:83,24:$V9,52:$V4,53:$V5},{18:[1,84]},o($V8,[2,23]),o($Va,[2,19]),o($VA,[2,20]),{14:85,56:$Vx,57:$Vy},o($V8,[2,22]),{16:[1,86]},{13:[1,87]},{14:88,56:$Vx,57:$Vy},{17:89,19:[1,90],20:[1,91],21:[1,92]},{14:93,56:$Vx,57:$Vy},o($VB,[2,4]),o($VB,[2,5]),o($VB,[2,6]),{10:[1,94]},{18:[1,95]},{9:[2,3]}],
        defaultActions: {5:[2,1],9:[2,2],95:[2,3]},
        parseError: function parseError (str, hash) {
            if (hash.recoverable) {
                this.trace(str);
            } else {
                var error = new Error(str);
                error.hash = hash;
                throw error;
            }
        },  
        parse: function parse (input) {
            var self = this,
                stack = [0],
                tstack = [], // token stack
                vstack = [null], // semantic value stack
                lstack = [], // location stack
                table = this.table,
                yytext = '',
                yylineno = 0,
                yyleng = 0,
                recovering = 0,
                TERROR = 2,
                EOF = 1;

            var args = lstack.slice.call(arguments, 1);

            //this.reductionCount = this.shiftCount = 0;

            var lexer = Object.create(this.lexer);
            var sharedState = { yy: {} };
            // copy state
            for (var k in this.yy) {
            if (Object.prototype.hasOwnProperty.call(this.yy, k)) {
                sharedState.yy[k] = this.yy[k];
            }
            }

            lexer.setInput(input, sharedState.yy);
            sharedState.yy.lexer = lexer;
            sharedState.yy.parser = this;
            if (typeof lexer.yylloc == 'undefined') {
                lexer.yylloc = {};
            }
            var yyloc = lexer.yylloc;
            lstack.push(yyloc);

            var ranges = lexer.options && lexer.options.ranges;

            if (typeof sharedState.yy.parseError === 'function') {
                this.parseError = sharedState.yy.parseError;
            } else {
                this.parseError = Object.getPrototypeOf(this).parseError;
            }

            function popStack (n) {
                stack.length = stack.length - 2 * n;
                vstack.length = vstack.length - n;
                lstack.length = lstack.length - n;
            }

        _token_stack:
            var lex = function () {
                var token;
                token = lexer.lex() || EOF;
                // if token isn't its numeric value, convert
                if (typeof token !== 'number') {
                    token = self.symbols_[token] || token;
                }
                return token;
            }

            var symbol, preErrorSymbol, state, action, a, r, yyval = {}, p, len, newState, expected;
            while (true) {
                // retreive state number from top of stack
                state = stack[stack.length - 1];

                // use default actions if available
                if (this.defaultActions[state]) {
                    action = this.defaultActions[state];
                } else {
                    if (symbol === null || typeof symbol == 'undefined') {
                        symbol = lex();
                    }
                    // read action for current state and first input
                    action = table[state] && table[state][symbol];
                }

        _handle_error:
                // handle parse error
                if (typeof action === 'undefined' || !action.length || !action[0]) {
                    var error_rule_depth;
                    var errStr = '';

                    // Return the rule stack depth where the nearest error rule can be found.
                    // Return FALSE when no error recovery rule was found.
                    function locateNearestErrorRecoveryRule(state) {
                        var stack_probe = stack.length - 1;
                        var depth = 0;

                        // try to recover from error
                        for(;;) {
                            // check for error recovery rule in this state
                            if ((TERROR.toString()) in table[state]) {
                                return depth;
                            }
                            if (state === 0 || stack_probe < 2) {
                                return false; // No suitable error recovery rule available.
                            }
                            stack_probe -= 2; // popStack(1): [symbol, action]
                            state = stack[stack_probe];
                            ++depth;
                        }
                    }

                    if (!recovering) {
                        // first see if there's any chance at hitting an error recovery rule:
                        error_rule_depth = locateNearestErrorRecoveryRule(state);

                        // Report error
                        expected = [];
                        for (p in table[state]) {
                            if (this.terminals_[p] && p > TERROR) {
                                expected.push("'"+this.terminals_[p]+"'");
                            }
                        }
                        if (lexer.showPosition) {
                            errStr = 'Parse error on line '+(yylineno+1)+":\n"+lexer.showPosition()+"\nExpecting "+expected.join(', ') + ", got '" + (this.terminals_[symbol] || symbol)+ "'";
                        } else {
                            errStr = 'Parse error on line '+(yylineno+1)+": Unexpected " +
                                        (symbol == EOF ? "end of input" :
                                                    ("'"+(this.terminals_[symbol] || symbol)+"'"));
                        }
                        this.parseError(errStr, {
                            text: lexer.match,
                            token: this.terminals_[symbol] || symbol,
                            line: lexer.yylineno,
                            loc: yyloc,
                            expected: expected,
                            recoverable: (error_rule_depth !== false)
                        });
                    } else if (preErrorSymbol !== EOF) {
                        error_rule_depth = locateNearestErrorRecoveryRule(state);
                    }

                    // just recovered from another error
                    if (recovering == 3) {
                        if (symbol === EOF || preErrorSymbol === EOF) {
                            throw new Error(errStr || 'Parsing halted while starting to recover from another error.');
                        }

                        // discard current lookahead and grab another
                        yyleng = lexer.yyleng;
                        yytext = lexer.yytext;
                        yylineno = lexer.yylineno;
                        yyloc = lexer.yylloc;
                        symbol = lex();
                    }

                    // try to recover from error
                    if (error_rule_depth === false) {
                        throw new Error(errStr || 'Parsing halted. No suitable error recovery rule available.');
                    }
                    popStack(error_rule_depth);

                    preErrorSymbol = (symbol == TERROR ? null : symbol); // save the lookahead token
                    symbol = TERROR;         // insert generic error symbol as new lookahead
                    state = stack[stack.length-1];
                    action = table[state] && table[state][TERROR];
                    recovering = 3; // allow 3 real symbols to be shifted before reporting a new error
                }

                // this shouldn't happen, unless resolve defaults are off
                if (action[0] instanceof Array && action.length > 1) {
                    throw new Error('Parse Error: multiple actions possible at state: '+state+', token: '+symbol);
                }

                switch (action[0]) {
                    case 1: // shift
                        //this.shiftCount++;

                        stack.push(symbol);
                        vstack.push(lexer.yytext);
                        lstack.push(lexer.yylloc);
                        stack.push(action[1]); // push state
                        symbol = null;
                        if (!preErrorSymbol) { // normal execution/no error
                            yyleng = lexer.yyleng;
                            yytext = lexer.yytext;
                            yylineno = lexer.yylineno;
                            yyloc = lexer.yylloc;
                            if (recovering > 0) {
                                recovering--;
                            }
                        } else {
                            // error just occurred, resume old lookahead f/ before error
                            symbol = preErrorSymbol;
                            preErrorSymbol = null;
                        }
                        break;

                    case 2:
                        // reduce
                        //this.reductionCount++;

                        len = this.productions_[action[1]][1];

                        // perform semantic action
                        yyval.$ = vstack[vstack.length-len]; // default to $$ = $1
                        // default location, uses first token for firsts, last for lasts
                        yyval._$ = {
                            first_line: lstack[lstack.length-(len||1)].first_line,
                            last_line: lstack[lstack.length-1].last_line,
                            first_column: lstack[lstack.length-(len||1)].first_column,
                            last_column: lstack[lstack.length-1].last_column
                        };
                        if (ranges) {
                        yyval._$.range = [lstack[lstack.length-(len||1)].range[0], lstack[lstack.length-1].range[1]];
                        }
                        r = this.performAction.apply(yyval, [yytext, yyleng, yylineno, sharedState.yy, action[1], vstack, lstack].concat(args));

                        if (typeof r !== 'undefined') {
                            return r;
                        }

                        // pop off stack
                        if (len) {
                            stack = stack.slice(0,-1*len*2);
                            vstack = vstack.slice(0, -1*len);
                            lstack = lstack.slice(0, -1*len);
                        }

                        stack.push(this.productions_[action[1]][0]);    // push nonterminal (reduce)
                        vstack.push(yyval.$);
                        lstack.push(yyval._$);
                        // goto new state = table[STATE][NONTERMINAL]
                        newState = table[stack[stack.length-2]][stack[stack.length-1]];
                        stack.push(newState);
                        break;

                    case 3:
                        // accept
                        return true;
                }

            }

            return true;
        }
    };

	var erroresLexicos = [];
	var variables=[];
	var erroresSintacticos = [];
/* generated by jison-lex 0.3.4 */
var lexer = (function(){
var lexer = ({

EOF:1,

parseError:function parseError(str, hash) {
        if (this.yy.parser) {
            this.yy.parser.parseError(str, hash);
        } else {
            throw new Error(str);
        }
    },

// resets the lexer, sets new input
setInput:function (input, yy) {
        this.yy = yy || this.yy || {};
        this._input = input;
        this._more = this._backtrack = this.done = false;
        this.yylineno = this.yyleng = 0;
        this.yytext = this.matched = this.match = '';
        this.conditionStack = ['INITIAL'];
        this.yylloc = {
            first_line: 1,
            first_column: 0,
            last_line: 1,
            last_column: 0
        };
        if (this.options.ranges) {
            this.yylloc.range = [0,0];
        }
        this.offset = 0;
        return this;
    },

// consumes and returns one char from the input
input:function () {
        var ch = this._input[0];
        this.yytext += ch;
        this.yyleng++;
        this.offset++;
        this.match += ch;
        this.matched += ch;
        var lines = ch.match(/(?:\r\n?|\n).*/g);
        if (lines) {
            this.yylineno++;
            this.yylloc.last_line++;
        } else {
            this.yylloc.last_column++;
        }
        if (this.options.ranges) {
            this.yylloc.range[1]++;
        }

        this._input = this._input.slice(1);
        return ch;
    },

// unshifts one char (or a string) into the input
unput:function (ch) {
        var len = ch.length;
        var lines = ch.split(/(?:\r\n?|\n)/g);

        this._input = ch + this._input;
        this.yytext = this.yytext.substr(0, this.yytext.length - len);
        //this.yyleng -= len;
        this.offset -= len;
        var oldLines = this.match.split(/(?:\r\n?|\n)/g);
        this.match = this.match.substr(0, this.match.length - 1);
        this.matched = this.matched.substr(0, this.matched.length - 1);

        if (lines.length - 1) {
            this.yylineno -= lines.length - 1;
        }
        var r = this.yylloc.range;

        this.yylloc = {
            first_line: this.yylloc.first_line,
            last_line: this.yylineno + 1,
            first_column: this.yylloc.first_column,
            last_column: lines ?
                (lines.length === oldLines.length ? this.yylloc.first_column : 0)
                 + oldLines[oldLines.length - lines.length].length - lines[0].length :
              this.yylloc.first_column - len
        };

        if (this.options.ranges) {
            this.yylloc.range = [r[0], r[0] + this.yyleng - len];
        }
        this.yyleng = this.yytext.length;
        return this;
    },

// When called from action, caches matched text and appends it on next action
more:function () {
        this._more = true;
        return this;
    },

// When called from action, signals the lexer that this rule fails to match the input, so the next matching rule (regex) should be tested instead.
reject:function () {
        if (this.options.backtrack_lexer) {
            this._backtrack = true;
        } else {
            return this.parseError('Lexical error on line ' + (this.yylineno + 1) + '. You can only invoke reject() in the lexer when the lexer is of the backtracking persuasion (options.backtrack_lexer = true).\n' + this.showPosition(), {
                text: "",
                token: null,
                line: this.yylineno
            });

        }
        return this;
    },

// retain first n characters of the match
less:function (n) {
        this.unput(this.match.slice(n));
    },

// displays already matched input, i.e. for error messages
pastInput:function () {
        var past = this.matched.substr(0, this.matched.length - this.match.length);
        return (past.length > 20 ? '...':'') + past.substr(-20).replace(/\n/g, "");
    },

// displays upcoming input, i.e. for error messages
upcomingInput:function () {
        var next = this.match;
        if (next.length < 20) {
            next += this._input.substr(0, 20-next.length);
        }
        return (next.substr(0,20) + (next.length > 20 ? '...' : '')).replace(/\n/g, "");
    },

// displays the character position where the lexing error occurred, i.e. for error messages
showPosition:function () {
        var pre = this.pastInput();
        var c = new Array(pre.length + 1).join("-");
        return pre + this.upcomingInput() + "\n" + c + "^";
    },

// test the lexed token: return FALSE when not a match, otherwise return token
test_match:function(match, indexed_rule) {
        var token,
            lines,
            backup;

        if (this.options.backtrack_lexer) {
            // save context
            backup = {
                yylineno: this.yylineno,
                yylloc: {
                    first_line: this.yylloc.first_line,
                    last_line: this.last_line,
                    first_column: this.yylloc.first_column,
                    last_column: this.yylloc.last_column
                },
                yytext: this.yytext,
                match: this.match,
                matches: this.matches,
                matched: this.matched,
                yyleng: this.yyleng,
                offset: this.offset,
                _more: this._more,
                _input: this._input,
                yy: this.yy,
                conditionStack: this.conditionStack.slice(0),
                done: this.done
            };
            if (this.options.ranges) {
                backup.yylloc.range = this.yylloc.range.slice(0);
            }
        }

        lines = match[0].match(/(?:\r\n?|\n).*/g);
        if (lines) {
            this.yylineno += lines.length;
        }
        this.yylloc = {
            first_line: this.yylloc.last_line,
            last_line: this.yylineno + 1,
            first_column: this.yylloc.last_column,
            last_column: lines ?
                         lines[lines.length - 1].length - lines[lines.length - 1].match(/\r?\n?/)[0].length :
                         this.yylloc.last_column + match[0].length
        };
        this.yytext += match[0];
        this.match += match[0];
        this.matches = match;
        this.yyleng = this.yytext.length;
        if (this.options.ranges) {
            this.yylloc.range = [this.offset, this.offset += this.yyleng];
        }
        this._more = false;
        this._backtrack = false;
        this._input = this._input.slice(match[0].length);
        this.matched += match[0];
        token = this.performAction.call(this, this.yy, this, indexed_rule, this.conditionStack[this.conditionStack.length - 1]);
        if (this.done && this._input) {
            this.done = false;
        }
        if (token) {
            return token;
        } else if (this._backtrack) {
            // recover context
            for (var k in backup) {
                this[k] = backup[k];
            }
            return false; // rule action called reject() implying the next rule should be tested instead.
        }
        return false;
    },

// return next match in input
next:function () {
        if (this.done) {
            return this.EOF;
        }
        if (!this._input) {
            this.done = true;
        }

        var token,
            match,
            tempMatch,
            index;
        if (!this._more) {
            this.yytext = '';
            this.match = '';
        }
        var rules = this._currentRules();
        for (var i = 0; i < rules.length; i++) {
            tempMatch = this._input.match(this.rules[rules[i]]);
            if (tempMatch && (!match || tempMatch[0].length > match[0].length)) {
                match = tempMatch;
                index = i;
                if (this.options.backtrack_lexer) {
                    token = this.test_match(tempMatch, rules[i]);
                    if (token !== false) {
                        return token;
                    } else if (this._backtrack) {
                        match = false;
                        continue; // rule action called reject() implying a rule MISmatch.
                    } else {
                        // else: this is a lexer rule which consumes input without producing a token (e.g. whitespace)
                        return false;
                    }
                } else if (!this.options.flex) {
                    break;
                }
            }
        }
        if (match) {
            token = this.test_match(match, rules[index]);
            if (token !== false) {
                return token;
            }
            // else: this is a lexer rule which consumes input without producing a token (e.g. whitespace)
            return false;
        }
        if (this._input === "") {
            return this.EOF;
        } else {
            return this.parseError('Lexical error on line ' + (this.yylineno + 1) + '. Unrecognized text.\n' + this.showPosition(), {
                text: "",
                token: null,
                line: this.yylineno
            });
        }
    },

// return next match that has a token
lex:function lex () {
        var r = this.next();
        if (r) {
            return r;
        } else {
            return this.lex();
        }
    },

// activates a new lexer condition state (pushes the new lexer condition state onto the condition stack)
begin:function begin (condition) {
        this.conditionStack.push(condition);
    },

// pop the previously active lexer condition state off the condition stack
popState:function popState () {
        var n = this.conditionStack.length - 1;
        if (n > 0) {
            return this.conditionStack.pop();
        } else {
            return this.conditionStack[0];
        }
    },

// produce the lexer rule set which is active for the currently active lexer condition state
_currentRules:function _currentRules () {
        if (this.conditionStack.length && this.conditionStack[this.conditionStack.length - 1]) {
            return this.conditions[this.conditionStack[this.conditionStack.length - 1]].rules;
        } else {
            return this.conditions["INITIAL"].rules;
        }
    },

// return the currently active lexer condition state; when an index argument is provided it produces the N-th previous condition state, if available
topState:function topState (n) {
        n = this.conditionStack.length - 1 - Math.abs(n || 0);
        if (n >= 0) {
            return this.conditionStack[n];
        } else {
            return "INITIAL";
        }
    },

// alias for begin(condition)
pushState:function pushState (condition) {
        this.begin(condition);
    },

// return the number of states currently on the stack
stateStackSize:function stateStackSize() {
        return this.conditionStack.length;
    },
options: {"case-insensitive":true},
performAction: function anonymous(yy,yy_,$avoiding_name_collisions,YY_START) {
var YYSTATE=YY_START;
switch($avoiding_name_collisions) {
case 0:return 51;
break;
case 1:return 50;
break;
case 2:return 49;
break;
case 3:return 48;
break;
case 4:return 47;
break;
case 5:return 9;
break;
case 6:return 18;
break;
case 7:return 13;
break;
case 8:return 56;
break;
case 9:return 57;
break;
case 10:return 25;
break;
case 11:return 10;
break;
case 12:return 11;
break;
case 13:return 12;
break;
case 14:return 16;
break;
case 15:return 19
break;
case 16:return 20;
break;
case 17:return 21;
break;
case 18:return 40;
break;
case 19:return 41;
break;
case 20:return 42;
break;
case 21:return 43;
break;
case 22:return 44;
break;
case 23:return 45;
break;
case 24:return 46;
break;
case 25:return 54;
break;
case 26:return 26;
break;
case 27:return 55;
break;
case 28:return 35;
break;
case 29:
break;
case 30:
break;
case 31:return 52;
break;
case 32:return 53;
break;
case 33:return 24; 
break;
case 34:return 5;
break;
case 35: erroresLexicos.push(new Error(yy_.yylloc.first_line,yy_.yylloc.first_column,1,'',yy_.yytext)); 
						console.error('Este es un error léxico: ' + yy_.yytext + ', en la linea: ' + yy_.yylloc.first_line + ', en la columna: ' + yy_.yylloc.first_column); 
break;
}
},
rules: [/^(?:;)/i,/^(?:\()/i,/^(?:\))/i,/^(?:\[)/i,/^(?:\])/i,/^(?:<)/i,/^(?:>)/i,/^(?:=)/i,/^(?:")/i,/^(?:')/i,/^(?:!)/i,/^(?:\?)/i,/^(?:xml\b)/i,/^(?:version\b)/i,/^(?:encoding\b)/i,/^(?:UTF-8\b)/i,/^(?:ASCII\b)/i,/^(?:ISO859-1\b)/i,/^(?:&lt;)/i,/^(?:&gt;)/i,/^(?:&amp;)/i,/^(?:&apos;)/i,/^(?:&quot;)/i,/^(?::)/i,/^(?:_\b)/i,/^(?:\+)/i,/^(?:-)/i,/^(?:\*)/i,/^(?:\/)/i,/^(?:[ \r\t]+)/i,/^(?:\n)/i,/^(?:[0-9]+(\.[0-9]+)?\b)/i,/^(?:[0-9]+\b)/i,/^(?:([a-zA-Z0-9])[a-zA-Z0-9_nÑ]*)/i,/^(?:$)/i,/^(?:.)/i],
conditions: {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35],"inclusive":true}}
});
return lexer;
})();
parser.lexer = lexer;
function Parser () {
  this.yy = {};
}
Parser.prototype = parser;parser.Parser = Parser;
return new Parser;
})();



if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
    exports.parser = gramarxml;
    exports.Parser = gramarxml.Parser;
    exports.parse = function () { return gramarxml.parse.apply(gramarxml, arguments); };
    exports.main = function commonjsMain (args) {
        if (!args[1]) {
            console.log('Usage: '+args[0]+' FILE');
            process.exit(1);
        }
        var source = require('fs').readFileSync(require('path').normalize(args[1]), "utf8");
        return exports.parser.parse(source);
    };
    if (typeof module !== 'undefined' && require.main === module) {
    exports.main(process.argv.slice(1));
    }
}

define(function () {
    return {
        getParser: function () {
            return gramarxml;
        }
    };
});