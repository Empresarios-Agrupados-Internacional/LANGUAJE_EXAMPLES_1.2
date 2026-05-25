/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPtrExamples6
  CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/

TYPEDEF FUNCTION REAL mftipo1(IN REAL a)


FUNCTION REAL fun678(REAL a)
DECLS
BODY
	WRITE("*** called fun678() with arguments(a=%g)\n",a)
	RETURN a+1
END FUNCTION

COMPONENT test0
DATA
	FUNC_PTR<mftipo1> mpt = fun678
DECLS
	REAL zz
CONTINUOUS
	zz= mpt(4)
END COMPONENT

COMPONENT test102
DECLS
	REAL z
	REAL t
TOPOLOGY
	test0 tx[2,3] (mpt= fun678)
	test0 tz (mpt= fun678)
CONTINUOUS
	z = tx[1,2].zz
	t = tz.zz
END COMPONENT


COMPONENT testFuncPtr10
TOPOLOGY
	test102 t1[3]
END COMPONENT
