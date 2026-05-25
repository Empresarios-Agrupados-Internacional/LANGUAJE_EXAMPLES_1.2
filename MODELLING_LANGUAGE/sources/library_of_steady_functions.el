/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: library_of_steady_partition_functions
-----------------------------------------------------------------------------------------*/
// How to Change the Criteria for Calculating an Individual Residue
/*
	To change any local residue information, use the following function:
		BOOLEAN setResidueInfo(INTEGER residue,
	                       REAL    tolerance,
	                       INTEGER tolType,
	                       REAL    vref= 1.0)
	Where residue is the residue equation number, tolerance is the allowed tolerance in this residue, tolType is the tolerance type  either ABSTOL or FRACTOL-, and vref is the reference value to be used when FRACTOL is selected (by default it is 1.0). The following is an example of usage:
		setResidueInfo( 2, 1E-3, FRACTOL, 4568.5)
	This example changes the second residue equation parameters as follows: the local tolerance is 1E-3, the residue will be evaluated in fractional mode and the reference value for the denominator is 4568.5. If, instead, it is written thus:
		setResidueInfo( 2, 1E-3, FRACTOL)
	The tool will estimate the vref on every residues function call based on the criteria explained before
	
*/
// How to Change the Algorithm for Calculating the Residues
/*
	The user can change the algorithm for calculating the residues in FRACTOL mode with the function
		useEvalNormResidueFunction(FUNC_PTR fcn)
	The only argument you have to pass to this function is another function to be called every time the residue needs to be calculated. The signature of this function must have the following arguments:
		FUNCTION REAL resMethod (INTEGER index, 
                         ENUM t_steadyMethods typeTol,
                         REAL lhs,
                         REAL rhs,
                         REAL ref)
		Where index is the number of residue (normally not used), typeTol is the tolerance type (FRACTOL or ABSTOL), lhs and rhs are left-hand-side and right-hand-side parts of the closure equation and ref it is the reference for the denominator (if given by the user).
*/
// Advanced steady settings
// Changing Parameters for the Steady Solver
/*
	EL allows certain default values to be changed when steady states are calculated. The table below shows the parameters that can be modified along with their default values and the associated EL variable or function which allows them to be modified:
	Parameter	EL variable	Values	Default value
	Solver method													SMETHOD		NR, MINPACK	                            	NR
	Tolerance type													TOLTYPE		RELTOL, RELTOL_DELTA,ABSTOL,FRACTOL		 	RELTOL
	Tolerance error												TOLERANCE	> 0													1.0E-6
	Maximum number of iterations								MAXITER		> 0													10000
	Maximum number of residue function evaluations		MAXFEVAL		> 0													40000
	Maximum number of Jacobian evaluations					MAXJACEVAL	> 0													60
	Maximum number of consecutive Jacobian estimations	MAXBROYDEN	> 0													60

*/

//Steady Solver Debugging Information
/*
	The log file of the simulation provides good debugging information of the tracing of the solving task. 
	When a steady state fails to find a solution and you use debug level 2, the steady solver generates info in the log file for these cases. If you increase to debug level to 3, the convergent cases are also reported; 
	and if the debug level is 4, all Jacobians of the calculation are shown.
	Normally, it only makes sense to request this report when a steady state is non-convergent, 
	although it can be produced anyway. The debug report is located in the log file associated with each experiment execution.
	Using debug level 1, the user can display information about the success or lack of success of the method. Only a brief error message is printed. 
	However, for debug levels 2 and 3, more information is returned detailing the solver configuration and iteration process: variable and residue values, Jacobian matrixes, etc
*/

COMPONENT comp_steadySolver
	DECLS
        REAL x
        REAL y
   CONTINUOUS
        x' = 1 + y**2
        y' = x - y
END COMPONENT
// External Steady State Calculation Example
/*
	The user can directly use the nonlinear equation solver with the functions nlsolver() and nldsolver() (STEADY() function calls those functions internally). The user can directly call these two functions to solve a set of algebraic equations:
	NO_TYPE nlsolver (FUNC_PTR fcn, 
			    	IN INTEGER n, 
				OUT REAL dyn[], 
				OUT REAL fres[], 
				OUT INTEGER info,
				OUT STRING errMsg)
	
	NO_TYPE nldsolver (FUNC_PTR fcn, 
				IN INTEGER n, 
		   		OUT REAL dyn[], 
				OUT REAL fres[], 
				OUT INTEGER info,
				IN STRING equations[],
				IN STRING names[],
				OUT STRING errMsg)
	Both are identical; the only difference is that the second one uses two extra arguments passing arrays of strings with the residue equations and names of the unknown variables (used for generating more meaningful reports).
	The arguments of the functions are:
	 	fcn: Function pointer. This function is called from the steady method (see below)
	 	n: Number of unknown variables
	 	dyn: Unknowns vector
	 	fres: Residues vector
	 	info: Returned code from the solver. It can take the following values:
	 	info = 1 Ok, convergence succeeds
	 	info = 2 Number of calls to fcn has reached or exceeded maxfev
	 	info = 3 tol is too small. No further improvement in the approximate solution x is possible
	 	info = 4 Iteration is not making good progress, as measured by the improvement from the last five Jacobian evaluations
	 	info = 5 Iteration is not making good progress, as measured by the improvement from the last ten iterations
	 	info = 6 A numerical exception happened during the calculation
	 	errMsg: Error message (in case of non-convergence)
	 	equations: Array with the residue equation strings
	 	names: Array with the unknown variable names
	

*/
COMPONENT comp_externalSteadyStateCalculation
	DECLS
        REAL x
        REAL y
   CONTINUOUS
        1.645 = x + y * 1e-6
		  2.3445e-6 * x + 3e-6 * y = 3.454
END COMPONENT