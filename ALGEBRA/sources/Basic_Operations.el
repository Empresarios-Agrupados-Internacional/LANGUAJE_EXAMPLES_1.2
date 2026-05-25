/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Basic_Operations
 CREATION DATE: 03/07/2017
 Basic Operations examples. Libro Álgebra Lineal página I-10
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code

FUNCTION	NO_TYPE Basic_Operations()
DECLS
	REAL error
OBJECTS
	EigenMatrix A
	EigenMatrix B
	EigenMatrix C
	EigenMatrix D
	
	EigenMatrix Result
	
BODY
        WRITE("\n*******************\nFUNCTION: Linear System Solvers\n")

	A.resize(2, 3)
	B.resize(2, 3)
	D.resize(2, 1)

	
	A.set(1, 1, 1)
	A.set(1, 2, 1)
	A.set(1, 3, 1)

		
	A.set(2, 1, 2)
	A.set(2, 2, 2)
	A.set(2, 3, 2)

	
	B.set(1, 1,-1)
	B.set(1, 2, 1)
	B.set(1, 3,-1)
	
	B.set(2, 1, 2)
	B.set(2, 2,-2)
	B.set(2, 3, 2)
	
	D.set(1, 1, 3)
	D.set(2, 1, 5)
	
	Result = A + B
	
	
	WRITE("A=\n%s \n", A.asString())
	WRITE("B=\n%s \n", B.asString())
	WRITE("D=\n%s \n", D.asString())
	WRITE("Result= A + B =\n%s \n", Result.asString())	

	WRITE("Result= A + D = Error\n")--%s \n", Result.asString())
	
	Result = 4*A
	
	WRITE("Result= 4*A = \n%s \n", Result.asString())
	
	Result = -1*A
	
	WRITE("Result= -1*A = \n%s \n", Result.asString())
	
	D.resize(3,1) 
	
	D.set(1,1,3)
	D.set(2,1,5)
	D.set(3,1,1)
	
	WRITE("D=\n%s \n", D.asString())
	
	C = A * D
	
	WRITE("C=\n%s \n", C.asString())

END FUNCTION

COMPONENT	Basic_Operations_Execution

INIT
	Basic_Operations()

END COMPONENT