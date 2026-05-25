/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPtrExamples4
  CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/

TYPEDEF FUNCTION REAL ftype222(REAL a, REAL b) 

CLASS WrapperClass33
METHODS
	METHOD REAL run(FUNC_PTR<ftype222> f2,REAL a, REAL b)
	DECLS
		REAL val1
	OBJECTS
	BODY
		WRITE("*** called WrapperClass.run() method with arguments(f2,a=%g,b=%g)\n",a,b)
		val1= f2(a,b)
		WRITE("val1 (solution %g+%g)= %g\n\n",a,b,val1)
		RETURN 2
	END METHOD
END CLASS


FUNCTION REAL fun233(REAL a, REAL b)
BODY
   WRITE("*** called fun2() function with arguments(a=%g,b=%g)\n",a,b)
	RETURN a+b
END FUNCTION


FUNCTION REAL callre33(FUNC_PTR<ftype222> f2,REAL a, REAL b)
DECLS
	REAL val2
BODY
	WRITE("*** called callre() function with arguments(f2,a=%g,b=%g)\n",a,b)
	val2= f2(a,b)
	WRITE("val2 (solution %g+%g)= %g\n\n",a,b,val2)
	RETURN 2
END FUNCTION

COMPONENT testFuncPtr08
OBJECTS
	WrapperClass33 obj
INIT
      WRITE("In INIT calling a function\n")
      callre33(fun233,50,20)
      WRITE("In INIT calling a method\n")
      obj.run(fun233,1000,200)

END COMPONENT
