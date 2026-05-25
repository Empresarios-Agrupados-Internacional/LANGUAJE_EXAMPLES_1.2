/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE : 
 //Basic Data Types

 	All variables must be declared before use so that the compiler knows what type they are. All identifiers have an associated type, which determines the operations which may be performed on them and how those operations should be interpreted. For example:
		INTEGER i
		REAL v[3]
		Identifier "i" will be associated with an integer variable; identifier v is declared as an array of three real elements. The indexing operator [] is meaningful for v, but not for i; in other words, each identifier has an associated series of operations which are valid, and no other operations are.
		There are four categories of data types in EL:
		 	Fundamental types such as REAL, BOOLEAN, etc. These are simple types commonly used for all types of logical and arithmetic operations.
		 	Enumeration types, ENUM.
		 	Derived types: arrays and SET_OF.
		 	Complex data types: COMPONENT, PORT and CLASS. In reality these are items with a high level of abstraction which contain internal variables, equations, etc.
		This chapter describes the first three categories in detail; complex types are explained in later chapters. The allowed types in the first three categories are:
		TYPE
		NO_TYPE
		REAL
		INTEGER
		BOOLEAN
		STRING
		FILEPATH
		TABLE_1D
		TABLE_2D
		TABLE_3D
		ENUM
		SET_OF
		FUNC_PTR
		OBJ_PTR
		
		NO_TYPE is a special type which is only used to indicate that a function does not return a value. Variables cannot be declared as NO_TYPE.

		Fundamental Data Types
		EL has a series of fundamental basic types which are used both in functions and in components and ports. The table below shows these fundamental types and the typical sizes and ranges in 32 bit machines:
		Name			Comments							Value ranges
		REAL			floating point (64 bits)	+/-1.7E +/- 308 (15 digits)
		INTEGER		integers (32 bits)			2,147,483,648 to 2,147,483,647
		BOOLEAN		Boolean (32 bits)				TRUE, FALSE
		STRING		character arrays				any ASCII string
		FILEPATH		character arrays				any ASCII string (used for file paths)
		TABLE_1D		one dimensional table		Only REAL values
		TABLE_2D		two dimensional table		Only REAL values
		TABLE_3D		three dimensional table		Only REAL values
		FUNC_PTR		function pointer	
		OBJ_PTR		Generic object pointer (using classes)	
		NO_TYPE		Void returns in a function	
		
		The variable declaration format is basically as follows:
		[CONST] data_type name[arrayIndex] [= init_expression] [units] [range] [description]
		Where:
		 	CONST indicates a constant (optional).
		 	data_type is the data type (e.g., REAL, STRING, etc).
		 	name is the identifier of the variable.
		 	arrayIndex indicates the dimensions for an array; e.g., v[6] (optional).
		 	init_expression is the initial value (optional).
		 	units are the units of this variable (optional).
		 	range is the valid range of values (optional).
		 	description is a short explanation of this variable (optional).

-----------------------------------------------------------------------------------------*/
//FILEPATH
/*
The FILEPATH data type is identical to STRING and allows the same operation to be carried out. The only
difference is that if a type is defined as FILEPATH, when the graphical interface is used it allows the user to
select a file path (relative or absolute) using an adequate browser.
The FILEPATH type will normally be used to represent the path of a file. An absolute path, such as the
following, can be represented:
FILEPATH myFile ="C:/ my programmes / files / file3455 . txt"
The relative path of a library can also be represented with the form @LIB_NAME@. For example:
FILEPATH myFile =" @ELECTRICAL@ / data / file45 .txt "
There are three very useful functions for dealing with file paths:
STRING expandFilePath (IN FILEPATH path )
This function, given a relative path to a library, will return an absolute one replacing the relative path by the
absolute one
Function in EL with a file name as an argument.
*/
USE MODELLING_LANGUAGE_OBJECTS

FUNCTION NO_TYPE func_readPath(IN FILEPATH file)
DECLS
BODY
        WRITE("\n\tPath file: %s\n", file) 
END FUNCTION
// Data Types
/*
EL has a series of fundamental basic types which are used both in functions and in components and ports. The
table below shows these fundamental types and the typical sizes and ranges in 32 bit machines:
Name Comments Value ranges
REAL floating point (64 bits) +/-1.7E +/- 308 (15
digits)
INTEGER integers (32 bits) -2,147,483,648 to
2,147,483,647
BOOLEAN Boolean (32 bits) TRUE, FALSE
STRING character arrays any ASCII string
FILEPATH character arrays any ASCII string
(used for file paths)
TABLE_1D one dimensional table Only REAL values
TABLE_2D two dimensional table Only REAL values
TABLE_3D three dimensional table Only REAL values
FUNC_PTR generic function pointer
FUNC_PTR<functionPrototype> specific function pointer to a function with a given
signature (arguments and return type)
OBJ_PTR Generic object pointer (using classes)
NO_TYPE Void returns in a function
User
*/
COMPONENT comp_data_types
	DECLS
		// REAL, INTEGER
		REAL x
		REAL y = 1.2387 RANGE 0.5,1.5 
		REAL speed1= 3.34  UNITS "m/s" RANGE 0,100 "This is the aircraft speed"
		INTEGER k = 5
		INTEGER  j[2] = { 0, 1 }
		REAL l,m = 7.8
		--REAL n= 4, o= 5   -- Syntax error
		REAL n= 4
		REAL o= 5
		REAL speed, maxLimit
		REAL v1[4]= { 0.23, 23.45, 87.3, .8 }
		REAL v[4,5,8]= 0.24
		//BOOLEAN
		BOOLEAN b
		BOOLEAN isOpen= FALSE       
		BOOLEAN val[3]   "array of three Booleans"
		// STRING
		STRING initialState = "START"
		STRING finalState = "END"
		STRING finalPath
		// FILEPATH
		/*
		The FILEPATH data type is identical to STRING and allows the same operation to be carried out. The only
		difference is that if a type is defined as FILEPATH, when the graphical interface is used it allows the user to
		select a file path (relative or absolute) using
		*/
		FILEPATH myFile ="@MODELLING_LANGUAGE@/data/file45.txt"
		FILEPATH myFile1 ="../data/file45.txt"
		STRING myFile2 = "C:/my programmes/files/file3455.txt"
		// TABLES
		// EL allows using more complex data types such as tables. These are groups of tabulated data which for given input values 
		// have an associated return value.	All values in a table must be of REAL type
		// Dimension 1: These are declared with the keyword TABLE_1D.
		// They are data tables for which one input value returns a single output, so they have the form a=table(X)
		TABLE_1D tab= { { 0, 0.5, 1},    -- X values
                {67.23, 4.83, -3.23} } -- output
		// Dimension 2: These are declared with the keyword TABLE_2D. 
		// These are tables of real values, for which a pair of input values returns a single output. They have the form a=table(X,Y)
		TABLE_2D t = {  { 1, 2},   	-- X values
			{ 0.9 ,1.0, 1.2 }, 			-- Y values
			{ {4,6,7} , { 2, 3, 2 } } }-- output
		// Dimension 3. These are declared with the keyword TABLE_3D. 
		// These are tables of real values, for which a triplet of input values returns a single output. They have the form a=table(X,Y,Z).
		TABLE_3D tbl = {  {  1.,  2. },          		-- X values
              { -1., -2., -3.},      					-- Y values
              {  4,   5 },           					-- Z values
              { {{ 1.,2.} ,{ 3.,4.} ,{ 5.,6.} } ,  -- output
				  {{ 11.,12.} , {13.,14.} , {15.,16.}}}
				  }
		// Enumeration Types
		// Enumerative types can be defined by means of ENUM data types
		ENUM Chemicals= {N2, O2,H2O, CO2 }
		// Variables of the "Chemicals" type can be declared
		ENUM Chemicals v2, w2
		CONST ENUM Chemicals water = H2O
		REAL v3[Chemicals]
		// Derivated types
		// Arrays
		/*
		   EL supports data arrays. An array is a collection of data items stored contiguously in memory, each accessed by its index.
		   Arrays are dimensioned with constants or parameters of type integer, 
		   enumeration ENUM or SET_OF derived types.
		*/
		REAL v4[2,3]
		INTEGER i4[2,3,2]
		BOOLEAN b4[2]
		ENUM Chemicals v5[2]
		ENUM Chemicals w6[Chemicals]
		STRING Colors4[3]
		// derivated types , initialized
		REAL v7[2,3]= { {1,2,3},{ 4,5,6 } }
		INTEGER  i7[2,3,2]= { { {1,2},{3,4},{5,6}},{{7,8},{9,10},{10,11}}}
		BOOLEAN b7[2]= { FALSE, TRUE }
		ENUM Chemicals v8[2]= { H2O, H2O }
		ENUM Chemicals  w8[Chemicals]= {N2, O2,H2O, CO2} 
		STRING colors5[3]= { "red", "white", "black" }
		REAL v9[2] = 2.3
		REAL V9[2] = { 2.3, 2.3 }
		// SET_OF
		// SET_OF types are another derived type, based on enumeration types. They are similar to ENUM and have only two allowed operations. 
		// They are mainly used as construction parameters passed to components and ports
		SET_OF(Chemicals) Air = {N2, O2, H2O, CO2} 
		SET_OF(Chemicals) Water = {H2O}
		//Global Variables and Types
		DISCR REAL x2           -- x2 will be a discrete variable
		INTEGER i               
		STRING name= "Fred"     -- but better use CONST STRING
		REAL x3                 
		ALG REAL x4             -- recommended as algebraic if is inside an algebraic loop
		PRIVATE DISCR REAL v6[3]-- array "v6" not visible in experiments
		//Error Codes Global Variables
		ENUM t_statusIntegration CODE_STATUS 
		STRING  CODE_ESI
	INIT
		x=1
		speed = 0.878
		maxLimit = 0.7
		IF(speed >= maxLimit) THEN
			l = (speed*x)/(1-exp(2))
		END IF
		IF (isOpen == TRUE) THEN
			b = FALSE
		END IF
		initialState = "END"
		initialState = finalState
		IF ( initialState == finalState ) THEN
			finalState = "END"
		END IF
		// Expand filepath
		// This function, given a relative path to a library, will return an absolute one replacing the relative path by the absolute one.
		finalPath= expandFilePath( myFile1 )
		WRITE("\tFinalPath: %s\n", finalPath)
		// This function expands the file path and returns TRUE if the file passed to it as an argument exists, and FALSE if it does not exist.
		IF( existsFile( myFile ) == TRUE ) THEN
	      WRITE("\tThe file has been found\n")  -- the file has been found
		ELSE
			WRITE("\tThe file has not been found\n")  -- the file has not been found
		END IF
		// Functions
		// External function in C++ and Fortran with a files name as an argument
		func_readPath(myFile1)	--EL function
		external_objects_manual_ext(myFile1, myFile2) -- external C++ function
		external_objects_manual_ext_f(myFile2, myFile2) --external Fortran function
		// array indexing
		v3[CO2]= 7.3244
		// The function "setofElem(SET_OF(t) set,int n)" is used to return the nth element inside the SET_OF set
		w2 = setofElem(Air,2)
		WRITE("\tsetofElem Air postion 2 : %d\n", w2)
		// The function "setofPos(SET_OF(t) set,ENUM t elem)" returns the position of element "elem" inside the SET_OF "set". 
		k = setofPos(Air, H2O)
		WRITE("\tsetofPos Air H2O : %d\n", k)
		// The function "setofSize(SET_OF(t) set)" returns the number of elements in "set".
		k = setofSize(Air)
		WRITE("\tsetofSize Air: %d\n", k)
END COMPONENT
//FUNC_PTR
/*
EL also allows function pointers. There are two types of function pointers: generic function pointers (eg
FUNC_PTR ptr) and specific function pointers (eg FUNC_PTR<myFunPtrType>).
Specific function pointers.
In this case, the user needs first to define the type of function with the TYPEDEF statement:
TYPEDEF FUNCTION REAL ptrFun (IN REAL a, OUT STRING b)
This definition states that the function type "ptrFun" has 2 arguments. The first argument is IN REAL and the
second, OUT string and it is returning a real value. Then, the user can create a pointer to this type of function,
but you will always need to initialize to a valid function.
*/
TYPEDEF FUNCTION REAL func_ptrFun (IN REAL a, OUT STRING b)
FUNCTION REAL func_example1 (IN REAL a, OUT STRING b)
	BODY
		RETURN a+10
END FUNCTION

COMPONENT comp_func_ptrFun
	DECLS
		FUNC_PTR <func_ptrFun > ptr= func_example1
END COMPONENT
// Objet pointers
/*
A pointer is a variable containing the memory address of an instance of a class in EL.  There are times when the programmer does not want to have a copy of an object but only its memory address in order to use it. For example, when you pass an instance of a class as an argument to a function or method in OUT mode, you are actually passing a pointer to that object: For example:
FUNCTION NO_TYPE func_setPerson(OUT Person p1)  -- p1 is passed as a pointer
We are actually using a pointer, as "p1" will be a pointer to an object of the "Person" class. Be careful: if the argument is defined as IN, a pointer will no longer be passed to the object, but rather a copy of it. In other words:
FUNCTION NO_TYPE func_setPerson(IN Person p1)    -- p1 is passed as a copy
Now a local copy of the object p will be made in p1, which is known as passing an object by copy; however, if it is done in OUT mode (the default) we say it is passed by reference or by pointer. When passing instances of classes, if the user does not specify IN or OUT, the compiler will assume OUT by default. Let's look at a more complete example using classes, which will be covered in a later chapter
*/
CLASS class_person
DECLS
	STRING m_name
	INTEGER m_age
END CLASS

FUNCTION NO_TYPE func_setPerson(OUT class_person p1)  -- p1 is an object pointer
BODY
	p1.m_name= "John"
	p1.m_age= 43
END FUNCTION

COMPONENT comp_person
OBJECTS
	class_person p
INIT
	func_setPerson(p)
	WRITE("p.m_name= %s, p.m_age= %d\n",p.m_name,p.m_age)
END COMPONENT

COMPONENT comp_person2
OBJECTS
	class_person p
	OBJ_PTR<class_person> ptr_p
INIT
	ptr_p= p
	func_setPerson(ptr_p)
   WRITE("ptr_p.m_name= %s, ptr_p.m_age= %d\n",ptr_p.m_name,ptr_p.m_age)
END COMPONENT


// SET_OF Default Values
/*
As in the case of construction parameters of the INTEGER type, BOOLEAN type, etc, 
the SET_OF values also admit default values when declared
*/
ENUM chemicals = { CO2, H2O, O2}
SET_OF(chemicals) mset = {O2}
COMPONENT comp_setofdefaultValues (SET_OF(chemicals) mix = mset)
	DATA
		REAL v[mix]=2
END COMPONENT
// When this component is used within another one, initialization of the "mix" parameter is optional. 
// If we initialize it, it uses the new SET_OF value; 
// if not, it will use the default value
COMPONENT comp_setofdefaultValuesEnum
	DECLS
		SET_OF(chemicals) setBis = {CO2, H2O}
	TOPOLOGY
		comp_setofdefaultValues(mix = setBis) foo1
		comp_setofdefaultValues foo2
END COMPONENT

//Template classes in EL
/*
In EL there are some special classes that allow a template type as target object. These special classes will be
 explained later in the chapter entitled "Container classes".
The template class syntax is as follows: EContainer < TargetType >
However, those definitions are not allowed directly in EL. To use a template class you are obliged to use
TYPEDEF to define a new class name that can be used later on as a regular class
*/
//Use TYPEDEF for advanced definitions of data types
//Defining function prototypes with TYPEDEF
/*
When pointers to functions are used, users have to specify the arguments and return type that the functions
will use to verify that the functioned passed is correct. With TYPEDEF we can create definitions of functions
and assign a name to them. For example:
TYPEDEF FUNCTION REAL funType1 ( REAL a, STRING comment )
This line defines a generic function call "funType1" that has two arguments; the first of type REAL and the
second of type STRING, and it returns a REAL.We can use this generic type called funType1 mainly when we
use pointers to functions.
EL provides several types of definitions of functions with names like "eFunTypeX", where X is an order number.
These types are used later in system pointers to functions. The predefined types are as follows:
TYPEDEF FUNCTION NO_TYPE eFunType1 ()
TYPEDEF FUNCTION NO_TYPE eFunType2 ( REAL v)
TYPEDEF FUNCTION NO_TYPE eFunType3 (OUT REAL time ,OUT REAL dyn [], OUT REAL der [], OUT
REAL res [])
TYPEDEF FUNCTION REAL eFunType4 ( INTEGER index , ENUM t_steadyMethods typeTol , REAL
lhs , REAL rhs , REAL ref)
TYPEDEF FUNCTION NO_TYPE eFunType5 (OUT INTEGER n,OUT REAL dyn [], OUT REAL fres [], OUT
INTEGER iflag )
TYPEDEF FUNCTION INTEGER eFunType6 ()
TYPEDEF FUNCTION REAL eFunType7 ( REAL v)
TYPEDEF FUNCTION NO_TYPE eFunType8 (OUT REAL left [], OUT REAL right [])
TYPEDEF FUNCTION BOOLEAN eFunType9 ( REAL mtime , REAL mdyn [], REAL mder [])
TYPEDEF FUNCTION NO_TYPE eFunType10 ( REAL mtime ,OUT REAL mdyn )
If users need a different type of function, they just need to declare it in another TYPEDEF statement. Please
refer to chapte entitled "Using pointers to function effectively" for more information and examples
*/
CLASS class_example
END CLASS
//Defining new classes with TYPEDEF
/*
When template classes are used in EL, the TYPEDEF statement can be used to define a new type of class
inherited from the template class applied to a specific class. For example, in the previous section we wrote two
wrong statements to declare some variables of template classes. You would need to create new typedef types
as follows
*/
TYPEDEF CLASS MyVectorReal IS_A EVector <REAL > -- ok
TYPEDEF CLASS MyMatrixExample IS_A EMatrix < class_example > -- ok
//Now, the new classes MyVectorReal and MyMatrixExample can be used just like any other class, for instance
FUNCTION NO_TYPE func_testTypedef ()
	OBJECTS
		MyVectorReal mr
		MyMatrixExample me
		class_example ex
	BODY
		mr. append (3.14)
		me. set (1,1, ex)
END FUNCTION


// Characteristics of Variables
// Constants
/*
EL allows the use of constants. When a variable is declared with the qualifier CONST, this indicates that it should remain constant
*/
CONST REAL const_PI = 3.141592
CONST INTEGER const_numberOfValves = 5
// Units
/*
When a variable is declared, the user may specify the units by using the reserved word UNITS followed by a string
*/
COMPONENT comp_units
	DATA
		REAL speed        UNITS "m/s"
		REAL acceleration UNITS "m/s**2"
	DECLS
		//STRING type constants and then use them as units
		PRIVATE CONST STRING u_speed= "m/s"
		PRIVATE CONST STRING u_accel= "m/s**2"
		REAL speed1        UNITS u_speed
		REAL acceleration1 UNITS u_accel
		// Description of variables
		REAL speed2 UNITS "m/s" "This is the aircraft speed"
		// Variable Range
		REAL v RANGE 0.5,1.5
END COMPONENT
//Scope of Variables
/*
A declaration introduces an identifier in a scope. In other words, an identifier can only be used in a specific part of a program.
For example, if a variable is declared in a function, that variable is only in scope in the BODY of that function, but nowhere else; it has local scope. An identifier declared outside a function, component or port in a library can be used from anywhere in that library or from outside it by specifying the library name;
it has global scope.
*/
REAL global_x = 2 -- global variable 
COMPONENT comp_scopeVariables
	DECLS
		REAL v,v1,x -- local variables
	CONTINUOUS
		v = x + 5 -- equation
		v1 = MODELLING_LANGUAGE.global_x + 5
END COMPONENT


