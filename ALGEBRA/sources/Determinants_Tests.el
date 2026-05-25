/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Determinants_Tests
 CREATION DATE: 05/07/2017
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code

FUNCTION NO_TYPE Determinant_Tests()

DECLS
	CONST INTEGER nrows= 4
	CONST INTEGER ncols=4
	REAL	A_Determinant
	REAL	A_as_Matrix [nrows,ncols]
	REAL	Row_Buffer [nrows]
	INTEGER	i	
OBJECTS
	EigenMatrix A
	EigenMatrix B	
	
BODY
   WRITE("\n*******************\nFUNCTION: Determinants_tests()\n")

	A.resize(4, 4)
	
	A.set(1, 1, 3)
	A.set(2, 1, 4)
	A.set(3, 1, 1)
	A.set(4, 1, 7)
	
	A.set(1, 2, 2)
	A.set(2, 2, 1)
	A.set(3, 2, 3)
	A.set(4, 2, 5)
	
	A.set(1, 3, 4)
	A.set(2, 3, 3)
	A.set(3, 3, 3)
	A.set(4, 3, 0)
	
	A.set(1, 4, 7)
	A.set(2, 4, 5)
	A.set(3, 4, 2)
	A.set(4, 4, 1)
	
	
	WRITE("A=\n%s \n", A.asString())

	A_Determinant = A.determinant()
	
	WRITE("A_Determinant=\n%g \n", A_Determinant)
	
-- Copy A matrix to EL array
	A.copyToArray2D(A_as_Matrix,nrows,ncols)
	
-- Multiply the first row of EL matrix by constant to verify that the determinant also apply the same constant
	FOR(i=1; i<=ncols;i=i+1)
		A.set(1,i, A.at(1,i)*4)
	END FOR
	
	WRITE("\nRow 1 multiplied by 4:\n")
	WRITE("A=\n%s \n", A.asString())
	
	A_Determinant = A.determinant()
	
   WRITE("\nIf we multiply a row by a constant the determinant will be multiplied as well.\n")
	WRITE("\nA.determinant() = %g\n", A_Determinant)
	
	A.set(1, 1, 3)
	A.set(2, 1, 4)
	A.set(3, 1, 1)
	A.set(4, 1, 7)
	
	A.set(1, 2, 2)
	A.set(2, 2, 1)
	A.set(3, 2, 3)
	A.set(4, 2, 5)
	
	A.set(1, 3, 4)
	A.set(2, 3, 3)
	A.set(3, 3, 3)
	A.set(4, 3, 0)
	
	A.set(1, 4, 7)
	A.set(2, 4, 5)
	A.set(3, 4, 2)
	A.set(4, 4, 1)
	
	WRITE("A=\n%s \n", A.asString())
		
-- Example by copying again to the EL array, modify values and copy back to EigenMatrix	
	
	A.copyToArray2D(A_as_Matrix,4,4,1,1)

-- Exchange first and second row and go back to Eigen A matrix
	FOR(i=1; i<=4;i=i+1)
		Row_Buffer [i] = A_as_Matrix[2,i]
		A_as_Matrix[2,i]=A_as_Matrix[1,i]
		A_as_Matrix[1,i] = Row_Buffer [i]
	END FOR

	A.setFromArray2D (A_as_Matrix, 4,4,1,1,-1,-1)
	

	WRITE("A after exchaning first and second rows=\n%s \n", A.asString())
	
	A_Determinant = A.determinant()
	
	WRITE("\nA.determinant() after = %g\n", A_Determinant)


	A.set(1, 1, 3)
	A.set(2, 1, 4)
	A.set(3, 1, 1)
	A.set(4, 1, 7)
	
	A.set(1, 2, 2)
	A.set(2, 2, 1)
	A.set(3, 2, 3)
	A.set(4, 2, 5)
	
	A.set(1, 3, 4)
	A.set(2, 3, 3)
	A.set(3, 3, 3)
	A.set(4, 3, 0)
	
	A.set(1, 4, 7)
	A.set(2, 4, 5)
	A.set(3, 4, 2)
	A.set(4, 4, 1)
	
	WRITE("A=\n%s \n", A.asString())

-- Add 3 times the first row to the second, the determinant should remain identical.	
	FOR(i IN 1,ncols)
		A.set(2,i, A.at(2,i)+3*A.at(1,i))
	END FOR
	
	WRITE("A after adding to the second row  3 times the first row =\n%s \n", A.asString())
	
	A_Determinant = A.determinant()
	
	WRITE("\nA.determinant() now = %g\n", A_Determinant)
	
	A.set(1, 1, 3)
	A.set(2, 1, 4)
	A.set(3, 1, 1)
	A.set(4, 1, 7)
	
	A.set(1, 2, 2)
	A.set(2, 2, 1)
	A.set(3, 2, 3)
	A.set(4, 2, 5)
	
	A.set(1, 3, 4)
	A.set(2, 3, 3)
	A.set(3, 3, 3)
	A.set(4, 3, 0)
	
	A.set(1, 4, 7)
	A.set(2, 4, 5)
	A.set(3, 4, 2)
	A.set(4, 4, 1)
	
	WRITE("A=\n%s \n", A.asString())
			
	
	A.transposeInPlace()

	WRITE("A transpose=\n%s \n", A.asString())
	
	A_Determinant = A.determinant()
	
	WRITE("\nA.determinant() of transposed should be identical = %g\n", A_Determinant)	
	
	A.set(1, 1, 3)
	A.set(2, 1, 4)
	A.set(3, 1, 1)
	A.set(4, 1, 7)
	
	A.set(1, 2, 2)
	A.set(2, 2, 1)
	A.set(3, 2, 3)
	A.set(4, 2, 5)
	
	A.set(1, 3, 4)
	A.set(2, 3, 3)
	A.set(3, 3, 3)
	A.set(4, 3, 0)
	
	A.set(1, 4, 7)
	A.set(2, 4, 5)
	A.set(3, 4, 2)
	A.set(4, 4, 1)
	
	WRITE("A=\n%s \n", A.asString())
		

-- Makes 0 the second row	
	A.setConstantRow(2,0)
	
	WRITE("A with  second row to zero=\n%s \n", A.asString())
	
	A_Determinant = A.determinant()
	
	WRITE("\nA.determinant() = %g\n", A_Determinant)
	
	A.set(1, 1, 3)
	A.set(2, 1, 4)
	A.set(3, 1, 1)
	A.set(4, 1, 7)
	
	A.set(1, 2, 2)
	A.set(2, 2, 1)
	A.set(3, 2, 3)
	A.set(4, 2, 5)
	
	A.set(1, 3, 4)
	A.set(2, 3, 3)
	A.set(3, 3, 3)
	A.set(4, 3, 0)
	
	A.set(1, 4, 7)
	A.set(2, 4, 5)
	A.set(3, 4, 2)
	A.set(4, 4, 1)
	
	WRITE("A=\n%s \n", A.asString())
		
	A.setConstantCol(2,0)

	WRITE("A after annuling the second column=\n%s \n", A.asString())
	
	A_Determinant = A.determinant()

	WRITE("\nDA.determinant() = %g\n", A_Determinant)
	
	
END FUNCTION



COMPONENT	Determinant_Tests_Execution

INIT
Determinant_Tests()

END COMPONENT