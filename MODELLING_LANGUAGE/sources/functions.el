/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE:
 //functions
 COMMENTS:
 	Functions in Program are similar to those in other programming languages like FORTRAN or C. A function is a piece of code that carries out operations and optionally returns a value. Functions are used for a wide range of problems; for example:
 		Evaluate a numerical formula and return a value
 		Reuse tried and tested functions
 		Encapsulate frequently used code
	The program is supplied with a library of basic commonly-used functions, such as sin(x), sqrt(x), etc. These functions can be used anywhere in EL where they are compatible (refer to Appendix B for a complete list of built-in functions).
	Functions in EL must be defined before they are used. External functions written in FORTRAN, C or C++ must be pre-declared.
	The syntax is :
	FUNCTION data_type IDENTIFIER( argument-list ) STRING_VALUE?  EOL*
         ( DECLS Local-variables )?
         ( OBJECTS class_instace_stm_s  )?  
    BODY
        Sequential-stms
	END FUNCTION
	Function return types fall into the following categories:
 		Standard types, such as REAL, INTEGER, STRING and BOOLEAN
 		1, 2 and 3 dimensional tables: TABLE_1D, TABLE_2D, TABLE_3D
 		Function pointer: FUNC_PTR
 		Enumeration, specifying the type
 		NO_TYPE if the function doesn return any value
	The argument list syntax is:
	[IN | OUT] data-type IDENTIFIER (= init_value)? COMMENT?

-----------------------------------------------------------------------------------------*/
//sqrt(x) is a function from the standard library, mySquare(x) is a user-defined function which returns the square of a number passed as an argument
FUNCTION REAL func_mySquare( REAL x ) "calculates a square"
    BODY
        RETURN x * x
END FUNCTION
// Argument List
-- If the argument has the IN prefix, this indicates that it is passed by value. OUT indicates that it is passed by reference and the value of the call variable will be updated
FUNCTION NO_TYPE func_square(IN REAL x,OUT REAL y) "square example"
    BODY
        y = x * x
END FUNCTION
/*
IMPORTANT: When you are passing arrays as arguments the array is passed as reference (OUT mode), even if you use the IN prefix,
				but it is very important to inform the compiler about this for the equations sorting algorithms to know if this array is calculated by the function (OUT mode) or it is just passed as input (IN mode).
				Be aware of the side effects of not respecting the convention of the prefix. 
*/
FUNCTION NO_TYPE func_calculate2(IN REAL x,IN REAL v[],IN INTEGER size_v)
BODY
   v[1]= 3
   x= 4.5 + v[1]
END FUNCTION
// BODY Block
/*
	The body contains all the functions sequential instructions. The syntax is:
	BODY
    	sequential-stms
	All the sequential statements are allowed, including:
 		Assignments
 		Function calls
 		IF-THEN-ELSE conditional statements
 		FOR and WHILE loops
 		Assertions with ASSERT statement
 		RETURN statements to return control

*/
FUNCTION REAL func_bodyBlock_max(REAL x, REAL y)
    BODY
        IF (x > y ) THEN
            RETURN x
        END IF
        RETURN y
END FUNCTION

//Argument List
//Can also use objects (instances of classes) as arguments
CLASS class_myClass
METHODS
   METHOD REAL add(IN REAL a, IN REAL b)
   BODY
      RETURN a+b
   END METHOD
END CLASS
FUNCTION REAL func_add(class_myClass pt, IN REAL a,IN REAL b)
BODY
     RETURN pt.add(a,b)
END FUNCTION
// Check Integration Step Reduction
FUNCTION REAL func_fdis (IN REAL x)
    DECLS
        REAL y
    BODY
        IF (x < 5.333) THEN
            y = 1
        ELSE
            y = 2000 --introduces a big discontinuity
        END IF
        RETURN y
END FUNCTION
// Check Residues Function Repeatability
REAL global_GG= 1.0  -- global variable
FUNCTION REAL func_mmm(IN REAL v)
    BODY
        global_GG = global_GG + 1.0         	-- increase global variable
        RETURN v + cos(v) + global_GG  	-- this is wrong, there is a side effect adding GG
END FUNCTION






