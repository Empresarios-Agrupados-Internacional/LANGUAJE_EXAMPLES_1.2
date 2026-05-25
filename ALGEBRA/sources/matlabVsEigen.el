/*-----------------------------------------------------------------------------------------
 LIBRARY: ALGEBRA
 FILE: matlabVsEigen
 CONTENTS: Difference in the nomenclature between EL Eigen matrices classes and Matlab
 CREATION DATE: 13/12/2017
-----------------------------------------------------------------------------------------*/

/***********************************************************
	
================================      ==========================================
	EigenMatrix/EigenVector            MATLAB
================================      ==========================================


RESIZING	 
m.resize(3,4)  matrices               m= [4;4]
v.resize(3)  vectors	                 v= [4;1]

OBTAINING INFO	 
m.size()	                             length(m)
m.rows()	                             size(m,1)
m.cols()	                             size(m,2)
m.trace()	                          trace(m)
m.sum()	                             sum(m(:))
m.prod()	                             prod(m(:))
m.minCoeff()	                       min(m(:))
m.maxCoeff()	                       max(m(:))
m.getMinCoeffRef(nrow,ncol)	        [s,i]=min(m(:));[r,c]=ind2sub(size(m),i);
m.getMaxCoeffRef(nrow,ncol)	        [s,i]=max(m(:));[r,c]=ind2sub(size(m),i);
m.norm()	                             norm(m).
m.squaredNorm()	                    dot(m,m)

BASIC ACCESS	 
m.at(nrow,ncol)                       m(nrow,ncol)
m.get(nrow,ncol,value) 	              value= m(nrow,ncol)

PRINTING	 
m.asString(ndigits)	                 disp(m)

INITIALISATIONS	 
m.set(nrow,ncol,value) matrices	     m(nrow,ncol)= value
v.set(nrow,value) column vector	     v(nrow) = value
vr.set(ncol,value) row vector	        vr(ncol) = value
m.setFromStr("1,2,3,4; 6,32,34,48")	  m= [1,2,3,4 ; 6,32,34,48]
m.setFromArray2D(v,nrows,ncols)    	  m= [1,2,3,4 ; 6,32,34,48]
m.resizeInit(nrows,ncols,0)  	        m= zeros(nrows,ncols)
m. resizeInit (nrows,ncols,1)   	     m= ones(nrows,ncols)
m.resize(nrows,ncols) & m.setRandom() m= rand(nrows,ncols)
v.setLinearSpaced(from,to)	           linspace(from,to,size)
m.setIdentity()	                    m= eye(4,4)

ACCESSING BY PARTS	 
m.chunk(row,col,nrows,ncols)	        m(row:row+nrows, col:col+ncols)
m.getRow(nrow)	                       m(nrow,:)
m.getCol(nrow)	                       m(:,nrow)
m.getRows(row,nrows)	                 m(row:nrows,:)
m.getCols(col,ncols)	                 m(:,col:ncols)
m.setRow(nrow,p.getCol(ncol))	        m(nrow,:) =p(:,ncol)
m.setCol(ncol,p.getRow(nrow))	        m(:,ncol) = p(nrow ,:)
m.setRows(nrow,rows,p)	              m(nrow:nrows , :)= p
m.setCols(ncol,cols,p)	              m(:,ncol:cols) = p
m.setChunk(nrow,ncol,rows,cols,p)	  m(nrow:rows,:) = p
m.diagonal()	                       diag(m)

TRANSFORMATIONS	 
m.adjoint()	                          m'
m.adjointInPlace()	                 m= m'
m.transpose()	                       m.' or conj(m')
m.transposeInPlace()	                 m= m.'
m.determinant()	                    det(m)
m.inverse()	                          inv(m)

ARITHMETIC	 
r= m * p	                             r= m * p
r= m + p	                             r= m + p
r= m - p	                             r= m - p
r= m / 5.6	                          r= m / 5.6
r += m                                

EIGENVALUES & EIGENVECTORS	 
eh.eigenvalues(m,vr,vi)               e= eig(m)
eh.eigenvectors(m,vr,vi)	           [V,D] = eig(m)

SOLVER FOR LINEAR SYSTEMS	 
eh.solve(A,B,solution)	              solution = linsolve(A,B)


*/