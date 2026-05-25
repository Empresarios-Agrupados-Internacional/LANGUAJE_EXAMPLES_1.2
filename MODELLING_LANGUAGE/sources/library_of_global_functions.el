/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: library_of_global_functions

-----------------------------------------------------------------------------------------*/
// Library of global functions
// Mathematical Functions
/*
	Note: for trigonometric function all arguments are in radians:
	 	sin: Sine of arg in the range [-1.0 ; 1.0]. If arg is infinite, NAN will be returned and domain error.
	REAL sin(REAL arg)
	 	cos: Cosine of arg in the range [-1.0 ; 1.0]. If arg is infinite, NAN will be returned and domain error.
	REAL cos(REAL arg)
	 	tan: Tangent of arg. If arg is infinite, NAN will be returned and domain error.
	REAL tan(REAL arg)
	 	asin: asin of arg.
		arg - floating point value in the range [-1.0; 1.0].  
		arc sine of arg in radians in the range of [-PI/2; PI/2] radians. If arg is out of range, NAN is returned.
	REAL asin(REAL arg)
	 	acos: acos of arg.
		arg  real value in the range [-1.0; 1.0]. If arg is outside this range, domain error is raised. 
		arc cosine of arg in radians in the range of [0; PI] radians. If arg is out of range, NAN is returned.
	REAL acos(REAL arg)
	 	atan: arc tangent of arg in the range of [-PI/2; PI/2] radians.
	REAL atan(REAL arg)
	 	atan2: inverse tangent of y/x in the range of [-PI; PI] radians. Note that in other tools (eg Excel) the definition is different.
	REAL atan2(REAL y, REAL x)
	 	sinh: hyperbolic sine of arg.
	REAL sinh(REAL arg)
	 	cosh: hyperbolic cosine of arg.
	REAL cosh(REAL arg)
	 	tanh: hyperbolic tangent of arg.
	REAL tanh(REAL arg)
	 	sqrt: square root of arg.
	REAL sqrt(REAL arg)
	 	exp: floating power number to raise e to arg e raised to the power arg. If the result is too large for the underlying type, range error is raised.
	REAL exp(REAL arg)
	 	log: natural logarithm of arg. NAN is returned if arg is negative. arg - must be > 0.
	REAL log(REAL arg)
	 	log10: base 10 logarithm of arg. NAN is returned if arg is negative. arg - must be > 0.
	REAL log10(REAL arg)
	 	abs: absolute value of arg ( |arg| )
	REAL abs(REAL arg)
	 	ssqrt: It is the sqrt() with sign. It returns the sqrt(arg) if arg is positive; if not, it returns the -sqrt(-arg).
	REAL ssqrt(REAL arg)
	 	spow2: It is the pow() with sign. If arg is positive returns arg*arg; if not, it returns -arg*arg.
	REAL spow2(REAL arg)
		Other interesting functions are:
	REAL floor(REAL arg)
		Returns the nearest integer not greater than arg. Eg floor(4.3) and floor(4.8) returns 4.0, floor(5.0) returns 5.0.
	REAL ceil(REAL arg)
		Returns the nearest integer not less than arg. Eg ceil(4.0) returns 4.0, ceil(4.1) returns 5.0, ceil(4.9) returns 5.0 and ceil(5.1) returns 6.0.
	REAL modf(IN REAL x, OUT REAL intpart)
	 	x - real value 
	 	intpart  integer part of  x
		Breaks x into an integral and a fractional part. The integer part is stored in the object pointed by intpart, and the fractional part is returned by the function. Both parts have the same sign as x
	REAL ldexp(REAL x, INTEGER exp)
	 	x- floating point value representing base.
	 	exp - floating point value representing exponent.
		Returns a real value composed from base and exponent (x * (2 ** exp)) 
	INTEGER rem (INTEGER x, INTEGER y)
		Returns the remainder of a the integer division x/y. Eg rem(8,3) returns 2.
	BOOLEAN areEqualReal (REAL x, REAL y, REAL tol=-1)
		Returns TRUE if x and y are equal and if they are separated with a maximum separation of tolerance tol. In other words if abs(x-y) < tol.
		By default (when tol=-1) the minimum allowed epsilon of the machine is used (eg in Windows 32 it is approx. 2.22E-16). The user can optionally provide other tolerances.
	BOOLEAN isZeroReal (REAL x, REAL tol=-1)
		Returns TRUE if x is zero or close to zero with a tolerance tol. In other words if abs(x) < tol.
		By default (when tol=-1) the minimum allowed epsilon of the machine is used (eg in Windows 32 it is approx. 2.22E-16). The user can optionally provide other tolerances.
	REAL fsqrt(REAL x, REAL xlam)
		This is a special function for calculating the square root of the absolute value of x with original sign. The additional argument xlam is used for making linear the result if x is in range [-xlam,xlam]. The behaviour of the function is shown in the following figure: where xlam is equal to 0.5
	REAL fpow2(REAL y,REAL ylam)
		This is a special function for calculating the square of y. The additional argument ylam is used for making linear the result if y is in range [-ylam,ylam]
	REAL dfsqrt(REAL x, REAL xlam)
		This is a special function for calculating the derivative of the square root of the absolute value of x with original sign. The additional argument xlam is used for making linear the result if x is in range [-xlam,xlam]. The behaviour of the function is shown in the following figure xlam is equal to 0.5
		This function removes the infinite value of the derivative closed to zero.
	REAL dfpow2(REAL x, REAL xlam)
		This is a special function for calculating the derivative of the square of the absolute value of x with original sign. The additional argument xlam is used for linearizing the result if x is in range [-xlam,xlam].


*/
COMPONENT comp_mathematicalFunctions
	DECLS
		  REAL x
        REAL y
   CONTINUOUS
        1.645 = x + y * 1e-6
		  2.3445e-6 * x + 3e-6 * y = 3.454

END COMPONENT
// Check the Validity of a REAL Number
/*
	Many times is important to maintain the integrity of the real variables in the model and check that they are representing valid numbers and not an infinite, undetermined values, etc. It is a common source of problems when any operation produces these non-valid numbers.
	The function validReal() can be used to check that a real number (REAL type) represented is valid, i.e. that it is not a Not-A-Number (#NAN) or indeterminate (#IND).  The signature of the function is:
	BOOLEAN validReal(REAL arg)
	If it returns TRUE, the number is valid, otherwise it returns FALSE. The usage of this function is especially interesting in the following cases:
	When no extra code for mathematical operations (eg, division by zero) is produced in the partition and the experiment code (flag "Edit->Options->Run-time speed->Check mathematical functions" is deactivated) 
	When external C, FORTRAN or C++ functions are called that return one/many value(s) that may not be valid numbers. This is a typical source of problems since the external functions cannot be properly protected against forbidden operations and produces non-valid numbers that are propagated to the model. 


*/
--A function that simply contains a division by zero is created.
FUNCTION REAL func_testDivision( REAL x, REAL y )
    DECLS
        REAL z
    BODY
        z= x / y
        IF( validReal(z) == FALSE ) THEN
            WRITE("\nz is not a valid number. Value:%g\n",z)
        ELSE
            WRITE("\nz is a valid number. Value:%g\n\n",z)
        END IF
        RETURN z
END FUNCTION

// Check the Validity of a REAL Number
/*
	Many times is important to maintain the integrity of the real variables in the model and check that they are representing valid numbers and not an infinite, undetermined values, etc. It is a common source of problems when any operation produces these non-valid numbers.
	The function validReal() can be used to check that a real number (REAL type) represented is valid, i.e. that it is not a Not-A-Number (#NAN) or indeterminate (#IND).  The signature of the function is:
	BOOLEAN validReal(REAL arg)
	If it returns TRUE, the number is valid, otherwise it returns FALSE. The usage of this function is especially interesting in the following cases:
	When no extra code for mathematical operations (eg, division by zero) is produced in the partition and the experiment code (flag "Edit->Options->Run-time speed->Check mathematical functions" is deactivated) 
	When external C, FORTRAN or C++ functions are called that return one/many value(s) that may not be valid numbers. This is a typical source of problems since the external functions cannot be properly protected against forbidden operations and produces non-valid numbers that are propagated to the model. 


*/
COMPONENT comp_checkValidityRealNumber
    INIT
        func_testDivision( 4.5, 0.0 )
END COMPONENT

// Concatenating Two Strings
/*
	The function to concatenate two strings and return the new string is as follows:
	"EL" FUNCTION STRING concatStrings( IN STRING st1 ,
                                    IN STRING st2 )

*/
// Concatenating Files Generated with SAVE_VARS or SAVE_STATE
/*
	The user can merge two or more files with xml format generated previously with SAVE_STATE or SAVE_VARS. To concatenate the files call the function CONCAT_VAR_FILES.
	The function concatenates multiple xml files generated with SAVE_STATE or SAVE_VARS.
	CONCAT_VAR_FILES(VECTOR_STRING vfileNames, VECTOR_STRING vpointNames, STRING filepathOut)
	Parameters
	 	vfileNames (IN VECTOR_STRING): list of filenames to concatenate. The files must have been generated by either SAVE_STATE or SAVE_VARS function and in XML format.
	 	vpointNames (IN VECTOR_STRING): list of files ids. The ids are the names that the user wants the merged files to have within the concatenated file for future parsing.
	 	filepathOut (IN STRING): name of the concatenated file.
	Return value
	 	TRUE if the function SUCCEEDS, FALSE in any other case.


*/
COMPONENT comp_concatenatingTwoStringsFiles
    DECLS
        STRING newString
        STRING oldString1= "Hello "
        STRING oldString2= "world!"

        REAL x
    INIT
        newString= concatStrings(oldString1, oldString2)
        WRITE("\nnew string is: %s\n\n",newString)
	 CONTINUOUS
        x' = sin(TIME)
END COMPONENT
// Data Type Conversion Functions
/*
	There are a number of functions that can be used to convert basic data types to string and vice versa. They are:
	FUNCTION STRING  integerToString(INTEGER v)
	FUNCTION STRING  boolToString(BOOLEAN v)
	FUNCTION STRING  realToString(REAL v, INTEGER precision=15)
	FUNCTION INTEGER stringToInteger(STRING v)
	FUNCTION REAL    stringToReal(STRING v)
	FUNCTION BOOLEAN stringToBool(STRING v)

*/
COMPONENT comp_dataTypeConversionFunctions
    DECLS
        REAL v1= 34.56
        INTEGER i1= 34
        BOOLEAN b1= TRUE
        STRING s1= "98"
        STRING s2= "3536.52e-2"
        STRING s3= "TRUE"
        REAL r
        INTEGER i
        STRING s
        BOOLEAN b
    INIT
        s= integerToString(i1)
        WRITE("[INTEGER -> STRING] converted %d to \"%s\"\n",i1,s)
        s= boolToString(b1)
        WRITE("[BOOLEAN -> STRING]converted %s to \"%s\"\n",gvalBool(b1),s)
        s= realToString(v1)
        WRITE("[REAL -> STRING]converted %g to \"%s\"\n",v1,s)
        i= stringToInteger(s1)
        WRITE("[STRING -> INTEGER] converted \"%s\" to %d\n",s1,i)
        b= stringToBool(s3)
        WRITE("[STRING -> BOOLEAN] converted \"%s\" to %s\n",s3,gvalBool(b))
        r= stringToReal(s2)
        WRITE("[STRING -> REAL] converted \"%s\" to %g\n",s2,r)
END COMPONENT
// Accessing time information and sleeping the simulation
/*
	There are a number of functions for measure time periods between two points in the code. The functions are:
	 	Reset the time to counter to 0.
	FUNCTION STRING resetTime()
	 	Get the time elapsed since last call to resetTime(). It is returned in the double precision number with granularity up to milliseconds.
	FUNCTION REAL getTime()
	 	Produces a standby in the simulation for a number of seconds.
	FUNCTION REAL sleepTime( REAL seconds )
	
	There are a couple of functions similar to the previous ones that produces a statistic of the final simulation time for each portion of the code controlled in the final log file. These functions are:
	FUNCTION NO_TYPE quantify_begin( IN STRING id, IN INTEGER fromDebugLevel=0 )
	FUNCTION REAL    quantify_end( IN STRING id, IN INTEGER fromDebugLevel=0 )
	The function quantify_begin() marks a starting point for counting the time (similar to resetTime()); the id is used to provide different performance meters with different names. The last argument is optional and it means that the analysis is done only if the actual DEBUG_LEVEL is greater than or equal to "fromDebugLevel". This prevents calculating the performance analysis every time (additional delays) and ensures that it is done only when DEBUG_LEVEL is appropriate.
	The function quantify_end() marks the end point for counting the time (similar to getTime()); it must contain the same id and the same associated debug level. The partial time from quantify_begin() is calculated and returned by this function. Apart from this, incremental time is added to previous calls to provide, at the end of the simulation, the total time elapsed in those periods.


*/
COMPONENT comp_calculatingPerformanceTime
  DECLS
        REAL x
        REAL y
		  REAL k
    INIT
        x= 3
        y= 4
    CONTINUOUS
        x' = sin(TIME) + k
        y= x**2 + 2 

END COMPONENT
// Analyzing code performance
/*
	There are a number of functions for measure time periods between two points in the code. The functions are:
	 	Reset the time to counter to 0.
	FUNCTION STRING resetTime()
	 	Get the time elapsed since last call to resetTime(). It is returned in the double precision number with granularity up to milliseconds.
	FUNCTION REAL getTime()
	 	Produces a standby in the simulation for a number of seconds.
	FUNCTION REAL sleepTime( REAL seconds )
	
	There are a couple of functions similar to the previous ones that produces a statistic of the final simulation time for each portion of the code controlled in the final log file. These functions are:
	FUNCTION NO_TYPE quantify_begin( IN STRING id, IN INTEGER fromDebugLevel=0 )
	FUNCTION REAL    quantify_end( IN STRING id, IN INTEGER fromDebugLevel=0 )
	The function quantify_begin() marks a starting point for counting the time (similar to resetTime()); the id is used to provide different performance meters with different names. The last argument is optional and it means that the analysis is done only if the actual DEBUG_LEVEL is greater than or equal to "fromDebugLevel". This prevents calculating the performance analysis every time (additional delays) and ensures that it is done only when DEBUG_LEVEL is appropriate.
	The function quantify_end() marks the end point for counting the time (similar to getTime()); it must contain the same id and the same associated debug level. The partial time from quantify_begin() is calculated and returned by this function. Apart from this, incremental time is added to previous calls to provide, at the end of the simulation, the total time elapsed in those periods.


*/
FUNCTION REAL func_calculateA( IN REAL p, OUT REAL v[], IN INTEGER N )
    DECLS
        REAL av=0.0
        REAL total1= 0.0
        REAL total2= 0.0
    BODY
	     quantify_begin("firstPart",1)
        FOR(i IN 1,N)
            v[i]= p / 3.141595
        END FOR
		  total1= quantify_end("firstPart",1)
        quantify_begin("secondPart",1)
        FOR(i IN 1,N)
            av= av + v[i]
        END FOR
        total2= quantify_end("secondPart",1)
        WRITE("firstPart= %.3g secondPart elapsed= %.3g\n",total1,total2)
        RETURN av
END FUNCTION
// Function to Stop Simulation when forbidden operation is detected
/*
	When the partition or experiment is generated, a flag can be used (Edit->Options->Run-time speed->Check mathematical functions) to enable/disable the generation of extra code to check problematic mathematical operations such as divisions by zero, logarithm of negative numbers, square root of negative numbers, etc.
	If this flag is enabled and this protection code is created, the operations will be checked all the time. Furthermore, if the variable DEBUG_LEVEL >= 4, a warning message will be printed in order to inform the user that something is going wrong and probably there is a modelling issue. Even more, it is possible to stop the simulation the first time a prohibited operation is detected. To do this the modeller can call the function:
		setStopWhenBadOperation(TRUE)
	And when it is detected, the simulation stops. 
	There is another function for obtaining the status flag
		status= stopWhenBadOperation() 
*/
// Continue integration when any algebraic fail
/*
	There is another advanced function that allows the default behaviour of some transient solvers to be modified in case some algebraics cannot be solved. The function is:
	NO_TYPE setStopWhenAlgebraicFails (BOOLEAN Code)
	Where  can be:
	 	Code= TRUE (default) stops integration if some algebraic cannot be solved during a transient solving process. It is important to note that the stopWhenBadOperation() function is stricter since the simulation stops when the first bad numerical operation (eg division by zero) is detected.
	 	Code= FALSE does not stop a transient solving process if some algebraics cannot be solved. This is a very exceptional behaviour but it could be used in some cases. This behaviour is not valid for the DASSL family since wit this method will always stop if some algebraic fails.
	This function can be typically used with transient solver algorithms like EULER, RK4 or the AM families
*/
COMPONENT comp_functionStopSimulationForbiddenOperation
	DECLS
        REAL x= 0.0
   CONTINUOUS
        x/ sin(x) = cos(TIME)
END COMPONENT
//Function for reading a file into a string
/*
The eReadFileAsString() function reads a file and returns it in a string. The format is:
"C++" FUNCTION BOOLEAN eReadFileAsString (IN FILEPATH filePath , OUT STRING fileContent
)
It is very easy and intuitive to use; the first argument is the name of the file; if it could be found, opened and
read, it returns the contents in the second argument fileContent in string format and it also returns TRUE. If it
could not open it or read it, it returns FALSE.
A simple example could be to read a file called inp.txt with this text
This is trial of eReadFileAsString function .

*/
FUNCTION NO_TYPE func_fConvertFileToString ()
	DECLS
		STRING sout
	BODY
		ASSERT ( eReadFileAsString ("@MODELLING_LANGUAGE@/inputFiles/inp.txt ",sout ) == TRUE ) FATAL " Cannot open file "
		WRITE ("\"%s\"\n",sout )
END FUNCTION
COMPONENT comp_functionforreadingfileintostring

END COMPONENT
// Functions to Operate with Matrices
/*
	matDet
		The matDet function calculates the determinant of a 2D square matrix.
		Parameters
		 	nRows (IN INTEGER): the size of the square matrix. 
		 	mat (IN REAL []): the matrix whose determinant is to be computed. 
		 	detValue (OUT REAL): will contain the calculated determinant value upon function's return.
		Return value
		 	0 if everything is ok.
		 	Less than 0 if a parameter is invalid (the value is the number of the invalid parameter).
		 	-99 if an unexpected error happened.
	matLU
		The function matLU computes the LU factorization of an m-by-n matrix.
		Parameters
		 	m (IN INTEGER): the number of rows of the matrix mat. m >= 0.
		 	n (IN INTEGER):  the number of columns of the matrix mat. n >= 0.
		 	mat (OUT REAL []): matrix whose LU factorization is to be calculated. The matrix should be stored row-wise in a 1D array matrix[i,j] = mat[(i * nRows) + j] On exit, the factors L and U from the factorization mat = P*L*U; the unit diagonal elements of L are not stored.
		 	lda (IN INTEGER): the leading dimension of the array mat.  lda >= m.
		 	ipiv (OUT INTEGER []): array with dimension min(m,n) containing the pivot indices; for 1 <= i <= min(m,n), row i of the matrix was interchanged with row ipiv[i].
		Return Value
		 	0:  successful exit.
		 	Less than 0:  the i-th argument had an illegal value.
		 	Greater than 0:  U[i,i] is exactly zero. The factorization has been completed, but the factor U is exactly singular, and division by zero will occur if it is used to solve a system of equations.
	matPrint
		The function matPrint() prints a 2D matrix.
		Parameters
		 	nRows (IN INTEGER): number of rows of the matrix. 
		 	nCols (IN INTEGER): number of columns of the matrix.
		 	mat (IN REAL []): the matrix stored row-wise in a 1D array.
		 	flagUseMatStatus (IN BOOLEAN): flag that triggers the printing of the state of the matrix mat elements (see matStatus parameter). 
		 	matStatus (IN REAL[]): integer array that stores the state of the matrix mat elements (If flagUseMatStatus = TRUE). If matStatus[i] = 1 means that the mat [i] element is correct and its value will be printed. Conversely, if matStatus[i] = 0 means that the mat[i] element is not correct and NOK will be printed instead of its value.
		 	rowNames (IN STRING []): the title for each of the rows.
		 	colNames (IN STRING []): the title for each column.
		 	title (IN STRING): title for the matrix to be printed.
		 	subtitle (optional IN STRING): the subtitle for the matrix to be printed.
		 	cornerTitle (optional IN STRING): title to be displayed in the upper left corner of the printed matrix.
		 	simplifyView (optional IN BOOLEAN): print values in scientific notation. The default value is FALSE.
		Return value
		 	TRUE if everything runs ok FALSE otherwise.
		

*/
COMPONENT comp_functionsOperateWithMatrices
	DECLS
		REAL Mat[2,2] = {{1,2},{6,8}}
		REAL M[4]={1,2,3,4}
END COMPONENT
// The system() function
/*
	The command prompt of the operating system can be called directly by using the function:
	FUNCTION INTEGER system (IN STRING command)
	where command is a string identifying the command to be run in the command processor. The command can be any typical command used in the operating system command window.
	The function system() invokes the host environment's command processor with  parameter. It is identical to the system() function of C/C++. If command is a null pointer, the function only checks whether a command processor is available through this function, without invoking any command.
	If command is not a null pointer, the value returned depends on the system and library implementations, but it is generally expected to be the status code returned by the called command, if supported. Windows returns 0 if command was ok.
	WARNING: The use of this command may be dangerous because the effects produced during simulation could be completely different (and sometimes catastrophic) if you execute it from the EcosimPro GUI environment, from a deck, from Excel, etc. It is the user responsibility to check that the behaviour in each of these cases is correct.

*/
COMPONENT comp_systemFunction
 DECLS
        REAL x
		  REAL k
   CONTINUOUS
        x = sin(TIME)
END COMPONENT