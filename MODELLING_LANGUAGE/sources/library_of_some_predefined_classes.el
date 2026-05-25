/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: library_of_some_predefined_classes

-----------------------------------------------------------------------------------------*/
// Library of Some Predefined Classes
// TABLE class
/*
Apart from the basic EL types TABLE_1D, TABLE_2D and TABLE_3D, the modeller can use the TABLE objects to represent any of the tables (in one, two or three dimensions). The advantage is that tables can be used as objects and they provide more capabilities in several areas.
	Use of the TABLE class is quite similar to that of other class types in EL but it has some constraints:
	 	It cannot be defined as a datum (in the DATA block of the component).
	 	It cannot be initialised in the declaration.
	 	To be created, it has to be read from an external file (either in XML or ASCII format) or copied from other table or created from arrays of data.
	 	Instead of using interpolation functions with TABLE objects are used interpolation methods from the class.
	However, it also has some advantages:
	 	It is not necessary to specify the dimension when declaring; this is determined when the table is read from an external file.
	 	The TABLE objects have methods that make working with them easier, instead of individual functions. The user does not need to pass the table as an argument every time he wants to interpolate the table.
	The TABLE class description with all available methods is as follows:
	EXTERN CLASS TABLE IS_A INTEG_topClass
	    DECLS
	        STRING  m_filePath      -- File path 
	        STRING  m_name          -- Name 
	        STRING  m_description   -- Description 
	        STRING  m_idAxis1       -- Id for axis 1 
	        STRING  m_idAxis2       -- Id for axis 2 
	        STRING  m_idAxis3       -- Id for axis 3 
	        STRING  m_idReturn      -- Id for return 
	        STRING  m_descrAxis1    -- Description for axis 1 
	        STRING  m_descrAxis2    -- Description for axis 2 
	        STRING  m_descrAxis3    -- Description for axis 3 
	        STRING  m_descrReturn   -- Description for return 
	    METHODS
	         -- Read table from XML/ASCII file
	        EXTERN METHOD BOOLEAN read(IN STRING fileName,
	                                   IN INTEGER format=2,
	                                   IN INTEGER dim=1)
	         -- Read table from ASCII file in column format
	        EXTERN METHOD BOOLEAN readCols1D(IN STRING fileName,
	                                   IN INTEGER col1,
	                                   IN INTEGER col2)
	        -- Free memory from tables and clear object entities
	        EXTERN METHOD BOOLEAN clear()
	         -- Save table
	        EXTERN METHOD BOOLEAN save(IN STRING fileName)
	         -- Return dimension
	        EXTERN METHOD INTEGER dimension()
	         -- Printing functions
	        EXTERN METHOD BOOLEAN print(IN INTEGER format)
	        -- Interpolation methods for tables with default interpolation methods
	        EXTERN METHOD REAL interpd1D(IN REAL x, OUT REAL dx=DUMMY_REAL)
	        EXTERN METHOD REAL interpd2D(IN REAL x, IN REAL y, OUT REAL dx=DUMMY_REAL, 
	                                     OUT REAL dy=DUMMY_REAL)
	        EXTERN METHOD REAL interpd3D(IN REAL x, IN REAL y, IN REAL z, 
	               OUT REAL dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL, OUT REAL dz=DUMMY_REAL) 
	        -- Generic Interpolation methods for tables giving the interpolation methods
	        EXTERN METHOD REAL interp1D(IN ENUM t_interp tin, IN ENUM t_interp tex, 
	               IN REAL x, OUT REAL dx=DUMMY_REAL)
	        EXTERN METHOD REAL interp2D(IN ENUM t_interp tin, IN ENUM t_interp tex, 
	               IN REAL x, IN REAL y, OUT REAL dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL)
	        EXTERN METHOD REAL interp3D(IN ENUM t_interp tin, IN ENUM t_interp tex, 
	               IN REAL x, IN REAL y, IN REAL z, OUT REAL dx=DUMMY_REAL, 
	               OUT REAL dy=DUMMY_REAL, OUT REAL dz=DUMMY_REAL)
	        	
				REAL interp1D(IN ENUM t_interp tin, -- interpolation method
	              IN ENUM t_interp tex, -- extrapolation method
	              IN REAL x,            -- input value x
	              OUT REAL dx=DUMMY_REAL) - derivative @F/@x 
	
				REAL interp2D(IN ENUM t_interp tin, -- interpolation method
				              IN ENUM t_interp tex, -- extrapolation method
				              IN REAL x,            -- input value x
				              IN REAL y,            -- input value y
				              OUT REAL dx=DUMMY_REAL, -- derivative @F/@x 
				              OUT REAL dy=DUMMY_REAL) -- derivative @F/@y 
				
				REAL interp3D(IN ENUM t_interp tin, -- interpolation method
				              IN ENUM t_interp tex, -- extrapolation method
				              IN REAL x,            -- input value x
				              IN REAL y,            -- input value y
				              IN REAL z,            -- input value z
				              OUT REAL dx=DUMMY_REAL, -- derivative @F/@x 
				              OUT REAL dx=DUMMY_REAL,  -- derivative @F/@y 
				              OUT REAL dx=DUMMY_REAL)   -- derivative @F/@z 
				
			  
			  -- Generic Interpolation methods with default interpolation methods and
	        -- historical cells
	        EXTERN METHOD REAL interpHistd1D(IN REAL x, OUT INTEGER pi, 
	               OUT REAL dx=DUMMY_REAL)
	        EXTERN METHOD REAL interpHistd2D(IN REAL x, IN REAL y, OUT INTEGER pi, 
	               OUT INTEGER pj, OUT REAL dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL)
	        EXTERN METHOD REAL interpHistd3D(IN REAL x, IN REAL y, IN REAL z, 
	               OUT INTEGER pi, OUT INTEGER pj, OUT INTEGER pk,OUT REAL dx=DUMMY_REAL, 
	               OUT REAL dy=DUMMY_REAL, OUT REAL dz=DUMMY_REAL)
	       -- Interpolation methods for tables with user interpolation methods and
	       --  historical cells
	        EXTERN METHOD REAL interpHist1D(IN ENUM t_interp tin, IN ENUM t_interp tex,
	               IN REAL x, OUT INTEGER pi, OUT REAL dx=DUMMY_REAL)
	        EXTERN METHOD REAL interpHist2D(IN ENUM t_interp tin, IN ENUM t_interp tex,
	               IN REAL x, IN REAL y, OUT INTEGER pi, OUT INTEGER pj,OUT REAL 
	               dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL)
	        EXTERN METHOD REAL interpHist3D(IN ENUM t_interp tin, IN ENUM t_interp tex,
	               IN REAL x, IN REAL y, IN REAL z, OUT INTEGER pi, OUT INTEGER pj,
	               OUT INTEGER pk,OUT REAL dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL, 
	               OUT REAL dz=DUMMY_REAL)  
						
						REAL interpHist1D(IN ENUM t_interp tin, -- interpolation method
                  IN ENUM t_interp tex, -- extrapolation method
                  IN REAL x, 	 -- input value x
                  OUT INTEGER i) -- previous position for x

			REAL interpHist1D(IN ENUM t_interp tin, -- interpolation method
			                  IN ENUM t_interp tex, -- extrapolation method
			                  IN REAL x, 	 -- input value x
			                  OUT INTEGER i) -- previous position for x
			
			REAL interpHist2D(IN ENUM t_interp tin, -- interpolation method
			                  IN ENUM t_interp tex, -- extrapolation method 
			                  IN REAL x,     -- input value x
			                  IN REAL y,     -- input value y
			                  OUT INTEGER i, -- previous position for x
			                  OUT INTEGER j) -- previous position for y
			
			REAL interpHist3D(IN ENUM t_interp tin, -- interpolation method
			                  IN ENUM t_interp tex, -- extrapolation method
			                  IN REAL x,     -- input value x
			                  IN REAL y,     -- input value y
			                  IN REAL z,     -- input value z
			                  OUT INTEGER i, -- previous position for x
			                  OUT INTEGER j, -- previous position for y
			                  OUT INTEGER k) -- previous position for z
			
	        
	       -- Inverse interpolation methods for tables
	        EXTERN METHOD REAL invInterp1D(IN ENUM t_interp tin, 
	                                       IN ENUM t_interp tex,  IN REAL val)
	        EXTERN METHOD REAL invInterpd1D(IN REAL val)
				REAL invInterp1D(IN ENUM t_interp tin, -- interpolation method
				                 IN ENUM t_interp tex, -- extrapolation method
				                 IN REAL val)  -- output value, now it is the input
				
				REAL invInterpd1D(IN REAL val) -- output value, now it is the input
				

	         -- copy from tables 1D, 2D and 3D
	        EXTERN METHOD NO_TYPE copyFromTable1D(TABLE_1D table)
	        EXTERN METHOD NO_TYPE copyFromTable2D(TABLE_2D table)
	        EXTERN METHOD NO_TYPE copyFromTable3D(TABLE_3D table)
	         -- fill the main data
	        EXTERN METHOD BOOLEAN fillData(IN STRING name,IN INTEGER nx,REAL x[],
	                 IN INTEGER ny,REAL y[],IN INTEGER nz,REAL z[],IN INTEGER nv,REAL v[])
	        EXTERN METHOD BOOLEAN fillInterpMethods(INTEGER ntin,ENUM t_interp tin[],
	                                                INTEGER ntex,ENUM t_interp tex[])
	
				METHOD BOOLEAN fillInterpMethods(INTEGER ntin,
			                                 ENUM t_interp tin[],
			                                 INTEGER ntex,
			                                 ENUM t_interp tex[])
				The arguments are:
				 	ntin - number of interpolation methods.
				 	tin - array of valid interpolation methods (first is the default).
				 	ntex - number of extrapolation methods.
				 	tex - array of valid extrapolation methods (first is the default).
			
				-- fill the main data X,Y,Z and values in V
				EXTERN METHOD BOOLEAN fillData(IN STRING name,
				                        IN INTEGER nx,
				                        REAL x[],
				                        IN INTEGER ny,
				                        REAL y[],
				                        IN INTEGER nz,
				                        REAL z[],
				                        IN INTEGER nv,
				                        REAL v[])
				The arguments are:
				 	name - name of the table
				 	nx - number of points in the first dimension
				 	x - vector of values in the first dimension
				 	ny - number of points in the second dimension
				 	y - vector of values in the second dimension
				 	nz - number of points in the third dimension
				 	z - vector of values in the third dimension
				 	nv - number of results values
				 	v- vector of result values in the table
			
			
	         -- accesing axis and interpolation/extrapolation methods
	        EXTERN METHOD REAL x(IN INTEGER index)
	        EXTERN METHOD REAL y(IN INTEGER index)
	        EXTERN METHOD REAL z(IN INTEGER index)
	        EXTERN METHOD REAL v(IN INTEGER index)
	        EXTERN METHOD INTEGER nx()
	        EXTERN METHOD INTEGER ny()
	        EXTERN METHOD INTEGER nz()
	        EXTERN METHOD INTEGER nv()
	        EXTERN METHOD ENUM t_interp tind()
	        EXTERN METHOD ENUM t_interp texd()
	        EXTERN METHOD INTEGER ntin()
	        EXTERN METHOD INTEGER ntex()
	        EXTERN METHOD ENUM t_interp tin(IN INTEGER index)
	        EXTERN METHOD ENUM t_interp tex(IN INTEGER index)
	        EXTERN METHOD BOOLEAN changeX(IN INTEGER index,REAL value)
	        EXTERN METHOD BOOLEAN changeY(IN INTEGER index,REAL value)
	        EXTERN METHOD BOOLEAN changeZ(IN INTEGER index,REAL value)
	        EXTERN METHOD BOOLEAN changeValue(IN INTEGER indexX,IN INTEGER indexY,
	                                          IN INTEGER indexZ,REAL value)
	        EXTERN METHOD BOOLEAN getValue(IN INTEGER indexX,IN INTEGER indexY,
	              IN INTEGER indexZ,OUT REAL value)
	        EXTERN METHOD INTEGER getValueIndex(IN INTEGER indexX,IN INTEGER indexY,
	              IN INTEGER indexZ)
	         -- Correct wrong values of the map with the values around it
	        EXTERN METHOD BOOLEAN correctWrongValues2D(VECTOR_BOOLEAN wrongValuesIndex)
	
	END CLASS INCLUDE "INTEG_simula.h" IN "INTEG.lib"



*/
COMPONENT comp_simpleTableObject
    DATA
        TABLE_1D table1 = { {0,100,200,300,400,500},{1, 3, 2, 4, 5, 1} } 
    DECLS
        REAL x
    OBJECTS
        TABLE tableObj
    INIT
        tableObj.copyFromTable1D(table1)
    CONTINUOUS
        x= tableObj.interpd1D(TIME)
END COMPONENT
COMPONENT comp_simpleTable
    DATA
        TABLE_1D table1 = { {0,100,200,300,400,500},{1, 3, 2, 4, 5, 1}}
    DECLS
        REAL x
    CONTINUOUS
        x= interp1D(table1,LINEAR,LINEAR,TIME)
END COMPONENT
COMPONENT comp_testInterpInTable1D
    DECLS
        REAL x,y
        TABLE_1D mtab = {{0.0, 4.0,   8.0,  10.0, 15.0, 20.},
                         {9.5, 9.5, 400.6,  16.6, 368.0, 3.}}
    OBJECTS
	 TABLE objTable
    INIT
        objTable.copyFromTable1D(mtab)
    CONTINUOUS
	 x = objTable.interp1D(LINEAR,LINEAR,TIME)
    y = interp1D(mtab,LINEAR,LINEAR, TIME)
END COMPONENT


COMPONENT comp_tableClass

    DECLS
        REAL x
		  REAL y = 800
		  CONST ENUM t_interp intm[6]={LINEAR, CONSTANT, QUADRATIC, CUBIC, SPLINE,AKIMA} 
        CONST ENUM t_interp extm[2]= { LINEAR, CONSTANT}
        CONST FILEPATH mpath ="@MODELLING_LANGUAGE@/maps/tableExample.xml"
        CONST REAL v1[3] = { 0, 1, 2 }
        CONST REAL v2[3] = { 3, 4, 5 }
        CONST REAL v3[1] = { 0 }
        CONST REAL vv[3,3] = { {2,3,4}, {5,6,7}, {8,9,0} }
        REAL val

    OBJECTS
		  TABLE tobj
    INIT
         -- fill the X,Y and V vectors
        tobj.fillData("mtable",3,v1,3,v2,0,v3,9,vv)

         -- fill the interpolation and extrapolation methods 
         -- and put default ones to LINEAR (first element in arrays)
        tobj.fillInterpMethods(6,intm,2,extm)

         -- write labels for the axis
        tobj.m_idAxis1 ="NcRdes"
        tobj.m_idAxis2 ="BETA"
        tobj.m_idReturn ="Eff"
	
         -- change point (2,3,1) to 0.23
        tobj.changeValue(2,3,1,0.23)
 
        -- confirm that the point has been changed
        IF( tobj.getValue(2,3,1,val) == TRUE AND val == 0.23 ) THEN
             WRITE("Confirmed\n")
        END IF
		  -- save in XML the table
        tobj.save(mpath)


    CONTINUOUS
 		  x = tobj.interpd2D(TIME,4) -- interpolate

END COMPONENT

// Vector Class
/*
	The older class names for VECTOR class have been deprecated but they are still valid. From now on there are
new names for the old vector classes:
Old Name New Name
VECTOR_REAL EVectorReal
VECTOR_INTEGER EVectorInt
VECTOR_BOOLEAN EVectorBool
VECTOR_STRING EVectorString
your previous code using these class names should be valid since the program transforms automatically the
old names to the new names. Anyway it is recommended to use the new names from now on. Please refer to
the section "Container Classes- EVector Class" for more information

*/
COMPONENT comp_vectorClass
 DECLS
        REAL x
		  REAL k
   CONTINUOUS
        x = sin(TIME)
END COMPONENT
// Vector Class
/*
		The older class names for VECTOR class have been deprecated but they are still valid. From now on there are
new names for the old vector classes:
Old Name New Name
VECTOR_REAL EVectorReal
VECTOR_INTEGER EVectorInt
VECTOR_BOOLEAN EVectorBool
VECTOR_STRING EVectorString
your previous code using these class names should be valid since the program transforms automatically the
old names to the new names. Anyway it is recommended to use the new names from now on. Please refer to
the section "Container Classes- EVector Class" for more information
	*/
FUNCTION NO_TYPE func_vectorClass()
    DECLS
        INTEGER size
    OBJECTS
        VECTOR_REAL v
    BODY
        v.push_back(1.2)
        v.push_back(2.3)
        v.push_back(3.4)
         -- print the element at position 2
        WRITE("element 2 is %g\n",v.at(2))
         -- get the size and print it
        size= v.size()
        WRITE("size of vector is %d\n",size)
END FUNCTION
// Classes for reading from ASCII files and strings
/*
	There are two classes in EL that are used for reading data from streams. The streams can be either an ASCII file or a STRING. The class names are:
		PARSER_FILE: for reading ASCII files
		PARSER_STRING: for reading STRING variables
	 	The PARSER_FILE class can be used to open a file and read all the text token by token and carry on to memory positions in the program. For instance you can read table values from files with this class.
	 	The PARSER_STRING class is identical to PARSER_FILE but instead of using an external file you can parse STRING variables.
	Both classes are inherited from a common virtual class named PARSER_STREAM which is not directly used by the user. The class definition is as follows:
	EXTERN CLASS PARSER_STREAM
	 DECLS
	 METHODS
		--read variables
		EXTERN METHOD BOOLEAN getReal(OUT REAL value)
		EXTERN METHOD BOOLEAN getInteger(OUT INTEGER value)
		EXTERN METHOD BOOLEAN getString(OUT STRING value)
		EXTERN METHOD BOOLEAN getBoolean(OUT BOOLEAN value)
		--read a line
		EXTERN METHOD BOOLEAN getLine(OUT STRING value)
		--read a field
		EXTERN METHOD BOOLEAN getField(OUT STRING value,STRING delim="\t")
		EXTERN METHOD BOOLEAN skipTokens(INTEGER nTokens,STRING delim=" "))
		--read N characters
		EXTERN METHOD INTEGER read(OUT STRING value,INTEGER N)
		--return data from the stream
		EXTERN METHOD INTEGER size()
		EXTERN METHOD INTEGER nlines()
		--clean the stream
		EXTERN METHOD NO_TYPE clean()
		--stream is at the end?
		EXTERN METHOD BOOLEAN is_end()
		--goto a position in the stream
		EXTERN METHOD BOOLEAN seek(INTEGER pos,INTEGER from=0)
		
			The user can move the stream over with the method:
			EXTERN METHOD BOOLEAN seek(INTEGER pos,INTEGER from=0)
			This method can be used to change the current position of the pointer in the stream. Its arguments are:
			 	pos: can be either a positive or a negative number (moving can be done forward or backward).
			 	from: depending on the value of this variable, the moving begins from a different position.
			 	from= 0, from the beginning (default value).
			 	from= 1, from current position.
			 	from= 2, from the end of the stream.

		--get position in stream
		EXTERN METHOD INTEGER position()
		EXTERN METHOD NO_TYPE getLineColumn(INTEGER position,OUT INTEGER line,
	                                          OUT INTEGER column)
		--return as a string
		EXTERN METHOD STRING  str()
		
		Get Position in the Stream
			Two methods are used for getting the current position in the stream:
			EXTERN METHOD INTEGER position()
			EXTERN METHOD NO_TYPE getLineColumn(INTEGER position,
			                                    OUT INTEGER line,
			                                    OUT INTEGER column)
			The method position() returns the current position in the stream and the getLineColumn() method returns the line and column numbers based on a given position.
			1.16.4.13. 	Get the Complete Stream in a STRING Format
			There is a method to get the complete stream in a STRING format:
			EXTERN METHOD STRING  str()
			This method returns a STRING value with the complete stream contents
			
	END CLASS INCLUDE "INTEG_simula.h"
	
	--------------------------------------------------------------------------------
	-- API for class STRING_PARSER  for parsign strings
	--------------------------------------------------------------------------------
	EXTERN CLASS PARSER_STRING IS_A PARSER_STREAM
	 DECLS
	 METHODS
		--set a STRING
		EXTERN METHOD BOOLEAN set(STRING value)
	END CLASS INCLUDE "INTEG_simula.h"
	
	--------------------------------------------------------------------------------
	-- API for class FILE_PARSER  for parsign ASCII files
	--------------------------------------------------------------------------------
	EXTERN CLASS PARSER_FILE IS_A PARSER_STREAM
	 DECLS
	 METHODS
		--open a file
		EXTERN METHOD BOOLEAN open(STRING fileName)
		--return file name
		EXTERN METHOD STRING  fileName()
	END CLASS INCLUDE "INTEG_simula.h"

*/
COMPONENT comp_parserClass
	DECLS
			STRING mPath = "@MODELLING_LANGUAGE@/inputFiles/data.txt"
			STRING txt="3.3 4 HTX\n4.5 6 NJG\n6.7 9 JIP"
			STRING str= "12.3,trans mut,4 4 3"
			STRING str1= "4.5 5.67 12.46 34.55"
			STRING str2= "4012 456 89ABC EFG IJAbc efg ij"
    		STRING vs
			STRING vs1
			REAL vr1,vr2

	OBJECTS
	      PARSER_FILE file1
			PARSER_STRING strparser
			PARSER_STRING rec
	INIT
		IF(file1.open(mPath) == FALSE) THEN
			STOP "File data.txt cannot be opened"
		END IF
		IF( strparser.set( txt) == FALSE ) THEN
			STOP "String cannot be set"
		END IF
		rec.set(str)
    	WHILE( rec.is_end() != TRUE )
   		rec.getField(vs,",")
			WRITE("Field: %s\n",vs)
    	END WHILE
		rec.set(str1)
   	WHILE( rec.is_end() != TRUE )
   		rec.getReal(vr1)
			rec.skipTokens(2) -- skip two tokens
			rec.getReal(vr2)
  			WRITE("vr1= %g vr2= %g\n",vr1,vr2)
		END WHILE
		rec.set(str2)
  		 WHILE( rec.is_end() != TRUE )
   	  	rec.read(vs,10)
        	WRITE("vs= %s\n",vs)
   	END WHILE
		// Obtain Sizes of Stream
		file1.open("@MODELLING_LANGUAGE@/inputFiles/data.txt")
	   WRITE("File size= %d\nNumber of lines= %d\n",file1.size(),file1.nlines())
		// The following example skips 4 characters from the beginning and reads 3 characters, then from that position jumps three positions forward and reads another 3 characters and finally it moves the pointer 5 positions before the end of the file
	   file1.seek(4)
	   file1.read(vs1,3)
	   WRITE("Chunk:%s (expected 4.5)\n",vs1)
	   file1.seek(3,1)
	   file1.read(vs1,3)
	   WRITE("Chunk:%s (expected 2)\n",vs1)
	   file1.seek(-5,2)
	   file1.read(vs1,5)
	   WRITE("Chunk:%s (expected 6.2)\n",vs1)
END COMPONENT
// A class for finding roots in functions
/*
	The program includes a class named ROOTFINDER1D which is an interface for finding the root of a function of type f(x) using Brent's method. Brent's method is an algorithm to find roots of one variable functions that was developed to speed up the bisection method by using the secant method or inverse quadratic interpolation whenever possible (for more information you can visit http://en.wikipedia.org/wiki/Brent's_method).
	The class ROOTFINDER1D is intended to substitute the existing functions root and root1 from the MATH library which were unsafe when nested calls were needed. The class ROOTFINDER1D allows nested calls if you create an instance of the class for each nested call that needs to find a root for a certain function.
	The methods provided by this class are:
	 	findRootZBrent: performs a single step of the algorithm in each call until the last call finds the root or reaches the maximum number of allowed steps to find a root.
	 	findRootZBrentPtr: it finds a root of a function but instead of performing one step in each call the method iterates until it finds the root. The user must pass a pointer to the function whose root is to be found.
	The API of the class is:
	--------------------------------------------------------------------------------
	-- API for class rootFinder1D. This class provides methods for finding roots
	--------------------------------------------------------------------------------
	EXTERN CLASS ROOTFINDER1D
	   DECLS
	   METHODS
	      EXTERN METHOD REAL findRootZBrent(INTEGER ilast, REAL fval, REAL lBound,
	                                        REAL uBound, REAL tol)
	      
	      EXTERN METHOD REAL findRootZBrentPtr(INTEGER ilast, FUNC_PTR f, REAL lBound,
	                                           REAL uBound, REAL tol)
	
	END CLASS INCLUDE "INTEG_rootFinder1D.h"
	
	findRootZBrent Method
	This method performs a single step of a customized Brent's method returning the root when the last iteration has been reached, or a temporary value needed for the next call to the method. It is strongly recommended that all previous use of the function root of the library MATH be replaced by this method in order to allow safe nesting of calls to root function.
		Parameters
	 	ilast: represents the state of the last call to the method. 0 should be passed when it is the first call to the method. The method will return one of the following values in this parameter:
	 	-3 An error occurred during the calculation.
	 	-2 The method wasn't able to find a root after a maximum number of iterations.
	 	-1 The specified bracket does not contain a root for the function.
	 	2 or 3 the function is iterating, which means everything is ok but a root hasn't been found yet. The return value of the function should be used in the next call to the method.
	 	4 a root was found and thus the return value of the function is the root's value.
	 	fval: it's the function's value, f(x), for a particular iteration. It must be the last return value of findRootZBrent. If it's the first call, in other words when ilast = 0, fval will be ignored.
	 	lBound: lower bound of the bracket in which to look for a root of the function f(x).
	 	uBound: upper bound of the bracket in which to look for a root of the function f(x).
	 	tol: desired tolerance in the search algorithm. It will affect the speed and precision of the root finding algorithm.
	
	findRootZBrentPtr Method
	This method iterates until a root is found for a passed function pointer. The function must be of type f(x) where x is a real number. Internally the method uses the same algorithm as findRootZBrent.
		Parameters
	 	ilast: represents the state of the last call to the method. 0 should be passed when it is the first call to the method. The method will return one of the following values in this parameter:
	 	-3 An error occurred during the calculation.
	 	-2 The method wasn't able to find a root after a maximum number of iterations.
	 	-1 The specified bracket does not contain a root for the function.
	 	4 a root was found and thus the return value of the function is the root's value.
	 	f: a pointer to the function whose root is to be found within the specified bracket.
	 	lBound: lower bound of the bracket in which to look for a root of the function f(x).
	 	uBound: upper bound of the bracket in which to look for a root of the function f(x).
	 	tol: desired tolerance in the search algorithm. It will affect the speed and precision of the root finding algorithm.
	
	

*/
----------------------------------------------------
-- Dummy compponent to test the use of ROOTFINDER1D
----------------------------------------------------
COMPONENT comp_rootFinder1dClass
       
END COMPONENT
//	findRootZBrent Method
/*
This method performs a single step of a customized Brent's method returning the root when the last iteration has been reached, or a temporary value needed for the next call to the method. It is strongly recommended that all previous use of the function root of the library MATH be replaced by this method in order to allow safe nesting of calls to root function.
	Parameters
 	ilast: represents the state of the last call to the method. 0 should be passed when it is the first call to the method. The method will return one of the following values in this parameter:
 	-3 An error occurred during the calculation.
 	-2 The method wasn't able to find a root after a maximum number of iterations.
 	-1 The specified bracket does not contain a root for the function.
 	2 or 3 the function is iterating, which means everything is ok but a root hasn't been found yet. The return value of the function should be used in the next call to the method.
 	4 a root was found and thus the return value of the function is the root's value.
 	fval: it's the function's value, f(x), for a particular iteration. It must be the last return value of findRootZBrent. If it's the first call, in other words when ilast = 0, fval will be ignored.
 	lBound: lower bound of the bracket in which to look for a root of the function f(x).
 	uBound: upper bound of the bracket in which to look for a root of the function f(x).
 	tol: desired tolerance in the search algorithm. It will affect the speed and precision of the root finding algorithm.

*/
-----------------------------------------------------
-- Function whose root is going to be searched for
-----------------------------------------------------
FUNCTION REAL func_simpleFunction(REAL x)
   BODY
      RETURN (x - 2) * (x + 5)
END FUNCTION
-----------------------------------------------------
-- Function whose root is going to be searched for
-----------------------------------------------------
FUNCTION REAL func_simpleFunction2(REAL x)
   BODY
      RETURN (x + 2) * (x - 1)
END FUNCTION

--------------------------------------------------------
-- Testing function
--------------------------------------------------------
FUNCTION NO_TYPE func_findRootZBrent_simpleExample()
   DECLS
     REAL lBound, uBound, tol, root, fval
     INTEGER ilast
   OBJECTS
      ROOTFINDER1D rf
   BODY
      -- Set initial bracket where the root is going to be searched for
      lBound = -6
      uBound = 0
      tol = 1e-3 -- Max tolerance
      root = 0
      ilast = 0
      -- Define the loop for finding a root of the function
      WHILE ( ilast != 4 AND ilast >= 0)
         -- Call to the method. Remember that ilast
         -- will be used in the next iteration and it
         -- will be modified by findRootZBrent
         root = rf.findRootZBrent(ilast, fval, lBound, uBound, tol)
         -- Calculate f(x) for next step
         fval = func_simpleFunction(root)
      END WHILE
      WRITE("\n Root value = %.20g Last state was %d\n\n", root, ilast)
END FUNCTION
--------------------------------------------------------
-- Testing function
--------------------------------------------------------
FUNCTION NO_TYPE func_findRootZBrent_ComplexExample()
   DECLS
      REAL lBound, uBound, tol, root, fval, lBound1, uBound1, root1, fval1
      INTEGER ilast, ilast1
   OBJECTS
      ROOTFINDER1D rf
      ROOTFINDER1D rfNested
   BODY
      -- Set initial bracket where the root is going to be searched for
      lBound = -6
      uBound = 0
      lBound1 = 0
      uBound1 = 2
      tol = 1e-7 -- Max tolerance
      root = 0
      ilast = 0
      -- Define the loop for finding a root of the function
      WHILE ( ilast != 4 AND ilast >= 0)
         -- Call to the method. Remember that ilast
         -- will be used in the next iteration and it
         -- will be modified by findRootZBrent
         root = rf.findRootZBrent(ilast, fval, lBound, uBound, tol)
         -- Nested call to test safety of nested calls 
         ilast1 = 0
         root1 = 0
         WHILE (ilast1 != 4 AND ilast1 >= 0)
            -- Call to the method. Remember that ilast1
            -- will be used in the next iteration and it
            -- will be modified by findRootZBrent
            root1 = rfNested.findRootZBrent(ilast1, fval1, lBound1, uBound1, tol)
            -- Calculate f(x) for next step
            fval1 = func_simpleFunction2(root1)
         END WHILE
         -- Calculate f(x) for next step
         fval = func_simpleFunction(root)
      END WHILE
      WRITE("\n Root value = %.20g Last state was %d", root, ilast)
      WRITE("\n Root1 value = %.20g Last state was %d\n\n", root1, ilast1)
END FUNCTION
//	findRootZBrentPtr Method
/*
This method iterates until a root is found for a passed function pointer. The function must be of type f(x) where x is a real number. Internally the method uses the same algorithm as findRootZBrent.
	Parameters
 	ilast: represents the state of the last call to the method. 0 should be passed when it is the first call to the method. The method will return one of the following values in this parameter:
 	-3 An error occurred during the calculation.
 	-2 The method wasn't able to find a root after a maximum number of iterations.
 	-1 The specified bracket does not contain a root for the function.
 	4 a root was found and thus the return value of the function is the root's value.
 	f: a pointer to the function whose root is to be found within the specified bracket.
 	lBound: lower bound of the bracket in which to look for a root of the function f(x).
 	uBound: upper bound of the bracket in which to look for a root of the function f(x).
 	tol: desired tolerance in the search algorithm. It will affect the speed and precision of the root finding algorithm.
*/
--------------------------------------------------------
-- Testing function
--------------------------------------------------------
FUNCTION NO_TYPE func_findRootZBrentPtr_simpleExample()
   DECLS
      REAL lBound, uBound, tol, root, fval
      INTEGER ilast
   OBJECTS
      ROOTFINDER1D rf
   BODY
      -- Set initial bracket where the root is going to be searched for
      lBound = -6
      uBound = 0
      tol = 1e-3 -- Max tolerance
      root = 0
      ilast = 0
 
      -- Call the root finding algorithm. It will iterate until a root
      -- is found or an error arises
		root = rf.findRootZBrentPtr(ilast, func_simpleFunction, lBound, uBound, tol)
      -- Print results
      WRITE("\n Root value = %.20g Last state was %d\n\n", root, ilast)
END FUNCTION
// INEQUALITIES Class
/*

	Program allows system design based on the creation of different equations and the relaxation of certain data  the data to be designed. Whereas equations allow both terms of the expression to be equalled, the inequalities impose a limit (right side of the expression) on a value (left side of the equation). This class is called "INEQUALITIES".
	A group of inequalities is defined as a collection of inequalities in which, in the final results, one of the expressions will become an equation and the others must be satisfied. The INEQUALITIES class allows several groups to be resolved at one time.
	There are two types of inequalities groups:
	 	Dominating groups
	 	Saturated groups
	
	Dominating Group of Equations
		A dominating group is defined as a collection of inequalities in which there will be at least one main inequality which is required to function as an equation and one or more associated inequalities which must be satisfied. In the event that both sides of the main equation are equal and the associated inequalities can not be satisfied, one of them will become an equation so that both the main inequality and the others associated with it are satisfied.
		Example:
			PRI:	variable_A 	>    10
			ASS:	variable_B 	>    const_A
		In the example, the value we want to reach is 10 units for variable_A and we start from a greater value. If while variable_A gradually decreases to reach 10 the value of variable_B becomes less than const_A, the solution will be variable_B = const_A, where variable_A is greater than 10.
		The direction of the associated equations may be different from that of the primary equation (lower and upper inequalities).
		The creation of these types of groups requires in-depth knowledge of the physical behaviour of the model to be simulated. The direction of the inequalities must be adequate so that a solution can be found whereby, when both terms of an equation are equal and therefore act as an equality, the other inequalities will be satisfied.
	Saturated Group of Equations
		The resolution of a saturated group consists in solving an equation in such a way that certain limits are not exceeded when its solution is obtained. Such limits are defined by means of a collection of inequalities for the lower bounds and another collection for the upper bounds.
		The group must always contain the main equation along with a bound, which will be lower or upper.
		As in the previous case, when the main equation is solved all the inequality bounds must be satisfied. If one or several are not satisfied, then one of them must become an equation, giving rise to two cases:
		 	When a lower bound has not been satisfied, it will become an equation and the main equation will change into an inequality in which the left side must be greater than the right side.
		 	When an upper bound has not been satisfied, it will become an equation and the main equation will change into an inequality in which the left side must be lower than the right side.
		Example:
				SAT		var_A 		= 	const_A
				LOWER	var_B		> 	const_B 
				LOWER	var_C	 	> 	const_C
				UPPER		var_D		<	const_D 
				UPPER		var_E		<	const_E
		If when the problem is solved with the equation var_A = const_A all the bounds are respected, the solution is considered valid.
		If when var_A = const_A is being calculated any of the lower conditions (var_B o var_C) reaches the minimum value (const_B o const_C), one of these inequalities will become an equation so var_A must be greater than const_A. Of course, the remaining inequalities must be satisfied so that the solution can be considered valid.
		If when var_A = const_A is being calculated any of the upper conditions (var_D o var_E) reaches the maximum value (const_D o const_E), one of these inequalities will become an equation so var_A must be lower than const_A. Obviously, the remaining inequalities must be satisfied so that the solution can be considered valid.
		The creation of these types of groups requires in-depth knowledge of the physical behaviour of the model to be simulated.
		 	The direction of the inequalities must be adequate so that a solution can be found whereby, when both terms of an equation are equal and therefore act as an equality, the other inequalities will be satisfied.
		 	Each bound must have an adequate direction (upper or lower).
		 	Upper and lower bounds must be disjoint; i.e., they must not have a common solution.
	Solving Method
		Problems of inequalities are solved with the external steady solver.
		Since the resolution of a group of inequalities consists in solving one of the inequalities as equality, the problem is reduced to selecting the equation.
		The problem can be solved as many times as inequalities are in the group, but this would be very slow, especially if we bear in mind that one equation has to be selected for each group. Therefore, if we had 5 groups each with 4 inequalities we would have a total of 5x5x5x5 = 625 possible combinations.
		With the external NR solver we can calculate the residues with which the Jacobian matrix will work ourselves. This means that as the solver tries to satisfy the residues of the model (those associated both with the inequalities and the rest), the inequality can be changed so that it will work as an equation.
			Residue Calculation
		The residue is calculated internally with the following formula:
		 
		Where the value of sign is:
		 	sign = 1: for the main equation
		 	sign = 1: if the inequality sign is lower
		 	sign = -1: if the inequality sign is greater
		
		This value represents the deviation between two sides of the inequality.
		In case that leftVal or rightVal were equal to zero, both sides would be increased by a constant whose initial value is 1. Otherwise, the value of the residue would be a constant with a value of and, therefore, the NR would not be able to apply its dynamics. That initial value can be modified using the setNonZeroConst function.
			Selection of the Equation in a Dominating Problem
		The dominating group problem is a simple case because all restrictions must be equally fulfilled. In the first instance, the solver will try to satisfy all the associated inequalities using as residue that which corresponds to the deviation of the main inequality (see setInitialConvergentError). Once it has obtained this approximation, in each call to the residues function it will select the inequality with the greatest residue; that means, speaking in positive, that which is less satisfied.
			Selection of the Equation in a Saturated Problem
		The selection of the inequality that will function as equation is an important point in the algorithm for solving inequalities. Given that the selected equation is the one that will provide the residue that the Jacobian will use for working in the NR, it is recommended to change it smoothly when said equation has to be changed for any other, thus preventing a big jump that would add instability to the model.
		The inequalities in the saturated groups are assembled according to their typology, obtaining:
		 	dev_main: deviation of the main equality.
		 	dev_lower(k): maximum deviation among all LOWER type inequalities.
		 	dev_greater(j): maximum deviation among all GREATER type inequalities.
		
		In this way the equation is selected bearing in mind the following logic:
		abs(dev_main) = 0  
			OR
			(dev_main > 0 AND exists k so that dev_lower(k) = 0)   
			OR 
			(dev_main < 0 AND exists j so that dev_greater(j) = 0) 
			AND
		      	dev_greater(i) <= 0 for all i 
			AND
			dev_lower(i) <= 0 for all i   
		Which is the same as:
		residue = max( min( abs( dev_main ),	
		 			     max( -dev_main, -dev_lower(k) ),
					     max(  dev_main, -dev_greater(j) ) 	
		  		     ),
				  dev_greater(j),
				  dev_lower(k) 
		 		) 
		The residue of one of the inequalities in each group must be equal to zero, and this is the aim of the inequalities solver. Because of the way in which the deviation of the inequalities is calculated, if the deviation is negative the inequality will be satisfied. Otherwise, if the deviation is positive the inequality will not be satisfied. The main equation is a special situation; if one of the inequalities is not satisfied, its value must be modified according to the following criterion:
		 	towards positive values if the inequality selected is of the LOWER type.
		 	towards negative values if the inequality selected is of the GREATER type.
		Since in the end the residue value must be zero, hence the global maximum must be zero. So then one of the following three cases must be obtained:
		 	dev_main is zero in the end and both dev_greater and dev_lower must be negative (they are satisfied).
		 	dev_lower is zero and therefore dev_main must be positive and dev_greater negative.
		 	dev_greater is zero and therefore dev_main must be negative and dev_lower positive.
		The formula is a predictive method that studies the value and direction (sign) of the deviations in such a way that it selects the equation that would most easily become zero.
		Let's look at how the formula deals with the above three cases. This is what happens to the equation in its last iteration:
		 	If dev_main is selected, we would obtain:
		0 = max( min( abs(  0 ),	
		 		   	max( -0, -dev_lower(k) ),
					max(  0, -dev_greater(j) ) 	
		  	      ),
			      dev_greater(j),
			      dev_lower(k) 
			 ) 
		Because dev_main was selected, in order for the residue to be zero the maximum has to correspond to:
		0 = min( abs(  0 ),	
		 	   max( -0, -dev_lower(k) ),
			   max(  0, -dev_greater(j) ) 	
		  	 )
		Whereby:
		0 = max( min( 0 ),
		         dev_greater(j),
		         dev_lower(k) 
		        ) 
		And thus, dev_greater(j) and dev_lower(k) will be negative and they will therefore be satisfied.
		 	If dev_greater is selected, we would obtain:
		0 = max( min( abs( dev_main ),	
		 	     	 max( -dev_main, -dev_lower(k) ),
				 max(  dev_main, -0 ) 	
		   	      ),
		         0,
		         dev_lower(k), 
		 	 ) 
		 	On one hand, we can see that dev_lower(k) has to be less than zero to fulfil the condition of most global maximum.
		 	On the other hand, we obtain:
		0 = min( abs(  dev_main ),	
		         max( -dev_main, -dev_lower(k) ),
		         max(  dev_main, -0 ) 	
		       )
		We can directly eliminate abs(dev_main) since it will always be greater than zero. We have already said that dev_lower(k) is negative, so the first maximum would be a positive number and therefore satisfy the condition that the residue be equal to the second maximum; i.e., max (dev_main, 0), from which it is clear that dev_main must be a negative number. This fact satisfies the condition that when dev_greater(j) is selected, dev_main has to take negative values.
		 	If dev_lower(k) is selected, we would obtain:
		selected = max( min( abs( dev_main ),	
		                     max( -dev_main, -0 ),
		                     max(  dev_main, -dev_greater(j) ) 	
		                   ),
		                dev_greater(j),
		                0 
		              ) 
		 	On one hand, we can see that dev_greater(j) has to be less than zero to fulfil the condition of most global maximum:
		0 = min( abs( dev_main ),	
		         max( -dev_main, -0 ),
		         max(  dev_main, -dev_greater(j) ) 
		       )	
		 	On the other hand, we obtain:
		We can directly eliminate abs(dev_main) since it will always be greater than zero. We have already said that dev_greater(j) is negative, so the second maximum would be a positive number and therefore satisfy the condition that the residue be equal to the first maximum; i.e., max (-dev_main, 0), from which it is clear that dev_main must be a negative number. This fact satisfies the condition that when dev_lower(k) is selected, dev_main has to take positive values.
		These would be the corresponding final iterations. The process followed to reach this status can be explained seeing that, since the residue is being annulled by the NR solver, the global maximum becomes equal to zero gradually. If dev_greater(j) or dev_lower(k) were positive, their values would reduce until they reached the final condition of zero, even when dev_main is selected. In the event that both values were negative, dev_main would be the one which would become zero regardless of its value due to the 'absolute value' function.
	
	Inequality Class Interface
		EXTERN METHOD NO_TYPE setDebugLevel(IN INTEGER level)
		 	It defines a different main integrator debug output level. If we want to use the general value again once it has been changed, the function will be called passing a negative number as the argument. Arguments:
		 	level: Level of output detail:
			0: No output will be displayed.
			1: Only the most important messages will be displayed. The results of the inequality solver will be displayed only when it has finished.
		­	2-3: The results of the inequality solver will be displayed each time the residues are evaluated.
			
		EXTERN METHOD NO_TYPE setTolerance(IN REAL tol)
		 	It defines a tolerance in the algorithm that is different from that of the main integrator. If we want to use the general value again once it has been changed, the function will be called passing a negative number as the argument. Arguments:
		 	tol: This parameter establishes a tolerance in the comparison between the sides of the inequalities that is different from that of the global tolerance.
		 	
		EXTERN METHOD NO_TYPE setResidueType (ENUM t_tolTypes tolType)
		 	The function setResidueType() can be used for changing the type of the returned residue. By default all residues from inequations are returned in FRACTOL mode. With this method it can be changed to ABSTOL. Arguments:
		 	tolType: Reside in either FRACTOL (default) or ABSTOL.
		
		EXTERN METHOD REAL getResidueOfGroup(IN STRING groupName,IN REAL time= -1.0,
		                                     OUT INTEGER activeIneq = DUMMY_INTEGER)
		 	The function getResidueOfGroup evaluates which will be the next inequality whose residue will be satisfied in the NR solver. This solver will initially return the residue value of the main equation until its relative error is lower than the value imposed by this method. The integer variable activeIneq returns the active inequality after calling the function. This functionality enables us to initialise the solver up to an area of known convergence and afterwards apply the restrictions. This feature can be disabled by passing a negative argument to the function.
		 	
		EXTERN METHOD NO_TYPE setInitialConvergentError(IN REAL convError)
		It provides an initial convergence error for the inequality problem. Arguments:
		 	convError: Residue value of the main equation based on which of the remaining inequalities will be enabled so that they are selected.
		 	
		EXTERN METHOD NO_TYPE setNonZeroConst(IN REAL nonZeroConst)
		 	When, in an equation, the value of one of the terms is equal to zero, a constant is added to it at both sides of the inequality so that the residue can have ascending or descending dynamics. Otherwise, the residue value would always be . The value of said constant can be changed with the following function. Arguments:
		 	nonZeroConst: Value of the constant that will be added to the null terms.
		 	
		EXTERN METHOD BOOLEAN nlsolver(FUNC_PTR fcn, INTEGER n, 
		                               OUT REAL x[], 
		                               OUT REAL residues[], 
		                               OUT INTEGER info,
		                               OUT STRING errMsg= DUMMY_STRING)
		
		EXTERN METHOD BOOLEAN nldsolver(FUNC_PTR fcn, 
		                                INTEGER n, 
		                                OUT REAL x[], 
		                                OUT REAL residues[], 
		                                OUT INTEGER info, 
		                                OUT STRING equations[], 
		                                OUT STRING names[],
		                                OUT STRING errMsg= DUMMY_STRING)
		 	These two functions are for calling the NR solver so that the restrictions imposed by the inequalities are taken into account. These functions are analogous with their homonyms 'nlsolver' and 'nldsolver'.
		 	For parameter descriptions, see external steady solver chapter.
		 	
		EXTERN METHOD NO_TYPE clearAllGroups()
		 	Eliminate the groups defined for the inequalities solver.
		 	
		EXTERN METHOD BOOLEAN addGroup(IN STRING groupName, 
		                               IN ENUM INE_GROUP_TYPE type, 
		                               FUNC_PTR updateValuesFunct)
		 	The inequalities solver works with one or more groups of inequalities so that in each group one of the inequalities will be equalled to zero and the remaining will be satisfied. To introduce the definition of a new group, the following is used. Arguments:
		 	groupName: Name of the group that will be added. It must be unique.
		 	type: Indicates whether the group will be saturated or dominating.
		 	updateValuesFunct: Pointer to the function for updating the values of the two sides of the inequalities.
		 	
		EXTERN METHOD BOOLEAN addInequality(IN STRING groupName, 
		                                    IN STRING ineName, 
		                                    IN ENUM INE_INE_SIGN sign, 
		                                    IN ENUM INE_INE_TYPE type)
		 	The inequalities that form a group will be added through the function. Arguments:
		 	groupName: Name of the group to which the inequality will pertain.
		 	ineName: Name that will identify the inequality within the group. It must be unique.
		 	sign: Sign of the inequality: lower or upper.
		 	type: In saturated groups. It establishes whether the inequality is lower bound or upper bound.
		 	
		EXTERN METHOD REAL getResidueOfGroup(IN STRING groupName)
		 	This function selects the inequality which will be equalled to zero in a determined group and returns the corresponding relative residue. Arguments:
		 	groupName: Name of the group from which we want to calculate the residue.
		 	
		EXTERN METHOD BOOLEAN setGroupFrozen(IN STRING groupName, 
		                                     IN BOOLEAN value, 
		                                     IN STRING ineID)
		 	This function provides a way to freeze the chosen equation in a group of inequalities. Arguments:
		 	groupName: Name of the group to be frozen.
		 	value: TRUE to freeze, FALSE to unfreeze.
		 	ineID: If the value is "", it will be frozen with the current inequality. If you wish to use a different equation, an introduction inequality ID must be given (view the log to check that the right one is used).
		 	
		EXTERN METHOD BOOLEAN setActiveIneGroup(IN STRING groupName,
		                                        BOOLEAN value, 
		                                        IN STRING ineID)
		 	This function provides a way to activate/deactivate the chosen equation in a group of inequalities. Arguments:
		 	groupName: Name of the group to which the inequality to be activate/deactivate belongs.
		 	value: TRUE to activate, FALSE to deactivate.
		 	ineID: ID of the inequality to activate/deactivate.
		 	
		EXTERN METHOD BOOLEAN startResiduesFunction()
		 	This function is only valid to ensure compatibility with earlier versions and should not be used.
		
		"C++" FUNCTION BOOLEAN iniInequalityClass(OUT INEQUALITIES ptr)
		In addition to the above methods, there is a global function which must be called once before using the class instance. Arguments:
		 	ptr: Pointer to the inequations class instance.
		 	
		EXTERN METHOD NO_TYPE setSatisfyMainEquationOnStart(IN BOOLEAN value=TRUE)
		 	Set if the inequality solver must satisfy main equation on start (default is TRUE).
		 	
		EXTERN METHOD NO_TYPE setForceReduceDeviationOfSelectedEquation(IN BOOLEAN value=TRUE)
		 	Set if the inequality solver must reduce the deviation of the selected equation before allowing the change of equation (default is TRUE).
		 	
		EXTERN METHOD NO_TYPE setForceCalculateJacobianIfEquationChanges(IN BOOLEAN value=TRUE)
		 	Set if the inequality solver must force to calculate a new Jacobian matrix in the event of a change in any equation (default is TRUE).
		
		
			Enumerative Types
		Enumerative type to decide the type of an inequalities group:
		CATEGORIES	DESCRIPTION
		INE_DOMINATING	The group is dominating
		INE_SATURATED	The group is saturated
		
		Enumerative type to decide the sign of an inequality:
		CATEGORIES	DESCRIPTION
		INE_S_GREATER	Left side greater than right side
		INE_S_LOWER	Left side lower than right side
		INE_S_EQ	Left side equal to right side
		
		Enumerative type to decide the type of an inequality:
		CATEGORIES	DESCRIPTION
		INE_T_NOTYPE	Type of equation for dominating groups and for the main equation of saturated groups
		INE_T_UPPER	Define an upper bound in saturated groups
		INE_T_LOWER	Define a lower bound in saturated groups
		
			Extra Functions
		A function has to be implemented in the experiment to allow the inequality value to be updated. This function will have two arrays whose dimensions will be the number of inequalities of the group (including the main one). The first array contains the left part of each inequality. The second array contains the right part of each inequality.
	
	Reports
			Problem Status
		Both in the output screen and in the reports to files, the inequalities solver will provide information on the process and the extent of detail will depend on the DEBUG_LEVEL selected.
		A photo can be taken of the problem status, either at intermediate points or at the end of the calculation. This photo is in table format, comprising general data and the status of each of the groups added to the model. The information is as follows:
		Information shown in the main header:
		 	problem: Number of the current problem.
		 	iter: Current iteration.
		 	info: Integration status information.
		 	-9 : Special intermediate status of the inequalities solver.
		 	tolerance: Tolerance used in inequality comparisons.
		 	
		Information shown in the group header:
		 	group: Group name.
		 	type: Type of the group (dominating, saturated).
		 	fulfilled equation: Inequality actually being used in the Jacobian (used as an equation).
		 	Actual status of the equations solver for the group.
		 	
		INEQUALITIES: (problem = 1, iter = 7, info = -9, tolerance = 1e-006)
		N.	Sel.	Group	Status	Name	Type	Val Y	Sign	Val Z	Deviation
		Group: 'group11', type: 'dominating', fulfilled equation: #3. The main equation has been changed
		#1	--	group11     	Ok	ln1	--	-12.3777       	<	1.2	-2.95884   
		#2	--	group11	Ok	ln2	--	-12.3777	<	-1.25	-1.6331
		#3	**	group11	Not Ok	ln3	--	-12.3777	= (>)	-4	1.02306
		Group: 'group21', type: 'dominating', fulfilled equation: #1. Inequalities problem is NOT Ok and without convergence
		#1	**	group21	Not Ok	lm1	--	19.6246	= (>)	1.1	1.78769
		#2	--	group21	Ok	lm2	--	19.6246	>	0.25	-1.94968
		#3	--	group21	Not Ok	lm3	--	19.6246	<	2	1.63005
		
		The meanings of the columns are:
		 	N.: Number of the inequality, the introduction order.
		 	Sel.: Current selected inequality.
		 	Group: Name of the group of the inequality.
		 	Status: Define if the inequality is feasible (Ok) or not.
		 	Name: Name of the inequality.
		 	Type: Type of the equation ("no type in dominating groups").
		 	Val Y: Left value of the inequality.
		 	Sign: Sign of the inequality. If the sign is  the sign of the inequality is shown in brackets.
		 	Val Z: Right value of the inequality.
		 	Deviation: Relative measurement of the differential value between the right value and the left value.
			Statistical Report
		When all the calculations have ended, a table with the final statistics will be displayed so that we can see at a glance how many problems have been solved.
		INEQUALITIES: Final statistics of the inequalities problem
		Total problems Ok:	1	Total problems NOT Ok:	0
		Total internal checks Ok:	6	Total internal checks NOT Ok:	74
		Times called to solveGroup:	78
		Global inequality problem: OK 
		The following is the meaning of the information in the table:
		 	Total problems Ok: Number of problems solved correctly.
		 	Total problems NOT Ok: Number of problems not solved.
		 	Total internal checks Ok: Number of times that all the inequalities were satisfied when an individual group was checked.
		 	Total internal checks NOT Ok: Number of times that any of the inequalities were not satisfied when an individual group was checked.
		 	Times called to solveGroup: Number of times that the residues function called the getResidueOfGroup function.
		 	Global inequality problem: Ok if all the problems in the model were correctly solved.
		
	

*/
COMPONENT comp_inequalityClass

END COMPONENT
// XML Parser Class
/*

	XML (eXtensible Markup Language) has become a standard language for data storage files for several reasons:
	 	The files are ASCII and, therefore, multiplatform.
	 	XML is a structured language which facilitates modifications and extensions.
	 	There is a wide range of parsers available on the market.
	Knowing the structure of an XML, it is easy to locate a specific datum independently of the program with which it was written.
	It has been implemented a parser that can be accessed from components and experiments, thus enabling models to easily read and write files in XML format. We did not attempt to cover all aspects related to the language; we simply selected the methods that are used the most, obtaining a simple but powerful interface.
	The XML format contains two data structures of note:
	 	Simple API for XML (SAX): plane structure.
	 	Document Object Model (DOM): tree structure.

	XML Parser Class Interface
		We have implemented a class in EL to parse XML files, a DOM structure without a Document Type Definition (DTD) validator. This class can be accessed at both the component level and the experiment level.
		The natural way to navigate through an XML DOM structure is by using nodes. The nodes will be handled internally in each XMLParser object. Each instance will have a pointer which points to a single node. The pointer will point to the last node in use; i.e., if the addNode function is used, the pointer will point to the child node that is created; the nodeParent function is used to return to the parent. Therefore, if we want to add three nodes to a root node, we have to call the two functions three times consecutively.
		The interface has been divided into three sets:
		 	Methods for managing XML documents.
		 	Methods for managing XML nodes.
		 	Methods for managing XML attributes.
		The following subsections explain the different methods implemented in the class, which enable us to work with the XML documents. Typical examples of use   like those included at the end of this section   involve different actions pertaining to the above three sets:
		 	Download to memory an existing XML document in an XML file, or create a new one (document handling).
		 	Create new nodes, or navigate through existing ones (node handling).
		 	Modify the attributes of the current node (attribute handling).
		 	Save the document to memory in an XML file (document handling).
			Document Methods
		An XML document is an instantiation of an ASCII file in structured memory. It can read, contain and save the data structure.
		The standard XML specifies that there must be a root node which will contain the other nodes. This node is unique, at the top of the tree and can be used to determine the type of information stored in the document. If we want to programmatically create an XML structure in memory, the first method to call will be that associated with the creation of its root node. In this way, we will create a document of a determined type.
		In principle, the XML document is designed to obtain information from a file, or to write information from a file. However, this class may also be useful for certain structured information in memory which can later be quickly and effectively accessed without involving file input/output.
		 	Create root node for an XML DOM structure. This function must be called only once, when creating a document manually. When an XML file is loaded, the node is automatically created and the function should therefore not be called.
		
		EXTERN METHOD BOOLEAN createRootParent(IN STRING type)
		 	type: Specifies the XML document type.
		 
		
		EXTERN METHOD BOOLEAN loadFile(IN STRING fileName, IN STRING type, IN STRING version)
		 	Load an XML DOM structure from a file. This function should not be called together with createRootParent, because the root node will be created with the type defined in the file. Arguments:
		 	fileName: XML file which will be downloaded to memory.
		 	type: Specifies the XML document type. If the document type does not coincide with the value of the parameter, an error will occur and the document will not be downloaded.
		 	version: XML document version required. If this field is not checked, the value will be an empty string.
		 	
		EXTERN METHOD BOOLEAN saveFile(IN STRING fileName)
		 	Save an XML DOM structure to a file.
		 	fileName: XML file to which the memory structure will be saved
		 	
		EXTERN METHOD BOOLEAN setISO_8859_1()
		 	Set format to 'ISO-8859-1'.
		 	
		EXTERN METHOD BOOLEAN setUTF_8()
		 	Set format to 'UTF-8'.
		
			Node Methods
		Nodes are the basic construction elements of an XML structure. They are organised into a tree in such a way that one node may contain N number of nodes. A node may in turn have attributes that give the node information.
		EXTERN METHOD BOOLEAN hasChildNodes() 
		 	Check if current node has one or more children.
		 	
		EXTERN METHOD STRING nodeParent()
		 	The internal document pointer will point to the parent of the current node.
		 	
		EXTERN METHOD BOOLEAN addNode(IN STRING name)
		 	Add sub-node to current node. The internal document pointer will point to the new node.
		 	name: Name of the new node.
		 	
		EXTERN METHOD STRING firstChild(IN STRING nodeName = "")
		 	Get first child node absolutely or by searching for a name in the current node. If the current node has no children or none of the children has the required name, the function will return an empty string. If there is a valid node, the internal document pointer will point to the node found.
		 	nodeName: If the string is empty, the function will search for the first absolute child node of the current node. If the parameter has a value, the function will search for the first child node whose name coincides with it.
		 	
		EXTERN METHOD STRING nextSibling()
		 	Get next node in the same level. If there are no more nodes in the current level, the function will return an empty string. If there is a valid node, the internal document pointer will point to the node that is found.
		 	
		EXTERN METHOD STRING nodeName()
		 	Obtains the name of the node to which the internal document pointer is pointing.
		 	
		EXTERN METHOD BOOLEAN setNodeName(IN STRING nodeName)
		 	Modifies the name of the node to which the internal document pointer is pointing. Arguments:
		 	nodeName: New name of the current node.
		 	
		EXTERN METHOD BOOLEAN goToNodeByPlainPath(IN STRING plainPath)
		 	With this function we will place the internal pointer in a node of the document. In a single step you can skip several levels. In order to do that, the names of the nodes through which you pass into an input parameter are stringed. In the DOM structure, there can be several nodes with the same name on the same level; if this occurs, you will enter into the first node encountered. To avoid this, the nodes can be individualized using attributes. In this case, an attribute that should exist and the value it should have can be specified optionally for each node. The search for the node will always be performed based on the root node. If one of the elements is not found during the run of the path, the function will yield a FALSE response and the document pointer will continue indicating the node at which it was pointed prior to calling the function. Arguments:
		 	plainPath: Route that will be followed until the desired node is reached. The nodes are strung consecutively separated by the separator ##. If you wish to specify the condition attribute (name and value) in a specific node, write the name of the node, the separator &&, the name of the attribute, a second separator && and the value of the attribute.
			Example: You have the input chain "node1##node2&&attName&&attValue##node3". Passing the cursor along the string placing the pointer in the root node and find the first node which name is "node1". Inside this node, look for the next node, which name is "node2" with an attribute "attName" which value is "attValue". Finally we will look for the first child node of "node2" which name is "node3". Upon exiting the function the pointer will be positioned at "node3" and can work with it, for example, by petitioning the value of one of its attributes. 
			Attribute Methods
		Attributes provide a node with information, and they are at the same level as the node name in the XML tree. Attributes are merely a listing of the attribute-value binomial. Attributes cannot have children or associated nodes. Each node has a pointer that points to the current attribute for said node.
		EXTERN METHOD STRING getAttribute(IN STRING attName, IN STRING defaultValue = "" )
		 	Obtains the first attribute found by its name. The value will be returned as a string. If there is a valid attribute, the internal document pointer will point to the node found. Arguments:
		 	attName: Name of the attribute to get.
		 	defaultValue: This string will be returned if the attribute is not found in the node.
		 	
		EXTERN METHOD BOOLEAN setAttribute(IN STRING attName, IN STRING value )
		 	Add string attribute to current node. Arguments:
		 	attName: Name of the attribute to set.
		 	value: Value of the attribute.
		 	
		EXTERN METHOD STRING getAttributeValueString( OUT BOOLEAN isOk = DUMMY_BOOLEAN )
		 	Obtains the STRING value of the current attribute of the current node. Arguments:
		 	isOk: Returns FALSE if there is a problem obtaining the attribute value.
		 	
		EXTERN METHOD REAL getAttributeValueReal( OUT BOOLEAN isOk = DUMMY_BOOLEAN )
		 	Obtains REAL as the current attribute value of the current node. Arguments:
		 	isOk: Returns FALSE if there is a problem obtaining the attribute value.
		 	
		EXTERN METHOD INTEGER getAttributeValueInteger( OUT BOOLEAN isOk = DUMMY_BOOLEAN )
		 	Obtains an INTEGER as the current attribute value of the current node. Arguments:
		 	isOk: Returns FALSE if there is a problem obtaining the attribute value.
		 	
		EXTERN METHOD BOOLEAN getAttributeValueBoolean( OUT BOOLEAN isOk = DUMMY_BOOLEAN )
		 	Obtains a BOOLEAN as the current attribute value of the current node. Arguments:
		 	isOk: Returns FALSE if there is a problem obtaining the attribute value.
		 	
		EXTERN METHOD BOOLEAN setAttributeValueString( IN STRING value )
		 	Set current attribute value of current node as STRING. Arguments:
		 	value: New attribute value.
		 	
		EXTERN METHOD BOOLEAN setAttributeValueReal( IN REAL value )
		 	Set current attribute value of current node as REAL. Arguments:
		 	value: New attribute value.
		EXTERN METHOD BOOLEAN setAttributeValueInteger( IN INTEGER value )
		 	Set current attribute value of current node as INTEGER. Arguments:
		 	value: New attribute value.
		EXTERN METHOD BOOLEAN setAttributeValueBoolean( IN BOOLEAN value )
		 	Set current attribute value of current node as BOOLEAN. Arguments:
		 	value: New attribute value.
		 	
		EXTERN METHOD BOOLEAN firstAttribute(OUT STRING attName, OUT STRING value)
		 	Get first absolute attribute. If there is valid attribute, the internal document pointer will point to the node found.
		 	attName: First absolute attribute name. If the node has no attributes, an empty string is returned.
		 	value: Value of the attribute found. If the attribute is not valid, an empty string is returned.
		 	
		EXTERN METHOD BOOLEAN nextAttribute(OUT STRING attName, OUT STRING value)
		 	Get next attribute. Arguments:
		 	attName: Name of the next attribute absolutely if the parameter is an empty string or its name coincides with the value of the parameter. If the attribute is not valid, an empty string is returned.
		 	value: Value of the attribute found. If the attribute is not valid, an empty string is returned.
		 	
		EXTERN METHOD BOOLEAN hasAttribute(IN STRING attName )
		 	Returns true if an attribute exists by name. If there is a valid attribute, the internal document pointer will point to the node found. Arguments:
		 	attName: Name of the attribute to check.
			
	

*/
COMPONENT comp_xmlParserClass
	OBJECTS
        XMLParser in
END COMPONENT
// ODE SOLVER class
/*
	The ODE_SOLVER class is used for solving ordinary differential equation systems independently.
	The class description is as follows:
	EXTERN CLASS ODE_SOLVER IS_A INTEG_topClass
	   METHODS
	
	      -- init the solver
	      EXTERN METHOD BOOLEAN init(IN ENUM t_integMethods method, 
	                                 FUNC_PTR fcnGetDerivatives, IN INTEGER ndyn)
	
	      -- integrate one step
	      EXTERN METHOD BOOLEAN integStep(OUT REAL fromTime,IN REAL delta,
	                                      OUT REAL y[],OUT REAL yprime[])
		
	      -- integrate one period of time, pass a function pointer to be called 
	      --   on every step for reporting
	      EXTERN METHOD BOOLEAN integ(OUT REAL fromTime,IN REAL delta,
	                                  IN REAL toTime,OUT REAL y[],OUT REAL yprime[], 
	                                  FUNC_PTR fcn_report)
			
	      -- call the residues function
	      EXTERN METHOD BOOLEAN getDerivs(REAL fromTime,OUT REAL y[],
	                                      OUT REAL yprime[])
			
	END CLASS INCLUDE "INTEG_simula.h" IN "INTEG.lib"
	
	Initialization
	To use the object, it must first be initialized correctly. Use the following method for this purpose:
	EXTERN METHOD BOOLEAN init(IN ENUM t_integMethods method, 
	                           FUNC_PTR fcnGetDerivatives, IN INTEGER ndyn)
	Where the arguments are:
	 	method: This is the integration method desired. Only Runge-Kutta (RK4) and Euler (EULER) are permitted
	 	fcnGetDerivatives: This is a function that has to be applied to obtain the derivatives. The function has to have the following arguments and return type:
	   BOOLEAN fcnGetDerivatives(IN REAL myTime,REAL y[], OUT REAL yprime[])
	 	This function should obtain the new values of the derivatives and write them in the yprime[] vector. Its inputs are the time (myTime) and dynamics vector y[]. If there is a problem with the calculation, it should return FALSE. Otherwise, it will return TRUE.
	 	ndyn: Number of dynamics of the model
	
	Direct obtaining of derivatives
		Sometimes you may want to call the derivatives calculation function directly, for instance, at the beginning, in order to obtain a first estimate of them. Use the method getDerivs to do this:
		EXTERN METHOD BOOLEAN getDerivs(REAL fromTime,OUT REAL y[],OUT REAL yprime[])
		The arguments are:
		 	fromTime: Actual time (input)
		 	y: Dynamics vector (input)
		 	yprime: Derivatives vector (input/output)
	
	Integrating a step
		To integrate a step, use the method integStep():
		EXTERN METHOD BOOLEAN integStep(OUT REAL fromTime,IN REAL delta,
		                                OUT REAL y[],OUT REAL yprime[])
		The arguments are:
		 	fromTime: This is the actual time of (input/output)
		 	delta: This is the increment of time required (input)
		 	y: This the vector of dynamics (input/output)
		 	yprime: This is the vector of derivatives (input/output)
		This method performs a complete integration and returns TRUE if everything is alright; otherwise, it returns FALSE. The final values of the variables fromTime, y[] and yprime[] are updated after the call to the new values of time, dynamic values and derivative values.
	
	Integrating a period
		To integrate a period of time, use the method integ():
		EXTERN METHOD BOOLEAN integ(OUT REAL fromTime,IN REAL delta, IN REAL toTime,
		                            OUT REAL y[],OUT REAL yprime[],FUNC_PTR fcn_report)
		The arguments are:
		 	fromTime: Actual time (input/output)
		 	delta: Increment of time required (input)
		 	toTime: Final integration time (input)
		 	y[]: Dynamics vector (input/output)
		 	yprime[]:  Derivatives vector (input/output)
		 	fcn_report: This is a pointer to a function that will be called automatically when an internal integration step is finished. It must be as follows:
		 	
		   EXTERN METHOD BOOLEAN fcn_report(REAL fromTime, REAL y[], REAL yprime[])
		 	Where fromTime, y[] and yprime[] are input arguments that you can use to update system variables to be reported. A call to REPORT_REFRESH() can be included to update both the reports generated and the plotters and to be able to view the results of the internal steps.
		 	This method integrates a complete period of time and returns TRUE if everything has gone well, or FALSE if it has not. The final values of fromTime, y[] and yprime[] are updated during the call to the last calculated values of time, dynamic values and derivative values.
	

*/
COMPONENT comp_odeSolverClass


END COMPONENT
/*
	The associated partition has a Jacobian of size two: one dynamic variable y and one algebraic variable x. Since the ODE_SOLVER class can solve only dynamic systems we need to use another procedure to solve the algebraic. We shall use the function FRES_ALG_ALL(), which basically calls the residues function of this model and solves the internal algebraics. Then we have all ingredients: ODE_SOLVER will take care of the dynamics and FRES_ALG_ALL() will solve the algebraics. Be aware that we need to call FRES_ALG_ALL(TRUE) with the argument TRUE, otherwise the derivative is not updated and cannot be returned properly
*/
COMPONENT comp_odeSolverClass1
	DATA
	   REAL d= 1
	 DECLS
	   REAL x
	   REAL y
	CONTINUOUS
	   y'= cos(TIME) + d
	   x -sin(x) = 5 + y
END COMPONENT
// Class for creating files in csv format
/*
The EFileCsv class allows users to easily generate files in csv (comma-separated values) format. Csv format is
a very simple and popular format; for example, Microsoft Excel allows you to import this format directly.
The standard CSV format consists of fields separated by commas (depends on the regional configuration),
where each line represents an information record.
The EFileCsv class is the following:
EXTERN CLASS EFileCsv
DECLS
METHODS
EXTERN METHOD BOOLEAN open ( STRING fileName )
EXTERN METHOD BOOLEAN close ()
EXTERN METHOD BOOLEAN header ( STRING head )
EXTERN METHOD BOOLEAN addReal ( REAL value , INTEGER digits )
EXTERN METHOD BOOLEAN addInteger ( INTEGER value )
EXTERN METHOD BOOLEAN addString ( STRING value )
EXTERN METHOD BOOLEAN addBoolean ( BOOLEAN value )
EXTERN METHOD BOOLEAN newLine ()
EXTERN METHOD BOOLEAN isReady ()
END CLASS
The open(STRING fileName) method allows users to open a file given a name into which information in CSV
format will be inserted. If it can not open it, it returns FALSE; if no problems were encountered, it returns
TRUE.
The close() method closes the generated file and the isReady() method returns TRUE if the file is already open
and FALSE if not.
Users can enter data into STRING, REAL and INTEGER type files using the methods addString(STRING
value), addReal(REAL value,INTEGER digits) and addInteger(INTEGER value). In the case of REAL types
it is possible to write the maximum number of digits to be printed in the second parameter.
The newLine() method enters a new line in the file, or starts a new record, which amounts to the same thing.
*/
FUNCTION REAL func_fGenCsv ( STRING fileName )
	DECLS
	OBJECTS
		EFileCsv csv
	BODY
		ASSERT ( csv. open ( fileName ) == TRUE ) FATAL " Cannot open csv file "
		csv.header ("Name ,Phone , Age")
		csv.addString (" Phil ")
		csv.addInteger (673346066)
		csv.addReal (1899.36 ,6)
		csv.newLine ()
		csv.addString (" Daisy ")
		csv.addInteger (695663771)
		csv.addReal (3066.986 ,6)
		csv.newLine ()
		csv.close ()
	RETURN 0
END FUNCTION
COMPONENT comp_eFileCsv
	DECLS
		REAL f
		STRING a = "@MODELLING_LANGUAGE@/inputFiles/csvFile.csv"
	CONTINUOUS
	
		f=func_fGenCsv(a)

END COMPONENT
//ERandomVector class for producing random values
/*
Class ERandomVector allows the user to produce random numbers in a vector and to work with them. Basically,
the user creates an instance of this type of special vector, states how many samples he desires and what
type of probability density function he wants to use, and the class automatically produces all the numbers in
the vector for later use. It can be used for Monte Carlo simulation.

The interface of class ERandomVector is as follows:
EXTERN CLASS ERandomVector
DECLS
METHODS
EXTERN METHOD BOOLEAN populate ( INTEGER nvalues , ENUM t_randomDistribution dis ,
REAL par1 , REAL par2 = 0, REAL par3 = 0)
EXTERN METHOD BOOLEAN populateSorted ( INTEGER nvalues , ENUM t_randomDistribution
dis , REAL par1 , REAL par2 = 0, REAL par3 = 0)
EXTERN METHOD REAL seed ()
EXTERN METHOD REAL setSeed ( INTEGER seed )
EXTERN METHOD REAL mean ()
EXTERN METHOD REAL stdDev ()
EXTERN METHOD REAL median ()
EXTERN METHOD REAL mode ()
EXTERN METHOD REAL variance ()
EXTERN METHOD REAL skewness ()
EXTERN METHOD REAL kurtosis ()
EXTERN METHOD REAL minv ()
EXTERN METHOD REAL maxv ()
EXTERN METHOD REAL range ()
EXTERN METHOD BOOLEAN segments ( INTEGER n, OUT REAL inUrange [], OUT INTEGER
inUdistr [])
EXTERN METHOD BOOLEAN append ( REAL v)
EXTERN METHOD NO_TYPE clear ()
EXTERN METHOD INTEGER size ()
EXTERN METHOD REAL at( INTEGER index )
EXTERN METHOD ENUM t_randomDistribution getDistr ()
EXTERN METHOD REAL getParam1 ()
EXTERN METHOD REAL getParam2 ()
EXTERN METHOD REAL getParam3 ()
EXTERN METHOD STRING asString ( INTEGER digits =9)
EXTERN METHOD STRING statAsString ( INTEGER digits =9)
EXTERN METHOD STRING histogram ( INTEGER nsegments , INTEGER nstarts , INTEGER digits )
END CLASS
The main methods are populate() and populateSorted(), which generate random numbers given different parameters.
Other methods are:
 populate(n,distribution,par1,par2,par3) generates n random values according to the distribution
populatedSorted(n,distribution,par1,par2,par3) generates n random values in strict order according to
the distribution
 setSeed(mySeed) and seed() set/get a seed to the random distribution
 size() returns the size of the vector
 at(index) returns the value at position index
 getDistr() returns the actual distribution of the object
 par1, par2 & par3: Depending on the distribution, these parameters can mean different things.
 mean(). It returns the arithmetic mean
 stdDev().It returns the standard deviation
 median().It returns the median
 mode().It returns the mode of the distribution
 variance().It returns the variance
skewness().It returns the skewness of the distribution.
 kurtosis().It returns the kurtosis of the distribution.
 minv().It returns the minimum value of the vector
 maxv().It returns the maximum value of the vector
 range().It returns the maxv()-minv() difference
 asString(INTEGER digits=9. It returns a string with all values, digits is used to report the precision
required
 statAsString(INTEGER digits=9). It returns a summary of the statistics associated to the vector. digits is
used to report the precision required
 histogram(nsegments, nstarts, digits) split te values in nsegments and create an ASCII list of stars lines
with proportional values according to the number of values on each segment
 segments(nsegments, inUrange[],inUdistr[])) fill in two vectors inUrange and inUdistr with the distribution
of values
 clear() cleans the object
The following types of distributions are available (the necessary parameters and validity range are written in
parentheses):
DISTR_NORMAL (, s>0): Produces a random number according to the probability density function:
Where (par1) is the mean and s(par2), the standard deviation.
DISTR_LOG_NORMAL(m>0,s>0): Produces random numbers according to the probability density function:

*/
/*
Let’s look at a simple example. We are going to produce 5 random numbers using 3 different probability
density functions: DISTR_NORMAL (mean=7,stdDev=0.2), DISTR_POISSON (=10) and DISTR_CHI (n=6).
Then, the vectors are printed using the asString() method with 4 digits:
*/
/*
The output of this function is:
NORMAL = 7.223 6.945 7.054 7.126 7.101 7.135 7.11 6.833 7.052 7.015
POISSON = 7 11 11 10 13 15 12 7 11 9
CHI_SQUARED = 7.367 7.133 7.084 9.08 5.364 9.687 7.117 4.294 13.46 3.015
*/
FUNCTION NO_TYPE func_random1 ()
	OBJECTS
		ERandomVector rn , rp , rc
	BODY
		rn. populate (10 , DISTR_NORMAL ,7, 0.2)
		WRITE (" NORMAL = %s\n",rn. asString (4))
		rp. populate (10 , DISTR_POISSON ,10)
		WRITE (" POISSON = %s\n",rp. asString (4))
		rc. populate (10 , DISTR_CHI_SQUARED ,6)
		WRITE (" CHI_SQUARED = %s\n",rc. asString (4))
END FUNCTION
/*
In this case, the vector orders the random numbers from lowest to highest:
rv= 6.785 6.881 6.927 6.956 7.13
*/
FUNCTION NO_TYPE func_random2 ()
	OBJECTS
		ERandomVector rv
	BODY
		rv. populateSorted (5, DISTR_NORMAL ,7, 0.2)
		WRITE ("rv= %s\n",rv. asString (4))
END FUNCTION
/*
The output is:
position 1= 6.78456
position 2= 7.05137
position 3= 7.05389
position 4= 7.21021
position 5= 7.4619
rv size = 0
*/
FUNCTION NO_TYPE func_random3 ()
	OBJECTS
		ERandomVector rv
	BODY
		rv. populateSorted (5, DISTR_NORMAL ,7, 0.2)
		FOR (i IN 1,rv. size () )
			WRITE (" position %d= %g\n",i, rv.at(i))
		END FOR
		rv. clear ()
		WRITE ("rv size = %d\n",rv. size ())
END FUNCTION
/*
The output is:
rv= 6.869 6.949 6.951 7.175 7.224
rv= 6.869 6.949 6.951 7.175 7.224
*/
FUNCTION NO_TYPE func_random4 ()
	OBJECTS
		ERandomVector rv
	BODY
		rv. setSeed (456)
		rv. populateSorted (5, DISTR_NORMAL ,7, 0.2)
		WRITE ("rv= %s\n",rv. asString (4))
		rv. clear ()
		rv. populateSorted (5, DISTR_NORMAL ,7, 0.2)
		WRITE ("rv= %s\n",rv. asString (4))
END FUNCTION
/*
The output yields:
rv= 3.44 52.6 9.35
*/
FUNCTION NO_TYPE func_random5 ()
	OBJECTS
		ERandomVector rv
	BODY
		rv. append (3.44)
		rv. append (52.6)
		rv. append (9.35)
		WRITE ("rv= %s\n",rv. asString (4))
END FUNCTION
/*
It writes in the standard output:
rv= 3.44 52.6 9.35
rv mean = 21.7967
rv stdDev = 21.9145
*/
FUNCTION NO_TYPE func_random6 ()
	OBJECTS
		ERandomVector rv
	BODY
		rv. append (3.44)
		rv. append (52.6)
		rv. append (9.35)
		WRITE ("rv= %s\n",rv. asString (4))
		WRITE ("rv mean = %g\n",rv. mean ())
		WRITE ("rv stdDev = %g\n",rv. stdDev ())
END FUNCTION
/*
Which produces the output:
rv statistics = Mean : 7.002 Standard Deviation : 0.2009
MinVal : 6.353 MaxVal : 7.587 Range : 1.234
Skewness : -0.07264 Kurtosis : 3.023
Median : 7.006 Mode : 7 Variance : 0.04038
rv histogram =
* (6.358/6.485 Probab : 0.6%)
***** (6.485/6.611 Probab : 2.6%)
************ (6.611/6.737 Probab : 6%)
****************************** (6.737/6.864 Probab : 15.2%)
****************************************** (6.864/6.99 Probab : 21.1%)
************************************************** (6.99/7.117 Probab : 25%)
********************************** (7.117/7.243 Probab : 17.2%)
****************** (7.243/7.369 Probab : 9.2%)
***** (7.369/7.496 Probab : 2.7%)
(7.496/7.622 Probab : 0.4%)
*/
FUNCTION NO_TYPE func_random7 ()
	OBJECTS
		ERandomVector rv
	BODY
		rv. populate (1000 , DISTR_NORMAL ,7, 0.2)
		WRITE ("rv statistics = %s\n",rv. statAsString (4) )
		WRITE ("rv histogram =\n%s\n",rv. histogram (10 ,50 ,4) )
END FUNCTION
/*
Which yields:
segment 1 range [6.40034 ,6.64182] # items = 39
segment 2 range [6.64182 ,6.88329] # items = 256
segment 3 range [6.88329 ,7.12477] # items = 428
segment 4 range [7.12477 ,7.36625] # items = 244
segment 5 range [7.36625 ,7.60772] # items = 33
*/
FUNCTION NO_TYPE func_random8 ()
	DECLS
		CONST INTEGER nsegments =10
		REAL inUrange [ nsegments +1]
		INTEGER inUdistr [ nsegments ]
	OBJECTS
		ERandomVector rv
	BODY
		rv. populate (1000 , DISTR_NORMAL ,7, 0.2)
		rv. segments ( nsegments , inUrange , inUdistr )
		FOR (i IN 1, nsegments )
			WRITE (" segment %d [%g ,%g] # items = %d\n",i, inUrange [i], inUrange [i+1] , inUdistr [i])
		END FOR
END FUNCTION
COMPONENT comp_eRandomVector

END COMPONENT

// MAP class -- ONLY AVAILABLE IN PROOSIS
/*
	Program has a MAP class in the system that facilitates the use of maps for compressors, turbines, etc. A map is an object containing constants and tables. 
	In order to use the MAP class, users must declare objects of it in the OBJECTS block. For example:
	COMPONENT Compressor
	    OBJECTS
	        MAP map1
	END COMPONENT
	From this point on, the user can use the "map1" object like any other object in Program. The definition of the class with all the available methods in EL is:
	EXTERN CLASS MAP IS_A INTEG_topClass
	
	   DECLS
		STRING  m_name
	
	   METHODS
	      -- Read map from file
	      EXTERN METHOD BOOLEAN read(IN STRING fileName)
	
	      -- Free memory from tables and clear object entities
	      EXTERN METHOD NO_TYPE clear()
	
	      -- Printing methods
	      EXTERN METHOD BOOLEAN print(IN INTEGER format)
	      EXTERN METHOD BOOLEAN printTable(IN STRING tableName, IN INTEGER format)
	
	      -- return the dimension of a table
	      EXTERN METHOD INTEGER dimensionTable(IN STRING tableName)
	
	      --Sets general information
	      EXTERN METHOD NO_TYPE setName(STRING name)
	      EXTERN METHOD NO_TYPE setDescription(STRING description)
	      EXTERN METHOD NO_TYPE setType(STRING type)
	      EXTERN METHOD NO_TYPE setVersionInfo(STRING version,STRING revision,STRING
	            cdate,STRING mdate)
	
	      -- Gets general information
	      EXTERN METHOD STRING  getName()
	      EXTERN METHOD STRING  getDescription()
	      EXTERN METHOD STRING  getType()
	      EXTERN METHOD NO_TYPE getVersionInfo(OUT STRING version,
	               OUT STRING revision,OUT STRING cdate,OUT STRING mdate)
	   
	      -- Gets map variables values
	      EXTERN METHOD BOOLEAN getBoolean(IN STRING varName)
	      EXTERN METHOD INTEGER getInteger(IN STRING varName)
	      EXTERN METHOD REAL    getReal(IN STRING varName)
	      EXTERN METHOD STRING  getString(IN STRING varName)
	      EXTERN METHOD STRING  getVarDescription(IN STRING varName)
	
	
	      -- Interpolation functions for tables with default interpolation methods
	      EXTERN METHOD REAL interpd1D(IN STRING tableName, IN REAL x, 
	               OUT REAL dx=DUMMY_REAL)
	      EXTERN METHOD REAL interpd2D(IN STRING tableName, IN REAL x, IN REAL y, 
	               OUT REAL dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL)
	      EXTERN METHOD REAL interpd3D(IN STRING tableName, IN REAL x, IN REAL y, 
	               IN REAL z, OUT REAL dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL, 
	               OUT REAL dz=DUMMY_REAL) 
	
	      -- Generic Interpolation functions for tables giving the interpolation methods
	      EXTERN METHOD REAL interp1D(IN STRING tableName, IN ENUM t_interp tin, 
	               IN ENUM t_interp tex, IN REAL x, OUT REAL dx=DUMMY_REAL)
	      EXTERN METHOD REAL interp2D(IN STRING tableName, IN ENUM t_interp tin, 
	               IN ENUM t_interp tex, IN REAL x, IN REAL y, OUT REAL dx=DUMMY_REAL, 
	               OUT REAL dy=DUMMY_REAL)
	      EXTERN METHOD REAL interp3D(IN STRING tableName, IN ENUM t_interp tin, 
	               IN ENUM t_interp tex, IN REAL x, IN REAL y, IN REAL z, 
	               OUT REAL dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL, OUT REAL dz=DUMMY_REAL)
	
	      -- Generic Interpolation functions with default interpolation methods and
	      -- historical cells
	      EXTERN METHOD REAL interpHistd1D(IN STRING tableName, IN REAL x, 
	               OUT INTEGER pi, OUT REAL dx=DUMMY_REAL)
	      EXTERN METHOD REAL interpHistd2D(IN STRING tableName, IN REAL x, IN REAL y,
	               OUT INTEGER pi, OUT INTEGER pj, OUT REAL dx=DUMMY_REAL, 
	               OUT REAL dy=DUMMY_REAL)
	      EXTERN METHOD REAL interpHistd3D(IN STRING tableName, IN REAL x, IN REAL y, 
	               IN REAL z, OUT INTEGER pi, OUT INTEGER pj, OUT INTEGER pk,
	               OUT REAL dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL, OUT REAL dz=DUMMY_REAL)
									  
	      -- Interpolation functions for tables with user interpolation methods and
	         -- historical cells
	      EXTERN METHOD REAL interpHist1D(IN STRING tableName, IN ENUM t_interp tin, 
	               IN ENUM t_interp tex,IN REAL x, OUT INTEGER pi, OUT REAL dx=DUMMY_REAL)
	      EXTERN METHOD REAL interpHist2D(IN STRING tableName, IN ENUM t_interp tin, 
	               IN ENUM t_interp tex,IN REAL x, IN REAL y,  OUT INTEGER pi, 
	               OUT INTEGER pj,OUT REAL dx=DUMMY_REAL, OUT REAL dy=DUMMY_REAL)
	      EXTERN METHOD REAL interpHist3D(IN STRING tableName, IN ENUM t_interp tin, 
	               IN ENUM t_interp tex,IN REAL x, IN REAL y, IN REAL z, OUT INTEGER pi, 
	               OUT INTEGER pj, OUT INTEGER pk,OUT REAL dx=DUMMY_REAL, 
	               OUT REAL dy=DUMMY_REAL, OUT REAL dz=DUMMY_REAL)
									
	      -- Inverse interpolation functions for tables
	      EXTERN METHOD REAL invInterp1D(IN STRING tableName, IN ENUM t_interp tin, 
	               IN ENUM t_interp tex, IN REAL val)
	      EXTERN METHOD REAL invInterpd1D(IN STRING tableName, IN REAL val)
	
	      -- find a table
	      EXTERN METHOD BOOLEAN findTable(IN STRING tableName, OUT TABLE table)
	
	      -- insert/delete a table
	      EXTERN METHOD NO_TYPE insertTable (IN STRING tableName,TABLE table)
	      EXTERN METHOD BOOLEAN deleteTable (IN STRING tableName)
		
	      -- insert/delete constants
	      EXTERN METHOD NO_TYPE insertReal(IN STRING name,IN STRING descr,IN REAL value)
	      EXTERN METHOD NO_TYPE insertInteger(IN STRING name,IN STRING descr,
	               IN INTEGER value)
	      EXTERN METHOD NO_TYPE insertBoolean(IN STRING name,IN STRING descr,
	               IN BOOLEAN value)
	      EXTERN METHOD NO_TYPE insertString(IN STRING name,IN STRING descr,
	               IN STRING value)
	      EXTERN METHOD NO_TYPE deleteConstant(IN STRING name)
	
	      -- save
	      EXTERN METHOD NO_TYPE save (IN STRING filePath)
	
	END CLASS INCLUDE "INTEG_map.h" IN "INTEG.lib"
	
// interpolation in tables
	The interpolation in tables is done through the use of interpolation methods. All methods valid for TABLE class are also valid for MAP class (see TABLE interpolation methods) with only one difference: the first argument that the user has to pass is the name of the table to be interpolated (as a STRING).
*/

COMPONENT comp_map
    DECLS
        FILEPATH pathMap ="@MODELLING_LANGUAGE@/maps/map34.xml"	
        REAL x_linear
        REAL dx_linear
   OBJECTS
        MAP map1
    INIT
        map1.read(pathMap )
    CONTINUOUS
         -- interpolate in table "t1" assuming it is a 1D table
        x_linear = map1.interpd1D("PRsurge_vs_Wc", TIME, dx_linear)
END COMPONENT
