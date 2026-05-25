/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPtrExamples10
  CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/


TYPEDEF FUNCTION REAL thermoFunc (REAL a)


FUNCTION REAL dummy (IN REAL a)
BODY
	 	WRITE("*** called dummy() with arguments(a=%g)\n",a)
      RETURN a + 10
END FUNCTION


CLASS FunPtrContainer
    DECLS
        FUNC_PTR<thermoFunc> f = dummy 
	REAL m_v
    METHODS
	METHOD NO_TYPE run(REAL a)
	BODY
		WRITE("*** called FunPtrContainer.run() with arguments(a=%g)\n",a)
	    m_v= f(a)
	END METHOD
END CLASS

TYPEDEF CLASS ThermoFuncVecBasic IS_A EVector<FunPtrContainer>

CLASS ThermoFuncVec IS_A ThermoFuncVecBasic 
METHODS

METHOD STRING asString ()
DECLS
	STRING st
OBJECTS
	FunPtrContainer obj
BODY
	WRITE("*** called ThermoFuncVec.asString() \n")
   FOR (i IN 1, size ())
     obj= at(i)
     WRITES (st ,"%s %g",st ,obj.m_v ) 
   END FOR
   RETURN st -- return vector in string format
END METHOD
END CLASS

COMPONENT testFuncPtr14
OBJECTS
	ThermoFuncVec th
	FunPtrContainer obj1,obj2
INIT
	obj1.run(10)
	obj2.run(200)
	th.push_back(obj1)
	th.push_back(obj2)
	WRITE("th (solution is 20 (10+10) 210 (200+10)= %s\n\n",th.asString())
END COMPONENT


