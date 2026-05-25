/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: 
 //Language Elements 
 //1.2.7.1. 	Arithmetic Expressions
 COMMENTS: Arithmetic Expressions
 	These are used in arithmetic operations. The BNF syntax is given in Appendix C. The syntax can be used to represent all types of mathematical operations. It allows the creation of expressions of any degree of complexity using numeric literals, variables, function calls or the summation operator SUM.
	The table below shows the arithmetic operators allowed in EL in descending order of precedence
		 Operator	Description		Expression		Input type	Output type	Precedence-Associativity
			**			power				expr ** expr	Numeric		Numeric		right
			+			unary plus		+ expr			Numeric		Numeric		none
			-			unary minus		- expr			Numeric		Numeric		none
			*			multiply			expr 	* expr	Numeric		Numeric		left
			/			divide			expr / expr		Numeric		Numeric		left
			+			add				expr + expr		Numeric		Numeric		left
			-			subtract			expr  expr		Numeric		Numeric		left

	For each operator the table specifies which types of expressions are allowed (input type), and the type of the evaluation result (output type). For example, for addition the operator takes two numeric expressions, adds them and generates a new numeric expression.
	Operator precedence is very important and defines the order of evaluation of expressions. The power operator has highest precedence, then the unary + and - operators, while the addition and subtraction have the lowest. If two similar operators are adjacent, either the left- or the right-hand operator has precedence. The table shows which operator has precedence: to the left in all cases except for power (**) which is to the right. For example, the expression x** y**z is equivalent to x**(y**z), but if precedence was to the left it would have been equivalent to ((x**y)**z) which would be incorrect

	SUM Operator
	This is a special numeric operator. It is a language construct which is valid in any numeric expression. Basically it represents an algebraic sum
	
	Relational Expressions
	These compare operands. The operands must be valid for the corresponding comparison operator. They are used to compare expressions; the output type is always a BOOLEAN. EL provides the following relational operators:
	Operator	Description			Expression		Input type	Output 									type	Associativity
	>			greater				Expr > expr		Numeric		BOOLEAN									left
	>=			greater or equal	Expr >= expr	Numeric		BOOLEAN									left
	< 			lower					Expr < expr		Numeric		BOOLEAN									left
	<=			lower or equal		Expr <= expr	Numeric		BOOLEAN									left
	==			equal					Expr == expr	Numeric, 	String, ENUM, Boolean	BOOLEAN	left
	!=			not equal			Expr != expr	Numeric, 	String, ENUM, Boolean	BOOLEAN	left
	
	The following examples are valid relational expressions:
		7 > ( x  y)			
	name == "capacitor"  
		8.88e-3 <= getPrecision(x)
	
	Logical Expressions
	Like mathematical expressions, EL allows logical expressions.
	The table below shows the logical operators provided by EL in descending order of precedence:
	Operator	Description		Expression		Input type	Output type	Precedence
	NOT		not operator	NOT expr			BOOLEAN		BOOLEAN		left
	AND		and operator	Expr AND expr	BOOLEAN		BOOLEAN		left
	OR			or operator		Expr OR expr	BOOLEAN		BOOLEAN		left

-----------------------------------------------------------------------------------------*/

// Simple case: the operator is applied only to an array. 
//	In this case it is recommended to use a function for adding the values.
FUNCTION REAL func_sumArray(IN INTEGER from,IN INTEGER to, IN REAL v[])
DECLS
        REAL tmp= 0.0
BODY
        FOR(i IN from,to)
            tmp = tmp + v[i]
        END FOR
        RETURN tmp
END FUNCTION
//These are used in arithmetic operations. The experiment call the functions sumArray
COMPONENT comp_aritmetic_expresions
END COMPONENT
//In this case a SEQUENTIAL block is much more efficient and faster
//Complex case: the expression to be added is more complex than an array, for example:
//dp_inertia = SUM (i IN 1 ,3; inertia_n [i ]+4*( sqrt (ang[i])))
//Note: Using the SUM operator with a big range could lead easily to surpassing the compiler limits
COMPONENT comp_aritmetic_expresions_sequential
	DECLS
		REAL dp_inertia
		REAL inertia_n[5] = 5
		REAL ang[5]= 4
	CONTINUOUS
	SEQUENTIAL
	  dp_inertia = 0.0
	  FOR(i IN 1,3)
		dp_inertia = dp_inertia + (inertia_n[i]+4*(sqrt(ang[i])))
	  END FOR
	END SEQUENTIAL
END COMPONENT
