/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Using_Methods
 CREATION DATE: 06/07/2017
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code

FUNCTION NO_TYPE Using_Methods_2()

DECLS
INTEGER Row, Col

OBJECTS
	EigenMatrix A
	EigenMatrix B

BODY

	A.resize(5, 5)
	A.setFromStr("1,2,3,4,5;6,7,8,9,10;11,12,13,28,15;16,17,18,19,20;21,22,23,24,25")
	
	A.getMinCoeffRef(Row, Col)
	
	WRITE("A Matrix =\n%s \n", A.asString())
	WRITE("Minimum coefficient Row,Col =\n%i,%i \n", Row,Col)
	
	A.getMaxCoeffRef(Row, Col)
	
	WRITE("Maximum coefficient Row,Col =\n%i,%i \n", Row,Col)	

	B = A.diagonal(0)
	WRITE("B = A.diagonal(0)=\n%s \n", B.asString())
	
	B = A.diagonal(+1)
	WRITE("B = A.diagonal(+1)=\n%s \n", B.asString())

	B = A.diagonal(-1)
	WRITE("B = A.diagonal(-1)=\n%s \n", B.asString())
	
END FUNCTION
	
COMPONENT	Using_Methods_2_Execution

INIT
Using_Methods_2()

END COMPONENT