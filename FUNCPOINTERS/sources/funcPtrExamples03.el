/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPtrExamples3
  CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/


CLASS MyClass
DECLS
	REAL x= 1
END CLASS

TYPEDEF FUNCTION REAL ftype1(IN MyClass a, REAL b, REAL c,STRING st) 
TYPEDEF FUNCTION REAL ftype2(REAL a, REAL b) 

FUNCTION REAL fun1subs(IN MyClass obj, REAL a, REAL b, STRING st)
BODY
	WRITE("*** called fun1subs() with arguments(obj.x=%g,a=%g,b=%g,st=\"%s\")\n",obj.x,a,b,st)
	RETURN obj.x + (a-b)
END FUNCTION

FUNCTION REAL fun2add(REAL a, REAL b)
BODY
	WRITE("*** called fun2add() with arguments(a=%g, b=%g)\n",a,b)
	RETURN a+b
END FUNCTION

FUNCTION REAL callre22(FUNC_PTR<ftype1> f1, FUNC_PTR<ftype2> f2,REAL a, REAL b)
DECLS
	REAL val1, val2
	BOOLEAN mbo
OBJECTS
	MyClass z
BODY
	WRITE("*** called callre() with arguments(f1, f2, a=%g,b=%g)\n",a,b)
	z.x= 100
	val1= f1(z,a,b,"Hello world!")
	WRITE("val1 (solution 100 + (50-20)=130)= %g\n",val1)
	val2= f2(a,b)
	WRITE("val2 (solution 100 + (50+20)=170)= %g\n\n",val2)
	RETURN 2
END FUNCTION

COMPONENT testFuncPtr07
INIT
      callre22(fun1subs,fun2add,50,20)
END COMPONENT