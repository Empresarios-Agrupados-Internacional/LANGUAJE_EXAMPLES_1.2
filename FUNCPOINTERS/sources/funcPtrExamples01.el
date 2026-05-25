/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPtrExamples01.el
 CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/

TYPEDEF FUNCTION REAL ptrFun (IN REAL a, OUT STRING b)

FUNCTION REAL example2(IN REAL a, OUT STRING b)
BODY
	RETURN a+10
END FUNCTION

FUNC_PTR<ptrFun> ptr= example2


TYPEDEF FUNCTION REAL ptrFunMat (IN REAL a)


FUNCTION REAL addOne(IN REAL a)
BODY
	RETURN a*1
END FUNCTION

FUNCTION REAL subsOne(IN REAL a)
BODY
	RETURN a*-1
END FUNCTION

COMPONENT testFuncPtr01
DECLS
	  FUNC_PTR<ptrFunMat> fptr= addOne
	  REAL x
DISCRETE
	 WHEN ( TIME > 5 ) THEN
	 	  fptr= subsOne
	 END WHEN
CONTINUOUS
	   x= fptr(TIME)
END COMPONENT

COMPONENT testFuncPtr02
DECLS
	  REAL x
CONTINUOUS
	 x= IF( TIME < 5 ) addOne(TIME)
           ELSE subsOne(TIME)
END COMPONENT

COMPONENT testFuncPtr03
DATA
	  FUNC_PTR<ptrFunMat> fptr= addOne
DECLS
	  REAL x
CONTINUOUS
	   x= fptr(TIME)
END COMPONENT

FUNCTION REAL sin10plus(IN REAL a)
BODY
	RETURN sin(a) + 10
END FUNCTION

FUNCTION REAL cos10minus(IN REAL a)
BODY
	RETURN cos(a) - 10
END FUNCTION

COMPONENT testFuncPtr04
DATA
	  FUNC_PTR<ptrFunMat> xvf= cos10minus
DECLS
	  REAL z
TOPOLOGY
	  testFuncPtr03  t1 (fptr= sin10plus)
	  testFuncPtr03  t2 (fptr= cos10minus)
CONTINUOUS
	   z= t1.x + t2.x 
END COMPONENT

COMPONENT testFuncPtr05
DATA
	  FUNC_PTR<ptrFunMat> xvf= cos10minus
DECLS
	  REAL z[3]
TOPOLOGY
	  testFuncPtr03  t1[3] (fptr= sin10plus)
	  testFuncPtr03  t2[3] (fptr= cos10minus)
CONTINUOUS
	EXPAND(i IN 1,3)
   	z[i]= t1[i].x + t2[i].x 
		
END COMPONENT


