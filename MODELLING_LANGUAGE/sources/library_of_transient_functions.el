/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: library_of_transient_partitions_function
-----------------------------------------------------------------------------------------*/
// Integration at a given time
/*
	Integration can be performed at TIME=TSTOP. It simply calls the component INIT blocks and satisfies residuals with the equations given in the CONTINUOUS blocks
*/
COMPONENT comp_expTest
    DECLS
        REAL x
        REAL y
		  BOOLEAN reached = FALSE
    INIT
        x= 3
        y= 4
    CONTINUOUS
        x' = sin(TIME)
        y= x + 2
END COMPONENT

// A way to reduce the Integration Step
/*
	The modeller will sometimes want to work with a specified integration step which does not coincide with the communications interval (CINT).
	This situation typically arises when fixed step numeric algorithms are used such as the explicit 4th order Runge-Kutta method.
	In such cases, EL supplies a variable called NSTEPS which allows the communications interval (CINT) to be divided into a series of internal steps

*/
COMPONENT comp_nsteps
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

// Synchronising time with Real Time
/*
	A simulation satisfies real time requirements when the model’s minimum calculation time is less than the real
time or the simulated period. If the calculations take longer, they would never be able to catch up with the real
time.
For example, with integration from 0 to 100 seconds and a calculation time of 10 seconds we can instruct
program to integrate the model, always waiting for the program time clock to coincide with the integration
time clock. In this case, integration would also take 100 seconds, which means that program would be on
standby for 90 seconds.
In the previous example, if the calculation time were 150 seconds, integration in real time would be impossible
because the necessary calculations take longer (150 sec) than the integrated period (100).
program has a FOLLOW_RT variable which is normally set to FALSE and means that the calculation time
clock does not follow the integration time clock. If it is set to TRUE, it will make the calculation time at least
the same as the integration time.
*/
COMPONENT comp_synchronising_realTime
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
// Advanced transient debugging with DASSL
/*
These advanced functions are only implemented in the DASSL family of solvers and are only considered to be of use to advanced users. This check is only carried out when the DEBUG_LEVEL is set to 3 or greater
*/
// Check Integration Step Reduction
/*
	Program can print out a warning each time the DASSL integrator reduces the integration step. This gives an idea of a potential problem when integrating the equations system.
	This check is only carried out when the DEBUG_LEVEL is set to 3 or greater and the variable WARN_STEP_REDUCT is TRUE. 
	By default the variable is set to TRUE. Use of the variable is only required to activate/deactivate the messages.
		
*/
COMPONENT comp_integrationStepReduction
    DECLS
      REAL x
    CONTINUOUS
	 	x' = func_fdis(x)
END COMPONENT
// Check Residues Function Repeatability
/*
	program can detect whether the residues function is a true independent function returning always the same outputs given the same inputs.
	This test gives the modeller an important clue to avoid this situation since non-repeatable residues function can be a serious problem when it comes to making the system of equations converge.
	There is a global variable to activate/deactivate this warning; it is CJVITG. By default this variable is set to TRUE but DEBUG_LEVEL must be 3 for getting the error messages
*/
COMPONENT comp_residuesFunctionRepeatability
    DECLS
        REAL x,y,z
    CONTINUOUS
        y'= sin(TIME)
        x'= cos(TIME) + func_mmm(y)  	-- this equation will have problems!
        z* x= z' - y
END COMPONENT
