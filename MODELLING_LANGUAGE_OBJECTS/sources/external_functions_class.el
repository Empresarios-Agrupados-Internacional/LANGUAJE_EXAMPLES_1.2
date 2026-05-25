/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: Using External C, C++ and FORTRAN Functions
 COMMENTS:
 	EL allows you to reuse existing functions written in C, C++ or FORTRAN. There are very powerful libraries available commercially which supply a wide range of mathematical functions (optimisation, properties calculation, etc).
	Using these libraries or others you have developed yourself expands the power of the EL modelling language.
	To use an external function from EL, you first have to pre-declare its interface. The only difference between using one language or another is in the header declaration
	You can use the modifiers IN and OUT to force variables to be passed by reference or by value. In FORTRAN, variables are always passed by reference.
	Permitted types for external FORTRAN functions are limited: only REAL, INTEGER, STRING, FUNC_PTR and ARRAY. As return types are valid, the same types can be used, except the STRING type.
	Before compiling, you need to specify the object libraries where your external functions are placed
-----------------------------------------------------------------------------------------*/
-- function used to external_objects
"C++" FUNCTION NO_TYPE external_objects_manual_ext(STRING RUN_PATH, STRING RUNPATH2) --path where the simulation is run
IN "external_objects_manual_ext.lib"
"C" FUNCTION NO_TYPE external_objects_manual_ext_c(STRING RUN_PATH) --path where the simulation is run
IN "external_objects_manual.lib"
"FORTRAN" FUNCTION NO_TYPE external_objects_manual_ext_f(STRING RUN_PATH1, STRING RUNPATH2) --path where the simulation is run
IN "external_objects_manual.lib"
// Using C++ Classes from EL
/*
	EL allows C++ external classes to be reused in EL. To do this, a class that is to be used as an interface for the C++ classes has to be pre-declared in EL. The general format to define a CLASS in EL is as follows:
	class_def ::= EXTERN? CLASS IDENTIFIER EOL*  
	 		( IS_A scoped_id_s EOL*)? 
		 		STRING_VALUE?  EOL*
		 	( DECLS     var_object_decl_s )?
		 	( OBJECTS  class_instace_stm_s )?
	          	( METHODS  extern_method_def_s )?    
	           	 END CLASS EOL*
			(INCLUDE EOL* STRING_VALUE)? EOL* (IN EOL* STRING_VALUE+ EOL)? 
	
	extern_method_header ::= EXTERN METHOD data_type IDENTIFIER
	         		     '(' EOL* func_arg_decl_s ')' STRING_VALUE?
	It is necessary to use the word EXTERN before the CLASS word and before the METHOD declarations. The method must be a pure declaration without body.
	Finally, the header file must be stated (using INCLUDE directive) and the library where the C++ class can be located.
	By default, the include files should be located in the "include" directory of the library and the libraries in the "lib" library. If they are not found there they will be found in the directory external/include and external/lib
	The following elements can be distinguished in this interface:
 		The word EXTERN indicates that it is an externally defined class. The word EXTERN must also be used for each of the methods
 		The class has a variable of type REAL called "m_val"
 		It has two public methods that may be accessed, and each of these has two real input arguments and one REAL-type return argument
 		The file that defines the class header is in mmath.h (normally located in LIB_DIR/include)
 		The library that contains the definition of the C++ class is testCpp.lib (normally located in LIB_DIR/lib)
	This class could then be used from any component, method, function or experiment. For this purpose, the above definition would have to be compiled, and then the mmath class would appear as an additional item of the library
*/
EXTERN CLASS external_class_example
METHODS
	EXTERN METHOD REAL add (IN REAL  a, IN REAL  b)
	EXTERN METHOD REAL subs (IN REAL  a, IN REAL  b)
END CLASS INCLUDE "external_class_example.h" IN "external_class_example.lib" 
