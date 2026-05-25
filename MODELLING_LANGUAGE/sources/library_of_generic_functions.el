USE MATH
/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: library_of_generic_partitions_functions
 -----------------------------------------------------------------------------------------*/
// Library of generic functions
// Automatic report Generation
/*
In EL, all automatic reports that trace the simulation variables are called views. EL allows you to generate automatic
reports by means of some functions. The reports are updated automatically whenever there are new data
to report and user does not need to worry about them. They are normally updated at each communication interval
or any event. You can also update reports manually at any time using the function REPORT_REFRESH(),
as well as activate or deactivate automatic report generation
The functions are:
FUNCTION NO_TYPE REPORT_TABLE ( STRING fileName ,
	IN STRING filter ,
	IN BOOLEAN filterEquivalents =FALSE ,
	IN INTEGER digits = RDIGITS ,
	IN BOOLEAN headerFlag = TRUE ,
	IN BOOLEAN isOrdered = TRUE ,
	IN STRING separator = DEFAULT_SEP )
FUNCTION NO_TYPE REPORT_LIST ( STRING fileName ,
	STRING regExpr ,
	BOOLEAN filterEquivalents =FALSE ,
	IN INTEGER digits = RDIGITS ,
	IN BOOLEAN headerFlag = TRUE ,
	IN BOOLEAN isOrdered = TRUE )
The arguments are:
 fileName (mandatory): The file name of the report. The extension of the file is important since the tool
can generate reports in different formats. If not extension is provided the tool will generated the report
in ASCII format by default. The valid extensions are:
 ".rpt" or ".txt". The report is generated in ASCII format
 ".xml". The report is generated in XML format
 ".html". The report is generated in HTML format. This file can be opened with any internet viewer
program.
Page 1046 5. Modelling Language User Manual
program 3.9
 ".csv". The report is generated in CSV format (comma-separated values). This file can be opened
directly from MS Excel.
 ".h5". The report is generated in the binary format HDF5. This file can be opened with the Monitor
application. This format is recommended if the size of the data is very big.
 filter (mandatory): This argument can be used for two things:
 Write some regular expressions separated by white spaces denoting the variable names to be reported
periodically. For example "*.pt" denotes all variables ended in .pt, and *engine* denotes all
variables containing the word "engine" on his name. See the format for these regular expressions in
the chapter dedicated to Regular Expressions.
 A filter file where the regular expressions for filtering the variables are read. This is useful when
there are many regular expressions and the user does not want to write directly in this field but in
a separate file. It is also interesting when many experiments share the same filters. The format is
"$file:myFilter.flt" for a local file or "$file:@CONTROL@/filters/myFilter.flt" for finding a filter file
relatively to a library. Only one file is allowed.
 FilterEquivalents (optional, default is TRUE): Boolean flag to avoid writing the equivalent variables. For
instance if variable x and z are equivalents only one of them will be reported. If this flag is TRUE this
will be applied, if FALSE all variables will be reported.
 Digits (optional, default is RDIGITS=9): how many precision digits to print in the reports. By default, it
uses the value of RDIGITS. The user can change this precision with this argument.
 headerFlag (optional, default is TRUE): Flag to print (or not) a header on the reports with the model
name, libraries dependencies, date, etc. By default it is set to TRUE.
 isOrdered (optional, default is TRUE): By default all variables to report are sorted in alphabetical order
and it is removing duplicate variables. If this flag is set to FALSE, it will not sort the variables and it will
allow repeating the same variables in different positions.
 Separator (optional, default is extracted from user regional configuration): When creating reports in
ASCII format there is a separator character between values. This option allows selecting any separator.
By default the separator between is the one selected by the user in the Options menu from the GUI. If a
specific separator is needed, this argument can be used.*/
COMPONENT comp_automaticReportGeneration
	DECLS
		REAL xA, yD
	CONTINUOUS
		xA = sin(TIME)
		yD = cos(TIME)
END COMPONENT
// REPORT_REFRESH ()
/*
The function REPORT_REFRESH() is used to refresh manually the views (eg reports and plotters). All views
are updated each time it is called. It is useful when the user wants to control the precise moment to refresh
Page 1050 5. Modelling Language User Manual
program 3.9
results.
*/
COMPONENT comp_reportRefresh
	DECLS
		REAL x, y
	CONTINUOUS
		x = sin(TIME)
		y = cos(TIME)
END COMPONENT

// Precision of the reports
/*
	At any point in the experiment, Program users can decide how many significant numbers they require for all output results.
	Accordingly, they must use the overall variable RDIGITS
	By default RDIGITS is equal to 9, which under normal conditions is sufficient precision for the majority of engineering problems.
	The range of normal values for RDIGITS (in 32 bits machines) varies between 5 and 15 significant numbers.
*/

COMPONENT comp_precisionReports
    DECLS
        REAL x
        REAL y
    INIT
        x= 3
        y= 4
    CONTINUOUS
        x' = sin(TIME)
        y= x + 2
END COMPONENT

// Changing the Moment to Refresh Results
/*
There are times when users want to change the exact moment at which the integration results of a model are obtained. By default Program will provide results
	to each communication interval and to each discrete event which causes the model to vary.
If we want to change the refresh moment, we can change a global experiment variable called "REPORT_MODE". The allowable values of the variable are:
 	IS_EVENT: this is the default mode. Results are refreshed for each communication interval and discrete event.
 	IS_CINT: in this mode, the results will only be given at precise communication intervals.
 	IS_STEP: in this mode, all the results obtained will be given at+ communication intervals, discrete events and internal integration steps
 	IS_MANUAL_REFRESH: in this mode, the results will be refreshed only when the user makes a manual refresh with the function REPORT_REFRESH(), 
		any other result from transient or steady solvers will not be refreshed.
*/
COMPONENT comp_refresh
   DECLS
        REAL x
        REAL y
    INIT
        x= 3
        y= 4
    CONTINUOUS
        x' = sin(TIME)
        y= x + 2
END COMPONENT
// Get the Current State of the Solver
/*
	Sometimes the modeller needs to know the state of the solver, for instance, if he is calculating a Jacobian. This can be used to perform some calculations or others depending on the state of the solver. The getSolverState() function returns the actual. The signature is as follows:
	INTEGER getSolverState()
	The integer value it returns is, depending on the state of the steady-state or transient solvers at that moment:
	 	Code 1: Initialization phase
	 	Code 2: Jacobian calculation
	 	Code 3: Calculating new interval or delta
	 	Code 4: Final calculation (only is some cases)
	It is especially interesting the code 2, since sometimes it is very important for the user to know whether the solver is calculating the Jacobian
	In this way, it is guaranteed that an invalid real number is not propagated. This solution entails certain risks that have to be determined by the modeller
*/
FUNCTION REAL func_currentStateofSolver(IN REAL x,IN REAL delta)
BODY
	IF ( getSolverState() == 2 ) THEN
		RETURN x + delta -- in Jacobian calculation it returns a different value
	END IF
	RETURN x
END FUNCTION
//Initialization functions
/*
	In general, the order of priorities from greater to less is:
 		The INIT block of the components (called by default at the beginning of INTEG() and STEADY() functions).
		It can be called explicitly with function EXEC_INIT().
 		Set a datum in the experiment BODY.
 		A call RESTORE_STATE().
 		The INIT and BOUND section of the EXPERIMENT.
 		The default value assigned when declared.

*/
COMPONENT comp_initizationIssues
    DECLS
        REAL Var= 0
		  REAL a = 2
    INIT
        Var= 1
    CONTINUOUS
        Var' = sin(TIME)
		  a' = cos(TIME)
END COMPONENT

// Saving and Restoring Variables
/*
	There is a family of functions for saving and restoring variable values. The modeller can use three formats:
 	A file in ASCII format (T_TEXT).
 	A file in XML format (T_XML).
 	An internal memory buffer (T_MEMORY).
	The functions available are:
		FUNCTION NO_TYPE SAVE_STATE(STRING fileName,
								ENUM docuMode format= T_TEXT)
		FUNCTION NO_TYPE SAVE_VARS(STRING fileName, 
								STRING pattern="*",
								ENUM docuMode format= T_TEXT)
		FUNCTION NO_TYPE SAVE_VARS_VECTOR(STRING fileName,
								VECTOR_STRING v
								ENUM docuMode format= T_TEXT)
		FUNCTION NO_TYPE SAVE_VARS_CATEGORY(STRING fileName, 
								ENUM T_VAR_PROP category, 
								BOOLEAN filterEquiv=TRUE,
								ENUM docuMode format= T_TEXT)
		FUNCTION NO_TYPE RESTORE_VARS(STRING fileName, 
									STRING pattern="*",
									ENUM docuMode format= T_TEXT)
		FUNCTION NO_TYPE RESTORE_STATE(STRING fileName, ENUM docuMode format= T_TEXT)
		FUNCTION NO_TYPE RESTORE_VARS_VECTOR(STRING fileName,
									VECTOR_STRING v,
									ENUM docuMode format= T_TEXT)
		FUNCTION NO_TYPE RESTORE_VARS_CATEGORY(STRING fileName, 
									ENUM T_VAR_PROP category,
									BOOLEAN filterEquiv=TRUE,
									ENUM docuMode format= T_TEXT)
		FUNCTION STRING  getMemoryBuffer(STRING fileName)
		FUNCTION BOOLEAN COPY_VARS(STRING fileNameIn, ENUM t_docuMode formatIn, 
		              STRING fileNameOut, ENUM t_docuMode formatOut)


*/
COMPONENT comp_savingRestoring
   DECLS
        REAL x
        REAL y
		  REAL a
		  REAL btemp
    INIT
        x= 3
        y= 4
		  a = 3
		  btemp = 4
    CONTINUOUS
        x' = sin(TIME)
        y= x + 2
		  a' = cos(TIME)
		  btemp = a + 2
END COMPONENT
// Working with Properties of Variables 
/*
	Get Variable Names of a Given Category
	From the experiments, the modeller can get names of variables with a given category (using the enumerative T_VAR_PROP) using the function getVariablesWithCategory(). The format is:
	VECTOR_STRING getVariablesWithCategory( ENUM T_VAR_PROP cat, 
	                                        BOOLEAN filterEquivalents= TRUE, 
	                                        BOOLEAN value= TRUE )
	It returns the vector of variable names with a given category. If filterEquivalents is TRUE, it returns only the root variable names but not the equivalent ones. The last argument is only used for categories T_EDIT, T_STORE and T_TRACE where it is possible to write the value that they must have (TRUE or FALSE).
	It returns a VECTOR_STRING object with the final list of names. These objects can be used like any other class in EL
	1- Get the names of every variable which belongs to the Jacobian without equivalent variables.
		v= getVariablesWithCategory( T_JACOBIAN_VARS )
	2- Get the names of every variable which belongs to the Jacobian including the equivalent one.
		v= getVariablesWithCategory( T_JACOBIAN_VARS, FALSE )
	3- Get the names of every variable which has the EDIT property set to FALSE without equivalent variables.
		v= getVariablesWithCategory( T_EDIT, TRUE, FALSE )
	4- Get the names of the algebraic variables without equivalents.
		v= getVariablesWithCategory( T_ALGEBRAIC )
	5- Get the names of the public variables in deck mode.
		v= getVariablesWithCategory( T_DECKIN_PUBLIC )

	1.15.12.2. 	Set a Property Value
	BOOLEAN setVarProperty( IN STRING varName,
	                        ENUM T_VAR_PROP propertyId,
	                        IN  BOOLEAN value )
	Purpose: To set a property for a variable. The properties that can be set at experiment level are T_EDIT, T_STORE and T_TRACE
	Examples: 
	1- Set the T_EDIT property of variable "Burner.Fu_in.W" to FALSE.
		setVarProperty ("Burner.Fu_in.W",T_EDIT,FALSE)
	2- Set the T_STORE property of variable "LPT.s_mapEff_in" to TRUE.
		setVarProperty ("LPT.s_mapEff_in",T_STORE,TRUE)
		
	1.15.12.3. 	Get a Property Value
	BOOLEAN getVarProperty( IN STRING varName,
	                        ENUM T_VAR_PROP propertyId,
	                        OUT BOOLEAN result )
	Purpose: To get a property variable. The properties that can be used at experiment level are T_EDIT, T_STORE and T_TRACE. It writes the property in the "result" field. It returns TRUE if the variable is found and the operation is OK.
	Examples: 
	1- Get the T_EDIT property of variable "Burner.Fu_in.W" in variable editCat (BOOLEAN), return the status of the operation in status variable (BOOLEAN).
	status= getVarProperty ("Burner.Fu_in.W",T_EDIT,editCat)



*/
COMPONENT comp_workingWithPropertiesVariables
   DECLS
        REAL x
        REAL y
		  REAL z
		  REAL k
    INIT
        x= 3
        y= 4
    CONTINUOUS
        x' = sin(TIME) + k
        z= x + 2 
		  z' = y**2 + y
		 
END COMPONENT
// Set a Callback Function to be called at each refreshing time
/*
	The modeller is often interested during the experiment in calculating at each step of the integration other expressions that are a function of some variables of the model
	We might wish to calculate during the experiment the average value of variables a and b, in other words:
		(a+b)/2
	We could do this somewhat manually by integrating step by step and calculating it ourselves at each step
*/
COMPONENT comp_callbackCommunicationsInterval
DECLS
	REAL a
	REAL b
CONTINUOUS
	a= sin(TIME)
	b= sin(TIME) + 4
END COMPONENT
//
// Create an Alternative Block for Calculating Boundaries
/*
	In the BOUNDS block  of the experiment the user can introduce time dependent equations for calculating the boundaries. Afterwards during the calculations on every call to the mathematical model (or residues function) this block is called on the beginning of the residues function (function FRES()). This allows introducing time dependent laws for boundaries.
	The user can use alternative blocks for boundaries using experiment functions. Sometimes the user wants to change the time dependent law during the experiments for them. For doing that he can use the functions
   	FUNCTION NO_TYPE setBoundsLaw (FUNC_PTR ptrBoundLaw)
   	FUNCTION NO_TYPE setBoundsLawDefault
	The first function allows the boundaries to be calculated using a block other than BOUNDS. The argument points to that function that must have the following format (it is mandatory to define the argument TIME as above):
    	FUNCTION NO_TYPE myFunctionForBounds(REAL TIME)
	This function, and not the BOUNDS block of the experiment, will be called every time the boundaries need to be calculated in the residues function. 
	It is strongly recommended to name the argument TIME (uppercase), since all the wizards will generate this function automatically with this argument name. In any case this variable is local to the function and not necessarily identical to the global TIME.
	Function setBoundsLawDefault() resets the default scenario and addresses the call to the BOUNDS block
*/
COMPONENT comp_changingBoundariesEquations
DECLS
   REAL x
   REAL y
	REAL b1
	REAL z

CONTINUOUS 
   x'= sin(TIME) + y
	z =  b1
END COMPONENT
// Evaluation of numerical expressions at runtime
/*
	Normally, all mathematical expressions in EL are translated into C++ and then compiled to be run: this is very good in terms of performance, but there are times when it would be good for the user to have a dynamic interpretation capability of numerical expressions. This way, even if an experiment is already closed, the user would be able to evaluate dynamically these expressions.
	The function that permits this is:
   	FUNCTION BOOLEAN eEvalExpr (IN STRING expression,
                               OUT REAL result,
                               OUT STRING errorMessage)
	The arguments of the function are the following:
 "expression" is any valid numerical expression (eg. "a+b"); any variable of the partition can be used
 "result" is the final result of the operation
 "errMessage" is the error message produced if it was not possible to evaluate the expression
This function will return TRUE if the expression could be calculated and FALSE if not.
The expression may use the following capabilities:
 any valid variable of the partition including derivatives (eg "y’ + c.str")
 any valid global variable (eg. "TIME + 1")
 any arithmetic operation:
 add "+"
 subtract "-"
 multiplication "*"
 division "/"
 exponentiation "**"
 module "%"
 any level of parentheses (eg "(a+(b*c))") 
the following list of mathematical functions with 1 numerical argument: log(), log10(), sin(), cos(),
tan(), asin(), acos(), atan(), abs(), sinh(), cosh(), tanh(), sqrt(), exp(), ceil() and floor()
 the mathematical function with 2 numerical pow()
Examples of valid expressions:
"a + b"
"log( asin (rt.rp.t)+1) /2.3 "
" (((( sqrt (3.3) + cos( TIME ))+ ceil (ar.a)) /2.23) + tan(k))"
If a non-existent variable, unknown function or an expression that is not well balanced with the parentheses is
encountered, the function returns FALSE and writes the error message in the output variable errorMessage.

*/
COMPONENT comp_evaluationNumericalExpressionsAtRuntime
DECLS
	REAL a
	REAL b
CONTINUOUS
	a= sin(TIME)
	b= sin(TIME) + 4
END COMPONENT
//	Getting the actual directory and experiment name
/*
	The user can get the actual working directory of the experiment by calling the function getWorkingDir().
	FUNCTION STRING  getWorkingDir()

	The user can redirect the experiment output to a different directory from the standard one. In these cases the user sometimes needs to find the original experiment path (eg. to read an input file). The function getExperimentDir() returns this original path. If the experiment directory has not been changed, this function returns the same value as getWorkingDir(). 

*/
COMPONENT comp_getActualWorkingDirectoryExperiment
	DECLS
        STRING dir
    INIT
        dir= getWorkingDir()
        WRITE("\nActual working directory: %s\n\n",dir)
END COMPONENT
// Execute calculation with a time limit
/*
	The function runWithTimeLimit() calls a user defined function allowing it to run for a maximum amount of
time in seconds. The signature of the function is:
FUNCTION BOOLEAN runWithTimeLimit ( FUNC_PTR < eFunType6 > fcnToRun , INTEGER timeLimitSecs
.
The description of the arguments and return type is:
Parameters
 fcnToRun (IN FUNC_PTR): name of the EL function to run with a time limit. This function must receive
no arguments and return a boolean value, TRUE if it succeeds and FALSE if it was wrong (typically a
steady or a transient fails). The function must also call the residues function at some point or it will not
be time controlled. The function must be defined with the function type eFunType6
TYPEDEF FUNCTION BOOLEAN eFunType6 ()
 timeLimitSecs (IN INTEGER): maximum amount of time the function fcnToRun will be allowed to run.
Return value
 It returns TRUE if the function finished properly in time, it returns FALSE when the function was stopped
due to the time constraint.
*/

FUNCTION REAL func_delay()
	BODY
		FOR (i IN 1, 1e8)
			
		END FOR
		RETURN 0.0

END FUNCTION
COMPONENT comp_calculationWithTimeLimit
   DECLS
        REAL x
		  REAL k
   CONTINUOUS
        x = sin(TIME) + func_delay()
		  

END COMPONENT
// Accessing partition variables during simulation
/*
Basic get/set functions
The user can access any partition variable during the simulation. The following functions are available
INTEGER getNumberVars ()
Get the total number of variables in the partition and experiment. Be aware that arrays are deployed and each individual item is a different variable name.
STRING getVarName (IN INTEGER i)
Get the name of the variable that has index i
BOOLEAN existsVariable(IN STRING name)
It returns TRUE if a variable exists
STRING getVarTypeStr (IN STRING name)
Get the type of the variable in string format such as "REAL", "INTEGER", "BOOLEAN", "ENUM",etc.
INTEGER getVarType (IN STRING name)
Get the type of the variable in integer format. The valid types and codes are REAL=1, INTEGER=2, STRING=3, BOOLEAN=4, ENUM_ELEM=12 and FILEPATH=17 
INTEGER  getVarCategory (IN STRING name)
Get the category of the variable in integer format. The valid codes are BOUNDARY=1, DYNAMIC=2, DERIVATIVE=3, ALGEBRAIC=4, PARAMETER_CTE=5, EXPLICIT=6, DISCRETE=7, DATA_VAR=8, CTE=9 and EXPERIMENT_VAR=10
STRING  getVarCategoryStr (IN STRING name)
Get the variable category in string format such as "DYNAMIC", "ALGEBRAIC", "DATA", "DERIVATIVE", etc.
REAL    getValueReal  (IN STRING name)
Return the actual value of a REAL variable
BOOLEAN setValueReal  (IN STRING name, IN REAL v)
Set the REAL value to value v (returns FALSE if not found)
INTEGER    getValueInt  (IN STRING name)
Get the current value of an INTEGER variable
BOOLEAN setValueInt  (IN STRING name, IN INTEGER v)
Set the INTEGER value to value v (returns FALSE if not found)
BOOLEAN    getValueBool  (IN STRING name)
Get the current value of a BOOLEAN variable
BOOLEAN setValueBool  (IN STRING name, IN BOOLEAN v)
Set the BOOLEAN value to value v (returns FALSE if not found)
STRING    getValueString  (IN STRING name)
Get the current value of a STRING variable
BOOLEAN setValueString  (IN STRING name, IN STRING v)
Set the STRING value to value v (returns FALSE if not found)
STRING    getValueEnum  (IN STRING name)
Get the current value (in string format) of an Enumerative variable (deprecated)
BOOLEAN setValueEnum  (IN STRING name, IN STRING v)
Set the Enumerative value to value v (returns FALSE if not found)
STRING    setValueAsString(IN STRING name, IN STRING name)
Set the current value (in string format) of any variable of any type. Using a complete array (eg. V) is not valid; you have to select element by element (eg. V[1], v[2],etc)
STRING    getValueAsString(IN STRING name)
Get the current value (in string format) of any variable of any type (returning a complete array is not valid)
*/
/*
Here is presented a simple example to show two different ways of using the model variables. First we define a simple component with different type of variables
*/
ENUM colorss = { redd, bluee, yelloww, blackk }

COMPONENT comp_use_ext_fun
DATA
      REAL var_real= 0
      REAL var_real_array[3]= 1
      STRING var_str= "hello"
      BOOLEAN var_bool= TRUE
		ENUM colorss var_color=  redd
END COMPONENT

COMPONENT comp_use_enum_funcs
  DATA
    ENUM colorss myColor = yelloww
  INIT
  	WRITE("myColor= %s\n", getValueEnum("myColor"))
	WRITE("myColor= %s\n", gvalEnumByType(colorss,myColor)) -- recommended  
	WRITE("myColor= %s\n", getValueAsString("myColor"))
	WRITE("myColor category= %s\n", getVarCategoryStr("myColor"))   
	WRITE("myColor data type= %s\n", getVarTypeStr("myColor"))
END COMPONENT 

// Advanced array functions
/*
There are some other more sophisticated functions to work with arrays in a more efficient way externally. These are the functions shown below.
BOOLEAN getArray1D(IN STRING name, OUT REAL v[],IN INTEGER dim1)
Gets the values of the array named "name" and copies them into the array "v" whose size is "dim1"
BOOLEAN setArray1D(IN STRING name, IN REAL v[],IN INTEGER dim1)
Copies the values of array "v" whose size is "dim1" into the array "name"
BOOLEAN getArray2D(IN STRING name, OUT REAL v[],IN INTEGER dim1, ,IN INTEGER dim2)
Gets the values of a 2D array named "name" and copies them into a 2D array "v" whose first dimension is "dim1" and second dimension is "dim2"
BOOLEAN setArray2D(IN STRING name, IN REAL v[], IN INTEGER dim1, ,IN INTEGER dim2)
Copies the values of 2D array "v", whose first dimension is "dim1" and second dimension is "dim2", into a 2D array named "name"
BOOLEAN getArray3D(IN STRING name, OUT REAL v[],IN INTEGER dim1, IN INTEGER dim2,IN INTEGER dim3)
Gets the values of a 3D array named "name" and copies them into 3D array "v" whose first dimension is "dim1", second dimension is "dim2" and third dimension is "dim3"
BOOLEAN setArray3D(IN STRING name, IN REAL v[],IN INTEGER dim1, 
    IN INTEGER dim2,IN INTEGER dim3)
Copies the values of a 3D array "v", whose first dimension is "dim1", second dimension is "dim2" and third dimension is "dim3", into a 3D array named "name".
*/
/*
Let's see how you can optimize the use of arrays from external functions. Given a simple component with a unique array v
*/
COMPONENT comp_testArrayInit
    DECLS
        REAL v[3]
END COMPONENT

//	The delay() Function
/*
	EL can assign to variables the value of another variable with a delay. The delay() function returns historical values of a variable. For example:
	x = delay(y,2)
	This assigns to x the value of y two seconds ago; delay() is a predefined system function with the form:
	"C++" REAL delay(REAL var,REAL delayTime )
	Where var is the name of the variable whose historical value is required and delayTime is the time period. It returns the value of the time variable (TIME  delayTime), where TIME is the current time. The variable var must always be a dynamic variable declared in the DECLS block of a component. It cannot be an integer.
	This function can be used only inside component or port CONTINUOUS block; it cannot be used inside functions. 


*/
COMPONENT comp_delay
PORTS
   IN ports_analog_signal s_in 
   OUT ports_analog_signal s_out 
DATA
   REAL tdelay = 0.3
CONTINUOUS
   s_out.signal[1] = delay (s_in.signal[1], tdelay)

END COMPONENT
// Change the Level of Debugging
/*
	The user can use directly the DEBUG_LEVEL global variable to change the debug level but also he can prefer to do it with some proper functions: 
		"C++" FUNCTION INTEGER debugLevel()
		"C++" FUNCTION NO_TYPE setDebugLevel(INTEGER level)
	The function debugLevel() returns the actual debug level and the function setDebugLevel() can be used  to change the level of debugging. This level can be changed directly by changing the DEGUG_LEVEL variable; however, it is recommended that the function be called because it reports a change in the debug level during the experiment (if you use the variable directly you will get no messages).
	There are four levels of debugging. At each level, different information is provided in order to debug a model:
	 	DEBUG_LEVEL= 0: No trace at all.
		 	No messages are printed except fatal errors.
		DEBUG_LEVEL= 1 (Default):
		 	Trace the reading of the symbols table.
		 	Trace the initial status of ZONE and IF statements.
		 	Trace the active When's.
		 	Trace the evolution of transient calculations (steps).
		 	Trace the basic transient information: header and footer with big statistics: time consumed and number of calls to the residue functions.
		 	Trace the basic steady information: header and footer with big statistics: time consumed, Jacobians, iterations, maximum error and number of calls to the residue functions.
		 	WRITE and PRINT statements.
		 	Messages about debug level, solving internal algebraic boxes, etc.
		 	Non-convergence messages.
 		DEBUG_LEVEL= 2:
		 	All DEBUG_LEVEL= 1 info.
		 	Trace all non-convergent steady calculations. It will produce a full report in the log file (HTML format) with the real evaluation of  Jacobians (no reporting the estimated), residues, Broyden evaluations, etc.
		 	Trace the evolution of ZONE and IF statements.
		 	Trace the begin and end execution of INIT blocks of components.
 		DEBUG_LEVEL= 3:
 			All DEBUG_LEVEL= 2 info.
		 	Trace the convergent steady calculations will produce a full report (similar to the non-convergent case).
		 	Print all variable values when the problem does not converge.
		 	In transient it prints warnings about non-repeatability of the residue function and non-linearity of the Jacobian.
 		DEBUG_LEVEL= 4:
 			All DEBUG_LEVEL= 3 info.
 			Plot unknowns and residues in the log file.
 			Print messages when a bad mathematical operation is detected (e.g. division by zero) and the flag "check mathematical functions" was active when the partition was generated.
*/
COMPONENT comp_debug
   DECLS
        REAL x
        REAL y
    INIT
        x= 3
        y= 4
    CONTINUOUS
        x' = sin(TIME)
        y= x + 2
END COMPONENT
// Residues Function Calls
/*
	It is possible to call the residues function directly from the experiment. There are two functions:
		FUNCTION BOOLEAN FRES(BOOLEAN updateDerivs=FALSE)
		FUNCTION BOOLEAN FRES_ARGS(OUT REAL time, 
                           OUT REAL y[],
                           OUT REAL dy[],
                           OUT REAL residues[],
                           BOOLEAN updateDerivs=FALSE))
	The first function FRES() calls the equations system with the given inputs: data and boundaries. 
		To change the inputs, the user must set the input variables from the experiment using the variable name. Only DATA, BOUNDARY and DYNAMIC has sense to be modified as input. After calling this function it produces the outputs: EXPLICIT variables and residue values. To get the output EXPLICIT variables the user must use the variable name and for obtaining the residues he must to use the getResidueValue() function. Optionally the user can get the new derivatives calculated in the residues function by passing the argument "updateDerivs" to TRUE. Be aware that by default the derivatives are not updated when called this function.
	This function is used for multiple purposes, typically:
 		Just for obtaining the residues based on some inputs.
 		When solving ODE systems it can be used to get the new derivatives (passing argument updatedDerivs to TRUE).
 		In the experiment types: extended steady and extended transient for evaluating the internal residues with different inputs. 
			Normally this is done with non-linear solver functions nlsolver() and nldsolver() for calculating the internal residues.
 		To make sensitivity analysis based on parametric calculations of some inputs.
	The FRES_ARGS() function is similar but it allows to explicitly provide a given time, two inputs vector: 
		the Jacobian vector and the initial derivatives vector and it produces the final residues vector. The arguments are:
 			time: input time to be evaluated the residues function.
 			y[]: this is the input vector for the unknowns, also it is known as Jacobian input values. 
					The structure of this vector must follow the Jacobian positions given in the partition view.
					The user cannot modify the order of the variables from the Jacobian and must provide the values in the strict order of the partition schema. The user can change the values of this vector to obtain different outputs.
 			dy[]: this is the input-output vector of derivatives with respect to y. The user can provide different initial values for the derivatives. The output derivatives are provided as output.
 			residues[]: this is the output vector of residues obtained after calling this function. This vector provides the output of the call to the residues with the different residues. 
					The other outputs are the explicit variables but to get them the user should use the variable name.
 			updateDerivs. By default is FALSE. If set to TRUE the dy[] vector is updated with the latest derivatives.
	This function is used typically for implementing an external solver since it provides access to the typical input and output variables in most of the solvers.
*/
COMPONENT comp_residuesFunctionCalls
DATA
	REAL d= 1
DECLS
	REAL x
	REAL y
	REAL z
	REAL v
CONTINUOUS
	y'= cos(TIME) + d
	x -sin(x) = 5
	z -cos(z) = 2
	v - sin(v) = 5
END COMPONENT

// Debugging the Residues function of the partition
/*
	Normally, when an experiment is executed, a file called simulation.log.html (in HTML format) is automatically created. This file shows each of the steps that the simulation has gone through. Sometimes users may want to obtain another output file with information on the model status at each call to the residue function (FRES()) and calculation of Jacobians. Be aware that all steady and transient studies in the tool call many times to this function with the mathematical model of the partition. This can be done with the produceLogAsciiFile() function which has the following parameters:
	NO_TYPE produceLogAsciiFile( INTEGER fromCall=-1,
	                             INTEGER toCall=-1,
	                             REAL    fromTime=-1.0,
	                             REAL    toTime=-1.0,
	                             BOOLEAN initialFlag=TRUE, 
	                             BOOLEAN boundsFlag= TRUE, 
	                             BOOLEAN dataFlag= TRUE, 
	                             BOOLEAN explicitFlag= TRUE, 
	                             BOOLEAN residuesFlag= TRUE, 
	                             BOOLEAN jacobiansFlag=FALSE )
	This function that is used at the start of an experiment will produce an ASCII output file called simulation.log.txt containing information on the progress of a simulation. When working with medium or large models, the file could be enormous, so two filtering criteria are used.
	 	Criterion 1: By the call of the residue function. The arguments fromCall and toCall allow filtering a range [fromCall,toCall] of residues calls to be printed. By default they are -1, which means no filter. This criterion is typically used in steady studies.
	 	Criterion 2: By the interval of the TIME variable of the model. It is possible to set a time filter [fromTime,toTime] so that if TIME is in the margin the report is generated. This criterion is typically used for transient studies. By default the value of both arguments is -1.0 so that the filter is not active.
	The output report has several block data and all of them can be activated/deactivated:
	INPUTS
	 	Initial value of the Jacobian variables: dynamics+algebraics(initialFlag).
	 	Boundaries (boundsFlag).
	 	Data (dataFlag). 
	OUTPUTS
	 	Explicit variables (explicitFlag). 
	 	Residues (residuesFlag). 
	By default all these flags have value TRUE, the user can deactivate any of them.
	In addition, there is a flag called jacobianFlag to activate/deactivate the reporting of the Jacobians that are produced during the simulation. By default it is set at FALSE.
	The precision of the real values is taken from the actual RDIGITS variable. In case more precision is needed the modeller can change this variable outside of the function.
	A trivial call like this:
	produceLogAsciiFile()
	produces the full report of the residues function calls (no Jacobians are reported by default). This function can be very convenient in the following situations:
	 	Comparing the evolution of the simulation between two versions of the tool. Two files can be produced and then  we can compare them (this is one of the reasons the output in ASCII format).
	 	Following the evolution of any calculated variable.
	 	Tracing when a not-a-number (#NAN) or and infinity (#INF) is produced.
	 	Tracing the evolution of the residues.
	 	Analyzing Jacobians.
	

*/
COMPONENT comp_debuggingCallsResidues
DATA
        REAL ymax = 0.8             "Maximum value (-)"
        REAL ymin = -0.5            "Minimum value (-)"
        REAL tau = 0.01             "Characteristic delay time (s)"
    DECLS
        REAL dy                     "Finite differences derivative (Hz)"
        REAL x                      "Main variable (-)"
        REAL y                      "Limited and delayed variable (-)"
    CONTINUOUS
        dy = (x - y) / tau
        y' = ZONE ((y > ymax) AND (dy > 0)) 0.
             ZONE ((y < ymin) AND (dy < 0)) 0.
             OTHERS                         dy


END COMPONENT
-- Function to set v[i,j] = value
FUNCTION NO_TYPE func_setArrayElem2D( OUT REAL v[],
                                 IN INTEGER i,
                                 IN INTEGER j,
                                 IN REAL value )
    DECLS
        INTEGER index,dim2
    BODY
        dim2= sizeArrayReal( v[1], 2 ) -- calculate second dimension
        index= j + (i-1)*dim2  -- calculate equivalent one-dimension index
        v[index]= value
END FUNCTION
-- Function to get v[i,j]
FUNCTION REAL func_getArrayElem2D( OUT REAL v[],
                              IN INTEGER i,
                              IN INTEGER j )
    DECLS
        INTEGER index,dim2
    BODY
        dim2= sizeArrayReal( v[1], 2 ) -- calculate second dimension
        index= j + (i-1)*dim2      -- calculate equivalent one-dimension index
        RETURN v[index]

END FUNCTION

// Obtaining Array Dimensions during Runtime
/*
	There are functions in the program for calculating the dimensions of an array during the execution time. They are typically called from functions written in EL when they are passed as data array arguments. The functions available are as follows:
	FUNCTION INTEGER dimArrayReal( OUT REAL v )
	FUNCTION INTEGER sizeArrayReal( OUT REAL v, INTEGER code )
	FUNCTION INTEGER dimArrayInt( OUT INTEGER v )
	FUNCTION INTEGER sizeArrayInt( OUT INTEGER v, INTEGER code )
	FUNCTION INTEGER dimArrayBool( OUT BOOLEAN v )
	FUNCTION INTEGER sizeArrayBool( OUT BOOLEAN v, INTEGER code )
	FUNCTION INTEGER dimArrayString( OUT STRING v )
	FUNCTION INTEGER sizeArrayString( OUT STRING v, INTEGER code )
	There are basically two functions:
	 	Function dimArrayReal(OUT REAL) returns the number of dimensions of an array. For example, with the array REAL m[23,2,5] if we call the function:
	INTEGER dim= dimArrayReal( m[1] )
	     The value returned will be 3 (dim=3) because this array has 3 dimensions. It must be established that the argument passed is "m[1]", in other words the first element of the array must always be passed as though it were in one dimension because the number of dimensions is not yet known
	 	Function sizeArrayReal(OUT REAL, INTEGER  code), depending on the code, returns an integer with the size of:
	 	If code is 0, it returns the total size of the array.
	 	If code is greater than 0 and less than the number of dimensions (dim), it returns the size of the dimension given in code.
	    For example, it could be written like this:
	total= sizeArrayReal(m[1], 0)  total will be 23 * 2 * 5 = 230
	seconDim = sizeArrayReal(m[1], 2)  -- seconDim will be 2
	The other functions are the same as those described above, but using integer, boolean and string arrays.
	It is important to note that when the arrays you are passing as argument have more than one dimension, they have to be treated as one-dimensional in the function. To do this, you have to calculate the equivalent one-dimensional index in the array. This real index is calculated knowing that the arrays are stored in the following manner:
	V[3,2] is stored as:
		index 1= v[1,1]
		index 2= v[1,2]
		index 3= v[2,1]
		index 4= v[2,2]
		index 5= v[3,1]
		index 6= v[3,2]
	

*/
/*
	For example, we can program two functions to set and get an element of a two-dimensions array (in a similar manner can be done for bigger dimensions), since the arrays we are passing in this example have two dimensions, it is necessary to know the size of the second dimension (in general they are necessary all dimensions except the first one):
*/
FUNCTION REAL func_funfun(OUT REAL m[])
    DECLS
        REAL x
        INTEGER size
    BODY
        size= sizeArrayReal(m[1],1) -- obtain dimension  1 size
        FOR(i IN 1, size)
            m[i]= 8.34
        END FOR
        x= SUM(i IN 1,size; m[i])
        RETURN x
END FUNCTION
// Obtaining Array Dimensions during Runtime
/*
	There are functions in the program for calculating the dimensions of an array during the execution time. They are typically called from functions written in EL when they are passed as data array arguments. The functions available are as follows:
	FUNCTION INTEGER dimArrayReal( OUT REAL v )
	FUNCTION INTEGER sizeArrayReal( OUT REAL v, INTEGER code )
	FUNCTION INTEGER dimArrayInt( OUT INTEGER v )
	FUNCTION INTEGER sizeArrayInt( OUT INTEGER v, INTEGER code )
	FUNCTION INTEGER dimArrayBool( OUT BOOLEAN v )
	FUNCTION INTEGER sizeArrayBool( OUT BOOLEAN v, INTEGER code )
	FUNCTION INTEGER dimArrayString( OUT STRING v )
	FUNCTION INTEGER sizeArrayString( OUT STRING v, INTEGER code )
	There are basically two functions:
	 	Function dimArrayReal(OUT REAL) returns the number of dimensions of an array. For example, with the array REAL m[23,2,5] if we call the function:
	INTEGER dim= dimArrayReal( m[1] )
	     The value returned will be 3 (dim=3) because this array has 3 dimensions. It must be established that the argument passed is "m[1]", in other words the first element of the array must always be passed as though it were in one dimension because the number of dimensions is not yet known
	 	Function sizeArrayReal(OUT REAL, INTEGER  code), depending on the code, returns an integer with the size of:
	 	If code is 0, it returns the total size of the array.
	 	If code is greater than 0 and less than the number of dimensions (dim), it returns the size of the dimension given in code.
	    For example, it could be written like this:
	total= sizeArrayReal(m[1], 0)  total will be 23 * 2 * 5 = 230
	seconDim = sizeArrayReal(m[1], 2)  -- seconDim will be 2
	The other functions are the same as those described above, but using integer, boolean and string arrays.
	It is important to note that when the arrays you are passing as argument have more than one dimension, they have to be treated as one-dimensional in the function. To do this, you have to calculate the equivalent one-dimensional index in the array. This real index is calculated knowing that the arrays are stored in the following manner:
	V[3,2] is stored as:
		index 1= v[1,1]
		index 2= v[1,2]
		index 3= v[2,1]
		index 4= v[2,2]
		index 5= v[3,1]
		index 6= v[3,2]
	

*/
-- For using arrays arguments with more dimensions is similar, for example next function shows the equivalent set() function for three dimensional arrays:
-- Function to set v[i,j,k] = value
FUNCTION NO_TYPE func_setArrayElem3D( OUT REAL v[],
                                 IN INTEGER i,
                                 IN INTEGER j,
                                 IN INTEGER k,
                                 IN REAL value )
    DECLS
        INTEGER index,dim2,dim3
    BODY
        dim2= sizeArrayReal( v[1], 2 )
        dim3= sizeArrayReal( v[1], 3 )
        index = ( i-1 ) * dim2 * dim3 + (j-1) * dim3 + k
        v[index]= value
END FUNCTION
// Obtaining Array Dimensions during Runtime
COMPONENT comp_obtainingArrayDimensionsDuringRuntime 
    DECLS
        REAL g[13]   
        REAL x
		  REAL v[6,4]
		  REAL result
		  REAL vxm[3,4,5]
	INIT
		  func_setArrayElem2D( v, 2, 3, 67.34 ) -- set the element v[2,3] = 67.34
        result= func_getArrayElem2D( v, 2, 3 )
		  WRITE("v[2,3]= %g\n",result)
   CONTINUOUS
        x= func_funfun(g)
END COMPONENT
 
// Function to Obtain Units of Variables
// Function to Obtain the Release Report
//	Function to Obtain Internal Residues
//	Function to Obtain the tolerance of steady solver

/*
	The unitsOfVariable() function can be used to obtain the units of a variable 
		If the variable did not have any units or if it did not exist, an empty string is returned. If the user wants to check first whether the variable exists, the existsVariable() function can be used
	The versionReport() function returns a string with the identification of the version of the program including the following:
	 	Names of experiment, library, component and partition.
	 	User who generated the experiment.
	 	Date and time of creation.
	 	Libraries used and their versions.
	 	Name and version of program.
	If the user wants to know the value of an internal residue of the Jacobian, the getResidueValue() function can be used with the following format:
		residue1 = getResidueValue(1)
		This function returns a REAL with the value of the internal residue 1. The internal residues are associated with the dynamic and algebraic variables of the Jacobian equations system.
		To know the Jacobian variables, display the partition information file. In this file you will find a table with the Jacobian variables and their associated closure equations. The function allows the user to obtain any of the N residues at any time.
		If the residue number you pass to the function is lower than zero or greater than the number of internal residues (or Jacobian variables), the function returns 0.0 and displays an error message.
	The getSteadyTolerance() function returns the value of TOLERANCE. It can be used from components, port, functions, etc
*/
COMPONENT comp_obtainUnitsReportInternalResiduesTol
   "Aircraft arrester gear system example (used for ZONE statement demonstration)"

   DATA
      REAL m1 = 2042.6            UNITS u_kg		"Aircraft mass"
      REAL m2 = 660.6             UNITS u_kg		"Carriage mass"
      REAL m3 = 291.8             UNITS u_kg		"Squeezer mass"
      REAL k1 = 6170              UNITS u_N_m	"Spring coefficient 1"
      REAL k2 = 34310             UNITS u_N_m	"Spring coefficient 2"
      REAL h = 38.1               UNITS u_m		"Horizontal length of cable"

   DECLS
      TABLE_1D tab = {
            {0, 9.14, 18.29, 36.58, 45.72, 54.86, 64.01, 73.15, 82.30, 85.95, 89.61, 93.27, 95.10, 98.76},
            {398.56, 191.39, 76.56, 248.80, 248.80, 315.79, 397.13, 511.96, 765.55, 1004.78, 1339.71, 1961.72, 2392.34, 4306.22}
         } "Drag coefficient (N*s^2/m^2) vs 'y3' displacement (m)"

      REAL y1, y2, y3             UNITS u_m			"Displacements "
      REAL x                      UNITS u_m			"Horizontal distance aircraft arrester cable"
      REAL fk1, fk2               UNITS u_N			"Cable tensions"
      REAL sinetheta              UNITS no_units	"Sine of angle of cable under tension"
      REAL fdrag                  UNITS u_N			"Drag force"
      REAL temp                   UNITS "N*s^2/m^2"	"Drag coefficient"
	INIT
		WRITE("\n\nActual tolerance is %g\n\n", getSteadyTolerance())
   CONTINUOUS
      -- Geometry
      y1 = sqrt(x**2 + h**2) - h
      sinetheta = x / (h + y1)

      -- Calculats drag coefficient from the table
      temp = linearInterp1D(tab, y3)

      -- Drag force
      fdrag = temp * y3'**2

      -- Cable tensions
      fk1 = ZONE (y1 > 2 * y2) k1 * (y1 - 2 * y2)
            OTHERS             0.

      fk2 = ZONE (y2 > y3) k2 * (y2 - y3)
            OTHERS         0.

      -- Acceleration of masses
      y3'' = (fk2 - fdrag) / m3
      y2'' = (2. * fk1 - fk2) / m2
      x'' = -2. * fk1 * sinetheta / m1

END COMPONENT
// Creation of variables names at run-time
/*
The function joinName() is a global function that is used to create variable names based on a prefix and a suffix. Its format is as follows:
FUNCTION STRING  joinName(IN STRING prefix,IN STRING suffix)
Where the arguments are:
 	prefix: this is the left part of the name
 	suffix: the right part of the name
The function returns a string concatenation of both including a point (.) in between. For example if the prefix is "obj" and the suffix "velocity", the function will return "obj.velocity". If the prefix is empty it will return the suffix only (“velocity”).
Normally this function is used to create the full name of a variable at run-time; as a prefix it must be used INSTANCE_NAME that it will be translated to the actual prefix
*/
COMPONENT comp_joinName0
DECLS
	REAL z
INIT
	WRITE("final name:= \"%s\"\n",joinName(INSTANCE_NAME,"z"))
END COMPONENT

COMPONENT comp_joinNameFinal
TOPOLOGY
	comp_joinName0 obj[3]
END COMPONENT
//	Introduction of New Algebraic Constraints in the Experiment
/*
	Normally, the mathematical model of dynamic and algebraic variables is closed when the partition is done, but a possibility exists to increase the number of algebraic constraints (though not the dynamic ones) in the experiment itself. This can sometimes be interesting when it is wanted to impose additional restrictions on the mathematical model during its solving, both in the calculation of steady-state and of transient solvers. This technique can be used in the design of data or boundaries, to adjust models, etc.
	The technique to follow consists in creating 2 functions in the experiment that can be added to the mathematical model of the partition. The first function will be used to pass the values of the unknowns ("dyn" vector) to some datum or boundary of the model and the other function is the one that will create as many residuals as algebraic ones created which will be the constraints of the system. 
	There are 2 functions that can be used in the experiment:
		FUNCTION BOOLEAN addExtraEquationsToPartition(IN INTEGER nUnk,
	    	IN REAL initial[],FUNC_PTR fcn_pre,FUNC_PTR fcn_post,OUT STRING names[])
	
		FUNCTION BOOLEAN cleanExtraEquationsToPartition()
	The function addExtraEquationsToPartition() is the one used to add the necessary information to expand the system of algebraic equations of the partition. The arguments are:
	 	nUnk: Number of algebraic equations to be added.
	 	initial[]: Array (of size nUnk) with the initial values of the new algebraic functions.
	 	fcn_pre: Function pointer for initializing values of the model.
	 	fcn_post: Function pointer used to generate the new residuals.
	 	names[]: Array (of size nUnk) with the names of the new algebraic functions. This serves only to generate more legible convergence reports.
	The functions fcn_pre and fcn_post must obligatorily take the form:
		FUNCTION NO_TYPE fresXXX(OUT REAL time,
	                         OUT REAL dyn[],
	                         OUT REAL der[],
	                         OUT REAL res[]) 
		Where:
	 		time: is the actual time proposed by the solver.
	 		dyn[]: is the array of dynamic and algebraic variables used by the solvers. The user must use those from index 1, although internally all the new algebraic ones will be placed at the end of the vector dyn[] of the partition (the tool internally manages the indices).
	 		der[]: is the array of derivatives; could be used if the indices of each derivative are known (these are in the Jacobian that can be viewed in the mathematical model) but normally, this vector is never used.
	 		res[]: is the array of residuals. The new residuals will begin with the index 1 although internally all the new residue ones will be placed at the end of the vector res[]. This vector defines the new algebraic constraints which the models must meet. 
	The function cleanExtraEquationsToPartition() is used to reset the additional equations imposed on an experiment. In other words, it makes it possible to eliminate systems of equations created with addExtraEquationsToPartition(). This allows producing different set of new algebraics in the same experiment.
	
*/
COMPONENT comp_newAlgebraicConstraints
DECLS
	REAL x
CONTINUOUS
	x - cos(x) = 3.4
END COMPONENT
// Labelling different simulations in plotters
/*
	During simulation it is sometimes necessary to show different curves for a single variable in the same graph.
	The function NEW_BRANCH() enables us to indicate at what moment of the simulation each branch commences and to assign it a specific identity.
	The syntax of this function is:
		NEW_BRANCH(STRING label)
	where "label" represents the text which is added to the name of each variable in the legend of each graph. This label can also include numeric values from the simulation, using for example the syntax:
		NEW_BRANCH("VarName = $VarName")
		where "$VarName" is the value taken by the variable "VarName" the moment the new branch is created.
	If the label has already been used, a warning will appear on the Monitor and the command will be ignored. If you want to use an already-created branch, use the function USE_BRANCH().
	The syntax of this function is:
		USE_BRANCH(STRING label)
		Where "label" represents a label already created with the previous function. If it was not created, a message will appear and the function will be ignored.
*/
COMPONENT comp_newBrach
    DATA
        REAL tau = 0.6              "Delay time (s)"
		  REAL k1 = 0.
        REAL k2 = 0.

    DECLS
        REAL x                      "Main variable (-)"
        REAL y                      "Delayed variable (-)"
		  REAL z
    CONTINUOUS
        y' = (x - y) / tau
		  z = k1**2 + k1 * k2 - k2**2
END COMPONENT
// Getting Statistics of Jacobian Evaluations and Residues Functions
/*
	During the experiment, program users can ascertain the number of Jacobian evaluations of status variables that have been performed with the functions getJacobianEvals. The signature is simple:
		INTEGER getJacobianEvals()
	They can also determine the actual number of times the residues function has been evaluated with the function getResiduesEvals() with signature:
		INTEGER getResiduesEvals()

*/
COMPONENT comp_statisticsJacobianResidues
   DECLS
        REAL x
        REAL y
    INIT
        x= 3
        y= 4
    CONTINUOUS
        x' = sin(TIME)
        y= x + 2
END COMPONENT