/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: 
//Statements
Three different types of statements can be used in EL, depending on the context: sequential, continuous or
discrete. Classical languages like FORTRAN and C++ only allow sequential statements. Other event-oriented
modelling languages only allow discrete statements, while yet other equation system solving languages only
allow continuous statements. EL allows all three because they are paramount for the modelling of hybrid
systems which have discrete and continuous behaviour. The use of the three types of statements may be
summarised as follows:
 Sequential statements are used for initializations, functions and discrete events bodies which require a
strict execution order
 Continuous statements are used to express sets of differential-algebraic equations, where the order in
which they are written is not important, as they will be sorted later by the internal algorithms. They
form the core where the continuous physical models are defined
 Discrete statements are used to express events. These events are controlled by conditional statements
which indicate when an event occurs
-----------------------------------------------------------------------------------------*/
// Sequential Statements
// Sequential statements are used for initializations, functions and discrete events bodies which require a strict execution order
COMPONENT comp_sequential_statement
	DATA
		REAL b= 2
		REAL c= 3
	DECLS
		REAL a
	INIT
		a = b
		WRITE("\ta:%f\n",a)
		// For components (not for functions), delayed assignments are possible by using the AFTER statement. 
		// This means that when the statement is executed, the assignment will become effective after the delay you specify.
		a = b*c AFTER 2.5
	DISCRETE
		WHEN(TIME >= 2.5)	THEN
			WRITE("\n\ta AFTER 2.5:%f\n",a)
		END WHEN
END COMPONENT
//To print BOOLEAN or ENUM values, special functions must be used beginning with gval.... The functions always return a STRING which can be printed like any other string. For example, with the following statements:
ENUM liquids = { water, methane, ammonia }
ENUM liquids global_liq= ammonia
COMPONENT comp_special_functions
	DECLS
		REAL x = 2
		INTEGER i = 3
		BOOLEAN v= FALSE
	INIT
		WRITE("\nENUM example: %s = %s\n", gnameEnum(global_liq), gvalEnumByType (liquids,global_liq))
		WRITE("ENUM example: %s = %s\n", gnameEnum(global_liq), gvalEnum2 ("liquids",global_liq))
		WRITE("ENUM example: %s = %s\n\n", gnameEnum(global_liq), gvalEnum2 ("MODELLING_LANGUAGE.liquids",global_liq))
END COMPONENT
// Opening and Closing Files Explicitly
/*
Users can write text files from EL in any block of sequential statements by using the functions WRITEF() and
PRINTF(), described in this chapter section.
Unlike in most other languages, in EL it is not necessary to explicitly open and close the files to be used.
Whenever a WRITEF() function is to be written a new file is automatically opened with that name unless it has
already been opened by a previous WRITEF() call.
However, there are scenarios where files need to be explicitly opened or closed, such as when a new file has to
be opened without deleting the contents of the current one and writing at the end of it allowed or when a file
is to be closed because a different application needs to use it. Both functions are described below.
The OPENF() function opens a file explicitly. It is not necessary for WRITEF to work, but it can be used before
writing in any file. Its format is as follows:
BOOLEAN OPENF (IN STRING fileName , BOOLEAN cleanFile = TRUE )
The function returns TRUE if the file was opened properly, or FALSE otherwise. If the cleanFile argument is
TRUE (it is by default) and the file "fileName" already exists, its contents will be deleted upon opening. When
the cleanFile argument is FALSE, the file "fileName" will not be deleted, and new content will be appended to
the end of the file.
*/
FUNCTION NO_TYPE func_playWithFile()
DECLS
	FILEPATH fpath= "@MODELLING_LANGUAGE@/inputFiles/mfile.txt"
BODY
	 WRITE ("fpath: %s:\n",fpath)
	 //The OPENF() function opens a file explicitly
    IF( OPENF(fpath) == FALSE )THEN
		STOP "Cannot open file"
    END IF
	 // Written to a file (similar to fprintf() in C)
	 // Users can write text files from EL in any block of sequential statements by using the functions WRITEF() and PRINTF()
    WRITEF(fpath,"Hello world PART I\n")
	 // The function to close a file is CLOSEF() which closes a file that has been opened previously 
    CLOSEF(fpath)
    OPENF(fpath,FALSE)
    WRITEF(fpath,"Hello world PART II\n")
    CLOSEF(fpath)
    WRITEF(fpath,"Hello world PART III\n")
END FUNCTION
//IF-THEN-ELSE Statement
/*
 EL has the classic IF-THEN-ELSE programming structure. Its purpose is to select for execution one sequence of statements,
 			depending on the Boolean value of one or more conditions
			The syntax is as follows:
			IF condition THEN
				seq_stm_s
			( ELSEIF condition THEN seq_stm_s )*
			( ELSE seq_stm_s )?
			END IF
			In a WHILE statement, a block of statements is executed as long as the entry condition evaluates to TRUE. The
			syntax is as follows:
			WHILE condition
				seq_stm_s
			END WHILE
			The FOR statement represents a compact way of expressing loops. There are two types: the first one is similar to the FOR loop in C++ and it requires you to declare the iteration variables in advance. The second is a powerful way of making a variable iterate within a range of values without worrying about the declaration of the iteration variable. The syntax is as follows:
				FOR  '(' seq_for_schema  ')'  seq_stm_s END FOR
				seq_for_schema  ::= 
  				assign_stm_s? ';' expression ';' assign_stm_s? |
  				IDENTIFIER IN range1 ( EXCEPT expression_s )?

 -----------------------------------------------------------------------------------------*/
//IF-THEN-ELSE Statement
COMPONENT comp_if_then_else_while_for_statement
	DECLS
		ENUM type = {SIN,SQUARE}
		ENUM type signal = SQUARE
		ENUM type signal1 = SIN
		ENUM type signal2 = SQUARE
		REAL value
		INTEGER index = 0
		INTEGER maxIndex = 5
		INTEGER  b[6]
		BOOLEAN flagIn = FALSE
		INTEGER a = 0
		REAL w[10]
		INTEGER i,j
		REAL k[6]=12
		ENUM Chemicals2= { H2O, CO2, O2, H2 }
		SET_OF(Chemicals2) mix = { CO2, H2 }
		REAL ke[Chemicals2]=12
	INIT
		WRITE("\nENUM signal: %s \n", gvalEnum(signal))
		WRITE("ENUM signal1: %s \n", gvalEnum(signal1))
		IF(gvalEnum(signal) == gvalEnum(signal1)) THEN
			value =  sin (2 * 3.14159 * global_x)
	 		WRITE("IF_THEN_ELSE SIN example: %f\n\n",value)
		ELSEIF (gvalEnum(signal) == gvalEnum(signal2)) THEN
			value = sqrt(4)
			WRITE("IF_THEN_ELSE SQUARE example: %f\n\n",value)
		ELSE
			value = 1.
			WRITE("IF_THEN_ELSE example: %f\n\n",value)
		END IF
		// WHILE Statement
		-- In a WHILE statement, a block of statements is executed as long as the entry condition evaluates to TRUE
		WHILE  index < maxIndex 
    		b[index]= 0.0
    		index= index + 1
			WRITE("\tWHILE index example: %d\n",index)
		END WHILE
		WHILE ( a < 10 AND NOT flagIn )
    		w[index] += 0.1
    		index += 1
			a = a + 1
			IF(a > 5) THEN
				flagIn = TRUE
			END IF
			WRITE("\tWHILE a example: %d\n",a)
		END WHILE
		//FOR Statement
		/*
		The FOR statement represents a compact way of expressing loops. Is similar to the FOR loop in C++ and it requires to declare 
		the iteration variables in advance and the second is a powerful way of making a variable iterate within a range of values 
		without worrying about the declaration of the iteration variable
		*/
		FOR ( i=0; i < 5; i= i+1 )
    		k[i]= 0.0
		END FOR
		FOR ( i=0, j=0; i < 5 AND j < 5; i= i+1, j= j+2 )
    		k[i]= 0.0
		END FOR
		FOR ( j IN 1,5 )  -- from 1 to 5
    		k[j]= 0.0
		END FOR
		k[2]=5.
		FOR( j IN 1,5 EXCEPT 2 )  -- from 1 to 5 except 2
    		k[j]= 0.0
			WRITE("\tFOR k[%d] example: %f\n",j,k[j])
		END FOR
		FOR( i IN Chemicals2 EXCEPT CO2 ) 
    		ke[i]= 0.0	-- equivalent to k[H2O]=k[O2]=k[H2]= 0.0
			WRITE("\tFOR ke[%d] Chemicals example: %f\n",i,ke[i])
		END FOR
		FOR( i IN mix)
    		ke[i] = 0.0  -- equivalent to k[CO2]=k[H2]= 0.0
			WRITE("\tFOR ke[%d] mix example: %f\n",i,ke[i])
		END FOR
END COMPONENT
//Continuous Statements
/*
 Continuous statements are those which define the mathematical models in the continuous part. Basically, they are differential-algebraic equations which act continuously, not sequentially. This means that the order in which the equations are written is not significant, as the internal mathematical algorithms will sort them later, using different criteria.
 Conditional Insertion of Equations
 EL allows a set of equations to be introduced conditionally in the model at the beginning. 
 Since the final equations must be known when the models are generated, the conditions that can be applied for 
 these conditional insertions must only be based on the use of construction parameters, 
 because they need to be established when the models are generated.
*/
COMPONENT comp_continuos_statements_insert(INTEGER sw = 2)
    DECLS
        	REAL x
        	REAL y
	 INIT
	 		WRITE ("\n CONTINUOUS INSERT sw example: %d\n\n", sw)
    CONTINUOUS
        	IF( sw == 1 ) INSERT
            3*x - 6*y = 9
            4*x - 4*y = 9
        	ELSEIF( sw == 2 ) INSERT
            2*x + 2*y =  545
            4*x - 4*y = 54  
        	ELSE
            7*x + 6*y =  34
            8*x - 8*y = 75 
        	END IF

END COMPONENT
// Continuous Statements
/*
Continuous statements are those which define the mathematical models in the continuous part. Basically, 
they are differential-algebraic equations which act continuously, not sequentially. This means that the order in which the equations are written is not significant, 
as the internal mathematical algorithms will sort them later, using different criteria.
*/
COMPONENT comp_continuous_statements
	 DECLS
	 	REAL x
		REAL y = 5
		REAL z = 10
	 	REAL x0[3]
      REAL y0[3]
		REAL newMatrix[4,3]={ {1,2,3},{4,5,6},{7,8,9},{10,11,12} }
		REAL matrix[3,4]= 5
		REAL x1[3]
		REAL y1[3]
		REAL x2[3,2,2]
		REAL y2[3,2,2]
		REAL x3[3,2,2]
		REAL y3[3,2,2]
		REAL m
		REAL x4
		REAL y4 = 10
		INTEGER sw=2
		REAL x5
		REAL y5 = 23.41E8
	 TOPOLOGY
	 		// Conditional Insertion of Equations
			/*
			The conditions that can be applied for these conditional insertions must only be based on the use of construction parameters,
			because they need to be established when the models are generated. 
			*/
			comp_continuos_statements_insert(1) insert 
    CONTINUOUS
	 	//Continuous EXPAND Statement
		/*
		The user can insert multiple equations in one go by using EXPAND statements. They act like a FOR statement;
		the difference is that the EXPAND statement will populate them as if the user were to insert different and independent equations. 
		The FOR statements maintain the loop structure until the execution time.
		*/
		EXPAND( i IN 1,3)
   		EXPAND(j IN 1,4 EXCEPT i)
        		newMatrix[j,i] = matrix[i,j]

		EXPAND_BLOCK ( i IN 1,3 )
    		x0[i]= y0[i] + 4
    		x1[i]= y1[i] + 5
		END EXPAND_BLOCK
		EXPAND_BLOCK ( i IN 1,3 )
    		EXPAND_BLOCK ( j IN 1,2 )
        		EXPAND_BLOCK ( k IN 1,2 )
	      		x2[i,j,k]= y2[i,j,k] + 4
	      		x3[i,j,k]= y3[i,j,k] + 5
        		END EXPAND_BLOCK
    		END EXPAND_BLOCK
		END EXPAND_BLOCK
		// Use of Conditional Equations with Detection of Events ZONE
		/*
		EL allows the use of continuous equations with dynamic changing of the valid equation depending on certain conditions and 
		detecting the exact events of crossing. The ZONE statement is used for this purpose
		*/
		x=  ZONE ( TIME > 10 ) y + 3*z
    		OTHERS    y + 2*z
		
		x4 = 	ZONE ( m > 0 AND m < 2) y4 + 2*y4
   			ZONE ( m > 2 AND m < 4) y4 + 3*y4
   			ZONE ( m > 4 ) y4 + 4*y4
    			OTHERS y4 + 5*y4
				
		x5 = ZONE( y5 > 23.41E8 TOL 1E-2) y5+100000000
	  			OTHERS y5-100000000
	
END COMPONENT
// Use of Conditional Equations without Detection of Events
/*
A conditional equation may be modelled with an IF statement without forcing Program to deal with potential 
non-linearity in the system of equations. 
The syntax is similar to the ZONE statement-- define an enumerative type with different modes
*/
ENUM modes= { DESIGN, OFF_DESIGN, TRANSIENT }
COMPONENT comp_conditional_equations  
    DECLS
        REAL x= 3
        ENUM modes switchMode= DESIGN
    CONTINUOUS
        x= IF    ( switchMode == DESIGN )   5.6
           ELSEIF( switchMode== TRANSIENT ) sin(TIME)
           ELSE                             sin(TIME) + cos(TIME)
END COMPONENT
// Sequential Blocks of Equations
/*
With this block inside the CONTINUOUS block, code can be entered sequentially inside the continuous set of equations. 
In fact, the effect is similar to that when it is called an external function which performs a calculation and returns the control.
This example calculates the value of "x" and then the value of "y" in the call to function "limitVariable()"
taking into account the logic of the function
*/
FUNCTION NO_TYPE func_limitVariable(OUT REAL result, 
                          	     IN REAL x, 
				     IN REAL lowerLimit, 
				     IN REAL upperLimit)
    BODY
        IF( x < lowerLimit) THEN
            result= lowerLimit
        ELSEIF ( x > upperLimit) THEN
            result= upperLimit
        ELSE
		result= x
        END IF
END FUNCTION
COMPONENT comp_without_sequential_block
    DATA
        REAL lowerLimit= 9.9
        REAL upperLimit= 8.1
    DECLS
        REAL x
        REAL y
    CONTINUOUS
        x= sin(TIME) + 9
        func_limitVariable (y,x,lowerLimit,upperLimit)
END COMPONENT
//We could obtain the same behaviour with a SEQUENTIAL block inside the component
COMPONENT comp_sequential_block
    DATA
        REAL lowerLimit= 9.9
        REAL upperLimit= 8.1
    DECLS
        REAL x
        REAL y

    CONTINUOUS
        x= sin(TIME) + 9
        SEQUENTIAL
            IF( x < lowerLimit) THEN
                y= lowerLimit
            ELSEIF ( x > upperLimit) THEN
                y= upperLimit
            ELSE
                y= x
            END IF
        END SEQUENTIAL
END COMPONENT
// Parallel blocks of equations
/*
In previous section, it has been shown how the user can insert a sequential block in the continuous part of a component or port. Besides this, the modeller can also include parallel blocks in the continuous part of components and ports using the PARALLEL statement. The syntax is very similar to that for SEQUENTIAL blocks:
PARALLEL label
   Sequential_staments
END PARALLEL
However, it works very differently from sequential blocks, because now the EL compiler is going to identify and unify in a single block all the parallel blocks that have the same tag. Once done, it will then order this unified block as one more block of the set of equations and, lastly, create a different calculation thread for each individual parallel block. This way, all the blocks that have the same label will be executed in parallel.
In order to be able to use parallel blocks, some very important conditions must be taken into account:
 	The modeller is responsible for knowing if the blocks can be executed in parallel. This will be so if those blocks do not require a calculation sequence between them.
 	Parallel calculations have sense either only when they are time-consuming pieces of code or because they are slow calling external objects (eg. databases). It makes no sense and is counterproductive to try to parallelize pieces of code that are very fast.
*/
/*
First, let’s build a component with a heavy CPU consuming time block and another pair of equations that will allow us to see how the parallel block is ordered as another block of equations. It is written the component compSeq that instances 4 objects of that first component:
*/
COMPONENT comp_basicSeq
DECLS
    REAL v[10000]= 0
    REAL z[10]= 0
    REAL kr= 0
CONTINUOUS
    SEQUENTIAL   -- simulate a heavy CPU calculation
      FOR(j  IN 1,100)
        FOR(i IN 1,10000)
          v[i]= cos(TIME) * sin(TIME) +z[1]
        END FOR
      END FOR
   END SEQUENTIAL
   kr= sin(TIME)
   EXPAND(i IN 1,10) z[i]'= cos(TIME)
END COMPONENT

COMPONENT comp_compoSeq
TOPOLOGY
    comp_basicSeq b1, b2, b3, b4
END COMPONENT

/*
We are going improve this by replacing the SEQUENTIAL blocks with labelled PARALLEL blocks. The label allows us to create as many parallel calculations as we want because the compiler will group all blocks that have the same label. In this case, we use the label "parallel1"
*/
COMPONENT comp_basicParallel
DECLS
    REAL v[10000]= 0
    REAL z[10]= 0
    REAL kr= 0
CONTINUOUS
    PARALLEL "parallel1"
      FOR(j  IN 1,100)
        FOR(i IN 1,10000)
          v[i]= cos(TIME) * sin(TIME) +z[1]
        END FOR
      END FOR
    END PARALLEL
    kr= sin(TIME)
    EXPAND(i IN 1,10) z[i]'= cos(TIME)
END COMPONENT
COMPONENT comp_compoParallel
TOPOLOGY
    comp_basicParallel b1, b2, b3, b4
END COMPONENT
COMPONENT comp_basicParallel2
DECLS
    REAL v[10000]= 0
    REAL t[10000]= 0
    REAL z[10]= 0
    REAL kr= 0
CONTINUOUS
    PARALLEL "parallel1"
      FOR(j  IN 1,100)
        FOR(i IN 1,10000)
          v[i]= cos(TIME) * sin(TIME) +z[1]
        END FOR
      END FOR
    END PARALLEL
    kr= sin(TIME)
    EXPAND(i IN 1,10) z[i]'= cos(TIME)
    PARALLEL "parallel2"
      FOR(j  IN 1,100)
        FOR(i IN 1,10000)
          t[i]= cos(TIME) * sin(TIME) + v[i]
        END FOR
      END FOR
    END PARALLEL
END COMPONENT

COMPONENT comp_compoParallel2
TOPOLOGY
    comp_basicParallel2 b1, b2, b3, b4
END COMPONENT


//Discrete Statements
 /*
 Program allows events to be defined in the continuous part. 
 These events cause the continuous model to halt so that they can be dealt with. 
 After they have been dealt with the continuous model resumes.
 As a trivial example, let us assume that we are modelling a ball bouncing on the ground: 
 the following position equation may be used, but it is obvious that when the ball touches the ground,
 we have to express an event so that the direction of movement can be changed. 
 This is done by means of discrete statements, which may only be inserted in the DISCRETE block of the components.
 */
-----------------------------------------------------------------------------------------*/
// Discrete EXPAND Statement
/*
The EXPAND statements in the discrete part are similar to those in the continuous part; i.e., the conditional
insertion of none, one or many statements. The syntax is the same:
		expandStm ::= EXPAND '(' loop_schema ')' discrete_stm |
 	EXPAND '(' expression ')' discrete_stm
There is also a block version of the EXPANDstatement called discrete EXPAND_BLOCK. This statement allows
several discrete events to be introduced in the same EXPAND. The syntax is:
	EXPAND_BLOCK '(' expression ')'
		discrete_stm_s
	END EXPAND_BLOCK
Discrete EXPAND Statement
ASSERT Statement in DISCRETE Block
*/
COMPONENT comp_discrete_statements
	DECLS
		REAL y = 4
		REAL x[2]
	DISCRETE
      // The EXPAND statement called discrete EXPAND_BLOCK. This statement allows several discrete events to be introduced in the same EXPAND
		EXPAND_BLOCK ( i IN 1,2 )
    		WHEN( x[i] > 9 ) THEN
        		x[i]= 87
    		END WHEN
    		--ASSERT(x[i] < 1) FATAL "Fatal error"
    		WHEN( x[i] > 8 ) THEN
        		x[i]= 188
    		END WHEN
		END EXPAND_BLOCK
	CONTINUOUS
		EXPAND (i IN 1,2)
			x[i]' = y**2
END COMPONENT
