/*-----------------------------------------------------------------------------------------
 LIBRARY: ALGEBRA
 FILE: BookExamples
 DESCRIPTION: This file contains the Manual examples of the Eigen classes for linear algebra
 NOTE: It is very important to activate the flag for optimisation of the generated code  when
       using the Eigen classes (goto Edit->Options->Simulation->Optimize generated object code
		 The performance simulation time can be improved a lot with this flag activated.
 CREATION DATE: 05/12/2017
-----------------------------------------------------------------------------------------*/


-- Define some particular vectors with given dimensions

TYPEDEF CLASS MyRowVector IS_A EigenRowVectorRoot<5>
TYPEDEF CLASS MyColVector IS_A EigenVectorRoot<5>


-- Examples of using matrices and vectors from the EL Modelling Language Book

FUNCTION	NO_TYPE testInitial()  "test initialisation of matrices from EL arrays and addition of two matrices"
DECLS
	REAL aInit[2,3]= {{1,4,1},{2,2,2}}
	REAL bInit[2,3]= {{4,6,8},{2,5,2}}
OBJECTS
	EigenMatrix A, B, Result
BODY   
	A.setFromArray2D(aInit,2,3)
	B.setFromArray2D(bInit,2,3)
	Result = A + B	
	WRITE("A=\n%s \n", A.asString())
	WRITE("B=\n%s \n", B.asString())
	WRITE("Result= A + B =\n%s \n", Result.asString())	
END FUNCTION


FUNCTION NO_TYPE testSet()  "test initialisation of matrices with set() method"
DECLS
	REAL value
OBJECTS
	EigenMatrix     m
	EigenVector3    vc
	EigenRowVector2    vr
BODY
	m.resize(2,2)
	m.set(1,1,9)
	m.set(1,2,3)
	m.set(2,1,5)
	m.set(2,2,8)
	vc.set(1,6.4)
	vc.set(2,8.23e-3)
	vc.set(3,73)
	vr.resize(2)
	vr.set(1,0.02)
	vr.set(2,-6.7)
	WRITE("m=\n%s\n",m.asString())
	WRITE("vc=\n%s\n",vc.asString())
	WRITE("vr=\n%s\n",vr.asString())
	WRITE("m[2,2]= %g\n",m.at(2,2))
	IF ( vc.get(5,value) == TRUE ) THEN
	    WRITE("vc[5]= %g\n",value)
	ELSE
		WRITE("vc[5] is out-of-limits\n")
	END IF 
END FUNCTION 


FUNCTION NO_TYPE testCopyFromArray2D() "test initialisation of matrices from EL arrays and copy back to EL arrays"
DECLS
	REAL mat1[3,3] = {{1,2,3},{4,5,6},{7,8,9}}
	REAL mat2[3,3]
OBJECTS
	EigenMatrix a, b, c  -- dynamic matrix

BODY
	a.setFromArray2D(mat1,3,3)
	b.setFromArray2D(mat1,3,3,1,2,3,1)
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	a.copyToArray2D(mat2,3,3)
	FOR(i IN 1,3)
		FOR(j IN 1,3)
			WRITE("mat2[%d,%d]= %g\n",i,j,mat2[i,j])
		END FOR
	END FOR
END FUNCTION 

FUNCTION NO_TYPE testSetFromStr()  "test initialisation of matrices from  strings"
OBJECTS
	EigenMatrix a  -- dynamic matrix
	EigenMatrix2 b -- fixed 2x2 matrix
	EigenVector v  -- dynamic vector
BODY
	a.setFromStr("1,2,3;4,5,6;7,8,9")
	b.setFromStr("99,88;77,66")
	v.setFromStr("9;8;6;5")
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	WRITE("v=\n%s\n",v.asString())
END FUNCTION 

FUNCTION NO_TYPE testSetLinearSpace()  "test initialisation of rows/columns with gradual values"
OBJECTS
	EigenMatrix     a  
	EigenRowVector6     v
BODY
	a.resize(3,11)
	a.setLinearSpacedRow(1,0,100)
	a.setLinearSpacedCol(5,-1,1)
	v.setLinearSpaced(0,1)
	WRITE("a=\n%s\n",a.asString())
	WRITE("v=\n%s\n",v.asString())
END FUNCTION

FUNCTION NO_TYPE testSetRow() "test initialisation of complete rows"
OBJECTS
	EigenMatrix a, b, c,d
BODY
	a.resizeInit(4,4,1)
	b.resizeInit(2,4,6)
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	a.setRows(2,2,b)
	WRITE("a after a.setRows(2,2,b) =\n%s\n",a.asString())

	c.resizeInit(3,3,8)
	d.resizeInit(1,3,6)
	WRITE("c=\n%s\n",c.asString())
	WRITE("d=\n%s\n",d.asString())
	c.setCol(2,d)
	WRITE("c after d.resizeInit(1,3,6) =\n%s\n",c.asString())
END FUNCTION

FUNCTION NO_TYPE testGetRow() "test obtaining rows from a matrix"
OBJECTS
	EigenMatrix a, b, c,d
BODY
	a.setFromStr("1,2,3,4,5;6,7,8,9,10;11,12,13,14,15")
	b = a.getRows(2,2)
	c = a.getCol(4)
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	WRITE("c=\n%s\n",c.asString())
END FUNCTION

FUNCTION NO_TYPE testSetChunck() "test changing parts of a matrix with setChunk()"
OBJECTS
	EigenMatrix a, b, c
BODY
	a.resizeInit(5,5,0)
	b.resizeInit(2,2,8)
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	a.setChunk(3,3,2,2,b)
	WRITE("a after a.setChunk(3,3,2,2,b) =\n%s\n",a.asString())
	c= a.chunk(2,2,3,3)
	WRITE("c= a.chunk(2,2,3,3) =\n%s\n",c.asString())
END FUNCTION

FUNCTION NO_TYPE testCopy() "test copuing matrices"
OBJECTS
	EigenMatrix a
	EigenMatrix4 b, c
BODY
	a.resizeInit(4,4,7)
	b= a
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
END FUNCTION

FUNCTION NO_TYPE testSetConstRandom()  "test initialisation with random values"
OBJECTS
	EigenMatrix4 a
	EigenMatrix3 b
BODY
	a.setConstant(1)
	a.setConstantRow(2,8)
	a.setRandomRow(3)
	WRITE("a=\n%s\n",a.asString())
	b.setIdentity()
	WRITE("b as identity=\n%s\n",b.asString())
END FUNCTION

FUNCTION NO_TYPE testSetDiagonal() "test initialisation of matrix diagonal"
DECLS
	REAL v[4,4]= {{1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16}}
OBJECTS
	EigenMatrix a, b, c, d
	EigenVector4 z
	EigenVector3 t,r
BODY
	a.setFromArray2D(v,4,4)
	b= a.diagonal()
	c= a.diagonal(-1)
	d= a.diagonal(+1)
	WRITE("a=\n%s\n",a.asString())
	WRITE("b as diagonal(0) of a=\n%s\n",b.asString())
	WRITE("c as diagonal(-1) of a=\n%s\n",c.asString())
	WRITE("d as diagonal(+1) of a=\n%s\n",d.asString())
	z.setFromStr("-1;-2;-3;-4")
	a.setDiagonal(0,z)
	t.setFromStr("97;98;99")
	a.setDiagonal(-1,t)
	r.setFromStr("44;45;46")
	a.setDiagonal(1,r)
	WRITE("a after a.setDiagonal(0,z),a.setDiagonal(-1,t),a.setDiagonal(1,r)=\n%s\n",a.asString())
END FUNCTION

FUNCTION NO_TYPE testGetInfo() "test for obtaining some information from the matrix"
DECLS
	INTEGER x, y
	REAL minc, maxc
	REAL ar1[4]= {1,4,8,12}
OBJECTS
	EigenMatrix p1
	EigenVector v1
	EigenRowVector4 rv1
BODY
	p1.setFromStr("9,7;87,56")
	WRITE("p1=\n%s\n" , p1.asString()) 
   WRITE("p1 rows: %d columns: %d\n" , p1.rows(), p1.cols()) 
	WRITE("size= %d\n",p1.size())
	WRITE("sum= %g\n",p1.sum())
	WRITE("prod= %g\n",p1.prod())
	WRITE("trace= %g\n" , p1.trace())
	WRITE("squaredNorm= %g\n",p1.squaredNorm())
	WRITE("norm= %g\n",p1.norm())
	minc = p1.getMinCoeffRef(x, y)
	WRITE("matrix p1, minCoeff= %g at coordinates [%d,%d]\n",minc,x,y)
	maxc = p1.getMaxCoeffRef(x, y)
	WRITE("matrix p1, maxCoeff= %g at coordinates [%d,%d]\n",maxc,x,y)
	
	v1.setFromArray1D(ar1,4)
	WRITE("v1=\n%s\n" , v1.asString())  
   WRITE("v1 rows: %d columns: %d\n" , v1.rows(), v1.cols()) 
	WRITE("size= %d\n",v1.size())
	WRITE("sum= %g\n",v1.sum())
	WRITE("prod= %g\n",v1.prod())
	WRITE("trace= %g\n" , v1.trace())
	WRITE("norm= %g\n",v1.norm())
	WRITE("squaredNorm= %g\n",v1.squaredNorm())
	minc = v1.getMinCoeffRef(x)
	WRITE("vector v1, minCoeff= %g at position %d\n",minc,x)
	maxc = v1.getMaxCoeffRef(x)
	WRITE("vector v1, maxCoeff= %g at position %d\n",maxc,x)
END FUNCTION

FUNCTION NO_TYPE testGetTransf()  "test for obtaining the inverse of a matrix and others"
DECLS
	REAL v1[3,3]= {{0,1,1},{1,0,0},{0,0,1}}
OBJECTS
	EigenMatrix p1,p1inv,p1ad,p1trans
BODY
	p1.setFromArray2D(v1,3,3)
	WRITE("p1=\n%s\n" , p1.asString())
	WRITE("p1.determinant()= %g\n" , p1.determinant())
	p1inv= p1.inverse()
	p1trans= p1.transpose()
	p1ad= p1.adjoint()
	WRITE("p1.inverse()=\n%s\n",p1inv.asString())
	WRITE("p1.transpose()=\n%s\n",p1trans.asString())
	WRITE("p1.adjoint()=\n%s\n",p1ad.asString())
	p1.transposeInPlace()  -- transform p1 itself from the transpose
	WRITE("p1 after p1.transposeInPlace()=\n%s\n",p1.asString())
END FUNCTION

FUNCTION	NO_TYPE testBasicAritmetic() "test arithmetics of matrices"
DECLS
	REAL aInit[2,3]= {{1,4,1},{2,2,2}}
	REAL bInit[2,3]= {{4,6,8},{2,5,2}}
	REAL vc1Init[3]= {3,2,9}
	REAL vr1Init[2]= {9,5}
	REAL innerProduct
OBJECTS
	EigenMatrix A, B, C, outProd
	EigenVector vc1,vc2
	EigenRowVector vr1,vr2
	MyRowVector vg
	MyColVector vc
BODY   
	A.setFromArray2D(aInit,2,3)
	B.setFromArray2D(bInit,2,3)
	vc1.setFromArray1D(vc1Init,3)
	vr1.setFromArray1D(vr1Init,2)
	WRITE("A=\n%s \n", A.asString())
	WRITE("B=\n%s \n", B.asString())
	WRITE("vc1=\n%s \n", vc1.asString())
	WRITE("vr1=\n%s \n", vr1.asString())
	C = A + B	
	A += (B * 5) - (C /4.5) + (4*A)
	vc2= B  * vc1
	vr2= vr1 * B
	innerProduct= vc2.adjoint() * vc2
	outProd= vc1 * vc1.transpose()
	WRITE("A += (B * 5) - (C /4.5) + (4*A)=\n%s \n", A.asString())
	WRITE("C= A + B =\n%s \n", C.asString())
	WRITE("vc2= B  * vc1=\n%s \n", vc2.asString())
	WRITE("vr2= vr1 * B=\n%s \n", vr2.asString())
	WRITE("innerProduct= vc2.adjoint() * vc2= %g\n", innerProduct)
	WRITE("outProd= vc1.transpose() * vc1=\n%s\n", outProd.asString())
	vr2= vc1.transpose()
	WRITE("outProd= vc1.transpose() * vc1=\n%s\n", vr2.asString())
END FUNCTION



FUNCTION NO_TYPE testSolve()  "test for solving linear system of equations"
DECLS	
	REAL relative_error
OBJECTS
	EigenMatrix A, sol
	EigenVector B
	EigenHandler eh
BODY
   
	A.setFromStr(" 4,5,-12;36,-8,3;-3,5,-2")
	B.setFromStr(" 98; 23; 45")
	WRITE("A=\n%s\n",A.asString())
	WRITE("B=\n%s\n",B.asString())
	eh.solve(A, B, sol)
	WRITE("Solution\n%s\n",sol.asString())
END FUNCTION

FUNCTION NO_TYPE testMatrixAsImag()  "test printing two matrices as complex matrix"
DECLS	
	STRING sol
OBJECTS
	EigenMatrix A, B
	EigenHandler eh
BODY
   
	A.setFromStr(" 12.2,5,212e-2;3.36,-8,3;0.002,5,-2e-4")
	B.setFromStr(" -51.2,345.15,23.12;41,-8.3,3.2;52.3,13,-2")
	WRITE("A=\n%s\n",A.asString())
	WRITE("B=\n%s\n",B.asString())
	sol= eh.complexAsString(A, B)
	WRITE("A + Bi=\n%s\n",sol)
END FUNCTION

FUNCTION NO_TYPE testEigenValues() "test for obtaining the complex eigenvalues and eigenvectors of a matrix"
DECLS
	REAL Ainitial[3,3]= {{-3,  0,  2},{ 1, -1,  0},{-2, -1,  0}}
	--REAL Ainitial[3,3]= {{1,-2, 1},{ 0,1, 4},{ 0,0,3}}
OBJECTS
	EigenMatrix A, var, vai,ver,vei
	EigenHandler eh
BODY
	A.setFromArray2D(Ainitial,3,3)
	WRITE("A=\n%s\n",A.asString())
	eh.eigenvalues(A,var,vai,FALSE)
	WRITE("Eigenvalues:\n%s\n",eh.complexAsString(var,vai))
	eh.eigenvectors(A,ver,vei)
	WRITE("Eigenvectors matrix:\n%s\n",eh.complexAsString(ver,vei))
END FUNCTION

FUNCTION NO_TYPE testEigenValues2() "test for obtaining the real eigenvalues and eigenvectors of a matrix"
DECLS
	REAL Ainitial[3,3]= {{1,-2, 1},{ 0,1, 4},{ 0,0,3}}
	BOOLEAN isComplex
OBJECTS
	EigenMatrix A, var, vai,ver,vei
	EigenHandler eh
BODY
	A.setFromArray2D(Ainitial,3,3)
	WRITE("A=\n%s\n",A.asString())
	eh.eigenvalues(A,var,vai,TRUE,isComplex)
	IF( isComplex == FALSE ) THEN
		WRITE("Eigenvalues are real:\n%s\n",eh.complexAsString(var,vai))
	ELSE
		WRITE("Eigenvalues are complex:\n%s\n",eh.complexAsString(var,vai))
	END IF
END FUNCTION



COMPONENT book_examples "top component calling function for testing the Eigen classes for linear algebra"
INIT
	testInitial()
	testSet()
	testCopyFromArray2D()
	testSetFromStr()
	testSetLinearSpace()
	testSetRow()
	testGetRow()
	testSetChunck()
	testCopy()
	testSetConstRandom()
	testSetDiagonal()
	testGetInfo()
	testGetTransf()
	testBasicAritmetic()
	testSolve()
	testMatrixAsImag()
	testEigenValues()
	testEigenValues2()
END COMPONENT