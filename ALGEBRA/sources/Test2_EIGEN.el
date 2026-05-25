/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Test2_EIGEN
 CREATION DATE: 30/06/2017
 MATLAB Book Example 11.3
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code

FUNCTION NO_TYPE Test2_EIGEN()
DECLS
	REAL	Array[9] = {8,6,9,-5,8,1,4,8,2}
	REAL	aux1
	REAL	aux2
	REAL	aux3
	REAL	aux4
	REAL	aux5
	REAL	aux6
	REAL	aux7
	REAL	aux8
	REAL	aux9
	REAL	A_Row_Sum_Norm
	REAL	A_Inverse_Row_Sum_Norm
	REAL	A_Condition_Number
	

OBJECTS
	EigenMatrix A
	EigenMatrix A_inverse
	EigenVector Sum
	EigenRowVector	Row1
	EigenRowVector	Row2
	EigenRowVector	Row3
	EigenVector	Col1
	EigenVector	Col2
	EigenVector	Col3
	
	
BODY
	WRITE("\nMatrix condition evaluation with EcosimPro EIGEN\n")
	A.resize(3, 3)
	
	A.set(1, 1, 1)
	A.set(2, 1, 1/2)
	A.set(3, 1, 1/3)
	
	A.set(1, 2, 1/2)
	A.set(2, 2, 1/3)
	A.set(3, 2, 1/4)
	
	A.set(1, 3, 1/3)
	A.set(2, 3, 1/4)
	A.set(3, 3, 1/5)
	
	
	WRITE("A=\n%s \n", A.asString())

	Row1 = A.getRow(1)
	Row2 = A.getRow(2)
	Row3 = A.getRow(3)

	WRITE("Row1=\n%s \n", Row1.asString())
	WRITE("Row2=\n%s \n", Row2.asString())
	WRITE("Row3=\n%s \n", Row3.asString())
	
	Col1 = A.getCol(1)
	Col2 = A.getCol(2)
	Col3 = A.getCol(3)

	WRITE("Col1=\n%s \n", Col1.asString())
	WRITE("Col2=\n%s \n", Col2.asString())
	WRITE("Col3=\n%s \n", Col3.asString())
	
	Row1 = Row1 / Row1.maxCoeff()
	
	WRITE("Row1=\n%s \n", Row1.asString())
	
	Row2 = Row2 / Row2.maxCoeff()
	
	WRITE("Row2=\n%s \n", Row2.asString())
	
	Row3 = Row3 / Row3.maxCoeff()
	
	WRITE("Row3=\n%s \n", Row3.asString())
	
	A.setRow(1,Row1)
	A.setRow(2,Row2)
	A.setRow(3,Row3)
	
	WRITE("A normalized =\n%s \n", A.asString())
	
	WRITE("Sum of Row 1=\n%g \n", Row1.sum())
	WRITE("Sum of Row 2=\n%g \n", Row2.sum())
	WRITE("Sum of Row 3=\n%g \n", Row3.sum())

	Sum.resize(3)
	
	Sum.set(1,Row1.sum())
	Sum.set(2,Row2.sum())
	Sum.set(3,Row3.sum())
	
	WRITE("Sum =\n%s \n", Sum.asString())
	
	WRITE("Max Row Sum =\n%g \n", Sum.maxCoeff())
	
	A_Row_Sum_Norm = Sum.maxCoeff()
	
	A_inverse = A.inverse()
	
	WRITE("A inverse =\n%s \n", A_inverse.asString())
	
	Row1 = A_inverse.getRow(1)
	Row2 = A_inverse.getRow(2)
	Row3 = A_inverse.getRow(3)

	WRITE("Row1=\n%s \n", Row1.asString())
	WRITE("Row2=\n%s \n", Row2.asString())
	WRITE("Row3=\n%s \n", Row3.asString())

	Row1.get(1,aux1)
	Row1.get(2,aux2)
	Row1.get(3,aux3)
	
	Row2.get(1,aux4)
	Row2.get(2,aux5)
	Row2.get(3,aux6)
	
	Row3.get(1,aux7)
	Row3.get(2,aux8)
	Row3.get(3,aux9)
	
	
	Row1.set(1, abs(aux1))
	Row1.set(2, abs(aux2))
	Row1.set(3, abs(aux3))
	
	Row2.set(1, abs(aux4))
	Row2.set(2, abs(aux5))
	Row2.set(3, abs(aux6))
	
	Row3.set(1, abs(aux7))
	Row3.set(2, abs(aux8))
	Row3.set(3, abs(aux9))

	WRITE( "A inverse matrix in absolute values:\n")
	
	WRITE("Row1=\n%s \n", Row1.asString())
	WRITE("Row2=\n%s \n", Row2.asString())
	WRITE("Row3=\n%s \n", Row3.asString())
	
	Sum.set(1,Row1.sum())
	Sum.set(2,Row2.sum())
	Sum.set(3,Row3.sum())
	
	WRITE("Sum of absolute values =\n%s \n", Sum.asString())
	WRITE("Max Row Sum =\n%g \n", Sum.maxCoeff())
	
	A_Inverse_Row_Sum_Norm = Sum.maxCoeff()
	
	A_Condition_Number = A_Row_Sum_Norm * A_Inverse_Row_Sum_Norm
	
	WRITE("A matrix Condition Number =\n%g \n", A_Condition_Number)

END FUNCTION

COMPONENT	Test2_EIGEN_Execution

INIT
Test2_EIGEN()

END COMPONENT