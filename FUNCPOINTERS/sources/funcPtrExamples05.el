/*-----------------------------------------------------------------------------------------
 LIBRARY: FUNCPOINTERS
 FILE: funcPtrExamples5
  CONTENTS: Example using the function pointers in EL language
 CREATION DATE: 15/12/2017
-----------------------------------------------------------------------------------------*/
CONST FILEPATH fname= "out.rpt"

CLASS Red
END CLASS

CLASS Yellow
DECLS
	REAL m_x= 23
METHODS
	METHOD REAL add(REAL a, REAL b)
	BODY
		RETURN a+b
	END METHOD
END CLASS

FUNCTION REAL gt0(Red j,REAL a, REAL b)
BODY
	RETURN a+b
END FUNCTION

FUNCTION REAL gt1(REAL a, REAL b)
BODY
	RETURN a+b
END FUNCTION

TYPEDEF FUNCTION REAL ftype051(Red j,REAL a, REAL b) 
TYPEDEF FUNCTION REAL ftype052(REAL a, REAL b) 
FUNC_PTR<ftype052> GL_pt= gt1


REAL FPE

CLASS Black
DECLS
	FUNC_PTR<ftype051> m_fun1= gt0
	FUNC_PTR<ftype052> m_fun= gt1
METHODS
	METHOD REAL init(FUNC_PTR<ftype051> ghy,FUNC_PTR<ftype052> fpt)
	DECLS
		REAL res
		FUNC_PTR<ftype052> pou= gt1
	BODY
		WRITE("*** called Black.init() with arguments(ghy,fpt)\n")
		pou= fpt
		m_fun1= ghy
		m_fun= fpt
		RETURN res
	END METHOD

	METHOD REAL run(REAL a, REAL b)
	DECLS
		REAL res
	BODY
		WRITE("*** called Black.run() with arguments(a=%g,b=%g)\n",a,b)
		RETURN m_fun(a,b)
	END METHOD
	
	METHOD REAL run1(REAL a, REAL b)
	DECLS
		REAL res
	OBJECTS
		Red k
	BODY
		WRITE("*** called Black.run1() with arguments(a=%g,b=%g)\n",a,b)
		RETURN m_fun1(k,a,b)
	END METHOD
END CLASS

TYPEDEF FUNCTION REAL ftype05100(Red j,Black m,REAL a, REAL b) 

FUNCTION REAL fun0(Red j,REAL a, REAL b)
BODY
	WRITE("*** called fun0() with arguments(j,a=%g,b=%g)\n",a,b)
	RETURN a+b+10
END FUNCTION

FUNCTION REAL funAdd88(REAL a, REAL b)
BODY
	WRITE("*** called funAdd() with arguments(a=%g,b=%g)\n",a,b)
	RETURN a+b
END FUNCTION


FUNCTION REAL funSubs88(REAL a, REAL b)
BODY
	WRITE("*** called funSubs() with arguments(a=%g,b=%g)\n",a,b)
	RETURN a-b
END FUNCTION


COMPONENT testFuncPtr09
DECLS
	REAL res
	FUNC_PTR<ftype052> kptrr= gt1
OBJECTS
	Black man
	Black mon
	Red j
INIT
     WRITE("In INIT calling a function\n")
     GL_pt= funAdd88
     res= GL_pt(100,200)
     WRITE("here res0= %g\n",res)


     kptrr= funAdd88
     res= kptrr(100,200)
     WRITE("here res1= %g\n",res)

     man.m_fun= funSubs88
     res= man.m_fun(100,200)
     WRITE("man res2= %g\n",res)

     mon.init(fun0,funSubs88)
     res= mon.run(100,200)
     WRITE("mon res1= %g\n",res)

	 res= mon.run1(100,200)
     WRITE("mon res11= %g\n",res)
	 
     mon.init(fun0,funAdd88)
     res= mon.run(100,200)
     WRITE("mon res2= %g\n",res)

     res= mon.run1(100,200)
     WRITE("mon res21= %g\n",res)
	 
     res= mon.run(100,200) + man.m_fun(100,200)
     WRITE("mon res3= %g\n",res)
END COMPONENT

