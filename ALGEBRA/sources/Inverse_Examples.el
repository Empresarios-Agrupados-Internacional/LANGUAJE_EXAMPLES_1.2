/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Inverse_Examples
 CREATION DATE: 04/07/2017
 Apuntes Álgebra lineal página I-14
-----------------------------------------------------------------------------------------*/
-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code


FUNCTION	NO_TYPE Inverse_Examples()
DECLS
	STRING 	A_as_Str 			= "2,0,0,0;0,3,0,0;0,0,7,0;0,0,0,8"
	REAL		B_as_Array2D [4,4] 	= {{0,0,0,2},{0,0,3,0},{0,7,0,0},{8,0,0,0}}
	REAL		C_as_Array1D   [9]	= {1,0,1,0,1,1,1,1,0}
	REAL		A_inv_as_Array1D [16]
	REAL		B_inv_as_Array2D [4,4]
	REAL		C_inv_as_Array2D [3,3]	
	INTEGER		i
	INTEGER		j

OBJECTS
	EigenMatrix A
	EigenMatrix B
	EigenMatrix C
	
	EigenMatrix A_inv
	EigenMatrix B_inv
	EigenMatrix C_inv
	
BODY
	WRITE("\n*******************\nFUNCTION: Linear System Solvers\n")

	A.setFromStr(A_as_Str)
	B.setFromArray2D (B_as_Array2D, 4,4,1,1,-1,-1)
	C.setFromArray2D (C_as_Array1D, 3,3,1,1,-1,-1)
	
	WRITE("A matrix set from String =\n%s \n", A.asString())
	WRITE("A size = %i\n", A.size())

	WRITE("B matrix set from 2D array =\n%s \n", B.asString())
	WRITE("B size = %i\n", B.size())
	
	WRITE("C matrix set from 1D array =\n%s \n", C.asString())
	WRITE("C size = %i\n", C.size())
	
	A_inv = A.inverse()
	B_inv = B.inverse()
	C_inv = C.inverse()
	
	WRITE("A inverse =\n%s \n", A_inv.asString())
	WRITE("B inverse matrix set from 2D array =\n%s \n", B_inv.asString())
	WRITE("C inverse =\n%s \n", C_inv.asString())
	
	A_inv.copyToArray2D(A_inv_as_Array1D,4,4,1,1)
	WRITE("\nA inverse as array 1D\n")
	

	WRITE("\n")
	FOR (j=1; j<=16; j = j+1)
		WRITE("%g ", A_inv_as_Array1D[j])
	END FOR

	B_inv.copyToArray2D(B_inv_as_Array2D,4,4,1,1)
	
	WRITE("\nB inverse as array 2D\n")
	
	FOR (i=1; i<=4; i=i+1)
		WRITE("\n")
		FOR (j=1; j<=4; j = j+1)
			WRITE("%g ", B_inv_as_Array2D[i,j])
		END FOR
	END FOR

	C_inv.copyToArray2D(C_inv_as_Array2D,3,3,1,1) 
	
	WRITE("\nC inverse as array 2D\n")
	
	FOR (i=1; i<=3; i=i+1)
		WRITE("\n")
		FOR (j=1; j<=3; j = j+1)
			WRITE("%g ", C_inv_as_Array2D[i,j])
		END FOR
	END FOR
	WRITE("\n\n")
END FUNCTION

COMPONENT	Inverse_Examples_Execution

INIT
	Inverse_Examples()

END COMPONENT