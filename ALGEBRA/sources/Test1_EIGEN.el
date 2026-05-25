/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Test1_EIGEN
 CREATION DATE: 27/06/2017
 --MATLAB book page 216
-----------------------------------------------------------------------------------------*/


-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code


FUNCTION NO_TYPE Test1_EIGEN()
DECLS
	STRING Matrix_as_String
	REAL	Array[9] = {8,6,9,-5,8,1,4,8,2}
	

OBJECTS
	EigenMatrix A
	EigenMatrix A_Inverse
	EigenMatrix Identity
	EigenMatrix B
	EigenMatrix A_Transpose
	EigenMatrix Product
	EigenMatrix C
	EigenMatrix D
	EigenMatrix P
	EigenMatrix PA
	EigenMatrix AP
	EigenVector	x
	EigenVector	y
	EigenVector	z
	
	
BODY
        WRITE("\n*******************\nFUNCTION: t_basicOperations()\n")

	A.resize(3, 3)
	
	A.set(1, 1, 1)
	A.set(2, 1, 7)
	A.set(3, 1, -3)
	
	A.set(1, 2, 5)
	A.set(2, 2, 4)
	A.set(3, 2, 6)
	
	A.set(1, 3, 6)
	A.set(2, 3, 2)
	A.set(3, 3, 7)
	
	
	WRITE("A=\n%s \n", A.asString())
	Matrix_as_String = A.asString()
	WRITE("Matrix_as_String=\n%s \n", Matrix_as_String)

	A_Transpose = A.transpose()
	
	WRITE("A_Transpose=\n%s \n", A_Transpose.asString())

	x.resize(3)
	y.resize(3)
	z.resize(3)
	
	
	B.setFromArray2D(Array,3,3,1,1,3,3)
	
	WRITE("B=\n%s \n", B.asString())
	
	C = A+B
	
	WRITE("C=\n%s \n", C.asString())
	
	A = C-B
	
	WRITE("A=\n%s \n", A.asString())
	
	Product = A*B
	
	WRITE("Product=\n%s \n", Product.asString())
	
	D.resize(2, 3)
	
	D.set(1, 1, 1)
	D.set(2, 1, 5)
	D.set(1, 2, 4)
	D.set(2, 2, 8)
	D.set(1, 3, 3)
	D.set(2, 3, 1)

	WRITE("D=\n%s \n", D.asString())
	
	--Product = A*D -- Error in dimensions for product
	WRITE("Error in Product A*D\n \n")
	Product = D*A
	
	WRITE("Product D*A=\n%s \n", Product.asString())
	
	A_Inverse = A.inverse()
	WRITE("A inverse=\n%s \n", A_Inverse.asString())
	
	Identity = A*A_Inverse
	WRITE("Identity as A * A_Inverse =\n%s \n", Identity.asString())
	
	Identity.setIdentity()
	WRITE("Identity as .setIdentity method =\n%s \n", Identity.asString())
	
	P.resize(3, 3)
	
	P.set(1, 1, 0)
	P.set(2, 1, 0)
	P.set(3, 1, 1)
	
	P.set(1, 2, 0)
	P.set(2, 2, 1)
	P.set(3, 2, 0)
	
	P.set(1, 3, 1)
	P.set(2, 3, 0)
	P.set(3, 3, 0)
	
		WRITE("Permutation matrix =\n%s \n", P.asString())

	PA = P*A
	WRITE("PA =\n%s \n", PA.asString())
	
	AP = A*P
	WRITE("AP =\n%s \n", AP.asString())
	
END FUNCTION

COMPONENT	Tests_EIGEN_Execution

INIT
Test1_EIGEN()

END COMPONENT