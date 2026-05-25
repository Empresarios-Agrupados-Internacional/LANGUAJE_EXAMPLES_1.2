/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPtrExamples7
  CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/

TYPEDEF FUNCTION REAL mftipo61(IN REAL a)


FUNCTION REAL fun5677(REAL a)
DECLS
BODY
	WRITE("*** called fun5677() with arguments(a=%g)\n",a)
	RETURN a+5
END FUNCTION


FUNCTION REAL fun5678(REAL a)
DECLS
BODY
	WRITE("*** called fun5678() with arguments(a=%g)\n",a)
	RETURN a+1
END FUNCTION

FUNCTION REAL fun5679(STRING st)
DECLS
	REAL a=2
BODY
	WRITE("*** called fun5679() with arguments(st=\"%s\")\n",st)
	RETURN a+1
END FUNCTION

COMPONENT test077
DATA
	FUNC_PTR<mftipo61> mpt= fun5677
	REAL ku=119
	REAL xu=9
	STRING pepe="dfs"
DECLS
	REAL zz
CONTINUOUS
	zz= mpt(4) + ku + xu
END COMPONENT


COMPONENT testFuncPtr11
DATA	
   FUNC_PTR<mftipo61> mroo= fun678
   REAL m67= 88
DECLS
	REAL uu
TOPOLOGY
	test077 tz (xu=88,mpt=fun5678,ku= m67)
	test077 ty (xu=m67,mpt=fun5677,ku= m67)
	test077 tr (mpt=mroo,xu=12,ku= 13)
CONTINUOUS
	uu= mroo(4) + m67*4.5
END COMPONENT
