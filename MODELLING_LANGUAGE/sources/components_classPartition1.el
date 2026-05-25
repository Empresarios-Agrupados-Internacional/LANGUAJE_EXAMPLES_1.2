/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: components_classPartition1
 CREATION DATE: 15/03/2018
-----------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: class_componentPartition

-----------------------------------------------------------------------------------------*/
// Logs within partition classes
/*
	By default, performing calculations on any class associated with a partition will not produce any on-screen messages or log files.
	There is a set of functions to activate and deactivate these flags:
	 	Print simulation messages when running
	NO_TYPE setTraceProgramme(BOOLEAN status)
	 	Return the current status of flag for tracing the simulation
	BOOLEAN traceProgramme()
	 	Print simulation messages in the log file
	NO_TYPE setLogProgramme(BOOLEAN status)
	 	Return the current status of flag for logging the simulation
	BOOLEAN logProgramme()
	 	Check assertions when running
	NO_TYPE setWarnProgramme(BOOLEAN status)
	 	Return the current status of flag for checking assertions
	BOOLEAN warnProgramme()
*/
// Partition class inheritance
/*
	We can customize partition class behaviour creating classes that inherit from the partition class. This way, a more user-friendly interface can be created for operating with a mathematical model
	In this example, we have embedded the same experiment in a method of a new class called "aircraftTransient". 
*/
CLASS class_aircraftTransient IS_A comp_classAircraft_default
    METHODS
        METHOD NO_TYPE run()
            BODY
                 -- set initial values
                setTraceProgramme(TRUE)
                setValueReal("y3", 0)
                setValueReal("y3'", 0)
                setValueReal("y2", 0)
                setValueReal("y2'", 0)
                setValueReal("x", 0)
                setValueReal("x'", 60.96)
	
                 -- integrates the model
                REPORT_TABLE("rAir", " * ")
                TIME = 0.
                TSTOP = 10.
                CINT = 0.05
                INTEG()
        END METHOD
END CLASS