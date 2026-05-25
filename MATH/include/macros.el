//----------------------------------------------------------------------------
// Macros calculate the i-th component of the arithmetic operation performed
// The EXPAND statement is done in the CONTINUOUS block of the component
// Certain macros need an output matrix/vector which is expanded in the macro
//----------------------------------------------------------------------------

USE MATH

/*----------------------------------------------------------------------
Sum of two vectors
----------------------------------------------------------------------*/

-- Macro to sum the i-th components of two vectors, V1[i] + V2[i]:
#define VADD_i( V1, V2, i ) \
   ( V1[i] + V2[i] )
   
-- Macro to sum of two vectors, V3[N] = V1[N] + V2[N], without indexing:
#define VADD( N, V1, V2, V3 ) \
	EXPAND (i IN 1,N) \
		V3[i] = ( V1[i] + V2[i] )

-- Macro to sum two vectors, V3[N] = V1[N] + V2[N], without indexing:
#define VADD_en( enu_var, V1, V2, V3 ) \
	EXPAND (i IN enu_var) \
		V3[i] = ( V1[i] + V2[i] )

/*----------------------------------------------------------------------
Sum of two matrices
----------------------------------------------------------------------*/

-- Macro to sum the i,j-th components of two matrices, M1[i,j] + M2[i,j]:
#define MADD_ij( M1, M2, i, j) \
   ( M1[i,j] + M2[i,j] )
   
-- Macro to sum two matrices, M3[r,c] = M1[r,c] + M2[r,c]:
#define MADD( r, c, M1, M2, M3 ) \
	EXPAND (i IN 1,r) \
		EXPAND (j IN 1,c) \
			M3[i,j] = MADD_ij( M1, M2, i, j)
   
/*----------------------------------------------------------------------
Product of a vector and a scalar
----------------------------------------------------------------------*/

-- Macro to multiply the i-th component of a vector by a scalar, k*V1[i]:
#define VSMUL_i( k, V1, i ) \
   ( k * V1[i] ) 
   
-- Macro to multiply a vector by a scalar, V2[N] = k*V1[N]:
#define VSMUL( N, k, V1, V2 ) \
	EXPAND (i IN 1, N) \
		V2[i] = VSMUL_i( k, V1, i )

/*----------------------------------------------------------------------
Product of a matrix and a scalar
----------------------------------------------------------------------*/

-- Macro to multiply the i,j-th component of a matrix by a scalar, k*M1[i,j]:
#define MSMUL_ij( k, M1, i, j ) \
   ( k * M1[i,j] )
   
-- Macro to multiply a matrix by a scalar, M2[r,c] = k*M1[r,c]:
#define MSMUL( r, c, k, M1, M2 ) \
	EXPAND (i IN 1,r) \
		EXPAND (j IN 1,c) \
			M2[i,j] = MSMUL_ij( k, M1, i, j )

/*----------------------------------------------------------------------
Scalar product of two vectors
----------------------------------------------------------------------*/

-- Macro to calculate the scalar product of two vectors, V1[N]·V2[N]:
#define DOT( N, V1, V2 ) \
   (SUM(i IN 1,N;  V1[i] * V2[i] ))

-- Macro to calculate the scalar product of two vectors, V1[enu_var]·V2[enu_var]:
#define DOT_en( enu_var, V1, V2 ) \
   (SUM(i IN enu_var;  V1[i] * V2[i] ))

/*----------------------------------------------------------------------
Cross product of two vectors
----------------------------------------------------------------------*/

-- Macro to calculate the component i of the cross product V1[3]xV2[3]:
#define CROSS_i( V1, V2, i) \
   (V1[remainder(i+1,3,FALSE)] * V2[remainder(i+2,3,FALSE)] \
   - V1[remainder(i+2,3,FALSE)] * V2[remainder(i+1,3,FALSE)])
   
-- Macro that returns the i-th component (enu_var) of V3[3] = V1[3] x V2[3]:
#define CROSS_en_i( enu_var, V1, V2, i) \
   (V1[setofElem(enu_var,remainder(i+1,3,FALSE))] * V2[setofElem(enu_var,remainder(i+2,3,FALSE))] \
   - V1[setofElem(enu_var,remainder(i+2,3,FALSE))] * V2[setofElem(enu_var,remainder(i+1,3,FALSE))])
     
-- Macro to calculate the cross product between two vectors, V3[3]=V1[3]xV2[3]:
#define CROSS( V1, V2, V3) \
   EXPAND (i IN 1,3) \
      V3[i] = CROSS_i(V1, V2, remainder(i,3,FALSE))

-- Macro to calculate the cross product between two vectors, V3[enu_var]=V1[enu_var]xV2[enu_var]:
#define CROSS_en( enu_var, V1, V2, V3 ) \
   EXPAND (i IN 1,3) \
      V3[setofElem(enu_var,i)] = CROSS_en_i( enu_var, V1, V2, i)

/*----------------------------------------------------------------------
Triple product of three vectors
----------------------------------------------------------------------*/

-- Macro to calculate the i-th component of the vector triple product, V1x(V2xV3):
#define CROSS3_i( V1, V2, V3, i) \
		( V2[i] * DOT(V1,V3,3) - V3[i]*m_dot(V1,V2,3) )
		
-- Macro to calculate the vector triple product, V1x(V2xV3):
#define CROSS3( V1, V2, V3, V4) \
	EXPAND (i IN 1,3) \
		V4[i] = CROSS3_i( V1, V2, V3, i)

-- Macro to calculate the i-th component of the vector triple product, (V1xV2)xV3:
#define CROSS3B_i( V1, V2, V3, i ) \
		( V2[i] * DOT(V1,V3,3) - V1[i]*m_dot(V2,V3,3) )

-- Macro to calculate the vector triple product, (V1xV2)xV3:
#define CROSS3B( V1, V2, V3, V4) \
	EXPAND (i IN 1,3) \
		V4[i] = CROSS3B_i( V1, V2, V3, i )


/*----------------------------------------------------------------------
Product between a matrix and a vector
----------------------------------------------------------------------*/

-- Macro to calculate the i-th component of M1[-,c]·V1[c]:
#define MV_i( c, M1, V1, i) \
   (SUM(j IN 1,c;  M1[i,j]*V1[j] ))

-- Enum version:
#define MV_en_i( enu_var, M1, V1, i ) \
   (SUM(j IN enu_var;  M1[i,j]*V1[j] ))

-- Macro to calculate M1[r,c]·V1[c]:
#define MV( r, c, M1, V1, V2 ) \
	EXPAND (i IN 1,r) \
		V2[i] = MV_i( c, M1, V1, i )

-- Enum version:
#define MV_en( enu_var, M1, V1, V2 ) \
   EXPAND (i IN enu_var) \
		V2[i] = MV_en_i( enu_var, M1, V1, i )

/*----------------------------------------------------------------------
Product between two matrices
----------------------------------------------------------------------*/

-- Macro to calculate the i,j-th component of M1[-,c]·M2[c,-]:
#define MMUL_ij( c, M1, M2, i, j ) \
	(SUM(k IN 1,c;  M1[i,k]*M2[k,j] ))

-- Enum version:
#define MMUL_en_ij( enu_var, M1, M2, i, j ) \
	(SUM(k IN enu_var;  M1[i,k]*M2[k,j] ))

-- Macro to calculate M3[r,c] = M1[r,n]·M2[n,c]:
#define MMUL( r, n, c, M1, M2, M3) \
	EXPAND ( i IN 1, r) \
		EXPAND (j IN 1,c) \
			M3[i,j] = mm_ij( n, M1, M2, i, j)

-- Enum version:
#define MMUL_en( enu_var, M1, M2, M3) \
	EXPAND ( i IN enu_var) \
		EXPAND (j IN enu_var) \
			M3[i,j] = mm_ij_en( enu_var, M1, M2, i, j)

/*----------------------------------------------------------------------
Product between two tensors (components)
----------------------------------------------------------------------*/

-- Macro to calculate the i,j,k-th component of the product between two tensors, M1[-,-,N]·M2[-,N,-], for fixed x:
-- N: third dim of M1 and second dim of M2
#define TT_x_ijk( N, M1, M2, i, j, k ) \
   (SUM(l IN 1,N;  M1[i,j,l]*M2[i,l,k] ))

-- Macro to calculate the i,j,k-th component of the product between two tensors, M1[-,-,N]·M2[N,-,-], for fixed y:
-- N: third dim of M1 and first dim of M2
#define TT_y_ijk( N, M1, M2, i, j, k ) \
   (SUM(l IN 1,N;  M1[i,j,l]*M2[l,j,k] ))

-- Macro to calculate the i,j,k-th component of the product between two tensors, M1[-,N,-]·M2[N,-,-], for fixed z:
-- N: second dim of M1 and first dim of M2
#define TT_z_ijk( N, M1, M2, i, j, k ) \
   (SUM(l IN 1,N;  M1[i,l,k]*M2[l,j,k] ))

--Enum versions

-- Macro to calculate the i,j,k-th component of the product between two tensors, M1·M2, for fixed x:
#define TT_x_en_ijk( enu_var, M1, M2, i, j, k) \
   (SUM(l IN enu_var;  M1[i,j,l]*M2[i,l,k] ))

-- Macro to calculate the i,j,k-th component of the product between two tensors, M1·M2, for fixed y:
#define TT_y_en_ijk( enu_var, M1, M2, i, j, k) \
   (SUM(l IN enu_var;  M1[i,j,l]*M2[l,j,k] ))

-- Macro to calculate the i,j,k-th component of the product between two tensors, M1·M2, for fixed z:
#define TT_z_en_ijk( enu_var, M1, M2, i, j, k) \
   (SUM(l IN enu_var;  M1[i,l,k]*M2[l,j,k] ))

/*----------------------------------------------------------------------
Product between two tensors (tensors)
----------------------------------------------------------------------*/

-- Macro to calculate the product between two tensors, M3[N1,N2,N3] = M1[N1,N2,N]·M2[N1,N,N3], for fixed x:
-- N1, N2, N3 : dimensions of M3
-- N1: first dim of M1 and M2
-- N2: second dim of M1
-- N3: third dim of M2
-- N: third dim of M1 and second dim of M2
#define TT_x( N, M1, M2, M3 ) \
   EXPAND (i IN 1,N) \
      EXPAND (j IN 1,N) \
         EXPAND (k IN 1,N) \
            M3[i,j,k] = TT_x_ijk( N, M1, M2, i, j, k )

-- Macro to calculate the product between two tensors, M3[N1,N2,N3] = M1[N1,N2,N]·M2[N,N2,N3], for fixed y:
-- N1, N2, N3 : dimensions of M3
-- N1: first dim of M1
-- N2: second dim of M1 and M2
-- N3: third dim of M2
-- N: third dim of M1 and first dim of M2
#define TT_y( M1, M2, M3 ) \
   EXPAND (i IN 1,N) \
      EXPAND (j IN 1,N) \
         EXPAND (k IN 1,N) \
            M3[i,j,k] = TT_y_ijk( N, M1, M2, i, j, k )

-- Macro to calculate the product between two tensors, M3[N1,N2,N3] = M1[N1,N,N3]·M2[N,N2,N3], for fixed z:
-- N1, N2, N3 : dimensions of M3
-- N1: first dim of M1
-- N2: second dim of M2
-- N3: third dim of M1 and M2
-- N: second dim of M1 and first dim of M2
#define TT_z( M1, M2, M3 ) \
   EXPAND (i IN 1,N) \
      EXPAND (j IN 1,N) \
         EXPAND (k IN 1,N) \
            M3[i,j,k] = TT_z_ijk( N, M1, M2, i, j, k )

-- Enum versions

-- Macro to calculate the product between two tensors, M1·M2, for fixed x:
#define TT_x_en( enu_var, M1, M2, M3) \
   EXPAND (i IN enu_var) \
      EXPAND (j IN enu_var) \
         EXPAND (k IN enu_var) \
            M3[i,j,k] = TT_x_en_ijk( enu_var, M1, M2, i, j, k)

-- Macro to calculate the product between two tensors, M1·M2, for fixed y:
#define TT_y_en( enu_var, M1, M2, M3) \
   EXPAND (i IN enu_var) \
      EXPAND (j IN enu_var) \
         EXPAND (k IN enu_var) \
            M3[i,j,k] = TT_y_en_ijk( enu_var, M1, M2, i, j, k)

-- Macro to calculate the product between two tensors, M1·M2, for fixed z:
#define TT_z_en( enu_var, M1, M2, M3) \
   EXPAND (i IN enu_var) \
      EXPAND (j IN enu_var) \
         EXPAND (k IN enu_var) \
            M3[i,j,k] = TT_z_en_ijk( enu_var, M1, M2, i, j, k)


/*----------------------------------------------------------------------
Diagonal matrices
----------------------------------------------------------------------*/

-- Macro to obtain the i-th component of Dia·V1:
#define DV_i( Dia, V1, i) \
   ( Dia[i,i] * V1[i] )

-- Macro to multiply a diagonal matrix by a vector, Dia·V1:
#define DV( N, Dia, V1, Dia2 ) \
   EXPAND (i IN 1,N) \
      EXPAND (j IN 1,N) \
         Dia2[i,j] = IF (i==j) DV_i( Dia, V1, i) ELSE 0

-- Macro to calculate the i-th component of the inverse of a diagonal matrix :
#define DINV_i( Dia, i ) \
   1 / Dia[i,i]

-- Macro to calculate the inverse of a diagonal matrix (as a matrix):
#define DINV( N, Dia, Inv ) \
   EXPAND  (i IN 1,N) \
      EXPAND (j IN 1,N) \
         Inv[i,j] = IF ((i == j) AND Dia[i,i] != 0)  DINV_i( Dia, i ) ELSEIF (i == j) Inf ELSE 0
      

/*----------------------------------------------------------------------
Norm of a vector
----------------------------------------------------------------------*/

-- Macro to calculate the norm of a vector, ||V1||:
#define NORM( N, V1 ) \
   ( SUM(i IN 1,N;  V1[i]*V1[i])**0.5 )

#define NORM_en( enu_var, V1 ) \
   ( SUM(i IN enu_var;  V1[i]*V1[i])**0.5 )

/*----------------------------------------------------------------------
Skew matrices
----------------------------------------------------------------------*/

-- Macro that returns one skew symmetric matrix from one vector:
#define SKEW( V, M) \
   EXPAND (i IN 1,3) \
      M[i,i] = 0 \
   M[1,2] = -V[3] \
   M[1,3] = V[2] \
   M[2,1] = V[3] \
   M[2,3] = -V[1] \
   M[3,1] = -V[2] \
   M[3,2] = V[1]

-- Enum version:
#define SKEW_en( enu_var, V, M) \
   EXPAND (i IN enu_var) \
      M[i,i] = 0 \
   M[setofElem(enu_var,1),setofElem(enu_var,2)] = -V[setofElem(enu_var,3)] \
   M[setofElem(enu_var,1),setofElem(enu_var,3)] = V[setofElem(enu_var,2)] \
   M[setofElem(enu_var,2),setofElem(enu_var,1)] = V[setofElem(enu_var,3)] \
   M[setofElem(enu_var,2),setofElem(enu_var,3)] = -V[setofElem(enu_var,1)] \
   M[setofElem(enu_var,3),setofElem(enu_var,1)] = -V[setofElem(enu_var,2)] \
   M[setofElem(enu_var,3),setofElem(enu_var,2)] = V[setofElem(enu_var,1)]

/*----------------------------------------------------------------------
Determinant of a matrix
----------------------------------------------------------------------*/

-- Macro to calculate the determinant of a matrix of size 3x3, det(M1):
#define DET( M1 ) \
   (M1[1,1]*M1[2,2]*M1[3,3] + M1[1,2]*M1[2,3]*M1[3,1] + M1[2,1]*M1[3,2]*M1[1,3] \
   - M1[3,1]*M1[2,2]*M1[1,3] - M1[3,2]*M1[2,3]*M1[1,1] - M1[2,1]*M1[1,2]*M1[3,3])

-- Enum version:
#define DET_en( enu_var, M1 ) \
   (M1[setofElem(enu_var,1),setofElem(enu_var,1)]*M1[setofElem(enu_var,2),setofElem(enu_var,2)]*M1[setofElem(enu_var,3),setofElem(enu_var,3)] \
   + M1[setofElem(enu_var,1),setofElem(enu_var,2)]*M1[setofElem(enu_var,2),setofElem(enu_var,3)]*M1[setofElem(enu_var,3),setofElem(enu_var,1)] \
   + M1[setofElem(enu_var,2),setofElem(enu_var,1)]*M1[setofElem(enu_var,3),setofElem(enu_var,2)]*M1[setofElem(enu_var,1),setofElem(enu_var,3)] \
   - M1[setofElem(enu_var,3),setofElem(enu_var,1)]*M1[setofElem(enu_var,2),setofElem(enu_var,2)]*M1[setofElem(enu_var,1),setofElem(enu_var,3)] \
   - M1[setofElem(enu_var,3),setofElem(enu_var,2)]*M1[setofElem(enu_var,2),setofElem(enu_var,3)]*M1[setofElem(enu_var,1),setofElem(enu_var,1)] \
   - M1[setofElem(enu_var,2),setofElem(enu_var,1)]*M1[setofElem(enu_var,1),setofElem(enu_var,2)]*M1[setofElem(enu_var,3),setofElem(enu_var,3)])

/*----------------------------------------------------------------------
Inverse of a matrix
----------------------------------------------------------------------*/

-- Macro that returns the inverse of a matrix, Mat·Inv=I:
#define MINV( Mat, Inv ) \
      Inv[1,1] =  (Mat[2,2]*Mat[3,3] - Mat[2,3]*Mat[3,2]) / DET(Mat) &\
      Inv[1,2] = -(Mat[1,2]*Mat[3,3] - Mat[1,3]*Mat[3,2]) / DET(Mat) &\
      Inv[1,3] =  (Mat[1,2]*Mat[2,3] - Mat[1,3]*Mat[2,2]) / DET(Mat) &\
      Inv[2,1] = -(Mat[2,1]*Mat[3,3] - Mat[2,3]*Mat[3,1]) / DET(Mat) &\
      Inv[2,2] =  (Mat[1,1]*Mat[3,3] - Mat[1,3]*Mat[3,1]) / DET(Mat) &\
      Inv[2,3] = -(Mat[1,1]*Mat[2,3] - Mat[1,3]*Mat[2,1]) / DET(Mat) &\
      Inv[3,1] =  (Mat[2,1]*Mat[3,2] - Mat[2,2]*Mat[3,1]) / DET(Mat) &\
      Inv[3,2] = -(Mat[1,1]*Mat[3,2] - Mat[1,2]*Mat[3,1]) / DET(Mat) &\
      Inv[3,3] =  (Mat[1,1]*Mat[2,2] - Mat[1,2]*Mat[2,1]) / DET(Mat)

-- Enum version:
#define MINV_en( enu_var, Mat, Inv ) \
      Inv[setofElem(enu_var,1),setofElem(enu_var,1)] =  (Mat[setofElem(enu_var,2),setofElem(enu_var,2)]*Mat[setofElem(enu_var,3),setofElem(enu_var,3)] \
      - Mat[setofElem(enu_var,2),setofElem(enu_var,3)]*Mat[setofElem(enu_var,3),setofElem(enu_var,2)]) /  &\
      Inv[setofElem(enu_var,1),setofElem(enu_var,2)] = -(Mat[setofElem(enu_var,1),setofElem(enu_var,2)]*Mat[setofElem(enu_var,3),setofElem(enu_var,3)] \
      - Mat[setofElem(enu_var,1),setofElem(enu_var,3)]*Mat[setofElem(enu_var,3),setofElem(enu_var,2)]) / DET_en(enu_var,Mat) &\
      Inv[setofElem(enu_var,1),setofElem(enu_var,3)] =  (Mat[setofElem(enu_var,1),setofElem(enu_var,2)]*Mat[setofElem(enu_var,2),setofElem(enu_var,3)] \
      - Mat[setofElem(enu_var,1),setofElem(enu_var,3)]*Mat[setofElem(enu_var,2),setofElem(enu_var,2)]) / DET_en(enu_var,Mat) &\
      Inv[setofElem(enu_var,2),setofElem(enu_var,1)] = -(Mat[setofElem(enu_var,2),setofElem(enu_var,1)]*Mat[setofElem(enu_var,3),setofElem(enu_var,3)] \
      - Mat[setofElem(enu_var,2),setofElem(enu_var,3)]*Mat[setofElem(enu_var,3),setofElem(enu_var,1)]) / DET_en(enu_var,Mat) &\
      Inv[setofElem(enu_var,2),setofElem(enu_var,2)] =  (Mat[setofElem(enu_var,1),setofElem(enu_var,1)]*Mat[setofElem(enu_var,3),setofElem(enu_var,3)] \
      - Mat[setofElem(enu_var,1),setofElem(enu_var,3)]*Mat[setofElem(enu_var,3),setofElem(enu_var,1)]) / DET_en(enu_var,Mat) &\
      Inv[setofElem(enu_var,2),setofElem(enu_var,3)] = -(Mat[setofElem(enu_var,1),setofElem(enu_var,1)]*Mat[setofElem(enu_var,2),setofElem(enu_var,3)] \
      - Mat[setofElem(enu_var,1),setofElem(enu_var,3)]*Mat[setofElem(enu_var,2),setofElem(enu_var,1)]) / DET_en(enu_var,Mat) &\
      Inv[setofElem(enu_var,3),setofElem(enu_var,1)] =  (Mat[setofElem(enu_var,2),setofElem(enu_var,1)]*Mat[setofElem(enu_var,3),setofElem(enu_var,2)] \
      - Mat[setofElem(enu_var,2),setofElem(enu_var,2)]*Mat[setofElem(enu_var,3),setofElem(enu_var,1)]) / DET_en(enu_var,Mat) &\
      Inv[setofElem(enu_var,3),setofElem(enu_var,2)] = -(Mat[setofElem(enu_var,1),setofElem(enu_var,1)]*Mat[setofElem(enu_var,3),setofElem(enu_var,2)] \
      - Mat[setofElem(enu_var,1),setofElem(enu_var,2)]*Mat[setofElem(enu_var,3),setofElem(enu_var,1)]) / DET_en(enu_var,Mat) &\
      Inv[setofElem(enu_var,3),setofElem(enu_var,3)] =  (Mat[setofElem(enu_var,1),setofElem(enu_var,1)]*Mat[setofElem(enu_var,2),setofElem(enu_var,2)] \
      - Mat[setofElem(enu_var,1),setofElem(enu_var,2)]*Mat[setofElem(enu_var,2),setofElem(enu_var,1)]) / DET_en(enu_var,Mat)