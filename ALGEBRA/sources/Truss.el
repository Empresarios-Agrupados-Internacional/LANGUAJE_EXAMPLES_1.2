/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Truss
 CREATION DATE: 27/06/2017
 Reactors Example at Matlab book 227
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code

FUNCTION	NO_TYPE Truss()
DECLS
	REAL error
OBJECTS
	EigenMatrix Matirx
	EigenMatrix Y_Array
	EigenMatrix X_Array

	EigenHandler	Linear_System
	
BODY
        WRITE("\n*******************\nFUNCTION: Truss\n")

	Matirx.resize(6, 6)
	Y_Array.resize(6,1)
	X_Array.resize(6,1)
	
	Matirx.set(1, 1, 0.866)
	Matirx.set(1, 2, 0)
	Matirx.set(1, 3, -0.5)
	Matirx.set(1, 4, 0)
	Matirx.set(1, 5, 0)
	Matirx.set(1, 6, 0)

	
	Matirx.set(2, 1, 0.5)
	Matirx.set(2, 2, 0)
	Matirx.set(2, 3, 0.866)
	Matirx.set(2, 4, 0)
	Matirx.set(2, 5, 0)
	Matirx.set(2, 6, 0)


	Matirx.set(3, 1, -0.866)
	Matirx.set(3, 2, -1)
	Matirx.set(3, 3, 0)
	Matirx.set(3, 4, -1)
	Matirx.set(3, 5, 0)
	Matirx.set(3, 6, 0)

	
	Matirx.set(4, 1, -0.5)
	Matirx.set(4, 2, 0)
	Matirx.set(4, 3, 0)
	Matirx.set(4, 4, 0)
	Matirx.set(4, 5, -1)
	Matirx.set(4, 6, 0)

	
	Matirx.set(5, 1, 0)
	Matirx.set(5, 2, 1)
	Matirx.set(5, 3, 0.5)
	Matirx.set(5, 4, 0)
	Matirx.set(5, 5, 0)
	Matirx.set(5, 6, 0)
	
	Matirx.set(6, 1, 0)
	Matirx.set(6, 2, 0)
	Matirx.set(6, 3, -0.866)
	Matirx.set(6, 4, 0)
	Matirx.set(6, 5, 0)
	Matirx.set(6, 6, -1)

	
	Y_Array.set(1,1,0)
	Y_Array.set(2,1,-1000)
	Y_Array.set(3,1,0)
	Y_Array.set(4,1,0)
	Y_Array.set(5,1,0)
	Y_Array.set(6,1,0)
	
	WRITE("Matrix=\n%s \n", Matirx.asString())
	WRITE("Y_Array=\n%s \n", Y_Array.asString())

   WRITE("\n*******************\nMethod: linear solver\n")
		  
	Linear_System.solve (Matirx, Y_Array, X_Array)
	WRITE("X_Array=\n%s \n", X_Array.asString())
END FUNCTION

FUNCTION	NO_TYPE Truss_inv ()

OBJECTS
	EigenMatrix Matirx
	EigenMatrix Matirx_inv
	EigenMatrix Y_Array
	EigenMatrix X_Array
	
BODY
        WRITE("\n*******************\nFUNCTION: Truss_inv\n")

	Matirx.resize(6, 6)
	Y_Array.resize(6,1)
	X_Array.resize(6,1)
	
	Matirx.set(1, 1, 0.866)
	Matirx.set(1, 2, 0)
	Matirx.set(1, 3, -0.5)
	Matirx.set(1, 4, 0)
	Matirx.set(1, 5, 0)
	Matirx.set(1, 6, 0)

	
	Matirx.set(2, 1, 0.5)
	Matirx.set(2, 2, 0)
	Matirx.set(2, 3, 0.866)
	Matirx.set(2, 4, 0)
	Matirx.set(2, 5, 0)
	Matirx.set(2, 6, 0)


	Matirx.set(3, 1, -0.866)
	Matirx.set(3, 2, -1)
	Matirx.set(3, 3, 0)
	Matirx.set(3, 4, -1)
	Matirx.set(3, 5, 0)
	Matirx.set(3, 6, 0)

	
	Matirx.set(4, 1, -0.5)
	Matirx.set(4, 2, 0)
	Matirx.set(4, 3, 0)
	Matirx.set(4, 4, 0)
	Matirx.set(4, 5, -1)
	Matirx.set(4, 6, 0)

	
	Matirx.set(5, 1, 0)
	Matirx.set(5, 2, 1)
	Matirx.set(5, 3, 0.5)
	Matirx.set(5, 4, 0)
	Matirx.set(5, 5, 0)
	Matirx.set(5, 6, 0)
	
	Matirx.set(6, 1, 0)
	Matirx.set(6, 2, 0)
	Matirx.set(6, 3, -0.866)
	Matirx.set(6, 4, 0)
	Matirx.set(6, 5, 0)
	Matirx.set(6, 6, -1)

	
	Y_Array.set(1,1,0)
	Y_Array.set(2,1,-1000)
	Y_Array.set(3,1,0)
	Y_Array.set(4,1,0)
	Y_Array.set(5,1,0)
	Y_Array.set(6,1,0)
	
	Matirx_inv = Matirx.inverse()
	
	X_Array = Matirx_inv*Y_Array
	
	WRITE("\n*******************\nMethod: Multiplying by inverse)\n")
	
	WRITE("Matirx=\n%s \n", Matirx.asString())
	WRITE("Matirx_inv=\n%s \n", Matirx_inv.asString())	
	WRITE("Y_Array=\n%s \n", Y_Array.asString())


	WRITE("\n*******************\nX_Array = Matirx_inv*Y_Array\n")	
	WRITE("X_Array=\n%s \n", X_Array.asString())
	WRITE("\nResults should be identical to the obtained with function Truss()\n\n")	
	
END FUNCTION

COMPONENT	Truss_Execution

INIT
	Truss()
	Truss_inv()

END COMPONENT