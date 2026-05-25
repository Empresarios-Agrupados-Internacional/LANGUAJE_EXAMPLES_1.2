/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPtrExamples8
  CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/

TYPEDEF FUNCTION REAL mftipo101(IN REAL a)
 
FUNCTION REAL fun8676(REAL a)
DECLS
BODY
	WRITE("*** called fun8676() with arguments(a=%g)\n",a)
	RETURN a+1
END FUNCTION

FUNCTION REAL fun8677(REAL a)
DECLS
	FUNC_PTR<mftipo101> fet = fun8676
BODY
	WRITE("*** called fun8677() with arguments(a=%g)\n",a)
	RETURN a+1
END FUNCTION

FUNCTION REAL fun8678(REAL a)
DECLS
BODY
	WRITE("*** called fun8678() with arguments(a=%g)\n",a)
	RETURN a+100
END FUNCTION
  
CLASS typeaa
DECLS
	FUNC_PTR<mftipo101> m_kk = fun8678
METHODS
	METHOD NO_TYPE paso()
	DECLS
	    FUNC_PTR<mftipo101> pa= fun8678
	BODY
		WRITE("*** called typeaa.paso() with arguments()\n")
	   pa(7)
	END METHOD
END CLASS

COMPONENT test01
DATA
DECLS
	FUNC_PTR<mftipo101> tt0 = fun8678
	REAL bb
CONTINUOUS
	bb= tt0(77)
END COMPONENT


COMPONENT testParent
DATA
DECLS
	FUNC_PTR<mftipo101> orr = fun8678
	REAL pp
INIT
	orr= fun8677
DISCRETE
	WHEN (TIME > 2 ) THEN
		WRITE("*** Detected even TIME > 2\n")
	   orr= fun8677
	END WHEN
CONTINUOUS
	pp= orr(88)
END COMPONENT

COMPONENT testFuncPtr12 IS_A testParent
DATA
DECLS
	FUNC_PTR<mftipo101> cpt = fun8677
	REAL aa
OBJECTS
	typeaa tt
TOPOLOGY
	test01 t1[3,2]
INIT
	WRITE("*** Calling INIT of testFuncPtr11 component\n")
	cpt= fun8678
DISCRETE
	WHEN (TIME > 5 ) THEN
		WRITE("*** Detected even TIME > 5\n")
	   cpt= fun8677
	END WHEN
CONTINUOUS
	aa= cpt(66) + orr(982) + TIME
END COMPONENT


