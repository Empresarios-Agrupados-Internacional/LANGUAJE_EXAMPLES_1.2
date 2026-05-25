

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

COMPONENT comp_classAssociatedPartition
    DECLS
        STRING tvar
        STRING tcategory
		  INTEGER nvars
    OBJECTS
        comp_classAircraft_default obj
    INIT
         -- obtain the total number of variable of this model
        nvars = obj.getNumberVars()
         -- print all variable names
        FOR(i IN 1,nvars)
            WRITE("variable %d= %s\n", i , obj.getVarName(i))
        END FOR

         -- set a value for variable c1.c if exits
        IF ( obj.existsVariable("h") ) THEN
            obj.setValueReal("h", 40)
        END IF
        
         -- get the variable type (e.g. "REAL", "INTEGER", etc.)
        tvar = obj.getVarTypeStr("m3")
         -- get the variable category (e.g. "EXPLICIT", "BOUNDARY", etc.)
        tcategory= obj.getVarCategoryStr("m3")
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

COMPONENT comp_useAircraft
    OBJECTS
        comp_classAircraft_default air
    INIT
         -- set initial values
        air.setTraceProgramme(TRUE)
        air.setValueReal("y3", 0)
        air.setValueReal("y3'", 0)
        air.setValueReal("y2", 0)
        air.setValueReal("y2'", 0)
        air.setValueReal("x", 0)
        air.setValueReal("x'", 60.96)
	
         -- integrates the model
        air.REPORT_TABLE("rAir", " * ")
        air.TIME = 0.
        air.TSTOP = 10.
        air.CINT = 0.05
        air.INTEG()
		  
END COMPONENT




// Partition class inheritance
// In this example, we have embedded the same experiment in a method of a new class called "aircraftTransient
COMPONENT comp_useAircraftTransient
    OBJECTS
        class_aircraftTransient air
    INIT
         -- run the experiment
        air.run()
END COMPONENT
