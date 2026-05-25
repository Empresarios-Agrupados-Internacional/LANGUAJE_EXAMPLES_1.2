/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Using_Methods
 CREATION DATE: 06/07/2017
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code

FUNCTION NO_TYPE Using_Methods()
DECLS

	REAL	A_Determinant
	REAL	A_as_Matrix [3,3]
	REAL	A_33
	INTEGER row,column
	REAL   maxCoef, minCoef
OBJECTS
	EigenMatrix A
	EigenMatrix A_inv
	EigenMatrix B	
	
BODY


	A.resize(5, 5)
	
	WRITE("A Rows = %i \n", A.rows())
	WRITE("A Cols= %i \n", A.cols())
	WRITE("A size= %i \n", A.size())
	
	A.setRandom()
	
	WRITE("A Random=\n%s \n", A.asString())
	
	A.setRandom()
	
	WRITE("A Random second time=\n%s \n", A.asString())
	
	A.setConstant(3)
	
	WRITE("A.setConstant(3) =\n%s \n", A.asString())
	
	A.setFromStr("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25")
	
	WRITE("A Set From String in one dimension row=\n%s \n", A.asString())
	
	A.setFromStr("1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25")
	
	WRITE("A Set From String in two dimensions row=\n%s \n", A.asString())	
	
	B= A		
		
	WRITE("B Set copied From A =\n%s \n", B.asString())
	
	WRITE("Addition of A elements = %g \n", A.sum())
	
	WRITE("Product of B elements = %g \n", B.prod())
	
	WRITE("Minimun value of A = %g \n", A.minCoeff())
	
	WRITE("Maximum value of B = %g \n", B.maxCoeff())
	
	WRITE("Trace of B = %g \n", B.trace())
	
	WRITE("Norm of B = %g \n", B.norm())
	
	WRITE("Squared norm of B = %g \n", B.squaredNorm())
	-- Cambio el tamaño para ver si el método adjoint redimensiona B.
	
	B = A.adjoint()	
	
	WRITE("B as adjoint of A =\n%s \n", B.asString())
	

	-- EigenMatrixRoot methods
	
	A.set(1,1,0)
	A.set(5,5,0)
	A.get(3,3, A_33)
	
	WRITE("A (after making 0 first and last element) =\n%s \n", A.asString())
	WRITE("A(2,2) using at() method = %g \n", A.at(2,2))
	WRITE("A(3,3) using get()method = %g \n", A_33)
	
	A_inv = A.inverse()  
	
	WRITE(" A.inverse() =\n%s \n", A_inv.asString())
	
	WRITE("A.determinant() = %g\n", A.determinant()) 
	
	A.resize(6,6) 
	
	WRITE("A.resize(6,6) =\n%s \n", A.asString())
	
	A.resizeInit(3,3,1)
	
	WRITE("A.resizeInit(3,3,1)=\n%s \n", A.asString())
		
	A.setIdentity()
	
	WRITE("A.setIdentity()=\n%s \n", A.asString())
	
	A.setRandom()
	
	WRITE("A.setRandom()=\n%s \n", A.asString())
	
	A.transposeInPlace()
	
	WRITE("A.transposeInPlace() =\n%s \n", A.asString())
	
	A.transposeInPlace()
	
	WRITE("A.transposeInPlace() again  =\n%s \n", A.asString())
	
	B = A.transpose()
	
	WRITE("B as  A.transpose()=\n%s \n", B.asString())	
	
	A.adjointInPlace()
	
	WRITE("A.adjointInPlace() =\n%s \n", A.asString())
	
	B = A.getRow(2) 
	
	WRITE("B= A.getRow(2)  =\n%s \n", B.asString())
	
	B = A.getCol(2) 
	
	WRITE("B=A.getCol(2)  =\n%s \n", B.asString())
	
	A.setRow(1,B)
	
	WRITE("A.setRow(1,B) =\n%s \n", A.asString())
	
	A.setCol(1,B)
	
	WRITE("A.setCol(1,B) =\n%s \n", A.asString())
	
	A.setRandom()
	
	WRITE("A.setRandom()  =\n%s \n", A.asString())
	
	B = A.getRows(2,1)
	
	WRITE("B= A.getRows(2,1)  =\n%s \n", B.asString())
	
	B = A.getCols(1,2)
	
	WRITE("B= A.getCols(1,2) =\n%s \n", B.asString())
	
	A.resize(3,3)
	
	A.setIdentity()
	
	WRITE("A as identity =\n%s \n", A.asString())
	
	A.setRandom()
	
	WRITE("A.setRandom() =\n%s \n", A.asString())
	
	minCoef= A.getMinCoeffRef(row,column)
	WRITE("A.getMincoeffRef=\n%g at position [%d,%d] \n", minCoef,row,column)
	
	maxCoef= A.getMaxCoeffRef(row,column)
	WRITE("A.getMaxcoeffRef=\n%g at position [%d,%d] \n", maxCoef,row,column)
	
END FUNCTION
	
COMPONENT	Using_Methods_Execution

INIT
	Using_Methods()

END COMPONENT