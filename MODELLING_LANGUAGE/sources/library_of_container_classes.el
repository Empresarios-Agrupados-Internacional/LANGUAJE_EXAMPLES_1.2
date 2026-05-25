/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: library_of_container_classes
// Library of COntainer Classes
Users often need to use object containers that can be dynamically dimensioned and that avoid having to resize
new memory to do so. Several typical containers have been implemented in EL, such as vectors, matrices,
dictionaries and sets. These allow several objects to be stored in a container with different ways of accessing
them.
All containers have advantages and disadvantages: some allow fast insertions but slower access and others
are just the opposite: new elements are inserted slowly but access is fast.
Container classes are generally an alternative to the use of arrays in EL. At the moment, users can store a data
vector in an array. However, the limitation of this is that it cannot be dynamically resized. Users can rely
on these more advanced containers that allow the automatic handling of memory. On the other hand, their
syntax in the class containers is less intuitive than arrays, since access to them is done through class methods
(eg. v.at(3) vs v[3]). Users will need to determine whether it is better to use an array or a container of this type
for a specific application.
-----------------------------------------------------------------------------------------*/
/*
// Vectors of objects
NOTE: Older versions used other names such as VECTOR_REAL for EVectorReal, VECTOR_INTEGER for
EVectorInt, VECTOR_BOOLEAN for EVectorBool and VECTOR_STRING for EVectorString, etc. These are
equivalent to the new ones. The only change is in the class name and the push_back() method name, which is
now called append() (although it is still valid).
The methods of the EVector class are:
EXTERN ABSTRACT CLASS EVector IS_A INTEG_topClass
METHODS
EXTERN METHOD NO_TYPE clear ()
EXTERN METHOD BOOLEAN erase ( INTEGER index )
EXTERN METHOD INTEGER size ()
EXTERN METHOD BOOLEAN empty ()
EXTERN METHOD STRING asString ()
EXTERN METHOD BOOLEAN append (IN EVectorClass s)
EXTERN METHOD BOOLEAN replace ( INTEGER index ,IN TargetClass s)
EXTERN METHOD EVectorClass at( INTEGER index )
EXTERN METHOD BOOLEAN get( INTEGER index , OUT TargetClass s)
EXTERN METHOD BOOLEAN set( INTEGER index , IN TargetClass s)
EXTERN METHOD BOOLEAN insert ( INTEGER index , IN TargetClass s)
EXTERN METHOD BOOLEAN assign ( INTEGER nitems , IN TargetClass s)
END CLASS
*/
COMPONENT comp_eVectorReal

END COMPONENT
FUNCTION NO_TYPE func_testVectorReal ()
	DECLS
	OBJECTS
		EVectorReal vr
	BODY
		WRITE ("\n\n *************** testVectorReal ()\n")
		FOR (i IN 1 ,11)
			vr. append (100+ i ) -- Add 11 elements to vr
		END FOR
		WRITE ("vr element 2 is %g\n",vr.at (2)) -- print position 2
		WRITE ("vr= %s ( size =%d)\n",vr. asString () ,vr. size ())
		vr. clear () -- clear the vector
		vr. assign (7 ,8) -- create 7 objects with value 8
		vr. replace (4 ,9) -- replace number at position 4
		vr. insert (7 ,6) -- insert a new element at position 7
		WRITE ("vr= %s ( size =%d)\n",vr. asString () ,vr. size ())
		vr. clear () -- clear the vector
		vr. set (5 ,6) -- set at position 5 the value 6
		vr. append (7) -- append at the end the value 7
		WRITE ("vr= %s ( size =%d)\n",vr. asString () ,vr. size ())
END FUNCTION
FUNCTION NO_TYPE func_testVectorMix ()
	DECLS
	OBJECTS
		EVectorInt vi
		EVectorString vs
		EVectorBool vb
	BODY
		WRITE ("\n\n *************** testVectorMix ()\n")
		vi. append (34) -- add an element to vi
		vi. set (3 , -56) -- change the value at position 3
		WRITE ("vi= %s ( size =%d)\n",vi. asString () ,vi. size ())
		vs. set (3," hello ") -- set some strings in vs
		vs. set (5," world !")
		WRITE ("vs= %s ( size =%d)\n",vs. asString () ,vs. size ())
		vb. assign (5, FALSE ) -- dimension vector vb to size 5
		vb. replace (3, TRUE ) -- replace value at position 3 to TRUE
		WRITE ("vb= %s ( size =%d)\n",vb. asString () ,vb. size ())
END FUNCTION
ENUM TM_colors = { red , blue , green , black , brown , white }
-- define the new class for storing a vector of TM_colors
TYPEDEF CLASS class_VectorColorsBasic IS_A EVector < TM_colors >
-- create a subclass for creating the asString () method
CLASS class_VectorColors IS_A class_VectorColorsBasic
	METHODS
		METHOD STRING asString ()
	DECLS
		STRING st
	BODY
		FOR (i IN 1, size ())
			WRITES (st ,"%s %s",st , gvalEnum2 ("TM_colors",at(i)) )
		END FOR
		RETURN st -- return vector in string format
	END METHOD
END CLASS
FUNCTION NO_TYPE func_testVectorEnumColors ()
	DECLS
		ENUM TM_colors c
	OBJECTS
		class_VectorColors ve
	BODY
		WRITE ("\n\n *************** testVectorEnumColors ()\n")
		ve. assign (6, black ) -- set dimension =6 with value black as default
		ve. set (3, green ) -- set color green at pos =3
		ve. set (6, blue ) -- set color blue at pos =6
		WRITE ("ve= %s ( size =%d)\n",ve. asString () ,ve. size ())
END FUNCTION
/*
The following example uses a vector of a class that is defined by the user. This gives an idea of the versatility
of the EVector class to store any type of object. Firstly, a class is defined to store information from a friend:
*/
CLASS class_Friends " Friend information class "
	DECLS
		PRIVATE STRING m_name = "" " friend name "
		PRIVATE INTEGER m_phone =0 " friend phone number "
	METHODS
		METHOD NO_TYPE setFriend ( STRING name , INTEGER phone )
			"Set a new friend and phone number "
			BODY
				m_name = name
			m_phone = phone
		END METHOD
		-- --------------------------
		METHOD STRING getName () "get the friend name "
			BODY
				RETURN m_name
		END METHOD
		-- --------------------------
		METHOD INTEGER getPhone () "get the phone number "
			BODY
				RETURN m_phone
		END METHOD
		-- --------------------------
		METHOD NO_TYPE setPhone ( INTEGER phone ) "set the phone "
			BODY
				m_phone = phone
		END METHOD
		METHOD STRING asString () " return friend info as string "
			DECLS
				STRING st
				BODY
					WRITES (st ,"[%s ,%d]",m_name , m_phone )
				RETURN st
		END METHOD
END CLASS
/*
This Friends class has 2 variables (one is the name of the friend and the other is his/her telephone number)
and methods to initialize, obtain the information and return the object in string format.
A new class will now be created to represent an object vector of the Friend class and another subclass by
implementing the asString() method, as shown before with the vectors of enumerated types:
*/
-- Creates a new class that represents a vector of Friends
TYPEDEF CLASS class_VectorFriendsBasic IS_A EVector <class_Friends>
-- Creates a subclass for implementing a asString () method
CLASS class_VectorFriends IS_A class_VectorFriendsBasic
	METHODS
		METHOD STRING asString ()
			DECLS
				STRING st
			OBJECTS
				class_Friends f
			BODY
				FOR (i IN 1, size ())
					f= at(i)
					WRITES (st ,"%s [%s(%d)] ",st ,f. getName () ,f. getPhone ())
				END FOR
		RETURN st
	END METHOD
END CLASS
--A function will now be created where this new type of vector will be used:
FUNCTION NO_TYPE func_testVectorFriend ()
DECLS
OBJECTS
   class_VectorFriends vf
   class_Friends f
BODY
   WRITE("\n\n***************testVectorFriend()\n")
   f.setFriend("John",623636842) -- set new friend
   vf.append(f)                  -- add to the vector
   f.setFriend("Alice",627378532)
   vf.append(f)
   f.setFriend("Bruce",667388095)
   vf.append(f)
   WRITE("vf= %s(size=%d)\n",vf.asString(),vf.size())
   vf.at(2).setPhone(111222333)
   WRITE("vf= %s(size=%d)\n",vf.asString(),vf.size())
   f.setFriend("Luik",444555666)
   vf.insert(2,f)  -- insert new friend at pos=2
   WRITE("vf= %s(size=%d)\n",vf.asString(),vf.size())
   vf.erase(3)    -- erase friend at pos=3
   WRITE("vf= %s(size=%d)\n",vf.asString(),vf.size())
   WRITE("The phone of %s is %d\n",vf.at(2).getName(), vf.at(2).getPhone())
   f.setFriend("Charles",111111)
   vf.clear()       -- clear the vector
   vf.assign(5,f)  -- set 5 elements initialize to f
   WRITE("vf= %s(size=%d)\n",vf.asString(),vf.size())
END FUNCTION
/*
A more advanced example will now be shown, using a class that requires construction parameters. This will
be an implication of the Friends class, above, called Friends2, so that we can see only the power of using the
construction parameters
*/
-- Create a simplified Friends but using construction parameters
CLASS class_Friends2 ( INTEGER N, STRING st , REAL ab , BOOLEAN bo)
	DECLS
		STRING m_name = "" " friend name "
		INTEGER m_phone [N,N]= 44 " friend phone "
	METHODS
		METHOD NO_TYPE setFriend ( STRING name , INTEGER phone ) "set a new friend "
			BODY
				m_name = name
				m_phone [1 ,1]= phone
	END METHOD
	METHOD NO_TYPE setPhone(INTEGER phone) "set the phone"
   BODY
      m_phone[1,1]= phone
   END METHOD
END CLASS
--We will now be defining two new classes to define object vectors of this class, as shown in the above examples:
TYPEDEF CLASS class_VectorFriendsBasic2 IS_A EVector < class_Friends2 >
CLASS class_VectorFriends2 IS_A class_VectorFriendsBasic2
	METHODS
		METHOD STRING asString ()
			DECLS
				STRING st
			OBJECTS
				class_Friends2 (N=3, st=" hello ",ab =3.4 , bo= TRUE ) f
			BODY
				FOR (i IN 1, size ())
					f= at(i)
					WRITES (st ,"%s [%s(%d)] ",st ,f.m_name ,f. m_phone [1 ,1])
				END FOR
			RETURN st
		END METHOD
END CLASS
/*
It is obvious that every time an instance of Friends2 is created, it is mandatory to assign a value to its construction
parameters. The most important parameter is N (the rest are not used). This parameter dynamically
dimensions a two-dimensional vector (a matrix) of telephones. Let’s now look at a function to test this class:
*/
FUNCTION NO_TYPE func_testVectorFriendWithParamConstruction ()
OBJECTS
   class_VectorFriends2    vf
   class_Friends2(N=3,st="hello",ab=3.4,bo=TRUE) f -- set the parameters here
BODY
   WRITE("\n\n***************testVectorFriendWithParamConstruction()\n")
   f.setFriend("John",623636842)
   vf.append(f)
   f.setFriend("Alice",627378532)
   vf.append(f)
   f.setFriend("Bruce",667388095)
   vf.append(f)
   WRITE("vf= %s(size=%d)\n",vf.asString(),vf.size())
   vf.at(2).setFriend("Warren",111222333)
   WRITE("vf= %s(size=%d)\n",vf.asString(),vf.size())
END FUNCTION


// Matrices of objects
// Using dynamic matrices of objects
/*
The EMatrix class represents a two-dimensional matrix with a number of rows and columns. They are sequential
containers that are similar to the two-dimensional arrays (eg REAL v[4,5]), but with significant improvements
for the dynamic use of memory. Adjacent storage of objects in the memory shall be used. EMatrix
handles its elements in a dynamic array and enables random access by means of two indexes: row and column
The EMatrix class goes a step further, since it does not require the dimensioning of the matrix. The matrix
itself is capable of redimensioning itself in the execution time according to the use at that moment. It only
needs to state an EMatrix object and fill it in. It also has other advantages such as querying about its size at
any moment. A classic matrix does not offer this possibility.
The EMatrix class is defined as:
EXTERN ABSTRACT CLASS EMatrix IS_A INTEG_topClass
METHODS
EXTERN METHOD NO_TYPE clear ()
EXTERN METHOD INTEGER size ()
EXTERN METHOD INTEGER rows ()
EXTERN METHOD INTEGER cols ()
EXTERN METHOD BOOLEAN empty ()
EXTERN METHOD STRING asString ()
EXTERN METHOD BOOLEAN replace ( INTEGER row , INTEGER col ,IN TargetClass s)
EXTERN METHOD TtargetClass at( INTEGER row , INTEGER col)
EXTERN METHOD BOOLEAN get( INTEGER row , INTEGER col , OUT TargetClass s)
EXTERN METHOD BOOLEAN set( INTEGER row , INTEGER col , IN TargetClass s)
EXTERN METHOD BOOLEAN assign ( INTEGER nitems , IN TargetClass s)
END CLASS
The generic class TargetClass should be replaced by the type of object this container is using (e.g. in a EMatrixReal
the TargetClass=REAL).
Following is a description of each method:
 The clear() method clears the object and leaves it at size zero.
 The size() method returns the number of elements currently in the object: rows*columns
 The rows() method returns the number of rows
 The cols() method returns the number of columns
 The empty() method returns TRUE if the object is empty, or otherwise returns FALSE.
 The insert() method inserts an element in a given position
 The set() method places an element in the (row,column) position. If there are not enough rows or
columns, these are created automatically, and if that position existed already the contents are changed.
In other words, this method allows the automatic resizing of the vector in a way that is transparent for
the user.
 The at() method returns the content in a given position. If it does not exist, it issues a warning but
proceeds.
 The get() method is similar to at(), but the former returns the object in an argument. If that position does
not exist, it returns FALSE, whereas if it does exist it returns TRUE.
 The replace() method replaces the contents of an array position
The assign() method assigns an initial size to the matrix. This improves the performance, since it does
not need to be dynamically resized. This is the method that will be used if the size of the matrix is known
beforehand.
 The asString() method returns the matrix in string format. It is only implemented for the basic types
(REAL, INTEGER, BOOLEAN and STRING). In the case of other matrices, the modeller can be implemented
with its own method, as shown in the examples.
*/
--Below is an example using matrices of real values: This is a function that performs some typical operations
--with matrices:
COMPONENT comp_matrix

END COMPONENT

FUNCTION NO_TYPE func_testMatrixReal ()
	DECLS
		CONST INTEGER nrows =5
		CONST INTEGER ncols =4
	OBJECTS
		EMatrixReal mr
	BODY
		FOR (i IN 1, nrows )
			FOR (j IN 1, ncols )
				mr. set(i,j,i*j) -- set values in the matrix mr
			END FOR
		END FOR
		WRITE ("mr= \n%s ( rows =%d cols =%d size =%d)\n",mr. asString () ,mr. rows () ,mr. cols () ,mr.size ())
		mr. clear () -- clear matrix
		mr. set (4 ,2 ,3) -- set new values
		mr. set (3 ,3 ,9)
		WRITE ("mr= \n%s ( rows =%d cols =%d size =%d)\n",mr. asString () ,mr. rows () ,mr. cols () ,mr.size ())
		mr. clear () -- clear matrix
		mr. assign (6 ,4 ,3) -- dimension the matrix to rows =6, cols =4 and write 3 in all	fields
		mr. replace (2 ,3 ,0) -- replace element at position (2 ,3)
		mr. set (4 ,4 ,8) -- set element at position (4 ,4)
		WRITE ("mr= \n%s ( rows =%d cols =%d size =%d)\n",mr. asString () ,mr. rows () ,mr. cols () ,mr.size ())
		WRITE ("m[4 ,4]= %g\n",mr.at (4 ,4))
END FUNCTION
--Below is an example that uses other basic types, such as STRING and BOOLEAN:
FUNCTION NO_TYPE func_testMatrixMix ()
	DECLS
		CONST INTEGER nrows =5
		CONST INTEGER ncols =4
	OBJECTS
		EMatrixString ms
		EMatrixBool mb
	BODY
		ms. assign (3,3," hello ") -- create a matrix 3x3 and set " hello " on each field
		ms. replace (2,2," world ") -- replace position 2,2 with " world "
		WRITE ("ms= \n%s ( rows =%d cols =%d size =%d)\n",ms. asString () ,ms. rows () ,ms. cols () ,ms.size ())
		mb. set (4,2, TRUE ) -- Dimension the matrix to 4,2 and set last value
		mb. set (3,3, TRUE )
		WRITE ("mb= \n%s ( rows =%d cols =%d size =%d)\n",mb. asString () ,mb. rows () ,mb. cols () ,mb. size ())
END FUNCTION
--As in the case of the EVectors of enumerated type, an EMatrix of enumerated values can be created. Below is
--an example. The two new classes that will define the matrix class of colours will need to be defined firstly.
-- define basic class for storing matrices of colors
TYPEDEF CLASS class_MatrixColorsBasic IS_A EMatrix <TM_colors>
-- define final class for storing matrices of colors with asString () method
CLASS class_MatrixColors IS_A class_MatrixColorsBasic
	METHODS
		METHOD STRING asString () " return matrix of boolean as string "
			DECLS
				STRING st
			BODY
				FOR (i IN 1, rows ())
					FOR (j IN 1, cols ())
						WRITES (st ,"%s %s",st , gvalEnum2 ("TM_colors",at(i,j)) )
					END FOR
					WRITES (st ,"%s\n",st)
				END FOR
			RETURN st
		END METHOD
END CLASS
--The new MatrixColors class can be used as a new class in EL. We will now develop a function that uses this
--class and performs some functions:
FUNCTION NO_TYPE func_testMatrixEnumColors () " test matrix of enumerative type "
	OBJECTS
		class_MatrixColors mc
	BODY
		mc. assign (4,5, red) -- allocate size (4 ,5) and set default to red
		mc. replace (2,2, brown ) -- replace element at (2 ,2) by brown
		mc. set (6,6, green ) -- resize to (6 ,6) and set this value to green
		WRITE ("mc= \n%s ( rows =%d cols =%d size =%d)\n",mc. asString () ,mc. rows () ,mc. cols () ,mc.size ())
END FUNCTION
/*
It is also possible to create matrices of other non-basic classes that are defined in EL. To do this, we will use
the TYPEDEF that was used beforehand. For instance, we could develop a vector of the Friends class shown
in the previous paragraph, as well as a subclass to implement the asString() method
*/
-- define a subclass of EMatrix
TYPEDEF CLASS class_MatrixFriendsBasic IS_A EMatrix <class_Friends>
-- define a subclass of MatrixFriendsBasic
CLASS class_MatrixFriends IS_A class_MatrixFriendsBasic
	METHODS
		METHOD STRING asString () " return the object as a string "
			DECLS
				STRING st
			OBJECTS
				class_Friends f
			BODY
				FOR (i IN 1, rows ())
					FOR (j IN 1, cols ())
						f= at(i,j)
						WRITES (st ,"%s [%s(%d)] ",st ,f. getName () ,f. getPhone ())
					END FOR
					WRITES (st ,"%s\n",st)
				END FOR
			RETURN st
	END METHOD
END CLASS
--We can now create a function that uses this new MatrixFriends class:
FUNCTION NO_TYPE func_testMatrixFriends()
DECLS
	CONST INTEGER nrows=5
	CONST INTEGER ncols=4
OBJECTS
	class_MatrixFriends mf
	class_Friends f
BODY
	f.setFriend("John",636732634) -- set a new friend
	mf.set(2,2,f)
	f.setFriend("Luik",925252495)-- set a new friend
	mf.set(3,3,f)
	WRITE("mf= \n%s (rows=%d cols=%d size=%d)\n",mf.asString(),mf.rows(),mf.cols(),mf.size())

END FUNCTION
/*
As we can see, the definition of this new class is simply inherited from the EMatrix<> template class for
the VectorFriends vectors. Similarly, a daughter class can be created to implement the asString() method. As
mentioned above, it is not indispensable to create this daughter class. Instead it could be possible to work with
the "MatrixVectorFriendsBasic" class, but we are using it to simplify the printing of an object of such a complex
class
*/
-- Define a final class for the matrix of vectors
TYPEDEF CLASS class_MatrixVectorFriendsBasic IS_A EMatrix <class_VectorFriends>
CLASS class_MatrixVectorFriends IS_A class_MatrixVectorFriendsBasic
	METHODS
		METHOD STRING asString () " return object as string "
	DECLS
		STRING st
	OBJECTS
		class_VectorFriends vf
	BODY
		FOR (i IN 1, rows ())
			FOR (j IN 1, cols ())
				vf= at(i,j)
				WRITES (st ,"%s {%s}",st ,vf. asString () )
			END FOR
			WRITES (st ,"%s\n",st)
		END FOR
		RETURN st
	END METHOD
END CLASS
--We can now make a simple function to show how this MatrixVectorFriends class is used
FUNCTION NO_TYPE func_testMatrixVectorFriends () " test matrix of vectors "
OBJECTS
   class_MatrixVectorFriends mf
   class_VectorFriends vf
   class_Friends f1,f2
BODY
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


// Dictionaries of objects
//Using dictionaries of objects
/*
The class EDictionary is an associative (non-sequential) container that sorts its elements according to a key.
Each dictionary element is a pair <key,value> where the key can be of type types: STRING or INTEGER,
as users will always access the dictionary via one of these keys. The value can be of any basic type (REAL,
INTEGER, STRING, BOOLEAN), enumeration or object of another class defined in EL.
The EDictionary class has the following methods:
EXTERN ABSTRACT CLASS EDictionary IS_A INTEG_topClass
METHODS
EXTERN METHOD NO_TYPE clear ()
EXTERN METHOD INTEGER size ()
EXTERN METHOD BOOLEAN empty ()
EXTERN METHOD STRING asString ()
EXTERN METHOD BOOLEAN get( INTEGER index , OUT TkeyClass key , OUT ValueClass value )
EXTERN METHOD BOOLEAN set(IN TkeyClass key , IN ValueClass value )
EXTERN METHOD BOOLEAN find (IN TkeyClass key , OUT ValueClass value )
EXTERN METHOD BOOLEAN erase (IN TkeyClass key)
END CLASS
The generic class TkeyClass should be replaced by the type of object this container is using as key class (e.g. in
a EDictionaryStringInt the TkeyClass =STRING). The generic class ValueClass should be replaced by the type
of object this container is saving (e.g. in a EDictionaryStringInt the ValueClass =INTEGER).
Following is a description of each method:
 The clear() method clears the object and leaves it at size zero.
 The size() method returns the number of elements (pairs)
 The empty() method returns TRUE if the object is empty, or otherwise returns FALSE.
 The get() method, given an index, returns the key and the value in two arguments. If this element does
not exist (valid range is [1,size()]) it returns FALSE, otherwise TRUE.
 The set() method enters a new element with its pair <key,value> as two arguments. If another object
with that already exists, it replaces it. It returns TRUE unless it is unable to do so for some memory
management reason, in which case it returns FALSE.
 The find() method searches for an object in the dictionary using a key. If it finds it, it returns the value in
the second argument and TRUE, otherwise it returns FALSE.
 The erase() method deletes an element, using a given key.
*/
COMPONENT comp_dictionary

END COMPONENT
TYPEDEF CLASS class_PointerFriends IS_A EPointerDictString <class_Friends>
TYPEDEF CLASS class_DictFriendsPtr IS_A EDictionaryStringPtr <class_Friends , class_PointerFriends>
FUNCTION NO_TYPE func_testDictionaryFriendsPtr ()
	DECLS
		STRING key
	OBJECTS
		class_DictFriendsPtr dfr
		class_PointerFriends frPtr
		class_Friends fr
	BODY
		fr.setFriend(" John " ,623636842)
		dfr.findPtr(" John ",frPtr )
		frPtr.setPhone(222222)
END FUNCTION
FUNCTION NO_TYPE func_testDictionaryReal ()
	DECLS
		STRING key
		INTEGER keyInt
		REAL val
	OBJECTS
		EDictionaryStringReal dsr
		EDictionaryIntReal dir
	BODY
		WRITE ("\n\n *************** testDictionaryReal ()\n")
		dsr.set(" random " ,44.5)
		dsr.set(" fixed " , -34.4e3)
		dsr.set(" abrupted " ,736.3534757)
		IF( dsr.find (" fixed ",val) == TRUE ) THEN
			WRITE (" Found item with key =\" fixed \"\n")
		END IF
		dsr.get (3,key ,val)
		WRITE (" Found item at position 3 with pair <\"% s\" ,%g >\n",key , val)
		WRITE ("dsr= %s ( size =%d)\n",dsr.asString () ,dsr.size ())
		FOR (i IN 1,dsr.size ()) -- iterate over all dictionary
			dsr.get(i,key ,val)
			WRITE ("++ <%s ,%g >\n",key , val)
		END FOR
END FUNCTION
/*As already seen above for the previous containers, users can create a dictionary of objects created with classes
in EL. We will use the Friends class described in the EVector section. Declaring a new class for a dictionary
with pair <STRING,Friends> has to be done as follows:
*/
TYPEDEF CLASS class_DictionaryFriendsBasic IS_A EDictionaryString < class_Friends >
-- Create a final class implmenting asString () method
CLASS class_DictionaryFriends IS_A class_DictionaryFriendsBasic
	METHODS
		METHOD STRING asString ()
			DECLS
				STRING st ,key
			OBJECTS
				class_Friends friend
			BODY
				FOR (i IN 1, size ())
					get (i,key , friend )
					WRITES (st ,"%s <\"%s\" ,%s> ",st ,key , friend.asString ())
				END FOR
			RETURN st
		END METHOD
END CLASS
--Now we create a function for this dictionary:
FUNCTION NO_TYPE func_testDictionaryFriends ()
DECLS
   STRING key
OBJECTS
   class_DictionaryFriends dfr
   class_Friends fr
BODY
   WRITE("\n\n***************testDictionaryFriends()\n")
   fr.setFriend("John",623636842)
   dfr.set("John",fr)
   fr.setFriend("Alice",627378532)
   dfr.set("Alice",fr)
   fr.setFriend("Luik",936577888)
   dfr.set("Luik",fr)
   WRITE("dsr= %s (size=%d)\n",dfr.asString(),dfr.size())
   IF( dfr.get(3,key,fr) == TRUE) THEN
      WRITE("Found item at position 3 with pair<\"%s\",%s>\n",key,fr.asString())
	ELSE
	   WRITE("Not found element 3\n",key,fr.asString())
	END IF
	dfr.at("Alice").setPhone(111222333)
	WRITE("dsr= %s (size=%d)\n",dfr.asString(),dfr.size())
	dfr.erase("John")
	WRITE("dsr= %s (size=%d)\n",dfr.asString(),dfr.size())
END FUNCTION

TYPEDEF CLASS class_DictionaryMatrixVectorFriendsBasic   IS_A EDictionaryInt<class_MatrixVectorFriends>

CLASS class_DictionaryMatrixVectorFriends IS_A class_DictionaryMatrixVectorFriendsBasic
METHODS
	METHOD STRING asString() "retun element as string"
	DECLS
	   INTEGER keyInt
	   STRING st
	OBJECTS
	   class_MatrixVectorFriends mvf
	BODY	
	   FOR(i IN 1,size())
	     get(i,keyInt,mvf)
	     WRITES(st,"%s <%d,%s>",st,keyInt,mvf.asString() )
	  END FOR
	  RETURN st
	END METHOD
END CLASS
/*
As you can see, all we have to do is use the MatrixVectorFriends class as if it were just another class in order to create the new name of class DictionaryMatrixVectorFriendsBasic. Then we can create another class that inherits it to implement an asString() method. Note that it is not actually necessary to do this; we are just doing it here for the convenience of having an asString() method to print complex objects such as this one. A function that uses this class is then created:
*/
FUNCTION NO_TYPE func_testDictionaryMatrixVectorFriends()
DECLS
   INTEGER keyInt
OBJECTS
   class_DictionaryMatrixVectorFriends dmvf
   class_MatrixVectorFriends mf
   class_VectorFriends vf
   class_Friends fr
--   MAP m1
BODY
   WRITE("\n\n***************testDictionaryMatrixVectorFriends()\n")
   fr.setFriend("John",623636842)
   vf.append(fr)
   mf.assign(2,2,vf)
   dmvf.set(55,mf)
   vf.clear()
   mf.clear()
   fr.setFriend("Luik",983567742)
   vf.append(fr)
   fr.setFriend("Luca",263475477)
   vf.append(fr)
   mf.set(2,2,vf)
   dmvf.set(10,mf)
   WRITE("dmvf= %s (size=%d)\n",dmvf.asString(),dmvf.size())
   dmvf.get(1,keyInt,mf)
   WRITE("\nFound item pos=1 with pair<\"%d\",%s>\n",keyInt,mf.asString())
   dmvf.at(55).at(2,2).at(1).setPhone(111222333) -- change phone to element with key 55 and position (1,1) in the matrix
   WRITE("dmvf= %s (size=%d)\n",dmvf.asString(),dmvf.size())
END FUNCTION
/*
Now we will look at a complete example of a dictionary with pair <STRING,pointerTo(Friends)> that contains objects of the Friends class and which we can access using pointers to the objects of the same type, and also via a copy. First we define the classes that define the type of pointer, the basic dictionary class and the final class that implements the asString() method, for convenience of testing.
*/
TYPEDEF CLASS class_DicFriendsPtrBa IS_A EDictionaryStringPtr<class_Friends,class_PointerFriends>

CLASS class_DictionaryFriendsPtr IS_A class_DicFriendsPtrBa
METHODS
	METHOD STRING asString() "return object as string"
	DECLS
	    STRING st,key
	OBJECTS
	    class_PointerFriends friendPtr
	BODY	
	     FOR(i IN 1,size())
	       getPtr(i,key,friendPtr)
		 WRITES(st,"%s <\"%s\",%s> ",st,key,friendPtr.asString())
	     END FOR
	     RETURN st
	END METHOD
END CLASS
FUNCTION NO_TYPE func_testDictionaryFriendsPtr1()
DECLS
	STRING key
OBJECTS
	class_DictionaryFriendsPtr dfr
	class_PointerFriends    frPtr
	class_Friends fr
BODY
	WRITE("\n\n***************testDictionaryFriendsPtr()\n")
	fr.setFriend("John",623636842)
	dfr.set("John",fr)
	fr.setFriend("Alice",627378532)
	dfr.set("Alice",fr)
	WRITE("dsr= %s (size=%d)\n",dfr.asString(),dfr.size())
	dfr.get(1,key,fr)                 -- obtain a local copy of object
	fr.setFriend(key,1111111)         -- change phone in the copy
	dfr.set(key,fr)                   -- insert again in the dictionary
	WRITE("dsr= %s (size=%d)\n",dfr.asString(),dfr.size())
	dfr.getPtr(2,key,frPtr)           -- obtain a pointer to the object
	frPtr.setPhone(222222)            -- change phone directly
	WRITE("dsr= %s (size=%d)\n",dfr.asString(),dfr.size())
END FUNCTION


// Ordered sets of objects
//Using ordered sets of objects
/*
The ESet class represents a set of sorted objects. EL allows sorted lists of values of basic EL types such as
REAL, INTEGER, STRING or enumeration. When a value is entered into an ESet object it is automatically
sorted internally and no duplications are allowed.
A very similar ESet is an EDictionary, the only difference being that it does not contain a pair <key,value> but
only <key>.
It is interesting to use when users do not want to automatically have a sorted list of values. The ESet class
provides methods that allow sequential access to the final sorted list.
The ESet class has the following methods:
EXTERN ABSTRACT CLASS ESet IS_A INTEG_topClass
METHODS
EXTERN METHOD NO_TYPE clear ()
EXTERN METHOD INTEGER size ()
EXTERN METHOD BOOLEAN empty ()
EXTERN METHOD STRING asString ()
EXTERN METHOD BOOLEAN get( INTEGER index , OUT ValueClass value )
EXTERN METHOD BOOLEAN insert (IN ValueClass value )
EXTERN METHOD BOOLEAN find (IN ValueClass value )
EXTERN METHOD BOOLEAN erase (IN ValueClass value
END CLASS
The generic class ValueClass should be replaced by the type of object this container is using (e.g. in a ESetReal
the ValueClass =REAL).
Following is a description of each method:
 The clear() method clears the purpose and leaves it at size zero.
 The size() method returns the number of elements currently in the set
 The empty() method returns TRUE if the object is empty, or otherwise returns FALSE.
 The insert() method inserts an element
 The get() method obtains an object in a given position
 The find() method returns TRUE if it finds an object
 The get() method is similar to at(), but the former returns the object in an argument. If that position does
not exist, it returns FALSE, whereas if it does exist it returns TRUE.
 The erase() method deletes an element from a set
 The asString() method is only implemented for the basic types REAL, INTEGER and STRING and returns
the object in string format. For other types of object users can create their own asString() method with an
inherited class.
*/
COMPONENT comp_orderedSetsofObjects

END COMPONENT

FUNCTION NO_TYPE func_testSetString ()
	DECLS
		STRING v
	OBJECTS
		ESetString esr
	BODY
		esr.insert ("set")
		esr.insert (" dictionary ")
		esr.insert (" vector ")
		esr.insert (" matrix ")
		WRITE (" ESetString ( size %d): %s\n",esr.size () ,esr.asString () )
		IF ( esr.find (" vector ") == TRUE ) THEN
			WRITE (" Found value vector in ESet \n")
		ELSE
			WRITE ("Not found value vector in ESet \n")
		END IF
		WRITE (" Erase item \n" )
		esr.erase (" dictionary ")
		WRITE (" ESetString ( size %d): %s\n",esr.size () ,esr.asString () )
		FOR (i IN 1,esr.size ())
			esr.get(i,v)
		WRITE ("Pos =%d value =\"% s\"\n",i,v)
		END FOR
END FUNCTION
--This example shows how to create and use an ordered set of enumerated elements. First we have to define a
--new class in EL using TYPEDEF, based on on ESet<enumType>

TYPEDEF CLASS class_SetEnumColorsBasic IS_A ESet <TM_colors>
CLASS class_SetEnumColors IS_A class_SetEnumColorsBasic
	METHODS
		METHOD STRING asString ()
			DECLS
				ENUM TM_colors val
				STRING st
			BODY
				WRITES (st ,"{")
				FOR (i IN 1, size ())
					get (i,val)
					WRITES (st ,"%s %s",st , gvalEnum2 ("TM_colors",val))
				END FOR
				WRITES (st ,"%s}",st)
				RETURN st
		END METHOD
END CLASS
FUNCTION NO_TYPE func_testSetEnumColors ()
	DECLS
		STRING v
	OBJECTS
		class_SetEnumColors esr
	BODY
		esr.insert ( brown )
		esr.insert ( white )
		esr.insert ( blue )
		WRITE (" ESetEnum ( size %d): %s\n",esr.size () ,esr.asString () )
		IF ( esr.find ( white ) == TRUE ) THEN
			WRITE (" Found value white in ESet \n")
		ELSE
			WRITE ("Not found value white in ESet \n")
		END IF
		WRITE (" Erase item blue \n" )
		esr.erase ( blue )
		WRITE (" ESetEnum ( size %d): %s\n",esr.size () ,esr.asString () )
END FUNCTION

