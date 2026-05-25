/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: GetMethods_Tests
 CREATION DATE: 14/07/2017
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code


FUNCTION NO_TYPE GetMethods_Tests()

DECLS

OBJECTS
	EigenMatrix A
	EigenMatrix B

	
BODY

	-- getRow Method
	
	A.setFromStr("1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25")
	
	WRITE("A Set From String =\n%s \n", A.asString())
	
	
	B = A.getRow(3)	
	
	WRITE("B = A.getRow(3)=\n%s \n", B.asString())
	
	-- getCol Method
	
	A.setFromStr("1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25")
	
	WRITE("A Set From String =\n%s \n", A.asString())
	
	B = A.getCol(3)	
	
	WRITE("B = A.getCol(3)=\n%s \n", B.asString())

	B = A.getRows(1,5)	

	WRITE("B = A.getRows(1,5) =\n%s \n", B.asString())

	-- getCols Method

	B.resize(5,3)
	
	WRITE("B.resize(5,3) =\n%s \n", B.asString())
	
	B = A.getCols(1,3)
	
	WRITE("B = A.getCols(1,3)=\n%s \n", B.asString())
	

	
END FUNCTION



COMPONENT	GetMethods_Execution
INIT
GetMethods_Tests()

END COMPONENT