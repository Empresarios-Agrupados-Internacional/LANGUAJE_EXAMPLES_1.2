/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN_TESTS
 FILE: Functions
 CREATION DATE: 15/06/2017
-----------------------------------------------------------------------------------------*/


-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code


-- define new user matrices types with predefined dimensions
-- Remember, if dimension is -1, it means is dynamic size

TYPEDEF CLASS EigenTypeMatrix_A 	IS_A EigenMatrixRoot<-1,-1>
TYPEDEF CLASS EigenTypeMatrix_B 	IS_A EigenMatrixRoot<3,4>
TYPEDEF CLASS EigenType_Vector 	IS_A EigenVectorRoot<30>
TYPEDEF CLASS EigenMatrix_1_8 IS_A EigenMatrixRoot<1,8>
TYPEDEF CLASS EigenMatrix_2_8 IS_A EigenMatrixRoot<2,8>
TYPEDEF CLASS EigenMatrix_8_1 IS_A EigenMatrixRoot<8,1>
TYPEDEF CLASS EigenMatrix_8_2 IS_A EigenMatrixRoot<8,2>
TYPEDEF CLASS EigenRowVector_15 IS_A EigenRowVectorRoot<15>


FUNCTION NO_TYPE t_basicOperations()
DECLS
	REAL z= 2
	STRING p4St
OBJECTS
	EigenMatrix p0, p1, p2, p3
	EigenMatrix s0, s1, s2, s3, s4, s5, s6, s7
	EigenVector2 v1
BODY
        WRITE("\n*******************\nFUNCTION: t_basicOperations()\n")

	p1.resize(2, 2)
	p1.set(1, 1, 9)
	p1.set(2, 1, 7)
	p1.set(1, 2, 87)
	p1.set(2, 2, 56)

	p2.resize(2, 2)
	p2.set(1, 1, 10)
	p2.set(2, 1, 3)
	p2.set(1, 2, 37)
	p2.set(2, 2, 6)

	p3.resize(2, 2)
	p3.set(1, 1, 4)
	p3.set(2, 1, 8)
	p3.set(1, 2, 7)
	p3.set(2, 2, 2)
	
	v1.set(1,3)
	v1.set(2,4)

	s1 = p1 + p2 - p3
	s2 = p1 * p2
	s3 = p1 * 2
	s4 = p1 / 2
	s5 = p1.transpose() * z
	s6 = (p3 - (p2*p1) / 3) * (s3+p1*8)
	s6= ((p3 - (p2*p1) / 3) * (s3+p1*8))
	s7= p1 * v1
	
	p4St = s1.asString()
	WRITE("p1=\n%s \n", p1.asString())
	WRITE("p2=\n%s\n",p2.asString())
	WRITE("p3=\n%s\n",p3.asString())
	WRITE("v1=\n%s\n",v1.asString())
	WRITE("s1 (p1+p2-p3)=\n%s\n", s1.asString())
	WRITE("s2 (p1*p2)=\n%s\n",s2.asString())
	WRITE("s3 (p1*2)=\n%s\n",s3.asString())
	WRITE("s4 (p1/2)=\n%s\n",s4.asString())
	WRITE("s5 (p1.transpose()*2)=\n%s\n",s5.asString())
	WRITE("s6 ((p3 - (p2*p1) / 3) * (s3+p1*8))=\n%s\n",s6.asString())
	WRITE("s7 (p1 * v1)=\n%s\n",s7.asString())
END FUNCTION

FUNCTION NO_TYPE t_basicOperations2()
DECLS
	REAL z= 2
	STRING p4St
OBJECTS
	EigenMatrix a
	EigenMatrix2 b
	EigenVector3 v
	EigenMatrix s1,s2,s3,s4,s5,s6
BODY
    WRITE("\n*******************\nFUNCTION: t_basicOperations2()\n")

	a.resize(2, 2)
	a.set(1, 1, 1)
	a.set(2, 1, 2)
	a.set(1, 2, 3)
	a.set(2, 2, 4)
	WRITE("a=\n%s \n",a.asString())

	b.set(1, 1, 1)
	b.set(2, 1, 2)
	b.set(1, 2, 3)
	b.set(2, 2, 4)
	WRITE("b=\n%s \n", b.asString())
	
	v.set(1,1)
	v.set(2,2)
	v.set(3,3)
	WRITE("v=\n%s \n", v.asString())
	
	s1= a + b
	s2= a - b
	s3= a * b
	s4= a * 2.5
	s5= 0.1 * v
	s6= 0.1 * b * 2
	v= v * 2
	a = a + b
  
	WRITE("s1 (a+b)=\n%s \n", s1.asString())
	WRITE("s2 (a-b)=\n%s \n", s2.asString())
	WRITE("s3 (a*b)=\n%s \n", s3.asString())
	WRITE("s4 (a * 2.5)=\n%s \n", s4.asString())
	WRITE("s5 (0.1 * v)=\n%s \n", s5.asString())
	WRITE("s6 (0.1 * b * 2)=\n%s \n", s6.asString())
	WRITE("a = a + b=\n%s \n", a.asString())
	WRITE("v = v * 2=\n%s \n", v.asString())
	  
END FUNCTION

FUNCTION NO_TYPE t_transpose()
OBJECTS
	EigenMatrix p0
	EigenMatrix s1, s2,s3
BODY
	WRITE("\n*******************\nFUNCTION: t_transpose()\n")

	p0.resize(3, 2)
	p0.set(1, 1, -0.211)
	p0.set(2, 1, 0.68)
	p0.set(3, 1, -36)
	p0.set(1, 2, 0.597)
	p0.set(2, 2, 0.566)
	p0.set(3, 2, 9.35)
	WRITE("p0 original=\n%s\n",p0.asString() )
	
	s1 = p0.transpose()
	s2= p0.transpose() * p0
	s3= 4 * p0.transpose() * p0
	WRITE("s1 as transposed from p0=\n%s\n",s1.asString() )
	WRITE("s2 (p0.transpose() * p0)=\n%s\n",s2.asString() )
	WRITE("s3 a(4 * p0.transpose() * p0)=\n%s\n",s3.asString() )
	p0.transposeInPlace()
	WRITE("p0 transposeInPlace=\n%s\n",p0.asString() )
END FUNCTION


FUNCTION NO_TYPE t_adjoint()
DECLS
	REAL z= 5.5
OBJECTS
	EigenMatrix p0, p1
	EigenMatrix s1, s2, s3
BODY
	WRITE("\n*******************\nFUNCTION: t_adjoint()\n")
	p0.resize(3, 3)
	p0.set(1, 1, 1)
	p0.set(1, 2, 2)
	p0.set(1, 3, 3)
	p0.set(2, 1, 0)
	p0.set(2, 2, 4)
	p0.set(2, 3, 5)
	p0.set(3, 1, 1)
	p0.set(3, 2, 0)
	p0.set(3, 3, 6)
	WRITE("p0 original=\n%s\n",p0.asString() )

	s1 = p0.adjoint()
	s2 = p0 + (p0.adjoint() * p0) / ( 0.3 - z)
	s3 = (p0.adjoint() * s2.adjoint()) / 0.45
	WRITE("s1 as adjoint of p0=\n%s\n",s1.asString() )	
	WRITE("s2(p0 + (p0.adjoint() * p0)) =\n%s\n",s2.asString() )
	WRITE("s3((p0.adjoint() * s2.adjoint()) / 0.45) =\n%s\n",s3.asString() )
	
	p0.adjointInPlace()
	WRITE("p0 adjointInPlace=\n%s\n",p0.asString() )
END FUNCTION


FUNCTION NO_TYPE t_doubleFuns()
DECLS
	INTEGER x, y
	REAL minc, maxc
OBJECTS
	EigenMatrix p1
	EigenVector4 v1
	EigenRowVector4 rv1
BODY
        WRITE("\n*******************\nFUNCTION: t_prodsum()\n")
	p1.resize(2, 2)
	p1.set(1, 1, 9)
	p1.set(2, 1, 7)
	p1.set(1, 2, 87)
	p1.set(2, 2, 56)
	WRITE("p1=\n%s\n" , p1.asString()) 
   WRITE("p1 rows: %d columns: %d\n" , p1.rows(), p1.cols()) 
	WRITE("size= %d\n",p1.size())
	WRITE("sum= %g\n",p1.sum())
	WRITE("prod= %g\n",p1.prod())
	WRITE("minCoeff= %g\n" ,p1.minCoeff())
	WRITE("maxCoeff= %g\n" ,p1.maxCoeff())
	WRITE("trace= %g\n" , p1.trace())
	WRITE("norm= %g\n",p1.norm())
	WRITE("squaredNorm= %g\n",p1.squaredNorm())
	WRITE("determinant= %g\n",p1.determinant())
	minc = p1.getMinCoeffRef(x, y)
	WRITE("minCoeff= %g %d %d\n",minc,x,y)
	maxc = p1.getMaxCoeffRef(x, y)
	WRITE("maxCoeff= %g %d %d\n",maxc,x,y)
	
	v1.set(1,1)
	v1.set(2,4)
	v1.set(3,8)
	v1.set(4,12)
	WRITE("v1=\n%s\n" , v1.asString())  
    WRITE("v1 rows: %d columns: %d\n" , v1.rows(), v1.cols()) 
	WRITE("size= %d\n",v1.size())
	WRITE("sum= %g\n",v1.sum())
	WRITE("prod= %g\n",v1.prod())
	WRITE("minCoeff= %g\n" ,v1.minCoeff())
	WRITE("maxCoeff= %g\n" ,v1.maxCoeff())
	WRITE("trace= %g\n" , v1.trace())
	WRITE("norm= %g\n",v1.norm())
	WRITE("squaredNorm= %g\n",v1.squaredNorm())
	minc = v1.getMinCoeffRef(x)
	WRITE("minCoeff= %g %d\n",minc,x)
	maxc = v1.getMaxCoeffRef(x)
	WRITE("maxCoeff= %g %d\n",maxc,x)
	
	rv1.set(1,1)
	rv1.set(2,4)
	rv1.set(3,8)
	rv1.set(4,12)
	WRITE("rv1=\n%s\n" , rv1.asString())  
    WRITE("rv1 rows: %d columns: %d\n" , rv1.rows(), rv1.cols()) 
	WRITE("size= %d\n",rv1.size())
	WRITE("sum= %g\n",rv1.sum())
	WRITE("prod= %g\n",rv1.prod())
	WRITE("minCoeff= %g\n" ,rv1.minCoeff())
	WRITE("maxCoeff= %g\n" ,rv1.maxCoeff())
	WRITE("trace= %g\n" , rv1.trace())
	WRITE("norm= %g\n",rv1.norm())
	WRITE("squaredNorm= %g\n",rv1.squaredNorm())
	minc = rv1.getMinCoeffRef(x)
	WRITE("minCoeff= %g %d\n",minc,x)
	maxc = rv1.getMaxCoeffRef(x)
	WRITE("maxCoeff= %g %d\n",maxc,x)
END FUNCTION


FUNCTION NO_TYPE t_chunk()
OBJECTS
	EigenMatrix p0, s1, p1, p2, p3
	EigenVector4 v1
	EigenRowVector er1
BODY
    WRITE("\n*******************\nFUNCTION: t_chunk()\n")
	p0.resize(3, 3)
	p0.set(1, 1, 1)
	p0.set(1, 2, 2)
	p0.set(1, 3, 3)
	p0.set(2, 1, 0)
	p0.set(2, 2, 4)
	p0.set(2, 3, 5)
	p0.set(3, 1, 1)
	p0.set(3, 2, 4)
	p0.set(3, 3, 6)

	WRITE("p0=\n%s\n",p0.asString())
	s1 = p0.chunk(1, 1, 2, 2)
	WRITE("p0.chunk(1, 1, 2, 2)=\n%s\n",s1.asString())
	s1 = p0.chunk(1, 1, 3, 2)
	WRITE("p0.chunk(1, 1, 3, 2)=\n%s\n",s1.asString())
	s1 = p0.chunk(1, 2, 2, 1)
	WRITE("p0.chunk(1, 2, 2, 1)=\n%s\n",s1.asString())
	s1 = p0.chunk(1, 1, 3, 3)
	WRITE("p0.chunk(1, 1, 3, 3)=\n%s\n",s1.asString())
	
	p1.resize(2, 2)
	p1.set(1, 1, 6)
	p1.set(1, 2, 7)
	p1.set(2, 1, 2)
	p1.set(2, 2, 9)
	WRITE("p1=\n%s\n",p1.asString())
	p2 = p1 + p0.chunk(2, 2, 2, 2)
	WRITE("p1 + p0.chunk(2, 2, 2, 2)=\n%s\n\n", p2.asString())
	p3 = p1 * p0.chunk(2, 2, 2, 2)
	WRITE("p1 * p0.chunk(2, 2, 2, 2)=\n%s\n\n", p3.asString())
	p3 = p1 + (p1 * p0.chunk(2, 2, 2, 2) / 2)
	WRITE("p1 + (p1 * p0.chunk(2, 2, 2, 2) / 2)=\n%s\n\n", p3.asString())
	
	v1.set(1,33)
	v1.set(2,4)
	v1.set(3,-35.5)
	v1.set(4,6)
	s1 = v1.chunk(2, 2)
	WRITE("v1=\n%s\n",v1.asString())
	WRITE("v1.chunk(2, 2)=\n%s\n\n", s1.asString())
	
	er1.resize(5)
	er1.set(1,5.3)
	er1.set(2,34)
	er1.set(3,-1.34)
	er1.set(4,4)
	er1.set(5,2)
	s1 = er1.chunk(3, 3)
	WRITE("er1=\n%s\n",er1.asString())
	WRITE("er1.chunk(3, 3)=\n%s\n\n", s1.asString())
END FUNCTION

FUNCTION NO_TYPE t_rowCol()
OBJECTS
	EigenMatrix p0, p1, s1
BODY
     WRITE("\n*******************\nFUNCTION: t_rowCol()\n")
	p0.resize(3, 3)
	p0.set(1, 1, 1)
	p0.set(1, 2, 2)
	p0.set(1, 3, 3)
	p0.set(2, 1, 0)
	p0.set(2, 2, 4)
	p0.set(2, 3, 5)
	p0.set(3, 1, 8)
	p0.set(3, 2, 0)
	p0.set(3, 3, 6)

	p1.resize(3, 1)
	p1.set(1, 1, 5)
	p1.set(2, 1, 2)
	p1.set(3, 1, 6)
	
	WRITE("p0=\n%s\n",p0.asString())
	WRITE("p1=\n%s\n",p1.asString())
	s1 = p0.getRow(2)
	WRITE("p0.getRow(2)=\n%s\n",s1.asString())
	s1 = p0.getCol(3)
	WRITE("p0.getCol(3)=\n%s\n",s1.asString())
	s1 = p0.getRow(3)
	WRITE("p0.getRow(3)=\n%s\n",s1.asString())

	s1= p0.getRow(2) * p0.getCol(1)
	WRITE("p0.getRow(2) * p0.getCol(1)=\n%s\n",s1.asString())
	s1= p0.getRow(2) * p1
	WRITE("p0.getRow(2) * p1=\n%s\n",s1.asString())
	s1= p0 * p0.getCol(3)
	WRITE("p0 * p0.getRow(3)=\n%s\n",s1.asString())
	s1= p0 * p0.diagonal()
	WRITE("p1 * p0.diagonal()=\n%s\n",s1.asString())
	s1= 3 * p0.getCol(1)
	WRITE("3 * p0.getCol(1)=\n%s\n",s1.asString())
END FUNCTION

FUNCTION NO_TYPE t_solve()
OBJECTS
	EigenMatrix A, b, solution
	EigenHandler eh
BODY
    WRITE("\n*******************\nFUNCTION: t_solve()\n")
	A.setFromStr(" 1, 2, 3;   \
	               4, 5, 6;   \
				      7, 8, 10")
	b.setFromStr(" 3; 3; 4")

	WRITE("A=\n%s\n",A.asString())
	WRITE("b=\n%s\n",b.asString())
	WRITE("Correct solution Ax=b:   \n[-2]\n[ 1]\n[ 1]\n")
	eh.solve(A, b, solution)
	WRITE("solution is:\n%s\n",solution.asString())
END FUNCTION



FUNCTION NO_TYPE t_eigenValues()
OBJECTS
	EigenMatrix A, eigValuesReal, eigValuesImag, eigVectorsReal, eigVectorsImag
	EigenHandler eh
BODY
    WRITE("\n*******************\nFUNCTION: t_eigen()\n")
	A.resize(2, 2)
	A.set(1, 1, 1)
	A.set(1, 2, 2)
	A.set(2, 1, 2)
	A.set(2, 2, 3)
	WRITE("A=\n%s\n",A.asString())
	eh.eigenvalues(A,eigValuesReal, eigValuesImag)
	WRITE("The eigenvalues of A are= \n%s\n",eh.complexAsString(eigValuesReal,eigValuesImag))
	eh.eigenvectors(A,eigVectorsReal, eigVectorsImag)
	WRITE("The eigenvectors of A are=\n%s\n",eh.complexAsString(eigVectorsReal,eigVectorsImag))
END FUNCTION


FUNCTION NO_TYPE t_determinant()
OBJECTS
	EigenMatrix A, x
BODY
    WRITE("\n*******************\nFUNCTION: t_determinant()\n")
	A.resize(3, 3)
	A.set(1, 1, 1)
	A.set(1, 2, 2)
	A.set(1, 3, 1)
	A.set(2, 1, 2)
	A.set(2, 2, 1)
	A.set(2, 3, 0)
	A.set(3, 1,-1)
	A.set(3, 2, 1)
	A.set(3, 3, 2)

	WRITE("A=\n%s\n",A.asString())
	WRITE("The determinant of A is= \n%g\n",A.determinant())
	x= A.inverse()
	WRITE("The inverse of A is\nSolution:\n[-0.667      1  0.333]\n[1.33 -1 -0.667]\n[-1      1      1]\nCalculated:\n%s\n", x.asString(3))
END FUNCTION


FUNCTION NO_TYPE t_matrixInit()
OBJECTS
	EigenMatrix A,B,C,D,E,F,G,H
BODY
    WRITE("\n*******************\nFUNCTION: t_setOnes()\n")
	A.resizeInit(3,3,8)
	B.resize(2,4)
	B.setConstantRow(2,9)
	B.setConstantCol(3,5)
	C.resizeInit(2,2,0)
	C.setConstant(4)
	D.resizeInit(2,3,0)
	D.setConstant(2)
	E.resize(3,3)
	E.setIdentity()
	F.resizeInit(6,6,0)
	F.setLinearSpacedRow(1,-100,+100)
	F.setLinearSpacedRow(3,0,10)
	F.setLinearSpacedCol(3,50,60)
	G.resize(3,3)
	G.setFromStr("1, 2, 5.6e-03;   \
				     5, -4.00020E-004, 5;  \
				     7.000008, 8, 9    ")
	H.resize(3,3)
	H.setFromStr(" 1 , 2,  3; \
	               4 , 5, 6; \
				      7 , 8, 9 ")
	
	WRITE("A=\n%s\n",A.asString())
	WRITE("B=\n%s\n",B.asString())
	WRITE("C=\n%s\n",C.asString())
	WRITE("D=\n%s\n",D.asString())
	WRITE("E=\n%s\n",E.asString())
   WRITE("F=\n%s\n",F.asString())
	WRITE("G=\n%s\n",G.asString(10))
	WRITE("H=\n%s\n",H.asString(10))
END FUNCTION

FUNCTION NO_TYPE t_matrixDiagonalIdentity()
DECLS
OBJECTS
	EigenMatrix a,b,c
BODY
    WRITE("\n*******************\nFUNCTION: t_matrixDiagonalIdentity()\n")
	
	a.resize(3,3)
	a.setFromStr("9,4,8;2,7,27;78,12,90")
	WRITE("a= \n%s\n",a.asString())
	
	b= a.diagonal()
	WRITE("a(diagonal 0)= \n%s\n",b.asString())
	
	b= a.diagonal(+1)
	WRITE("a (diagonal +1)= \n%s\n",b.asString())
	
	b= a.diagonal(-1)
	WRITE("a (diagonal -1)= \n%s\n",b.asString())
	
	a.setIdentity()
	WRITE("a (identity)= \n%s\n",a.asString())
END FUNCTION

FUNCTION NO_TYPE t_changeMatrixFixed()
DECLS	
	REAL relative_error
OBJECTS
	EigenMatrix a, b, c,d, f,g,h,j
BODY
    WRITE("\n*******************\nFUNCTION: t_changeMatrixFixed()\n")
	a.resizeInit(8,8,1)
	b.resize(2,2)
	b.setFromStr("6,7;8,9") 
	c.resizeInit(2,8,6)
	d.resizeInit(8,2,7)
	f.resizeInit(2,8,8)

	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	WRITE("c=\n%s\n",c.asString())
	WRITE("d=\n%s\n",d.asString())
	WRITE("f=\n%s\n",f.asString())
	a.setChunk(2,2,2,2,b)
	WRITE("a after setChunk(2,2,2,2,b) =\n%s\n",a.asString())
	a.setRows(5,2,c)
	WRITE("a after setRows(5,2,c) =\n%s\n",a.asString())
	a.setCols(6,2,d)
	WRITE("a after setCols(6,2,d) =\n%s\n",a.asString())
	a.setCols(2,2,f)
	WRITE("a after setCols(2,2,f) =\n%s\n",a.asString())
	a.setConstant(9)
	g.resizeInit(8,1,2)
	h.resizeInit(1,8,3)
	j.resizeInit(8,1,4)
	a.setRow(2,g)
	a.setCol(4,h)
	a.setCol(6,j)
	WRITE("g=\n%s\n",g.asString())
	WRITE("h=\n%s\n",h.asString())
	WRITE("j=\n%s\n",j.asString())
	WRITE("a after setRow(2,g), setCol(4,h), setCol(6,j) =\n%s\n",a.asString())
END FUNCTION



FUNCTION NO_TYPE t_changeMatrixVariable()
DECLS	
	REAL relative_error
OBJECTS
	EigenMatrix8 a
	EigenMatrix2 b
	EigenMatrix_1_8 h
	EigenMatrix_2_8 c, f
	EigenMatrix_8_1 g,j
	EigenMatrix_8_2 d
BODY
    WRITE("\n*******************\nFUNCTION: t_changeMatrixVariable()\n")
	a.setConstant(1)
	b.setFromStr("6,7;8,9")  
	c.setConstant(6)			
	d.setConstant(7)
	f.setConstant(8)
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	WRITE("c=\n%s\n",c.asString())
	WRITE("d=\n%s\n",d.asString())
	WRITE("f=\n%s\n",f.asString())
	a.setChunk(2,4,2,2,b)
	WRITE("a after setChunk(2,4,2,2,b) =\n%s\n",a.asString())
	a.setRows(5,2,c)
	WRITE("a after setRows(5,2,c) =\n%s\n",a.asString())
	a.setCols(6,2,d)
	WRITE("a after setCols(6,2,d) =\n%s\n",a.asString())
	a.setCols(2,2,f)
	WRITE("a after setCols(2,2,f) =\n%s\n",a.asString())
	a.setConstant(9)
	WRITE("a after setConstant(9) =\n%s\n",a.asString())
	g.setConstant(2)
	h.setConstant(3)
	j.setConstant(4)
	
	WRITE("g=\n%s\n",g.asString())
	WRITE("h=\n%s\n",h.asString())
	WRITE("j=\n%s\n",j.asString())
	
	a.setRow(2,g)
	WRITE("a after setRow(2,g) =\n%s\n",a.asString())
	a.setCol(4,h)
	WRITE("a after setCol(4,h) =\n%s\n",a.asString())
	a.setCol(6,j)
	WRITE("a after setCol(6,j) =\n%s\n",a.asString())
	
END FUNCTION


FUNCTION NO_TYPE t_initMatrixArray()
DECLS	
	REAL vinit1[4]= {6,7,8,9}
	REAL vinit2[8]= {82, 1e-3, 0.2, 1.647437, 4.5, -2.2, 5.2, 3333333 }
OBJECTS
	EigenMatrix a, b, c, d, e
	EigenMatrix2 x, y, z, t,u
	EigenVector v1,v2,v3,v4,v5
	EigenRowVector w1,w2,w3,w4,w5
	EigenVector4 t1,t2,t3,t4
BODY
    WRITE("\n*******************\nFUNCTION: t_changeMatrixFixed()\n")
	a.resizeInit(4,4,1)
	b.resize(2,2)
	b.setFromArray2D(vinit1,2,2,1,1,-1,-1)
	c.resize(2,8)
	c.setFromStr("4,4,4,4,4,4,4,4,4,4,4,4,4,4,5,6")
	d.resize(4,2)
	d.setFromArray2D(vinit2,4,2,1,1,-1,-1)
	e.resize(2,2)
	e.setFromStr("-0.04e-003, 4.34 ,16 ,0.00054")
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	WRITE("c=\n%s\n",c.asString())
	WRITE("d=\n%s\n",d.asString())
	WRITE("e=\n%s\n",e.asString())
	
	x.setConstant(9)
	y.setConstant(5)
	y.setLinearSpacedRow(2,0,10)
	-- z.resize(1,4) --This does not work since the this static matrix cannot be resized
	-- z.setFromStr("5,6,7,8") -- No way
	z.setFromStr("5,6;7,8") --Ok it is 2x2 the correct dimension

	u.setConstant(0)
	u.setLinearSpacedCol(1,-10,4)
	WRITE("x=\n%s\n",x.asString())
	WRITE("y=\n%s\n",y.asString())
	WRITE("z=\n%s\n",z.asString())
	WRITE("t=\n%s\n",t.asString())
	WRITE("u=\n%s\n",u.asString())
	
	v1.resize(4)
	v1.setConstant(5)
	v2.resize(4)
	v2.setFromStr("4.34; 6.4; 4.23; 34.34")
	v3.resize(8)
	v3.setFromArray1D(vinit2,8,1,-1)
    v4.resize(5)
	v4.setLinearSpaced(0,10)
	v5.resizeInit(5,6)
	WRITE("v1=\n%s\n",v1.asString())
	WRITE("v2=\n%s\n",v2.asString())
	WRITE("v3=\n%s\n",v3.asString())
	WRITE("v4=\n%s\n",v4.asString())
	WRITE("v5=\n%s\n",v5.asString())	
	
	w1.resize(4)
	w1.setConstant(5)
	w2.resize(4)
	w2.setFromStr("4.34, 6.4, 4.23, 34.34")
	w3.resize(8)
	w3.setFromArray1D(vinit2,8,1,4) 
   w4.resize(5)							
	w4.setLinearSpaced(0,10)
	w5.resizeInit(5,6)
	WRITE("w1=\n%s\n",w1.asString())
	WRITE("w2=\n%s\n",w2.asString())
	WRITE("w3=\n%s\n",w3.asString())
	WRITE("w4=\n%s\n",w4.asString())
	WRITE("w5=\n%s\n",w5.asString())
	
	t1.setConstant(5)
	t2.setFromStr("4.34, 6.4, 4.23, 34.34")
	t3.setFromArray1D(vinit1,4,1,-1)
	t4.setLinearSpaced(0,10)
	WRITE("t1=\n%s\n",t1.asString())
	WRITE("t2=\n%s\n",t2.asString())
	WRITE("t3=\n%s\n",t3.asString())
	WRITE("t4=\n%s\n",t4.asString())
END FUNCTION

FUNCTION NO_TYPE t_changeVectorFixed()
DECLS	
	REAL relative_error
	REAL n[4]= { 1,2,3,4}
OBJECTS
	EigenVector a, b, c
	EigenRowVector d,g,h
BODY
   WRITE("\n*******************\nFUNCTION: t_changeVectorFixed()\n")
	a.resizeInit(8,1)
	b.resizeInit(2,2)
	b.setFromStr("6;7")
	c.resizeInit(2,4)
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	WRITE("c=\n%s\n",c.asString())
	a.setChunk(2,2,b)
	a.setChunk(5,2,c)
	WRITE("a.setChunk(2,2,b) & a.setChunk(5,2,c) =\n%s\n",a.asString())
	
	d.resizeInit(10,1)
	WRITE("d.resizeInit(10,1)=\n%s\n",d.asString())
	g.resizeInit(3,2)
	h.resizeInit(4,3)
	d.setChunk(2,3,g)
	d.setChunk(7,4,h)
	WRITE("g=\n%s\n",g.asString())
	WRITE("h=\n%s\n",h.asString())
	WRITE("d.setChunk(2,3,g) & d.setChunk(7,4,h) =\n%s\n",d.asString())
END FUNCTION



FUNCTION NO_TYPE t_changeVectorVariable()
DECLS	
	REAL vinit1[4]= { 1,2,3,4}
OBJECTS
	EigenRowVector_15 a,c
	EigenVector4 b,d
BODY
    WRITE("\n*******************\nFUNCTION: t_changeVectorVariable()\n")
	a.setConstant(1)
	b.setFromStr("6;7;8;9")
	c.setConstant(6)
   d.setFromArray1D(vinit1,4,1,-1)
	WRITE("a=\n%s\n",a.asString())
	WRITE("b=\n%s\n",b.asString())
	WRITE("c=\n%s\n",c.asString())
	WRITE("d=\n%s\n",d.asString())
	WRITE("a.setChunk(3,4,b)=\n%s\n",a.asString())
	a.copy(c)
	WRITE("a.copy(c)=\n%s\n",a.asString())
END FUNCTION

COMPONENT MatrixMultipleOperations
INIT
	t_basicOperations()
	t_basicOperations2()
	t_transpose()
	t_adjoint()
	t_doubleFuns()
	t_chunk()
	t_rowCol()
	t_solve()
	t_eigenValues()	
	t_determinant()
	t_matrixDiagonalIdentity() 
	t_changeMatrixFixed()		
	t_changeMatrixVariable()
	t_matrixInit()
	t_initMatrixArray()
	t_changeVectorFixed()
	t_changeVectorVariable()
END COMPONENT
