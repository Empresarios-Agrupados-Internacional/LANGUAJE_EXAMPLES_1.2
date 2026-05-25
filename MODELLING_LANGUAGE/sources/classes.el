/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: class
-----------------------------------------------------------------------------------------*/
// Classes
/*
	Classes in EL are the equivalent to classes in classic object-oriented programming languages such as C++ and Java, but their use is more restricted (and simple). In fact, they are like high-level wrappers for producing a C++ class but bearing in mind that the final users are engineers and not programmers.
	There are times when the modeller wants to encapsulate data and behaviour in the same item, and later instantiate them and use them by means of certain methods.
	The main difference between a class and a component in EL is that a component is meant to include dynamic equations and discrete events that the simulation tool arranges and solves, whereas a class represents a set behaviour and only allows the publication of variables and methods.
	Classes are normally used in EL to support the modelling of complex systems where the use of functions is sometimes improved if all the functions referring to the same utility are grouped together and share memory by means of common variables.
	The general syntax to define classes is as follows:
		class_def: CLASS IDENTIFIER  ( IS_A scoped_id_s)?
	                 	DESCRIPTION?
	       				( DECLS     var_object_decl_s )?
	       				( OBJECTS  class_instance_stm_s )?
	       				( METHODS  method_def_s )?
	   				END CLASS 
	The class is named by means of an identifier. A class can contain the following information:
	 	IS_A. This reserved word is used to indicate that this class inherits from one or more other classes. When multiple inheritance occurs, the parents are separated by commas
	 	DESCRIPTION. A string can be used to describe the class. If it takes up more than one line, use the separator \ to indicate that the string continues onto the next line
	 	DECLS. This is a block where class variables can be declared. All the basic EL types can be used (e.g., REAL)
	 	OBJECTS. This is a block where objects from other classes can be encapsulated
	 	METHODS. This block describes the internal methods of the class
	As all elements are optional
	
*/
USE MATH
-- This class represents the coordinates of a 2D point. It has a description, two private variables named "x" and "y" and two methods named "set2D()" and "get3D()" 
CLASS class_point2D   "class reprenting a 2D point"
    DECLS
        PRIVATE REAL x
        PRIVATE REAL y
    METHODS
        METHOD NO_TYPE set2D(IN REAL valueX, IN REAL valueY)
            BODY
                x = valueX
                y = valueY
        END METHOD
        
        METHOD NO_TYPE get2D(OUT REAL valueX, OUT REAL valueY)
            BODY
                valueX = x
                valueY = y
        END METHOD
END CLASS
// Construction parameters
/*
Similarly to components, classes allow the use of construction parameters during the creation of objects. For
instance.
Whenever the class is instanced, the construction parameters need to be assigned a value. Classes do not allow
default values to be set for these parameters. Instead, they need to be initialized when the objects are instanced
(components do allow default values). The rationale behind this is partly that these values are normally used
to dimension arrays in execution times, and users need to be fully aware of the values they are setting.
The valid construction parameters are scalar values (vector values are not valid) of INTEGER, REAL, BOOLEAN,
STRING and FILEPATH type. SET_OF cannot be used as construction parameter for a class.
Below is a complete example of a class that will display information about our friends, namely their name and
telephone number. Since the number of each is not known, an array is created to store this field. In addition,
two methods are created: one to add friends and another one that returns a copy of the data of a friend as a
string.
*/
CLASS class_MyMatrix ( INTEGER rows , INTEGER cols ) " class representing a 2d matrix "
	DECLS
		REAL values [rows , cols ]
END CLASS
FUNCTION NO_TYPE func_fUseClass ()
	OBJECTS
		class_MyMatrix (rows=5, cols=7) mm
	BODY
END FUNCTION

CLASS class_clBestFriends ( INTEGER N)
	DECLS
		STRING m_name = ""
		INTEGER m_phones [N]
	METHODS
		METHOD NO_TYPE setFriend ( STRING name , INTEGER n, INTEGER phones [])
		BODY
			m_name = name
			FOR (i IN 1,n)
				m_phones [i]= phones [i]
			END FOR
	END METHOD
	METHOD STRING asString ()
		DECLS
			STRING st
		BODY
			WRITES (st ,"%s phones :",m_name )
			FOR (i IN 1,N)
				WRITES (st ,"%s %d",st , m_phones [i])
			END FOR
			RETURN st
		END METHOD
END CLASS
FUNCTION NO_TYPE func_fTestClassConstPars ()
	DECLS
		CONST INTEGER nphones =3
		INTEGER phones [ nphones ] = { 11111 ,22222 ,33333 }
	OBJECTS
		class_clBestFriends (N=3) fr
	BODY
		fr. setFriend (" Lucas ",nphones , phones )
		WRITE (" Friend : %s\n",fr. asString ())
END FUNCTION
--The construction parameters can also be used to dimension more complex objects such as instances of other
--objects
CLASS class_clMyMatrix ( INTEGER rows , INTEGER cols )
	DECLS
		REAL m_x[rows , cols ]= 1.0
	OBJECTS
		TABLE m_tables [rows , cols ]
END CLASS
// Inheritance
-- As seen above, a class can be inherited from one class (simple inheritance) or more (multiple inheritance) at the same time, in which case it will inherit all the associated variables and methods exactly as if they had been defined in the class itself.
-- This example shows how inheritance is used to inherit "point3D" class from "point2D" class and thus inherit their variables "x" and "y" and the methods "set2D()" and "get2D()".
CLASS class_point3D IS_A class_point2D "a 3D point"
    DECLS
        PRIVATE REAL z
    METHODS
         -- Method to init a 3D point
        METHOD NO_TYPE set3D(IN REAL valueX, IN REAL valueY,IN REAL valueZ)
            BODY
                set2D(valueX,valueY)
                z = valueZ
        END METHOD

         -- Method to obtain a 3D point
        METHOD NO_TYPE get3D(OUT REAL valueX, OUT REAL valueY,OUT REAL valueZ)
            BODY
                get2D(valueX,valueY)
                valueZ = z
        END METHOD
END CLASS

// DECLS Block
/*
	With the DECLS block of a class, any kind of basic EL variable can be defined, whether this be a simple variable or a multidimensional array
	Defined in it are variables such as REAL, INTEGER, BOOLEAN and STRING. Initial values are also assigned. The general syntax for defining variables in classes is as follows:
		var :  PRIVATE?     CONST?   data_type name_s 
		   	( '=' init_expression )?  STRING_VALUE?
	An explanation for each element is given below:
		 	PRIVATE. To keep the variable from being visible to others, the qualifier PRIVATE is put before it. Otherwise, it would be public and its value could be both read and changed directly. In object-oriented modelling, it is very common not to make variables directly visible, but to create "get" and "set" methods to initialize or obtain their value instead. However, this can sometimes be awkward, so it is best to give direct access to the variable (in that case, do not write PRIVATE)
		 	CONST. If it is a constant whose value should never change, write CONST before the variable type
		 	data_type. It can be any of the basic EL types (e.g., REAL)
		 	names. You can declare one variable or several in the same declaration. If there are more than one, they must be separated by commas
		 	init_expression. If they are to be given an initial value, it will be given in this section
		 	description. The variable can be described with a string typically containing the units
	Examples of declarations are:
		PRIVATE REAL x = 1
			The variable x has no outside accessibility and its initial value is 1.
		PRIVATE CONST REAL x = 1
		I	n this case, x is a private constant and its value can never change (moreover, the compiler will require us to give it a value in the declaration).
		REAL speed= 1 "speed of the aircraft (m/s)"
			This gives a description of the public variable speed and its units.

*/
CLASS class_declsBlock
    DECLS
        REAL x = 9.9
        REAL z,y = 1.1
        INTEGER v[3] = {1, 2, 4}
        BOOLEAN stat
        STRING str  = "hello world"
END CLASS
// OBJECTS Block
/*
	Objects can be declared within classes, components, functions and experiments. The general syntax of the objects declaration is as follows:
	PRIVATE? names STRING_VALUE?  
	The meaning of each key is:
	 	PRIVATE: An object can be declared as private (by default they are not) and they are not visible in the object (but they can be used locally)
	 	Names: many objects can be defined in the same line. Array objects are allowed (e.g., MyClass object[2,4,7])
	 	STRING_VALUE: a description of the object can be added
	It is quite similar to declaring a variable in a component or port, but with some differences:
	 	The objects cannot be initialized with an initial value (like variables)
	 	The creation of constant objects is not allowed
	These restrictions have been imposed to simplify using classes (especially for initializing complex objects that required creating special constructors)
	
*/
CLASS class_objectsBlock
OBJECTS
    class_point3D p1
    class_point2D points[3,4]
END CLASS
// METHODS Block
/*
	Methods define the functional interface of a class. They are subroutines connected to a definition of a class. They are always declared within a class in the METHODS block and can only be invoked from instances of that class.
	Like functions, a method can return a basic EL type and has a number of call arguments which are defined when the method is written.
	The general syntax of a method is:
	method_def    :    PRIVATE? METHOD data_type IDENTIFIER 
	                   '(' EOL* func_arg_decl_s ')' 
	                       STRING_VALUE?
	                    ( DECLS var_decl_s )?
	                    ( OBJECTS class_instace_stm_s  )?  
	                    (  BODY seq_stm_s )?
	                    (  END METHOD )?
	Its syntax is similar to that of functions (see the chapter on functions for details on each block) with the following special features:
	 	A method starts and ends with the word METHOD instead of FUNCTION
	 	A method can be kept private from the class by using the word PRIVATE, whereas a function is always public and visible in the library. By default they are public
	 	A method can make free use of local variables, variables of the class they are in and global variables. A function can only access local variables and global variables in the library
	
*/
CLASS class_methodsBlock
    DECLS
        PRIVATE REAL x
    METHODS
         -- method to increment x with value v (returns nothing)
        PRIVATE METHOD NO_TYPE incr(IN REAL v)
            BODY
                x= x + v  -- increase the class variable x
        END METHOD

         -- method to return the value of x after increasing it with value v
        METHOD REAL popValue(IN REAL v)
            BODY
                incr ( v )
                RETURN x
        END METHOD
END CLASS
// Using object pointers
/*
The ability to define and use pointers to objects within the OBJECTS block of classes using the special syntax was described in a previous section:
OBJ_PTR<ClassType> ptr
But at that time, the classes and the use of virtual methods had not been described. This section provides a more detailed description of the use of pointers.
Pointers allow us to have pointers to real objects in memory and be able to use them as if they were the object itself, but with a difference: 
they neither create nor destroy the object, but are simply "observers" that give them permission to act on them.
*/
CLASS class_figure
DECLS
	STRING m_name
METHODS
	VIRTUAL METHOD REAL area()
	BODY
		RETURN 0.0
	END METHOD
END CLASS

CLASS class_rectangle IS_A class_figure
DECLS
	REAL m_length,m_hight
METHODS
	METHOD NO_TYPE init(STRING n,REAL l, REAL h)
	BODY
		m_name= n
		m_length= l
		m_hight= h
	END METHOD
	VIRTUAL METHOD REAL area()
	BODY
		RETURN m_length*m_hight
	END METHOD
END CLASS

CLASS class_circle IS_A class_figure
DECLS
	REAL m_radius
METHODS
	METHOD NO_TYPE init(STRING n,REAL r)
	BODY
		m_name= n
		m_radius= r
	END METHOD
	VIRTUAL METHOD REAL area()
	BODY
		RETURN 3.141592* (m_radius**2)
	END METHOD
END CLASS

CLASS class_triangle IS_A class_figure
DECLS
	REAL m_base
	REAL m_height
METHODS
	METHOD NO_TYPE init(STRING n,REAL b,REAL h)
	BODY
	   m_name= n
	   m_base= b
	   m_height= h
	END METHOD
	VIRTUAL METHOD REAL area()
	BODY
		RETURN (m_base*m_height)/2
	END METHOD
END CLASS

COMPONENT comp_class_figures_handler
OBJECTS
	class_circle  circle1
	class_rectangle class_rectangle1
	class_triangle triangle1
	OBJ_PTR<class_figure> m_listclass_figures[3]  -- list of pointers to class_figure objects
INIT
	class_rectangle1.init("class_rectangle1",12,6)
	circle1.init("circle1",4)
	triangle1.init("triangle1",5,2)
	m_listclass_figures[1]= class_rectangle1
	m_listclass_figures[2]= circle1	
	m_listclass_figures[3]= triangle1
	FOR(i IN 1,3)
	   WRITE("Area of object %s is %g\n",m_listclass_figures[i].m_name,m_listclass_figures[i].area())
	END FOR
END COMPONENT

FUNCTION NO_TYPE func_usePointers() 
OBJECTS
	class_circle  circle1
	class_rectangle rectangle1
	class_triangle triangle1
	OBJ_PTR<class_figure> m_listFigures[3]
BODY
	rectangle1.init("rectangle1",12,6)
	circle1.init("circle1",4)
	triangle1.init("triangle1",5,2)
	m_listFigures[1]= rectangle1
	m_listFigures[2]= circle1	
	m_listFigures[3]= triangle1
	FOR(i IN 1,3)
	   WRITE("Area of object %s is %g\n",m_listFigures[i].m_name,m_listFigures[i].area())
	END FOR
END FUNCTION

CLASS class_use_pointers
OBJECTS
	class_circle  circle1
	class_rectangle rectangle1
	class_triangle triangle1
	OBJ_PTR<class_figure> m_listFigures[3]
METHODS
	METHOD NO_TYPE run()
	BODY
		rectangle1.init("rectangle1",12,6)
		circle1.init("circle1",4)
		triangle1.init("triangle1",5,2)
		m_listFigures[1]= rectangle1
		m_listFigures[2]= circle1	
		m_listFigures[3]= triangle1
		FOR(i IN 1,3)
		   WRITE("Area of object %s is %g\n",m_listFigures[i].m_name,m_listFigures[i].area())
		END FOR
	END METHOD
END CLASS
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
	Care must be taken when using partition classes within the CONTINUOUS block of components because program arranges the equations that appear in the CONTINUOUS block, changing the execution order of the calls to object methods (as it does when using functions). Normally, operations with these types of objects should be done in the INIT or DISCRETE blocks of components and BODY blocks of functions and experiments
	
*/
COMPONENT comp_classAircraft
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

//	Access to Variables during Simulation
/*
	The following functions ease up array handling and initialization, all functions return FALSE in case of error:
 	Gets the values of array named "name" and copies them in array "v" which size is "dim1"
		BOOLEAN getArray1D(IN STRING name, OUT REAL v[],IN INTEGER dim1)
 	Copies the values of array "v" which size is "dim1" into array "name"
		BOOLEAN setArray1D(IN STRING name, IN REAL v[],IN INTEGER dim1)
 	Gets the values of a 2D array named "name" and copies them in 2D array "v" which first dimension is "dim1" and second dimension is "dim2"
		BOOLEAN getArray2D(IN STRING name, OUT REAL v[],IN INTEGER dim1, ,IN INTEGER dim2)
 	Copies the values of 2D array "v", which first dimension is "dim1" and second dimension is "dim2", into 2D array named "name"
		BOOLEAN setArray2D(IN STRING name, IN REAL v[], IN INTEGER dim1, ,IN INTEGER dim2)
 	Gets the values of a 3D array named "name" and copies them in 3D array "v" which first dimension is "dim1", second dimension is "dim2" and third dimension is "dim3"
		BOOLEAN getArray3D(IN STRING name, OUT REAL v[],IN INTEGER dim1, IN INTEGER dim2,IN \
                   INTEGER dim3)
 	Copies the values of a 3D array "v", which first dimension is "dim1", second dimension is "dim2" and third dimension is "dim3", into 3D array named "name".
		BOOLEAN setArray3D(IN STRING name, IN REAL v[],IN INTEGER dim1, IN INTEGER dim2,IN  \
                   INTEGER dim3)
	These methods help save on code when initializing arrays and copying them
*/
COMPONENT comp_classAssociatedPartitionInitializeArray
	DECLS
        REAL v[3]
END COMPONENT
// Class associated with a Partition
/*
The modeler can create classes associated to partitions from the wizard of the tool. The process is automatic and the class generated can be used as a regular class in EL.
For example, we can model a simple component that has a differential equation that represents a delay in the “y” variable with respect to “x”
*/
COMPONENT comp_eqt "Delay example"
   DATA
      REAL tau = 0.69       UNITS "s"	"Delay time"
   DECLS
      REAL x                "Main variable"
      REAL y                "Delayed variable"
   CONTINUOUS
		x= cos(TIME)
      y' = (x - y) / tau 
END COMPONENT



// This pointer
/*
But the "this" pointer is most useful when used in experiments (use case 3 explained above). 
For example, let's create a generic library function that performs a transient of any mathematical model (a partition) that is passed as an argument
*/
FUNCTION BOOLEAN func_tran(EPartition model,
                      REAL fromTime,
                       REAL toTime,REAL cint)
BODY	
	model.TIME= fromTime
	model.TSTOP= toTime
	model.CINT= cint
	IF ( model.INTEG() != INTEG_END ) THEN
		RETURN FALSE
	END IF
	RETURN TRUE
END FUNCTION
/*
Let's use it from a simple example, creating a basic component that represents a delay in a signal
*/
COMPONENT comp_math_delay
DATA
   REAL tau = 0.6 "delay time (seconds)"
DECLS
   REAL x, y
CONTINUOUS
   y' = (x - y) / tau
END COMPONENT