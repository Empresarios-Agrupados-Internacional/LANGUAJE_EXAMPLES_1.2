/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: components_classPartition2
 CREATION DATE: 16/03/2018
-----------------------------------------------------------------------------------------*/
// Class Associated with a Partition
/*
	When generating a partition, the tool can automatically generate an internal class representing the mathematical model generated. This provides a number of advantages:
	 	Any partition can be encapsulated in a single class
	 	This class provides an interface for interaction with a partition. For instance, initialization of variables, steady and transient calculation, value retrieval of variables, etc.
	 	Simulations can be embedded in components, functions, experiments and classes, since they are encapsulated within the partition class
	 	Multiple experiments can be executed in the same run
	 	Child classes (inherited from the partition classes) can be created by adding new variables and methods. Moreover a child class could provide complex experiments embedded in a single method
	To automatically generate the class associated with the partition, the user must select the option:
	Generate an associated class for a partition
	In the advanced partition options, located at the partition edition assistant. In this case, each time the modeller makes a partition, an internal class will be generated with the name:
	ComponentName_PartitionName
	Once the internal class has been created, the modeller can declare an object of that class from any OBJECTS block, such as:
		OBJECTS
	    	aircraft_transient air
	Care must be taken when using partition classes within the CONTINUOUS block of components because Program arranges the equations that appear in the CONTINUOUS block, changing the execution order of the calls to object methods (as it does when using functions). Normally, operations with these types of objects should be done in the INIT or DISCRETE blocks of components and BODY blocks of functions and experiments
*/	
//	Access to Variables during Simulation
/*
	The user can access any model variable and information about it using the following methods:
	 	Get the total number of variables
	INTEGER getNumberVars ()
	 	Get the name of the variable that has index i
	STRING getVarName (IN INTEGER i)
	 	Check whether a variable exists
	BOOLEAN existsVariable(IN STRING name)
	 	Get the type of the variable (in string format such as "REAL", "INTEGER", "BOOLEAN", etc)
	STRING getVarTypeStr (IN STRING name)
	 	Get the type of the variable in integer format. The valid types and codes are REAL=1, INTEGER=2, STRING=3, BOOLEAN=4 and FILEPATH=17
	INTEGER getVarType (IN STRING name)
	 	Get the category of the variable in integer format. The valid types and codes are BOUNDARY=1, DYNAMIC=2, DERIVATIVE=3, ALGEBRAIC=4, PARAMETER_CTE=5, EXPLICIT=6, DISCRETE=7, DATA_VAR=8, CTE=9 and EXPERIMENT_VAR=10
	STRING  getVarCategory (IN STRING name)
	 	Get the variable category in string format such as "DYNAMIC", "ALGEBRAIC", "DATA", "DERIVATIVE", etc)
	INTEGER  getVarCategoryStr (IN STRING name)
	
	 	Return the actual value of a REAL variable
	REAL    getValueReal  (IN STRING name)
	 	Set the REAL value to value v (returns FALSE if not found)
	BOOLEAN setValueReal  (IN STRING name, IN REAL v)
	 	Get the current value of an INTEGER variable
	INTEGER    getValueInt  (IN STRING name)
	 	Set the INTEGER value to value v (returns FALSE if not found)
	BOOLEAN setValueInt  (IN STRING name, IN INTEGER v)
	 	Get the current value of a BOOLEAN variable
	BOOLEAN    getValueBool  (IN STRING name)
	 	Set the BOOLEAN value to value v (returns FALSE if not found)
	BOOLEAN setValueBool  (IN STRING name, IN BOOLEAN v)
	 	Get the current value of a STRING variable
	STRING    getValueString  (IN STRING name)
	 	Set the STRING value to value v (returns FALSE if not found)
	BOOLEAN setValueString  (IN STRING name, IN STRING v)
	 	Get the current value (in string format) of an Enumerative variable
	STRING    getValueEnum  (IN STRING name)
	 	Set the Enumerative value to value v (returns FALSE if not found)
	BOOLEAN setValueEnum  (IN STRING name, IN STRING v)
	 	Get the current value (in string format) of any variable of any type
	STRING    getValueAsString(IN STRING name)
	The following code gives an example of valid calls to the partition class generated from the "transient" partition of the "aircraft" component: After producing the partition, a class named "aircraft_transient" is generated automatically and it is possible to use it from any OBJECTS block.
	
*/


COMPONENT comp_classAssociatedPartitionInitializeArrayO
    DECLS
        REAL initial[3] = { 1.2, 8.23, 9.24 }
        REAL result[3]
    OBJECTS
        comp_classAssociatedPartitionInitializeArray_default test
    INIT
         -- init the array v passing the initial array and the dimension
        test.setArray1D("v",initial,3)
		  WRITE ("v[1] = %g\n",test.getValueReal("v[1]"))
		   WRITE ("v[2] = %g\n",test.getValueReal("v[2]"))
			 WRITE ("v[3] = %g\n",test.getValueReal("v[3]"))
         -- do some calculations here
         -- get the array into result passing the dimension
       test.getArray1D("v",result,3)
		 WRITE ("result[1] = %g\n",result[1])
		   WRITE ("result[2] = %g\n",result[2])
			 WRITE ("result[3] = %g\n",result[3])

END COMPONENT
// Operations Allowed with Classes of Models
/*
	By using these types of classes, you can perform any calculation with the partitions as if you were writing an experiment. For example, you can perform steady state and transient calculations on the same model. Thus, all the functions explained in the chapter on experiments can be used with these classes as well
	Let's look at an example of an experiment carried out on the component aircraftGear from the DEFAULT_LIB library:
	EXPERIMENT exp1 ON aircraftGear.default
	    INIT
	         -- Dynamic variables
	        y3 = 0.
	        y3' = 0.
	        y2 = 0.
	        y2' = 0.
	        x = 0.
	        x' = 60.96
	    BODY
	        REPORT_TABLE("reportAll", " * ")
	        TIME = 0.
	        TSTOP = 10.
	        CINT = 0.05
	        INTEG()
	END EXPERIMENT
	This same experiment can be integrated into a component using partition classes . Suppose we create a new component called useAircraft and that in its initialization (INIT block) we want it to perform a transient calculation of the partition aircraftGear_default just as we did in the experiment
	When using this component, a transient study will be executed for the aircraftGear model at the beginning of the calculation. This way, we have managed to embed a calculation of a mathematical model into another component. This makes the language very powerful for embedding mathematical models inside others
*/




// Steady Solver 
/*
 	Main function for Internal Steady Calculations
 	The STEADY() function calculates the steady state of a model. In other words it solves with a non-linear solver the set of internal algebraic equations given a set of initial values for the algebraic. 
	It is important to say that the user does not need to arrange residue equations for the internal model, since this is done automatically by the tool. The user can change many parameters of the solver and also information related to particular algebraic and residues.
	Normally there are two types of residues to be solved (the Jacobian matrix):
 		Derivatives in the model. In this case the tool will create an artificial residue for annulling the derivative at the end of the calculation.
 		Algebraic. The tool should have identified an internal residue equation that should make zero (with a tolerance).
	If the tool cannot calculate the steady state, the STEADY() function will return the code STEADY_NOK; otherwise, it returns STEADY_OK

	The tool is capable of calculating the steady state of math models by solving the non-linear algebraic equation system that results from automatically declaring the time derivatives of all the dynamic variables to be equal to zero. It uses the modified Powell' hybrid algorithm.
	In some cases the user could use the FREEZE() function to deactivate the calculation of some dynamic variables and achieve steady state.
*/
//	How to Change the Non-linear Solver
/*
	The global variable SMETHOD is used to specify the chosen method that the following values may have.
 		NR (default): It is the default method. It is based on the Powell hybrid method. It is the preferred method since it provides a complete debug report in case of non-convergence problems. This method allows utilisation of RELTOL, RELTOL_DELTA, ABSTOL and FRACTOL global tolerance schemas. It enables the minimum and maximum perturbations (absolute and relative) to be changed for each algebraic variable and the minimum and maximum allowed steps (absolute and relative) for each iteration. It also provides a complete debug file about the evolution of the resolution in HTML format.
 		MINPACK: It is directly based on Minpack library (ref. [MINPACK]) with a few modifications to obtain better convergence. It is based on the Powell hybrid method. It only allows the use of RELTOL as global tolerance criteria. It produces limited debug information.
	Users can select any of the methods by changing the SMETHOD variables in the experiment; for instance:
		SMETHOD= MINPACK

*/
// Global Convergence Criteria
/*
	The previous section showed how a residue is calculated. This section addresses the global convergence criteria of the equation system.  
	The global variable TOLTYPE is used to specify the type of global tolerance; for example:
	TOLTYPE =RELTOL
	The global variable TOLERANCE is used to indicate the global tolerance required by the modeller. If the user assigns another tolerance to a particular residue (see function setResidueInfo), this one will always prevail.
	Using the variable TOLERANCE is simple. For example:
	TOLERANCE = 1e-6
	The convergence criteria will be based on a tolerance of 1E-6 and, by default, all residues will use this tolerance. 
	Global convergence comes in 4 modes:
	RELTOL
		If this (the default) method is selected, the individual residues will be calculated by default in absolute (ABSTOL) unless any have been individually changed to FRACTOL using the function setResidueInfo(), in which case it is calculated in fractional mode.
		Convergence test: If RESIDUES is the residues vector, NXSOL is the normalised solutions vector, and ENORM(Z) denotes the Euclidean norm of a vector Z, then this convergence test attempts to guarantee that:
		ENORM(RESIDUES) < TOLERANCE   AND  ENORM(RESIDUES) < TOLERANCE*ENORM(NXSOL)
		If these conditions are satisfied, the algorithm succeeds.
		If TOLERANCE is less than machine precision, then the method only attempts to satisfy the maximum tolerance that the latter allows. Further progress is not usually possible.
	RELTOL_DELTA
		If this method is selected, the individual residues will be calculated by default in absolute (ABSTOL) unless any have been individually changed to FRACTOL using the function setResidueInfo(), in which case it is calculated in fractional mode.
		Convergence test: it is based on an estimate of the distance between the current approximation NXSOL and the actual solution NXSOL* of the problem.
		If RESIDUES is the residues vector, NXSOL is the normalised solutions vector,DELTA it is actual increment calculated for next iteration and ENORM(Z) denotes the Euclidean norm of a vector Z, then this convergence test attempts to guarantee that:
		DELTA < TOLERANCE*ENORM(NXSOL)  OR  ENORM(RESIDUES) = 0
		If these conditions are satisfied, the algorithm succeeds. If TOLERANCE is less than machine precision, then the method only attempts to satisfy the maximum tolerance that the latter allows. Further progress is not usually possible.
	ABSTOL
		When this method is selected, all the local residues are calculated in absolute mode (ABSTOL) unless explicitly defined for a FRACTOL residue (using the function setResidueInfo()), in which case that established by the function prevails.
		The tolerance to be applied can be either the value of the TOLERANCE variable or the local tolerance set in the function setResidueInfo(). If no specific tolerance is assigned, the global variable TOLERANCE is taken.
	FRACTOL
		When this method is selected, all the local residues are calculated in fractional mode (FRACTOL) unless explicitly defined for an ABSTOL residue (using the function setResidueInfo()), in which case that established by the function prevails.
		The tolerance to be applied can be either the value of the TOLERANCE variable or the local tolerance set in the function setResidueInfo().If no specific tolerance is assigned, the global variable TOLERANCE is taken.
	


*/