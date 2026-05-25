/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: 
 //Ports
  A connection port connects components, both by the values that each needs to communicate with its environment and
  by the restrictions and equations applicable to the connections. 
  By defining new ports you can model any kind of exchange of values between components. Ports are part of a component interface

-----------------------------------------------------------------------------------------*/
//Port Definition Syntax
/* 
   The following extract shows syntax of a port definition:
	port_def: PORT ID( IS_A scoped_id_s )? param_def_s? (SINGLE (IN | OUT)? )? 
	                          STRING_VALUE?  
	                port_var_decl_s 
	               (CONTINUOUS conc_stm_s)?
	          	
	          END PORT
	
	port_var_decl: (PRIVATE|HIDDEN)? (BOUND|EXPL|DISCR)?((SUM|EQUAL)(IN|OUT)? )? obj_decl 
	                 ( '=' init_expression )? obj_range? STRING_VALUE?
	
	param_def_s     : '(' param_def ( ',' param_def )*  ')'
	
	param_def       : obj_decl ( '=' expression ) ? STRING_VALUE?
	                | enum_set_decl
	
	obj_decl        : data_type IDENTIFIER ( '[' expression_s  ']' ) ?
*/
USE MATH
CONST REAL global_TMAX   = 1.e5      UNITS u_K			"Maximum Temperature to report a warning"
CONST REAL global_TZERO  = 273.15    UNITS u_K			"Celsius scale shift with respect to Kelvin scale"

/*
The SINGLE modifier expressly forces all connections for a port type to be single.
If no mode is specified, the restriction applies to all ports of this type, regardless of mode.
If either of the modifiers IN or OUT is added, the restriction only applies to ports with that mode.
For instance, the control port allows multiple connections to an output but it does not allow multiple connections to an input.
The modifier SINGLE IN is used to forbid multiple connections at IN ports.
*/
PORT ports_control SINGLE IN "control port"
    EQUAL REAL signal
END PORT

-- Construction parameter should be an integer value used to dimension an ARRAY type port variable
PORT ports_type ( INTEGER N = 1 ) SINGLE IN "example of port"
    REAL v[N]
END PORT
-- Use of a generic mix to formulate a fluid component
PORT ports_flu ( SET_OF(chemicals) mix ) SINGLE IN "fluid port"
    REAL conc [mix]  "Concentration of Chemical compounds in the fluid"
END PORT
// Port Connecting Equations
--------------------------------------------------------------------------------
-- Port elec (Electricalport)
-- 	EQUAL: a variable with this behaviour maintains the same value for all the ports of a connection, 
--	          regardless whether it a multiple connection or whether it connects ports at the same node. 
-- 	       In other words, it forces equivalence of the variables
-- 	SUM: this is associated with flow type variables and indicates that on one connection the sum 
--           of the incoming flows is equal to that of the outgoing flow

--------------------------------------------------------------------------------
/*
		Pout: input port; Pin1: output port; Pin2: output port
		Connecting Eqts: Pin1.v = Pin2.v = Pout.v ; Pin1.i * Pin2.i = Pout.i
*/
PORT ports_elec    "Electrical pin" 
    EQUAL REAL v 		UNITS u_V		"Potential at pin pin1.v = pin2.v = pout.v"   
    SUM   REAL i 		UNITS	u_A		"Current flowing into the pin pin1.i+pint2.i =pout.i"
END PORT
--------------------------------------------------------------------------------
-- Port mech_rot (Rotational port)
--------------------------------------------------------------------------------
PORT ports_mech_rot "1D rotational flange"
   SUM   REAL T			UNITS u_Nm		"Torque "
   EQUAL REAL omega		UNITS u_rad_s	"Absolute angular velocity"
         REAL n			UNITS u_rpm		"Angular velocity"
   CONTINUOUS
		// This mechanical port introduces an equation that links omega and n port variables.
		// Those equations are inserted automatically by the tool in the final equations system
		omega = n * (2*MATH.PI/60)
END PORT
// In some cases, the behaviour of a port variable differs depending on whether it has multiple connections at
// an IN port or at an OUT port. These cases are covered by adding the auxiliary modifiers IN or OUT to SUM or EQUAL
/*
Multiple input port
		P1: input port; P2: input port; P: output port
		Connecting Eqts: P.w = P1.w + P2.w ; P.p = P1.p = P2.p ; P.E = P1.E + P2.E
		CONTINUOUS Eqts: P1.E = P1.w * P1.T ; P2.E = P2.w * P2.T ; P.E = P.w * P.T
Multiple output port
		P1: output port; P2: output port; P: input port
		Connecting Eqts: P.w = P1.w+P2.w ; P.p = P1.p = P2.p ; P.T = P1.T = P2.T
		CONTINUOUS Eqts: P1.E = P1.w * P1.T ; P2.E = P2.w * P2.T ; P.E = P.w * P.T
*/
PORT ports_fluid	             "fluid port"
    SUM REAL w		"mass flow" 
    EQUAL REAL p		"pressure"
    SUM IN REAL E		"energy flow"
    EQUAL OUT REAL T	"temperature"
    CONTINUOUS
        E = w * T
END PORT
// Examples of Port Types
// Ports can contain construction parameters for dimensioning arrays; 
// This gives a lot of flexibility for using the ports in different situations.
// The example below defines a typical thermal port that allows the user to define the number of nodes for each situation
--------------------------------------------------------------------------------
--    Thermal port for heat exchanges in array of nodes.
--------------------------------------------------------------------------------
PORT ports_thermal (INTEGER n = 1 UNITS no_units	"Size of thermal port arrays")   "1D thermal port"
   EQUAL REAL Tk[n] =  293.15   UNITS u_K			RANGE  0,global_TMAX   	"Kelvin  Temperature Array"
   EQUAL REAL Tc[n] =   20.     UNITS u_C									"Celsius Temperature Array"
   SUM   REAL  q[n]             UNITS u_W									"Heat Flow Array"
CONTINUOUS
    EXPAND (j IN 1, n)
        Tc[j] = Tk[j] - global_TZERO
END PORT
-- defines a simple digital port to carry on a signal
PORT ports_digitalPort  "Definition of a digital port"
    EQUAL OUT BOOLEAN s -- when the port is OUTPUT, the signal should be equal in all the connections
END PORT
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
PORT ports_Electrical
    SUM REAL i
        PRIVATE EQUAL REAL v
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
		HIDDEN EQUAL REAL v1
END PORT
-- Ports, Components and Construction Parameters
--------------------------------------------------------------------------------
-- Note:
--    "SINGLE IN" in the declaration of the signal port types means that
--    multiple connections to signal input ports are forbidden. However, it
--    is possible to make multiple connection from an outlet signal port,
--    i.e it is possible to broadcast an outlet signal.
--------------------------------------------------------------------------------
PORT ports_analog_signal (INTEGER n = 1 UNITS no_units	"Number of outputs")   SINGLE IN  "Analog signals 1D port"
   EQUAL OUT REAL signal[n]       UNITS no_units	"Analog signal values"
END PORT






