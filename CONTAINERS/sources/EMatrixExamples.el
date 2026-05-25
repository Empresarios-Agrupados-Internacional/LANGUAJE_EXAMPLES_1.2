/*-----------------------------------------------------------------------------------------
 LIBRARY: CONTAINERS
 FILE: EMatrixExamples
 CONTENTS: Examples of EMatrix classes
 CREATION DATE: 18/11/2017
-----------------------------------------------------------------------------------------*/
-- define a subclass of EMatrix
TYPEDEF CLASS MatrixFriendsBasic IS_A EMatrix<Friends>

-- define a subclass of MatrixFriendsBasic
CLASS MatrixFriends IS_A MatrixFriendsBasic
METHODS
	METHOD STRING asString() "return the object as a string"
	DECLS
		STRING st
	BODY	
	     FOR(i IN 1,rows())
		    FOR(j IN 1,cols())
				 WRITES(st,"%s [%s(%d)] ",st,at(i,j).getName(),at(i,j).getPhone())
			 END FOR
			 WRITES(st,"%s\n",st)
		  END FOR
		  RETURN st
	END METHOD
END CLASS

-- define basic class for storing matrices of colors
TYPEDEF CLASS MatrixColorsBasic   IS_A EMatrix<TM_colors>

-- define final class for storing matrices of colors with asString() method
CLASS MatrixColors IS_A MatrixColorsBasic
METHODS
	METHOD STRING asString() "return matrix of boolean as string"
	DECLS
		STRING st
	BODY	
	     FOR(i IN 1,rows())
			  FOR(j IN 1,cols())
		  	     WRITES(st,"%s %s",st,gvalEnum2("TM_colors",at(i,j)) )
			  END FOR
			  WRITES(st,"%s\n",st)
		  END FOR
		  RETURN st
	END METHOD
END CLASS

TYPEDEF CLASS MatrixVectorFriendsBasic   IS_A EMatrix<VectorFriends>

-- Define a final class for the matrix of vectors
CLASS MatrixVectorFriends IS_A MatrixVectorFriendsBasic
METHODS
	METHOD STRING asString() "return object as string"
	DECLS
		STRING st
	BODY	
	     FOR(i IN 1,rows())
			  FOR(j IN 1,cols())
		  	     WRITES(st,"%s {%s}",st,at(i,j).asString() )
			  END FOR
			  WRITES(st,"%s\n",st)
		  END FOR
		  RETURN st
	END METHOD
END CLASS



FUNCTION NO_TYPE testMatrixReal()
DECLS
	CONST INTEGER nrows=5
	CONST INTEGER ncols=4
OBJECTS
	EMatrixReal mr
BODY
	WRITE("\n\n***************testMatrixReal()\n")
   FOR(i IN 1,nrows)
	  FOR(j IN 1,ncols)
			mr.set(i,j,i*j) -- set values in the matrix mr
	  END FOR
	END FOR
	WRITE("mr= \n%s (rows=%d cols=%d size=%d)\n",mr.asString(),mr.rows(),mr.cols(),mr.size())
	
	mr.clear()    -- clear matrix
	mr.set(4,2,3) -- set new values
	mr.set(3,3,9)
	WRITE("mr= \n%s (rows=%d cols=%d size=%d)\n",mr.asString(),mr.rows(),mr.cols(),mr.size())
	
	mr.clear()    -- clear matrix
	mr.assign(6,4,3)  --dimension the matrix to rows=6, cols=4 and write 3 in all fields
	mr.replace(2,3,0) -- replace element at position (2,3)
	mr.set(4,4,8)     -- set element at position (4,4)
	WRITE("mr= \n%s (rows=%d cols=%d size=%d)\n",mr.asString(),mr.rows(),mr.cols(),mr.size())
	WRITE("m[4,4]= %g\n",mr.at(4,4))
END FUNCTION
	
	
FUNCTION NO_TYPE testMatrixMix()
DECLS
	CONST INTEGER nrows=5
	CONST INTEGER ncols=4
OBJECTS
	EMatrixString ms
	EMatrixBool mb
BODY
	WRITE("\n\n***************testMatrixMix()\n")
   ms.assign(3,3,"hello") -- create a matrix 3x3 and set "hello" on each field
	ms.replace(2,2,"world") -- replace position 2,2 with "world"
	WRITE("ms= \n%s (rows=%d cols=%d size=%d)\n",ms.asString(),ms.rows(),ms.cols(),ms.size())
	
	mb.set(4,2,TRUE)   -- Dimension the matrix to 4,2 and set last value
	mb.set(3,3,TRUE)
	WRITE("mb= \n%s (rows=%d cols=%d size=%d)\n",mb.asString(),mb.rows(),mb.cols(),mb.size())
END FUNCTION

	
FUNCTION NO_TYPE testMatrixFriends()
DECLS
	CONST INTEGER nrows=5
	CONST INTEGER ncols=4
OBJECTS
	MatrixFriends mf
	Friends f
BODY
	WRITE("\n\n***************testMatrixFriends()\n")
   f.setFriend("John",636732634) -- set a new friend
	mf.set(2,2,f)
	f.setFriend("Luik",925252495)-- set a new friend
	mf.set(3,3,f)
	WRITE("mf= \n%s (rows=%d cols=%d size=%d)\n",mf.asString(),mf.rows(),mf.cols(),mf.size())
END FUNCTION

FUNCTION NO_TYPE testMatrixEnumColors() "test matrix of enumerative type"
OBJECTS
	MatrixColors mc
BODY
	WRITE("\n\n***************testMatrixEnumColors()\n")
   mc.assign(4,5,red)   -- allocate size(4,5) and set default to red
	mc.replace(2,2,brown) -- replace element at (2,2) by brown
	mc.set(6,6,green)    -- resize to (6,6) and set this value to green
	WRITE("mc= \n%s (rows=%d cols=%d size=%d)\n",mc.asString(),mc.rows(),mc.cols(),mc.size())
END FUNCTION

FUNCTION NO_TYPE testMatrixVectorFriends() "test matrix of vectors"
OBJECTS
	MatrixVectorFriends mf
	VectorFriends vf
	Friends f1,f2
BODY
	WRITE("\n\n***************testMatrixVectorFriends()\n")
   f1.setFriend("John",111111111)
	f2.setFriend("Alice",222222222)
   vf.append(f1)              
	vf.append(f2)            
   mf.assign(2,2,vf)      -- set size (2,2) and set all elements to "John"
	WRITE("mf= \n%s (rows=%d cols=%d size=%d)\n",mf.asString(),mf.rows(),mf.cols(),mf.size())
	f1.setFriend("James",333333333)
	vf.clear()
	vf.append(f1)
	mf.replace(2,1,vf)        -- in matrix replace elemente at (2,1)
	WRITE("mf= \n%s (rows=%d cols=%d size=%d)\n",mf.asString(),mf.rows(),mf.cols(),mf.size())
	mf.at(2,2).at(2).setPhone(444444444)
	WRITE("mf= \n%s (rows=%d cols=%d size=%d)\n",mf.asString(),mf.rows(),mf.cols(),mf.size())
END FUNCTION


COMPONENT matrixTest
INIT
		testMatrixReal()
		testMatrixMix()
		testMatrixEnumColors()
	   testMatrixFriends()
	   testMatrixVectorFriends()
END COMPONENT