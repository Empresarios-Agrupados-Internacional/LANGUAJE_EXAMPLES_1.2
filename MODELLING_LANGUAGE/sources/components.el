/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE:
 //Components
 /* A component is a natural way to describe the behaviour of both the continuous and discrete behaviour of a model.
           Normally, components are created for individual physical entities such as a capacitor, a valve, a compressor, a heat-exchanger, etc.
			  In other words, components represent physical objects which act independently but are connected to others. 
			  A component can be as simple as a single electrical resistor with the Ohm's Law or as complex as a complete aircraft engine 
			  that includes compressors, turbines, etc.
*/
-----------------------------------------------------------------------------------------*/
/* 
	component_def   ::=  ABSTRACT? COMPONENT IDENTIFIER
 			( IS_A IDENTIFIER (,IDENTIFIER)*  )? 
			( '(' parameters_s ')' )?
				STRING_VALUE?  EOL*
 			( PORTS port_decl_s )?    
 			( DATA var_decl_s )?
 			( DECLS comp_decl_s )?    
 			( OBJECTS class_instace_stm_s  )?   
               	( TOPOLOGY topology_stm_s )?
                	( INIT seq_stm_s )?   
 			( DISCRETE discrete_stm_s )?
 			( CONTINUOUS labelled_stm_s )?
                     END COMPONENT

	A component can also contain special information about:
 	Abstract components, using the ABSTRACT keyword.
 	Inheritance. This is done using the keyword IS_A. It indicates that a component inherits from another or from others (multiple inheritance).
 	Construction parameters. They are only used in the construction of the component and for the creation of the component. 
	They are mainly used to dimension arrays and pass Chemical components.
 	A short description of the component in a textual format, e.g., "Valve component".
 	PORTS: Connection ports. These are the interface with the universe outside the component. Ports must be of a type already declared.
 	DATA: Component data. These are known data items of the component.
 	DECLS: The component s physical behaviour.
 	OBJECTS: The instances of classes used in this component.
 	TOPOLOGY: Aggregation of other components and their connections.
 	INIT: Initialization of the component. These are written as sequential statements.
 	DISCRETE: Discrete behaviour of the component. These are written as discrete statements.
 	CONTINUOUS: Continuous behaviour of the component. These are written as continuous statements.
*/
USE MATH
USE MODELLING_LANGUAGE_OBJECTS
// Syntax
/*
The general syntax for defining components is as follows:
component_def ::= ABSTRACT ? COMPONENT IDENTIFIER
( IS_A IDENTIFIER (, IDENTIFIER )* )?
( '(' parameters_s ')' )?
STRING_VALUE ? EOL *
( PORTS port_decl_s )?
( DATA var_decl_s )?
( DECLS comp_decl_s )?
( OBJECTS class_instace_stm_s )?
( TOPOLOGY topology_stm_s )?
( INIT seq_stm_s )?
( DISCRETE discrete_stm_s )?
( CONTINUOUS labelled_stm_s )?
END COMPONENT
The name of the component is declared using IDENTIFIER. A component can also contain special information
about:
 Abstract components, using the ABSTRACT keyword.
 Inheritance. This is done using the keyword IS_A. It indicates that a component inherits from another or
from others (multiple inheritance).
 Construction parameters. They are only used in the construction of the component and for the creation
of the component. They are mainly used to dimension arrays and pass Chemical components.
 A short description of the component in a textual format, e.g., "Valve component".
 PORTS: Connection ports. These are the interface with the universe outside the component. Ports must
be of a type already declared.
 DATA: Component data. These are known data items of the component.
DECLS: The component’s local variables. They are used to model the component’s physical behaviour.
 OBJECTS: The instances of classes used in this component.
 TOPOLOGY: Aggregation of other components and their connections.
 INIT: Initialization of the component. These are written as sequential statements.
 DISCRETE: Discrete behaviour of the component. These are written as discrete statements.
 CONTINUOUS: Continuous behaviour of the component. These are written as continuous statements.
*/
-- A simple component that models a delayed variable
COMPONENT comp_delayed "delayed simple component"
    DATA
        REAL tau= 0.1
    DECLS
        REAL x, y
    CONTINUOUS
        y' = ( x - y ) / tau
END COMPONENT
// A component with only a discrete part. The following example shows the modelling of a flip-flop device using only discrete behaviour.
-- defines the flip_flop device
COMPONENT comp_flip_flop (REAL delayTime) "Flip-flop example"
    PORTS
        IN ports_digitalPort pi			"input"
        OUT ports_digitalPort po			"output"
        IN ports_digitalPort clock		"from the clock"
        IN ports_digitalPort reset		"to reset the flip-flop"
    DISCRETE
	   -- when clock signal is FALSE generates an
	   -- output with a delay (except when reset is ON)	
      WHEN ( clock.s == FALSE ) THEN
      	IF ( NOT reset.s ) THEN
		   	po.s = NOT pi.s AFTER delayTime
			END IF
      END WHEN
	   -- if reset is ON, changes the output to FALSE
	  	WHEN ( reset.s == TRUE ) THEN
	   	po.s = FALSE AFTER 0
	  	END WHEN
END COMPONENT

// Abstract Components
/*
Components in EL are either abstract or concrete. 
 Abstract components describe a behaviour which on its own does not represent any physical component,
 and can only be used as a base component for other components. For example, in electrical components 
 we can define a common interface component which defines an input and output port typical for most electrical components
*/
ABSTRACT COMPONENT comp_OnePort 
    "Abstract component with one electrical port = Two Pins"
    PORTS
        IN ports_elec e_p "Positive pin"
        IN ports_elec e_n "Negative pin"
    DECLS 
        REAL i UNITS u_A	"Current flowing from pin e_p to pin e_n"
        REAL v UNITS u_V	"Voltage drop between the two pins = e_p.v - e_n.v"
    CONTINUOUS
        v = e_p.v - e_n.v
        0 = e_p.i + e_n.i
        i = e_p.i
END COMPONENT
// Inheritance
/*
EL supports single and multiple inheritance between components. 
 This is equivalent to exposing a child component to all the data and equations of the parent component(s).
 In this case it inherits the two connection ports "e_p" and "e_n" and de continuous block which are used in the child component as if they had been declared in it
*/
-- Resistor component with the Ohm' Law
COMPONENT comp_resistor IS_A comp_OnePort
    "Resistor"
    DATA
        REAL R=1 UNITS u_Ohm	"Resistance"
    CONTINUOUS 
        R*i = v
END COMPONENT
COMPONENT comp_capacitor IS_A comp_OnePort
    "Electrical Capacitor"
    DATA
        REAL C=1e-6 UNITS u_Farad 	"Capacitance"
    CONTINUOUS 
        i = C*v'
END COMPONENT
COMPONENT comp_ground 
    "Ground of an electrical circuit"
    PORTS
        IN ports_elec e_p 
    CONTINUOUS 
        e_p.v = 0
END COMPONENT
// A component that contains only an aggregation of other components and their topology.
// Below is an example of an electrical circuit which only instantiates already developed components and doesn't add any new behaviour
COMPONENT comp_circuit1 "electrical circuit example"
    TOPOLOGY
        comp_resistor r1 (1000)	
        comp_capacitor c1 ( 1e-1 )
        comp_ground e1				
        CONNECT r1.e_n TO c1.e_p	
        CONNECT c1.e_n TO e1.e_p 
END COMPONENT
// PORTS Block
/*
Components interface with the outside universe through connection ports. 
This block specifies which external ports are used by a component. These are the connectors to other components and 
they can only be used for that purpose. Instances of components can be used as normal variables and all the port local variables
Declaration syntax is:
PORTS
    [IN | OUT] port_type IDENTIFIER [,IDENTIFIER] [(parameters_init)]  
                                  ( CARDINALITY range )?  STRING_VALUE?
 	qualifier IN indicates that the port will be used for input and OUT for output.
 	"port_type" is the defined type of the port.
 	IDENTIFIER is the name of the port (several can be declared on the same line).
 	"parameters_init" is an optional list of the init construction parameters (if the port requires them).
 	"CARDINALITY range" is an optional flag to specify the minimum and maximum number of allowed connections to this port. If this flag is not present there are no restrictions on the number of allowed connections. Two formats are valid: "CARDINALITY min, max" and "CARDINALITY value". The first format is used to specify a range of minimum and maximum number of allowed connections, e.g., CARDINALITY 0,2. The second format imposes a unique valid number of connections, e.g., "CARDINALITY 1". The second format is equivalent to "CARDINALITY value, value".
 	"STRING_VALUE" is an optional field to write a short description of the port object.

*/
// The variable "pi" will be taken as the input port and "po" as the output port. The port "po" can be connected to none, 1 or 2 other ports
ABSTRACT COMPONENT comp_twoPorts
    PORTS
        IN ports_elec pi		             		"input port"
        OUT ports_elec po	CARDINALITY 0,2		"output port"
    
    CONTINUOUS
        pi.i = po.i
END COMPONENT
// DECLS block
/*
	The fundamental variables in the components fall into three categories:
 	In the CONSTRUCTION PARAMETERS block used only at instantiatiation time (public).
 	In the DATA block there are inputs to model (public).
 	In the DECLS block there are local variables to the component (private in other components, public in the experiments).

*/
// Construction Parameters
/*
	Construction parameters are passed for the creation of the component or port whose values do not have to be given when defining it,
	but which are necessary when it is used. When a parameterised port or component is instantiated,
	the value of the construction parameters must be specified and they cannot be changed during the simulation.
	One of the ways in which they differ from DATA is that DATA can change its value during an experiment, 
	but construction parameters never do.
	The BNF grammar for this block is as follows:
		param_def_s ::= '(' param_def ( ',' param_def )*  ')' 

		param_def ::= data_type id ( '=' initVal )? (UNITS STRING_VALUE)? STRING_VALUE?        
              enum_set_decl  '='  '{' enum_elem_s '}' STRING_VALUE?                         

*/
// The size of array "v" is "n". When this component is used from another component it can be changed
COMPONENT comp_mixcompo(INTEGER n=4)
    DATA
        REAL v[n] = 25
END COMPONENT
// Will use an array "v" of 15 positions
COMPONENT comp_big
    TOPOLOGY
        comp_mixcompo(n= 15) m1
END COMPONENT
// DATA Block
/*
	DATA are input data to the mathematical model; i.e., their value does not change over time, for instance,
	the value of R for a resistance, the diameter of a pipe, etc. Variables declared in the DATA block are initialized at the time
	of the declaration; they can also be initialized when the components are instantiated. 
	It is mandatory to provide them an initial value before to make the mathematical partitions, 
	then in the experiments could be changed this value if needed
	The BNF grammar for this block is as follow:
		data_s ::= (CONST? data_type general_id_s ( '=' init_expression )? 
           (UNITS STRING_VALUE)? obj_range? STRING_VALUE?)*

*/
// It allows declaring data (REAL, INTEGER, STRING, FILEPATH, ENUMERATIVE or BOOLEAN) with an initial value, 
// units (in STRING format), range of validity and description
COMPONENT comp_Pipe
    DATA
        REAL length = 1
        REAL diameter = 1
		  REAL speed[2] = 0
END COMPONENT
// It is strongly recommended to provide an initial value for any data when they are declared. 
// The data value can be changed later at several stages for example when using aggregation of components
COMPONENT comp_fluidCircuit
    TOPOLOGY
        comp_Pipe p1 (length = 0.5, diameter = 2, speed = 3)
END COMPONENT
// It is also possible to init a datum with other datum from the component
// In this example the whole array speed[] has been converted to explicit variables and also each element of the array has a different equation.
COMPONENT comp_fluidCircuitM
    DATA 
        REAL len1= 0.5
        REAL dia1= 2
	 DECLS
	 		REAL mySpeed[2] = 0.0
    TOPOLOGY
        comp_Pipe p1 (length = len1, diameter = dia1, speed = mySpeed)
	 CONTINUOUS
	 		mySpeed[1] = sin(TIME)
			mySpeed[2] = cos(TIME)
END COMPONENT
// DECLS Block
/*
The variables and enumeration types of any component are declared in the DECLS block. These are variables that have no connection to the outside universe and are normally used to calculate inside the component.
The BNF grammar for this block is as follow:
	decl_s ::= ( (PRIVATE|HIDDEN)? (BOUND|EXPL|DISCR|ALG)? var_decl
           | ENUM IDENTIFIER '=' '{' EOL* enum_elem_s EOL* '}' STRING_VALUE?
           | enum_set_decl  '='  '{' EOL* enum_elem_s EOL* '}' STRING_VALUE?
           | CLOSE identifier_s ( '=' init_expression )?
	var_decl ::= CONST? data_type id_s ( '=' initVal )? (UNITS STRING_VALUE)?
             obj_range? STRING_VALUE?
This allows declaration of variables (REAL, INTEGER, STRING or BOOLEAN) with an initial value, units (in STRING format), range of validity and description.
The optional prefix PRIVATE forbids the variable to be viewed or used in the experiments, it becomes internal to the models and no access to them is allowed. The prefix HIDDEN hides the variable in the experiment reports and plotters in the monitor but the variable can be used. HIDDEN is typically used for variables not very representative in the simulation reports but that sometimes the modeller could need to use
*/
COMPONENT comp_decls
	DATA
		BOOLEAN Contidition = TRUE
	DECLS
		// Continuous variables (they must be REAL)
		REAL z
		REAL v[3]
		// Arrays of discrete REAL variables
		DISCR REAL z1
		DISCR REAL v1[3]
		// Constant values using the keyword CONST
		CONST REAL PI = 3.1415
		// Set z variable as private, forbid its use in the experiments
		PRIVATE REAL z2
		//	Set z variable as hidden, hide the variable in experiment reports by default
		HIDDEN REAL z3
		// Declaration of enumeration types
		ENUM Chemicals = {CO2, H2O, O2}
		// Sets of enumeration types
		SET_OF(Chemicals) mix = {CO2, H2O}
		// 1, 2 and 3 dimensional tables used locally
		TABLE_1D tab = { { 0.0, 0.5, 1.0}, -- XValues
                     {67.23, 4.83, -3.23}} -- Output
		//  	Discrete variable types, such as REAL, INTEGER, BOOLEAN, STRING, enumeration and arrays (do not change its value in continuous part of component)
	   INTEGER  numberOfCartridges
	DISCRETE
   	WHEN ( Contidition  == TRUE ) THEN
			numberOfCartridges = 1
    	END WHEN
END COMPONENT
// Private Variables
/*
	When a variable is declared inside a component or port, it can be declared as private. 
	This means that the variable is internal to the model and is forbidden its use in the experiments.
	Private variables can be used for several different reasons, for example:
 		- Variables that are of no interest to the end user.
 		- Variables that must remain hidden as they contain restricted information.
		the private variables have two important limitations:
		1) If the private variable is boundary, algebraic, dynamic or derived, 
		   they cannot be changed or viewed in the experiments. 
		2) When saving status of the simulation with function SAVE_STATE() or SAVE_VARS() those variables are not saved. 
		   This is not really important if the private variables are EXPLICIT but if they are other types it could be a problem.
*/
COMPONENT comp_test
    DECLS
        PRIVATE REAL g[4]

// Hidden Variables
/*
   The optional prefix HIDDEN hides the variable in the experiment reports but the variable can be used for setting new values,
	like print this variable, save state, restore state, etc.
	Even using the function setVarProperty() in an experiment can be changed from hidden to visible.
	Also, during the schematics and partition edition this property can be changed to visible.
	It is associated to the property T_EDIT. By default, if HIDDEN is not used, the variable has a property T_EDIT= TRUE.
	If HIDDEN is used, T_EDIT= FALSE.
	The main difference between PRIVATE and HIDDEN is that the former makes the variable disappear 	at the experiment level
	(even for initialisation issues) and the latter hides the variable in default reports and the monitor list of variables 
	but it can be used as another variable	in the programming of experiments.
   Hidden variables can be used for different reasons, for example:
 		- Variables that are not considered important to be reported in automatic reports (e.g. REPORT_TABLE()).
 		- Variables that normally do not need to be plotted in the Monitor application
*/
		HIDDEN REAL g1[4]

// DISCR Operator
/*
	Variables which are calculated discretely in the program and do not need to be calculated in  CONTINUOUS block are known
	as discrete variables (DISCRETE type). 
	Automatically takes some to be discrete, such as INTEGER, BOOLEAN, STRING and ENUM. 
	If modellers want a REAL variable to behave as a discrete variable, then they must give it the qualifier DISCR
*/
		DISCR REAL x = 0
		REAL y = 1
// BOUND Operator
/*	
	The user can specify that a variable will be a boundary in the final mathematical model. 
	This is done by marking the declaration with the word BOUND
*/
		BOUND REAL z = 1
		REAL w = 0
	
// EXPL Operator
/*
	Sometimes we need to calculate a variable in an explicit format; i.e., we don't allow the mathematical algorithms 
	to transform the original equation to find other variables based on the same equation
*/
		EXPL REAL rho
// ALG Operator
/*
	Sometimes modellers can provide best algebraic variables to solve the loop. 
	They can use the ALG qualifier to mark a variable as candidate to become an algebraic variable 
	(only in case an algebraic loop is detected, otherwise it will be a regular variable)
*/		
		ALG REAL x2  -- candidate to be algebraic
	CONTINUOUS
		4*x + 5*y = 72 -- In this case the program will consider x as discrete and it will try to find only y
		4*w + 5*z = 72 -- In this example it is suggested to use z as boundary. Since there is only one equation and two variables the tool will assume z as known variable and it will calculate w 
		rho = x/y -- This equation will maintain this format and it will not be transformed symbolically into another 
		// In this code the modeller suggests that the variable "x" be taken as algebraic. 
		// When the program tries to solve this equation system it detects that the variables cannot be calculated explicitly 
		// and that an algebraic loop is needed. 
		// Program will propose variable "x" as the first candidate to become an algebraic variable when creating a partition. 
		x2 - y**2 - sin(z) = 98
		cos(z**2) + x2 = 3*y
		x2 - 5*z = 9
END COMPONENT
// Closing a Variable to a Final Value
/*
	Any construction parameter or datum in any child component can be closed with a concrete value. This option is useful sometimes to fix a datum 
	(or construction parameter) and not allow changing it anymore
*/
COMPONENT comp_res
    DATA
        REAL R
    DECLS
        REAL i, v
    CONTINUOUS
        R=v*i
END COMPONENT
// It is possible to create two customized child components by fixing the R value
// From now on when a Resistor5000 component is instantiated the datum R will have disappeared from the public part 
// and will be fixed internally at 5000
COMPONENT comp_res5000 IS_A comp_res
    DECLS
        CLOSE R= 5000
END COMPONENT
// CLOSE can also be used to hide a port in a child component
COMPONENT comp_aba
PORTS
    IN ports_elec pin
END COMPONENT

COMPONENT comp_foo IS_A comp_aba 
    DECLS
        CLOSE pin -- port "pin" disappears from the public interface in foo component
END COMPONENT
// OBJECTS Block
/* The OBJECTS block allows instances of classes (described later) to be declared. 
	The classes could be either internal classes defined in EL or external classes in C++. 
*/
COMPONENT comp_external_class_example 
    DECLS
        REAL x
		  REAL y
		  REAL z
	OBJECTS
		external_class_example m1
		external_class_example m2[3,2]
	INIT
        y= m1.add(2,2)
		  z = m2[2,2].add(2,2) --Arrays of any size can be used to define objects of external C++ classes. Their use is similar to that of the port or component arrays
    CONTINUOUS
        x= m1.add(2,4) + cos(TIME)
		  y= m1.add(2,4)
END COMPONENT
// TOPOLOGY Block
/* The topology block can encompass four types of statements:
 		Component instances.
 		Connect statements.
 		EXPAND and EXPAND_BLOCK statements to make multiple connections in one go.
 		A PATH statement.
	There is no pre-established order for statements and they can be intercalated  
*/
COMPONENT comp_Tank(INTEGER n= 2, INTEGER k= 3)
	PORTS
        IN ports_fluid f_in		"fluid input port"
        OUT ports_fluid f_out		"fluid output port"
    DATA
        REAL c1 = 7.8
        REAL c2 = 8.9
END COMPONENT
// Component Instances
COMPONENT comp_Tank_instance

	TOPOLOGY
	   -- As many instance names of a component as required can be defined in a single line
		comp_Tank t1
		comp_Tank t2[3]
		-- If objects are declared in the same line, e.g. t3 and t4, they must share the same construction parameter and data initialisation
		comp_Tank t3[3,4] , t4[1,2]
		-- The construction parameters are set only once when defining the instances but they can never be changed during simulation
END COMPONENT
// CONNECT Statement
/* 
	The CONNECT statement is used to connect the different components declared. In other words, 
	it is used to create the internal topology of a component. Typically, 
	if we want to create a new component using a topological diagram of other objects
*/
COMPONENT comp_tank
    PORTS
        IN ports_fluid f_in		"fluid input port"
        OUT ports_fluid f_out		"fluid output port"
END COMPONENT

COMPONENT comp_pipe
    PORTS
        IN ports_fluid f_in		"fluid input port"
        OUT ports_fluid f_out		"fluid output port"
END COMPONENT
//The CONNECT statement makes life easier for us; the modeller can make numerous connections in the same
//statement, using commas. In the following example, a tank is connected to two pipes and the output of the
//pipes to the input of a second tank:
COMPONENT comp_balance
    TOPOLOGY
        comp_tank t1
        comp_tank t2
        comp_pipe p
        CONNECT t1.f_out TO p.f_in
        CONNECT p.f_out TO t2.f_in
END COMPONENT
// Using EXPAND for Multiple Connections
/* 
	EXPAND and EXPAND_BLOCK operands can be used to make multiple connections in one go. It can be used in nesting form
*/
//In this example we can see that two construction parameters, mix and N, have been used to parameterise both the port arrays and the component arrays
COMPONENT comp_expand (SET_OF(chemicals) mix, INTEGER N)
    PORTS
        IN ports_fluid pin[N]
        OUT ports_fluid pout[N]
    TOPOLOGY
        comp_Tank t4[N,mix]
        comp_Tank t5[N,mix]
        EXPAND (I IN 1,N)
            EXPAND_BLOCK (J IN mix)
                CONNECT pin[I] TO t4[I,J].f_in
                CONNECT t4[I,J].f_out TO t5[I,J].f_in
                CONNECT t5[I,J].f_out TO pout[I]
            END EXPAND_BLOCK


END COMPONENT
// INIT Block
/* 
	A component may require an initialization block which specifies a series of sequential instructions to be executed before starting the simulation. 
	It is used to initialize some variables which require an initial value before they start the simulation.
	The INIT block can contain only sequential statements (IF, FOR, etc). Obviously all the statements are executed sequentially
*/
COMPONENT comp_initBlock
    DECLS
        REAL x
        REAL y
        REAL v[3]
    INIT
        x = 9.8
        y = SUM(i IN 1,3; v[i]) -- y = v[1] + v[2] + v[3]
        FOR(i IN 1,3)
            v[i] = 0            -- v[1]=0,  v[2]=0 and v[3]=0
        END FOR	
END COMPONENT
// Priorities for INIT Blocks
/*
	Priorities can be assigned to INIT blocks in order to be executed. By default, the priority of an INIT block is zero and they follow a set of general rules or execution. 
	To change the priority, the user can use the clause "PRIORITY value" after the word INIT,
	where value can be any positive or negative integer number
	INIT PRIORITY 100  	-- The INIT block has a priority of 100
	INIT PRIORITY -40  	-- The INIT block has a priority of -40
	INIT                -- The INIT block has a priority of 0
*/
COMPONENT comp_priorityInitBlock
    DECLS
        REAL x1
    INIT
        x1= 1
END COMPONENT

COMPONENT comp_priority1
    DECLS
        REAL x2
    INIT
        x2= 2
END COMPONENT

COMPONENT comp_priority2
    DECLS
        REAL x3
    INIT PRIORITY 100  -- changed the priority to 100
        x3= 3
END COMPONENT
/*
	When a partition is made and the INIT blocks are sorted, it will be done as follows:
	--init(obj2.compPriority2,100)
	obj2.x3 = 3
	-- init(compPriorityInitBlock,0)
	x1 = 1
	-- init(compPriorityFinal,0)
	x4 = 4
	-- init(obj1.compPriority1,0)
	obj1.x2 = 2
	As can be seen, the first one is from Compo2, as it has the highest priority (100). 
	The rest have been sorted following the general rules: first the parent component, then the final component, 
	and lastly the aggregate component with the same priority
*/
COMPONENT comp_priorityFinal IS_A comp_priorityInitBlock
    DECLS
        REAL x4
    TOPOLOGY
        comp_priority1 obj1
        comp_priority2 obj2
    INIT
        x4= 4
END COMPONENT
// DISCRETE Block
/* 
	All the discrete modelling parts of the component go into the DISCRETE block. Discrete information consists of events which must be detected during the simulation.
	Once an event is detected, the system executes an associated sequence of actions which can in turn activate new events in a chain reaction.
	When there are no more events, the system carries on with the continuous part if it exists
	Only discrete statements can be used in this part. The most important discrete statement is the WHEN statement
	Discrete events are evaluated at each instant in time that the continuous part advances. When a condition is met, the associated actions are executed.
	If one of these actions gives rise to another discrete event, it is in turn dealt with until there are no more left,
	at which point the system resumes with the continuous part
*/
/*
	Example 1: Represent an AND logic gate. It is defined as an EL component with two inputs and one output. When both inputs are TRUE, the output is TRUE, otherwise it is FALSE
*/
   -- AND logical port
COMPONENT comp_Gate_AND
    PORTS
        IN ports_digitalPort in1		"input port 1"
        IN ports_digitalPort in2		"input port 2"
        OUT ports_digitalPort out	     	"output port"
    DISCRETE
	   -- detect event, when both are TRUE, changes the output
        WHEN (in1.s == TRUE AND in2.s == TRUE) THEN
            out.s = TRUE		-- output is TRUE
        END WHEN
	   -- detect event, when any input is FALSE
        WHEN  (in1.s == FALSE OR in2.s == FALSE) THEN
            out.s = FALSE		-- output is FALSE
        END WHEN
END COMPONENT
/*
	Example 2: A T_flip_flop that inverts an input signal when the clock is on the falling edge. 
	Like a real flip-flop, the output signal is generated with a delay.
	Introduce a reset signal as well to change the output to FALSE
*/
COMPONENT comp_T_flip_flop (REAL delayTime = 1) -- Delay typical for device
    PORTS
        IN ports_digitalPort pi		 "Input port"
        OUT ports_digitalPort po		 "Output port"
        IN ports_digitalPort clock	 "Clock signal input"
         IN ports_digitalPort reset	 "Reset signal input"
    DISCRETE
	   -- when clock is in falling edge, generates an output
	   -- with a delay (if reset is not pressed)
        WHEN (clock.s == FALSE) THEN
            IF (NOT reset.s) THEN
                po.s = NOT pi.s AFTER delayTime
            END IF
        END WHEN
	   -- if reset is pressed, changes output to FALSE inmediately
        WHEN (reset.s == TRUE) THEN
            po.s = FALSE AFTER 0
        END WHEN
END COMPONENT
COMPONENT comp_instance_T_flip_flop
	TOPOLOGY
		comp_T_flip_flop t1[5]

END COMPONENT
/*
Example 3: Create a component in EL to regulate the temperature in a room. When the temperature is lower than the minimum Tmin, connect the heater after some time (4 seconds); 
           when the temperature is greater than Tmax, disconnect the heater.
*/
COMPONENT comp_whenExample
   "Heater example (used for WHEN statement demonstration)"
   DATA
      REAL Tmin = 20.             "Minimum temperature (degC)"
      REAL Tmax = 50.             "Maximum temperature (degC)"
   DECLS
      BOOLEAN HeaterON            "Heater power ON flag (TRUE/FALSE)"
      DISCR REAL HeaterPower      "Heater power (W)"
      REAL T = 10.                "System temperature (degC)"
   DISCRETE
      WHEN (T < Tmin) THEN
         HeaterON = TRUE
         HeaterPower = 50. AFTER 4.
      END WHEN

      WHEN (T > Tmax) THEN
         HeaterON = FALSE
         HeaterPower = 0.
      END WHEN
   CONTINUOUS
      T' = 0.1 * (HeaterPower - 10)
END COMPONENT
//  CONTINUOUS Block
/* 
	The CONTINUOUS block contains the continuous part of the component. You can only use continuous statements in this block. Here is where you define the differential-algebraic equations and insert permitted statements like ZONE and EXPAND
*/
/*
	Example 1: Define an ideal diode in EL. It conducts when the voltage is greater than zero and current is not lower than or equal to zero.
			If "(v > 0 AND NOT pi.i <= 0)" evaluates to TRUE, the equation would be as follows:
			    0 = v ¡ pi.i * rlow
			 And if it evaluates to FALSE:
			 	0 = v pi.i * rhigh
	This condition is evaluated at each instant of the integration (as shown in the above diagram). When a different branch is entered, the model changes and reinitializes automatically
*/
-- electrical diode
COMPONENT comp_diode
    PORTS
        IN ports_elec pi    "input port"
        OUT ports_elec po   "output port"
    DATA
        REAL rlow = 0.1   "Low resistance (Ohms)"
        REAL rhigh = 1.e6   "Very high resistance (Ohms)"
    DECLS
        REAL v   "Voltage difference  (Volts)"
    CONTINUOUS
        v = pi.v - po.v
        0 = ZONE (v > 0 AND NOT pi.i <= 0) v - pi.i * rlow
            OTHERS v - pi.i * rhigh
        pi.i = po.i
END COMPONENT
/*
	Example 2 creates an EL component with a variable that moves up and down between certain limits.
	The law governing this variable is that its first derivative should vary when any of the above are reached or when they fall within a certain margin
*/
COMPONENT comp_limits
    DATA 
        REAL ymax = 0.5
        REAL ymin = -0.2
        REAL tau = 0.01
    DECLS
        REAL dy, x, y
    CONTINUOUS
        x = sin(TIME)
        dy = (x - y) / tau
        y' = ZONE (y > ymax AND dy > 0) 0.
             ZONE (y < ymin   AND dy < 0) 0.
             OTHERS   dy
END COMPONENT
//  Virtual Equations
/* 
	The equations in the continuous part can be labelled and later replaced by others when you create an inherited component from a parent component. For example, you may want to create a new component based on an existing one in which some of the continuous equations are not the same; in this case the new equation would have the same label as the one to be replaced.
	Labels are just equation identifiers
*/
// In this case, when the component derivedComponent is instantiated, the system would use this equation:
// x = y / 0.4
COMPONENT comp_baseComponent

    DECLS
        REAL x, y, z
    CONTINUOUS
        z' = 8 * x
        <eqn1> x = y / 0.3
END COMPONENT
COMPONENT comp_derivedComponent IS_A comp_baseComponent
    CONTINUOUS
        <:eqn1> x = y / 0.4
END COMPONENT
// Causal and acausal equations
/*
	When the equations are written in the CONTINUOUS block of a component or port, it is possible to use the
	"=" and ":=" operators indistinctly. The "=" operator will be used whenever users want to express the equation
	in totally acausal format;this means that program could transform this equation symbolically as convenient;
for example, given the following equation:
x= sin (y)
the sorting algorithm can write this equation in the end in one of these two formats:
1 x=sin(y)
2 y= asin (x)
This is very advantageous and gives great flexibility to the tool so that the same model can be used in very
different scenarios. However, sometimes we are interested in forcing it to calculate a variable with a given
expression. To do this, we use the acausal equation format using ":=" operator:
x := sin(y)
We are instructing the sorting algorithm not to transform the equation symbolically and to keep the lefthand
and righthand parts intact. In this case, when the equation sorting ends, this equation either calculates x
explicitly or it converts it to a residue:
1 x=sin(y)
2 residue = (x) - ( sin(y))
The assignment operator ":=" limits the symbolic transformation of the equation. In many cases the modeller
does not want the algorithm to alter the equation, either because it may be dangerous for convergence or
because we just want this equation as it is. We are imposing causality on the equation.
Another difference between "=" and ":=" is that the former operator allows both "expression= expression" and
also "variable= expression" while the latter only allows "variable= expression".
For example, this is correct:
x + y = 24*z
However, this code is not correct
x + y := 24*z -- ERROR of compilation
The causality operator must always be linked to a variable. The operator ":=" is a more flexible alternative to
the prefix EXPL that searches for an equation to calculate a variable

The three solutions implement causal modelling for calculating the x variable. General solution 1 (using :=)
is more general and has another important advantage in that it can be used as a residue equation at some
point. The other two solutions cannot be transformed into residue equations. Using SEQUENTIAL block or
the function call is justified if you need to introduce some logic that is not possible in a single equation, or if
you want to calculate multiple variables together.
*/
COMPONENT comp_causalEquations1
DECLS
	REAL x
CONTINUOUS
	x:= sin ( TIME )
END COMPONENT
COMPONENT comp_causalEquations2
DECLS
	REAL x
CONTINUOUS
	SEQUENTIAL
		x = sin(TIME)
	END SEQUENTIAL
END COMPONENT
FUNCTION NO_TYPE func_calculateX ( REAL mtime ,OUT REAL x)
BODY
	x= sin ( mtime )
END FUNCTION
COMPONENT comp_causalEquations3
DECLS
	REAL x
CONTINUOUS
	func_calculateX (TIME ,x)
END COMPONENT
// Access to internal component variables
/*
EL provides access to internal component variables when they are used as instances in other components. For
instance, a Child component may be defined as follows:
COMPONENT Child
	DATA
		REAL d1 =1
	DECLS
		REAL x
	CONTINUOUS
		x' + d1 = cos( TIME )
END COMPONENT
which simply has an equation with a derivative variable x’ that is calculated by integrating the following
equation:
cos ( TIME ) - d1
When these components are used, sometimes it is necessary to have access to the internal variables to calculate
other derivative variables, such as:
COMPONENT Final
	DECLS
		REAL avgDeriv
	TOPOLOGY
		Child t1 (d1 =0)
		Child t2 (d1 =10)
	CONTINUOUS
		avgDeriv = (t1.x' + t2.x ') / 2
END COMPONENT
Two Child objects have been used. Each object is initialized with different data, and an equation has been
introduced in this topological component that will calculate the average value of the x’ variables in each instance.
To do this, expressions t1.x’ and t2.x’ can be used. A default partition shows that the equations of the
whole system are as follows:
[E -1] t1.x' = cos( TIME ) - t1.d1[E -2] t2.x' = cos( TIME ) - t2.d1[E -3] avgDer = (t1.x' +
t2.x ') / 2.
This equation is as expected and will yield the average value of the derivatives in a different variable of the
model. This can come in handy on certain occasions.
This example shows how the topological component created an equation to calculate the average value. However,
it would also have been possible to introduce some restrictions and to calculate an internal variable of an
instanced component. For instance, Child and Final can be rewritten as follows:
*/
COMPONENT comp_child
	DECLS
		REAL x
		REAL z
	CONTINUOUS
		x + z = cos( TIME )
END COMPONENT
COMPONENT comp_final
	TOPOLOGY
		comp_child t1
		comp_child t2
	CONTINUOUS
		6= (t1.x + t2.x)
END COMPONENT
COMPONENT comp_finalDiscreteEvent
	DECLS
		DISCR REAL tr = 1
	TOPOLOGY
		comp_child t1
	DISCRETE
		WHEN (t1.x > 0.5) THEN
			tr = tr +1
		END WHEN
	CONTINUOUS
END COMPONENT
// Advanced Modelling
// IMPL Operator
/* 
	The IMPL operator is used to guide the method of sorting the subsystems of the coupled algebraic equations. This operator provides important information helping to decide the equations to become in implicit format.
	There are two ways to use this operator, either passing the candidate variable as algebraic or not:
	Providing a candidate for algebraic in the operator:

	In this declaration, the user specifies that if this second equation is coupled algebraically with other equations, it will be transformed into an implicit form.
	Since in this example both equations form an algebraic loop the sorting algorithm will take the second as implicit and the variable "x" as algebraic. The final equations system will be:
		y = 5.12 / (x * 7.3 + 4.2)
		residue=  (5.15 - y * x * 2.6) -(25.5)
*/
COMPONENT comp_implOperator
DECLS
	REAL x
	REAL y
CONTINUOUS
	        x*y*7.3 + 4.2*y = 5.12
	IMPL(x) 5.15 - y*x*2.6 = 25.5
END COMPONENT
/*
	Remember that the operator ALG is used as well to provide candidates for algebraic at the declaration time
*/
COMPONENT comp_implOperatorAlg
DECLS
	ALG REAL x
	REAL y
CONTINUOUS
	   IMPL() x*y*7.3 + 4.2*y = 5.12
	          5.15 - y*x*2.6 = 25.5
END COMPONENT
// component that use in the experiment a function.
// Can also use objects (instances of classes) as arguments
COMPONENT comp_useFunction
OBJECTS
    class_myClass m
INIT
    WRITE("2+3= %g\n",func_add(m,2,3))
END COMPONENT

// BOUNDS Block
/*
	The BOUNDS block sets the expressions for every boundary of the model. The values can be complex expressions depending on time or a single value. It is called every time the model tries to evaluate the boundary variables (at every call to the residues function FRES()).
	During the experiment it is possible to modify any algebraic, dynamic or boundary variable. The system will detect automatically when to reinitialize the model. In other words, it is up to the user when and how to modify any variable but for tracing purposes 
	it is recommended that they are written into the corresponding block.
	Using the interface, the system will automatically fill in the blocks INIT and BOUNDS. The user only has to write in the correct initial values or expressions
	
*/
COMPONENT comp_boundsBlock
	DECLS
		REAL b1
		REAL b2

END COMPONENT
// Advanced Modelling
/*
	When port and component arrays are used and you want to initialize variables from both in the INIT block, the compiler runs into problems generating a valid mathematical partition.  
	These problems will only occur if you want to use loops for the initialization. If no loops are used there are no problems. The following example is a correct one that doesn't create any problems
*/
PORT port_array
       SUM REAL i
       EQUAL REAL v
END PORT

COMPONENT comp_initPortArray
PORTS
       IN port_array fin[4]
INIT
   fin[1].v= 1.0    
   fin[2].v= 1.0
   fin[3].v= 1.0
   fin[4].v= 1.0
END COMPONENT
/*
When we initialized each element of the array separately, we used the final index. The compiler knows how to handle it correctly and it is valid. However, 
it will not work if we try to do it using a loop with an index to iterate each element

COMPONENT comp_initPortArray0
PORTS
       IN port_array fin[4]
INIT   
       FOR(i IN 1,4)
		 	   fin[i].v= 1.0
       END FOR
END COMPONENT
/*
The global variable INSTANCE_NAME will be replaced by the correct prefix of the current variable and then the rest of the variable name is composed, 
including the index "i". Next, the model variable with that name is changed using the setValueReal() function. This solution works correctly if the component compo_initPortArray1 is itself embedded in another component
*/
COMPONENT comp_initPortArray1
PORTS
   IN port_array fin[4]
DECLS
	STRING vname
INIT 
   FOR(i IN 1,4)
 	   vname= INSTANCE_NAME + ".fin[" + integerToString(i) + "].v"
 		setValueReal(vname, 1.0)   
   END FOR
END COMPONENT

COMPONENT comp_initPortArray2
PORTS
   IN port_array fin[4]
DECLS
	STRING vname
INIT  
   FOR(i IN 1,4)
      vname= joinName(INSTANCE_NAME, "fin[" + integerToString(i) + "].v")
      setValueReal(vname, 1.0)   
   END FOR
END COMPONENT

COMPONENT comp_initPortArrayFinal
TOPOLOGY
	comp_initPortArray2 obj[3]
END COMPONENT

COMPONENT comp_initCompo
DECLS
	REAL z
CONTINUOUS
	z'= cos(TIME)
END COMPONENT

COMPONENT comp_initCompoFinal
DECLS
	DISCR REAL value
	STRING vname
TOPOLOGY
	comp_initCompo obj[2]
INIT
       FOR(i IN 1,2)
		 	vname= joinName(INSTANCE_NAME, "obj[" + integerToString(i) + "].z")
		 	setValueReal(vname,i)   
			WRITE("%s = %g\n",vname,getValueReal(vname))
       END FOR
END COMPONENT
