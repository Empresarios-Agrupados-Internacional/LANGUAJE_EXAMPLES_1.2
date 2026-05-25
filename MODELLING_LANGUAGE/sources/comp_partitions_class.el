/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: comp_partitions
// Class associated with a Partition
/*
The modeler can create classes associated to partitions from the wizard of the tool. The process is automatic and the class generated can be used as a regular class in EL.
For example, we can model a simple component that has a differential equation that represents a delay in the “y” variable with respect to “x”
*/
-----------------------------------------------------------------------------------------*/
/*
This new class will have access to the variables “x”, “y” and “tau”. 
This new class can be used in another part as a regular class or we can create a new class inherited from this one in order to add more intelligence, 
for example, to calculate a transient and return the final values of the model. For example we can create a new class  “comp_use_eqt” inherited from “comp_eqt_par1” 
adding some intelligence for calculating a transient
*/
CLASS comp_use_eqt IS_A comp_eqt_par1
METHODS
	METHOD NO_TYPE run(REAL from,REAL to,REAL cint,
				IN REAL tauInitial,OUT REAL xFinal, OUT REAL yFinal)
	BODY
		tau= tauInitial
		TIME= from
		TSTOP= to
		CINT= cint
		IMETHOD= IDAS
		INTEG()
		xFinal= x
		yFinal= y
	END METHOD
END CLASS

FUNCTION NO_TYPE func_seFinal(REAL tauInitial= 0.69)
DECLS
	REAL xFinal,yFinal
OBJECTS
	comp_use_eqt obj
BODY
	obj.run(0,1,0.1,tauInitial,xFinal,yFinal)
	WRITE("tauInitial= %g,xFinal=%g, yFinal= %g\n",tauInitial,xFinal,yFinal)
END FUNCTION
/*
Now let’s look at a more complete example using different methods for getting the total number of variables, printing the variable names, checking for the existence of a variable and getting the type and the category of a variable:
*/
COMPONENT comp_delayComplete
  DECLS    
     INTEGER nvars
     STRING tvar 
     STRING tcategory
   OBJECTS
	   comp_eqt_par1 obj
INIT
         -- obtain the total number of variable of this model
        nvars = obj.getNumberVars()
         -- print all variable names
        FOR(i IN 1,nvars)
            WRITE("variable %d= %s\n", i , obj.getVarName(i))
        END FOR

         -- set a value for variable x if exits
        IF ( obj.existsVariable("x") ) THEN
            obj.setValueReal("x", 3.45)
        END IF
        
         -- get the variable type (e.g. "REAL", "INTEGER", etc.)
        tvar = obj.getVarTypeStr("tau")
		  WRITE("type of var tau= %s\n",tvar)
		  
         -- get the variable category (e.g. "EXPLICIT", "BOUNDARY", etc.)
        tcategory= obj.getVarCategoryStr("y")
		  WRITE("category of var y= %s\n",tcategory)
END COMPONENT
