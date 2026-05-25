/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPtrExamples9
  CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/


TYPEDEF FUNCTION REAL mftipo611(IN REAL a)

FUNCTION REAL gt3(IN REAL a)
BODY
	WRITE("*** called gt3() with arguments(a=%g)\n",a)
	RETURN a+100
END FUNCTION

/*
FUNCTION REAL gt1(IN STRING a)
BODY
	WRITE("*** called gt0() with arguments(a=%g)\n",a)
	RETURN 34.34
END FUNCTION*/

FUNCTION REAL gt2(FUNC_PTR<mftipo611> xx= gt3)
DECLS
	FUNC_PTR<mftipo61> pp= gt3
BODY
	RETURN xx(10)
END FUNCTION


FUNC_PTR<mftipo611> lgp= gt3

COMPONENT testFuncPtr13 
DECLS
	REAL hh
INIT
	hh= gt2() + lgp(100)
	WRITE("hh (solution is 310)= %g\n",hh)
END COMPONENT