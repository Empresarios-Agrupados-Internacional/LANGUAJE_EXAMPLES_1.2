/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Adjoints_Test
 CREATION DATE: 05/07/2017
-----------------------------------------------------------------------------------------*/


-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code



FUNCTION NO_TYPE Adjoints_Tests()

DECLS
	CONST INTEGER nrows= 3
	CONST INTEGER ncols=3
	REAL	A_Determinant
	REAL	A_as_Matrix [nrows,ncols]
	REAL	Row_Buffer [3]
	INTEGER	i	

OBJECTS
	EigenMatrix A
	EigenMatrix B	
	
BODY
   WRITE("\n*******************\nFUNCTION: Determinants_tests()\n")

	A.resize(3, 3)
	A.set(1, 1, 2)
	A.set(2, 1, 0)
	A.set(3, 1, 1)

	
	A.set(1, 2, 3)
	A.set(2, 2, 0)
	A.set(3, 2, -2)

	
	A.set(1, 3, 7)
	A.set(2, 3, -3)
	A.set(3, 3, 7)

	
	
	WRITE("A=\n%s \n", A.asString())
			
-- Copy from A_as_Matrix as EL array to EigenMatrix A to operate over rows and columns
	
	A.copyToArray2D(A_as_Matrix,nrows,ncols,1,1)
	A.adjointInPlace()
	WRITE("A as adjoint=\n%s \n", A.asString())

-- Make zero a column
	FOR(i=1; i<=3;i=i+1)
	A_as_Matrix[i,2] = 0
	END FOR
	
-- Copy again to A matrix.

	A.setFromArray2D (A_as_Matrix, nrows,ncols)
	
	WRITE("\nIf a column is null the determinant is null.\n")
	WRITE("\nSecond column to 0:\n")
	WRITE("A=\n%s \n", A.asString())
	
	-- Calculate determinant
	A_Determinant = A.determinant()
	
	WRITE("Determinant of A after annul second column = Det(A) = 0 \n")
	WRITE("\nA.determinant() = %g\n", A_Determinant)
	END FUNCTION
	
COMPONENT	Adjoints_Tests_Execution

INIT
Adjoints_Tests()

END COMPONENT