/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Gauss_Example
 CREATION DATE: 22/06/2017
-----------------------------------------------------------------------------------------*/


-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code


FUNCTION	NO_TYPE Linear_system_example1()
DECLS
	REAL error
OBJECTS
	EigenMatrix A
	EigenMatrix y
	EigenMatrix solution

	EigenHandler	Linear_System
	
BODY
        WRITE("\n*******************\nFUNCTION: Linear_system_example1\n")

	A.resize(4, 4)
	y.resize(4,1)
	
	A.set(1, 1, 1)
	A.set(1, 2, 1)
	A.set(1, 3, 1)
	A.set(1, 4, 1)
		
	A.set(2, 1, 2)
	A.set(2, 2, 3)
	A.set(2, 3, 1)
	A.set(2, 4, 5)
	
	A.set(3, 1, -1)
	A.set(3, 2, 1)
	A.set(3, 3, -5)
	A.set(3, 4, 3)
	
	A.set(4, 1, 3)
	A.set(4, 2, 1)
	A.set(4, 3, 7)
	A.set(4, 4, -2)
	
	y.set(1,1,10)
	y.set(2,1,31)
	y.set(3,1,-2)
	y.set(4,1,18)
	
	WRITE("A=\n%s \n", A.asString())
	WRITE("y=\n%s \n", y.asString())

   WRITE("\n*******************\nSolving a linear equations system\n")
		  
	Linear_System.solve (A, y, solution)
	
	WRITE("solution=\n%s \n", solution.asString())


END FUNCTION

FUNCTION	NO_TYPE Linear_system_example2()
DECLS
	REAL error
OBJECTS
	EigenMatrix A
	EigenMatrix y
	EigenMatrix solution

	EigenHandler	Linear_System
	
BODY
        WRITE("\n*******************\nFUNCTION: Linear_system_example2\n")

	A.resize(3, 3)
	y.resize(3,1)
	
	A.set(1, 1, 2)
	A.set(1, 2, 2)
	A.set(1, 3, 4)

		
	A.set(2, 1, -1)
	A.set(2, 2, -2)
	A.set(2, 3, 3)

	
	A.set(3, 1, 3)
	A.set(3, 2, -7)
	A.set(3, 3, 4)

	
	
	y.set(1,1,16)
	y.set(2,1,1)
	y.set(3,1,10)
	
	WRITE("A=\n%s \n", A.asString())
	WRITE("y=\n%s \n", y.asString())

   WRITE("\n*******************\nLinear solver\n")
		  
	Linear_System.solve ( A, y, solution)
	WRITE("solution=\n%s \n", solution.asString())

END FUNCTION

FUNCTION	NO_TYPE Linear_system_example3()
DECLS
	BOOLEAN status
OBJECTS
	EigenMatrix A
	EigenMatrix y
	EigenMatrix solution

	EigenHandler	Linear_System
	
BODY
        WRITE("\n*******************\nFUNCTION: Linear_system_example3\n")

	A.resize(2,3)
	y.resize(2,1)
	
	A.set(1, 1, 1)
	A.set(1, 2, 6)
	A.set(1, 3, -2)

		
	A.set(2, 1, 2)
	A.set(2, 2, -4)
	A.set(2, 3, 1)

	
	y.set(1,1,0)
	y.set(2,1,0)

	
	WRITE("A=\n%s \n", A.asString())
	WRITE("y=\n%s \n", y.asString())

   WRITE("\n*******************\nMethod: colPivHouseholderQr\n")
		  
	WRITE("\nAn execution error should be raised now, since A is not squared\n")
   Linear_System.solve (A, y, solution)	
	 WRITE("solution=\n%s \n", solution.asString())
END FUNCTION

COMPONENT	Linear_system_execution

INIT
	Linear_system_example1()
	Linear_system_example2()
	Linear_system_example3()

END COMPONENT