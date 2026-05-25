/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: include
 COMMENTS:
 // Include Files and Macros

// Include Files
	This feature provides a pre-processing capability based on a C++ pre-processor. The user can create external .el files and then include them in other files by means of a 
	You can include this file in other file in different ways: relative to the include directories, relative to an absolute path from a library, or relative to an environment variable. For example, if you use the first approach you write the include statement using the bracket symbols <>
	In this case, the program will look for the file by default in the following directories:
	 	In the include directory of the actual library.
	 	In the include directory of program_dir\external\include.
	 	In any path pointing to the environment variable INCLUDE.
 		If you want to put the file in another location, you can include it using the absolute path in between quotation marks "". For example:
	Using an absolute path:
		--#include "C:/myIncludes/include/myFunctions.el"
	or using a relative path to a library:
		--#include "@ELECTRICAL@/include/myFunctions.el"
	or using a relative path from a system environment variable:
		--#include "%MY_INCLUDES%/myFunctions.el"
	This include capability has some limitations: in library source code files (extension .el) they can be used only at the beginning of the file, whereas in experiment files (extension .exp) they can be used at any part of the file.

//	Macros
	The use of C++ macros in EL provides a powerful mechanism to simplify the modelling of repetitive structures. For instance, the following component uses two dimensional arrays and we want to initialise them to a specific value
	It is possible to create another .el file implementing a macro for initialisation of this type of array.
	This is the C++ syntax for defining macros (get further information from any C++ pre-processor book).


	The use of C++ macros in EL provides a powerful mechanism to simplify the modelling of repetitive structures. For instance, the following component uses two dimensional arrays and we want to initialise them to a specific value:
	COMPONENT testMacro1
	    DECLS
	        REAL v[4,3,5]
	        REAL r[2,1,4]
	    CONTINUOUS
	        EXPAND(i IN 1,4)
	            EXPAND( j IN 1,3)
	                EXPAND( k IN 1,5)
	                    v[i,j,k] = 3.14
	        EXPAND(i IN 1,2)
	            EXPAND( j IN 1,1)
	                EXPAND( k IN 1,4)
	                    r[i,j,k] = 6.18
	END COMPONENT
	It is possible to create another .el file implementing a macro for initialisation of this type of array. For example, for the previous example it is possible to create a file named macros.el with the following macro code:
	--#define INIT_V3D(vect,i1,i2,i3,init) \
	EXPAND( i IN 1,i1) \
	    EXPAND( j IN 1,i2) \
	        EXPAND( k IN 1,i3) \
	            vect[i,j,k] = init
	This is the C++ syntax for defining macros (get further information from any C++ pre-processor book). The macros need a \ symbol at the end of each line (be careful not to put any character after this). With this macro the C-C++ pre-processor will replace the INIT_V3D() macro with this code. Now we can write the testMacro1 component as:




-----------------------------------------------------------------------------------------*/
COMPONENT comp_includeFiles
END COMPONENT
#include "@MODELLING_LANGUAGE@\includeFiles\macros.el"
COMPONENT comp_includeMacros
  DECLS
        REAL v[4,3,5]
        REAL r[2,1,4]
    CONTINUOUS
        INIT_V3D(v,4,3,5,3.14)
        INIT_V3D(r,2,1,4,6.18)

END COMPONENT
