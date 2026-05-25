/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: SetMethods_Tests
 CREATION DATE: 14/07/2017
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code

FUNCTION NO_TYPE SetMethods_Tests()

DECLS

OBJECTS
	EigenMatrix A
	EigenMatrix B
	EigenMatrix C

	
BODY
	WRITE("A Set From B using setCols(1,3,B) method=\n%s \n", A.asString())
	
	A.setFromStr("1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25")
	
	WRITE("A Set From String =\n%s \n", A.asString())
	
	C.resize(1,5)					
	C.setFromStr("0,0,0,0,0")
	
	WRITE("C =\n%s \n", C.asString())
	
	A.setRow(1,C)
	
	WRITE("A Set Row 1 From C =\n%s \n", A.asString())
	
	-- setCol Method
	
	A.setFromStr("1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25")
	
	WRITE("A Set From String =\n%s \n", A.asString())
	
	C.resize(5,1)					
	C.setFromStr("0;0;0;0;0")
	
	WRITE("C =\n%s \n", C.asString())
	
	A.setCol(2,C)
	
	WRITE("A Set Col 2 From C =\n%s \n", A.asString())
	
	-- setRows Method
	
	A.resize(5,5)
	B.resize(3,5) 
	
	A.setFromStr("1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25")
	
	WRITE("A Set From String =\n%s \n", A.asString())
	WRITE("B =\n%s \n", B.asString())
	
	A.setRows(1,3,B) 
	
	WRITE("A Set From B using setRows(1,3,B) method=\n%s \n", A.asString())

	-- setCols Method
	
	A.setFromStr("1,2,3,4,5;6,7,8,9,10;11,12,13,14,15;16,17,18,19,20;21,22,23,24,25")
	
	WRITE("A Set From String =\n%s \n", A.asString())
	
	B.resize(5,3) 
	
	WRITE("B =\n%s \n", B.asString())
	
	A.setCols(1,3,B) 
	
	WRITE("A Set From B using setCols(1,3,B) method=\n%s \n", A.asString())
	
END FUNCTION


COMPONENT	SetMethods_Execution
INIT
SetMethods_Tests()

END COMPONENT
