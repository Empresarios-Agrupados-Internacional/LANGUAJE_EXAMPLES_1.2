/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPointersExamples2
  CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/

TYPEDEF FUNCTION REAL mtype1()

FUNCTION REAL print41 ()
DECLS
BODY
   RETURN 41
END FUNCTION

FUNCTION REAL print42 ()
DECLS
BODY
   RETURN 42
END FUNCTION

COMPONENT pcompo
DATA
	REAL datum1=0
	FUNC_PTR<mtype1> fptr= print41
DECLS
	REAL finalValue=0
CONTINUOUS
	finalValue= fptr() + datum1
END COMPONENT


COMPONENT testFuncPtr06
   TOPOLOGY
		pcompo p1 (  fptr= print42, datum1= print41() )
		pcompo p2[3,3] ( fptr= print41, datum1= 10 )
   INIT
END COMPONENT

