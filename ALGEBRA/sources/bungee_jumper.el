/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: bungee_jumper
 CREATION DATE: 26/06/2017
 Example 8.2 at page 221 in Matlab book
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code

FUNCTION	NO_TYPE Bungee_jumper()
DECLS
	REAL error
OBJECTS
	EigenMatrix K
	EigenMatrix mg
	EigenMatrix solution
	EigenHandler	Linear_System
	
BODY
   WRITE("\n*******************\nFUNCTION: Bungee_jumper\n")

	K.resize(3, 3)
	mg.resize(3,1)
	
	K.set(1, 1, 150)
	K.set(1, 2, -100)
	K.set(1, 3, 0)

		
	K.set(2, 1, -100)
	K.set(2, 2, 150)
	K.set(2, 3, -50)

	K.set(3, 1, 0)
	K.set(3, 2, -50)
	K.set(3, 3, 50)

	mg.set(1,1,588.6)
	mg.set(2,1,686.7)
	mg.set(3,1,784.8)

	WRITE("K=\n%s \n", K.asString())
	WRITE("mg=\n%s \n", mg.asString())

   WRITE("\n*******************\nMethod: linear solver (method colPivHouseholderQr)\n")
		  
	Linear_System.solve (K, mg, solution)
	
	WRITE("solution=\n%s \n", solution.asString())

END FUNCTION

FUNCTION	NO_TYPE Bungee_Jumper_Inverse ()

OBJECTS
	EigenMatrix K
	EigenMatrix K_inv
	EigenMatrix mg
	EigenMatrix x
	
BODY
	K.resize(3, 3)
	mg.resize(3,1)
	x.resize(3,1)
	
	K.set(1, 1, 150)
	K.set(1, 2, -100)
	K.set(1, 3, 0)

		
	K.set(2, 1, -100)
	K.set(2, 2, 150)
	K.set(2, 3, -50)

	
	K.set(3, 1, 0)
	K.set(3, 2, -50)
	K.set(3, 3, 50)


	
	mg.set(1,1,588.6)
	mg.set(2,1,686.7)
	mg.set(3,1,784.8)
	
	K_inv = K.inverse()
	
	x = K_inv*mg
	
	WRITE("\n*******************\nMethod: Multiplying by inverse\n")
	
	WRITE("K=\n%s \n", K.asString())
	WRITE("K_inv=\n%s \n", K_inv.asString())	
	WRITE("mg=\n%s \n", mg.asString())


	WRITE("\n*******************\nx = K_inv * y\n")	
	WRITE("x=\n%s \n", x.asString())
	WRITE("\nSolution must be identical to the obtained with function Bungee_jumper()\n")
	
END FUNCTION

COMPONENT	Bungee_jumper_Execution

INIT
	Bungee_jumper()
	Bungee_Jumper_Inverse ()

END COMPONENT
