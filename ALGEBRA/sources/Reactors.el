/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Reactors
 CREATION DATE: 26/06/2017
 Reactors Example at Matlab book 227
-----------------------------------------------------------------------------------------*/


-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code


FUNCTION	NO_TYPE Reactors()
DECLS
	REAL error
OBJECTS
	EigenMatrix Coefficients
	EigenMatrix Array
	EigenMatrix Concentrations

	EigenHandler	Linear_System
	
BODY
        WRITE("\n*******************\nFUNCTION: Reactors\n")

	Coefficients.resize(5, 5)
	Array.resize(5,1)
	Concentrations.resize(5,1)
	
	Coefficients.set(1, 1, 6)
	Coefficients.set(1, 2, 0)
	Coefficients.set(1, 3, -1)
	Coefficients.set(1, 4, 0)
	Coefficients.set(1, 5, 0)

	
	Coefficients.set(2, 1, -3)
	Coefficients.set(2, 2, 3)
	Coefficients.set(2, 3, 0)
	Coefficients.set(2, 4, 0)
	Coefficients.set(2, 5, 0)


	Coefficients.set(3, 1, 0)
	Coefficients.set(3, 2, -1)
	Coefficients.set(3, 3, 9)
	Coefficients.set(3, 4, 0)
	Coefficients.set(3, 5, 0)

	
	Coefficients.set(4, 1, 0)
	Coefficients.set(4, 2, -1)
	Coefficients.set(4, 3, -8)
	Coefficients.set(4, 4, 11)
	Coefficients.set(4, 5, -2)

	
	Coefficients.set(5, 1, -3)
	Coefficients.set(5, 2, -1)
	Coefficients.set(5, 3, 0)
	Coefficients.set(5, 4, 0)
	Coefficients.set(5, 5, 4)

	
	Array.set(1,1,50)
	Array.set(2,1,0)
	Array.set(3,1,160)
	Array.set(4,1,0)
	Array.set(5,1,0)


	
	WRITE("Coefficients=\n%s \n", Coefficients.asString())
	WRITE("Array=\n%s \n", Array.asString())

   WRITE("\n*******************\nMethod: colPivHouseholderQr\n")
		  
	Linear_System.solve (Coefficients, Array, Concentrations)
	
	WRITE("Concentrations=\n%s \n", Concentrations.asString())

END FUNCTION

FUNCTION	NO_TYPE Reactors_inv ()

OBJECTS
	EigenMatrix Coefficients
	EigenMatrix Coefficients_inv
	EigenMatrix Array
	EigenMatrix Concentrations
	
BODY
        WRITE("\n*******************\nFUNCTION: Linear System Solvers\n")

	Coefficients.resize(5, 5)
	Array.resize(5,1)
	Concentrations.resize(5,1)
	
	Coefficients.set(1, 1, 6)
	Coefficients.set(1, 2, 0)
	Coefficients.set(1, 3, -1)
	Coefficients.set(1, 4, 0)
	Coefficients.set(1, 5, 0)

	
	Coefficients.set(2, 1, -3)
	Coefficients.set(2, 2, 3)
	Coefficients.set(2, 3, 0)
	Coefficients.set(2, 4, 0)
	Coefficients.set(2, 5, 0)


	Coefficients.set(3, 1, 0)
	Coefficients.set(3, 2, -1)
	Coefficients.set(3, 3, 9)
	Coefficients.set(3, 4, 0)
	Coefficients.set(3, 5, 0)

	
	Coefficients.set(4, 1, 0)
	Coefficients.set(4, 2, -1)
	Coefficients.set(4, 3, -8)
	Coefficients.set(4, 4, 11)
	Coefficients.set(4, 5, -2)

	
	Coefficients.set(5, 1, -3)
	Coefficients.set(5, 2, -1)
	Coefficients.set(5, 3, 0)
	Coefficients.set(5, 4, 0)
	Coefficients.set(5, 5, 4)

	
	Array.set(1,1,50)
	Array.set(2,1,0)
	Array.set(3,1,160)
	Array.set(4,1,0)
	Array.set(5,1,0)
	
	Coefficients_inv = Coefficients.inverse()
	
	Concentrations = Coefficients_inv*Array
	
	WRITE("\n*******************\nMethod: Multiplying by inverse)\n")
	
	WRITE("Coefficients=\n%s \n", Coefficients.asString())
	WRITE("Coefficients_inv=\n%s \n", Coefficients_inv.asString())	
	WRITE("Array=\n%s \n", Array.asString())


	WRITE("\n*******************\nConcentrations = Coefficients_inv*Array\n")	
	WRITE("Concentrations=\n%s \n", Concentrations.asString())
	WRITE("Results should be identical to the obtained with Reactors() function\n")	
	
END FUNCTION

COMPONENT	Reactors_Execution

INIT
	Reactors()
	Reactors_inv()

END COMPONENT