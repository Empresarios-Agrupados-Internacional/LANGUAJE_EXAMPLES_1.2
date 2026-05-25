/*-----------------------------------------------------------------------------------------
 LIBRARY: CONTAINERS
 FILE: EDictionaryExamples
 CONTENTS: Examples of EDictionary classes
 CREATION DATE: 18/11/2017
-----------------------------------------------------------------------------------------*/

TYPEDEF CLASS DictionaryFriendsBasic IS_A EDictionaryString<Friends>

-- Create a final class implmenting asString() method
CLASS DictionaryFriends IS_A DictionaryFriendsBasic
METHODS
	METHOD STRING asString()
	DECLS
		STRING st,key
	OBJECTS
		 Friends friend
	BODY	
	     FOR(i IN 1,size())
		  	 	 get(i,key,friend)
				 WRITES(st,"%s <\"%s\",%s> ",st,key,friend.asString())
		  END FOR
		  RETURN st
	END METHOD
END CLASS

TYPEDEF CLASS PointerFriends IS_A EPointerDictString<Friends>
TYPEDEF CLASS DicFriendsPtrBa IS_A EDictionaryStringPtr<Friends,PointerFriends>

CLASS DictionaryFriendsPtr IS_A DicFriendsPtrBa
METHODS
	METHOD STRING asString() "return object as string"
	DECLS
		STRING st,key
	OBJECTS
		 PointerFriends friendPtr
	BODY	
	     FOR(i IN 1,size())
		  	 	 getPtr(i,key,friendPtr)
				 WRITES(st,"%s <\"%s\",%s> ",st,key,friendPtr.asString())
		  END FOR
		  RETURN st
	END METHOD
END CLASS


TYPEDEF CLASS DictionaryMatrixVectorFriendsBasic   IS_A EDictionaryInt<MatrixVectorFriends>

CLASS DictionaryMatrixVectorFriends IS_A DictionaryMatrixVectorFriendsBasic
METHODS
	METHOD STRING asString() "retun element as string"
	DECLS
		INTEGER keyInt
		STRING st
	OBJECTS
		MatrixVectorFriends mvf
	BODY	
	     FOR(i IN 1,size())
			  get(i,keyInt,mvf)
		  	  WRITES(st,"%s <%d,%s>",st,keyInt,mvf.asString() )
		  END FOR
		  RETURN st
	END METHOD
END CLASS

FUNCTION NO_TYPE testDictionaryReal()
DECLS
	STRING key
	INTEGER keyInt
	REAL val
OBJECTS
	EDictionaryStringReal dsr
	EDictionaryIntReal    dir
BODY
   WRITE("\n\n***************testDictionaryReal()\n")
   dsr.set("random",44.5) 
	dsr.set("fixed",-34.4e3)
	dsr.set("abrupted",736.3534757)
	IF( dsr.find("fixed",val) == TRUE) THEN
		WRITE("Found item with key=\"fixed\"\n")
	END IF
	WRITE("dsr= %s (size=%d)\n",dsr.asString(),dsr.size())
	dsr.get(3,key,val)
	WRITE("Found item at position 3 with pair<\"%s\",%g>\n",key,val)
	FOR(i IN 1,dsr.size()) -- iterate over all dictionary
		dsr.get(i,key,val)
		WRITE("++ <%s,%g>\n",key,val)
	END FOR
	
   dir.set(567,44.5)
	dir.set(178,-34.4e3)
	dir.set(33,736.3534757)
	IF( dir.find(33,val) == TRUE) THEN
		WRITE("\nFound item with key=33\n")
	END IF
	WRITE("dir= %s (size=%d)\n",dir.asString(),dir.size())
	dir.get(3,keyInt,val)
	WRITE("Found item at position 3 with pair<%d,%g>\n",keyInt,val)
END FUNCTION

FUNCTION NO_TYPE testDictionaryFriends()
DECLS
	STRING key
OBJECTS
	DictionaryFriends dfr
	Friends    fr
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

FUNCTION NO_TYPE testDictionaryMatrixVectorFriends()
DECLS
	INTEGER keyInt
OBJECTS
	DictionaryMatrixVectorFriends dmvf
	MatrixVectorFriends mf
	VectorFriends vf
	Friends    fr
	--DictionaryMapas dm
	--MAP m1
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

FUNCTION NO_TYPE testDictionaryFriendsPtr()
DECLS
	STRING key
OBJECTS
	DictionaryFriendsPtr dfr
	PointerFriends    frPtr
	Friends fr
BODY
	WRITE("\n\n***************testDictionaryFriendsPtr()\n")
	fr.setFriend("John",623636842)
	dfr.set("John",fr)
	fr.setFriend("Alice",627378532)
	dfr.set("Alice",fr)
	WRITE("dsr= %s (size=%d)\n",dfr.asString(),dfr.size())
	dfr.get(1,key,fr)  -- obtain a local copy of object
	fr.setFriend(key,1111111) -- change phone in the copy
	dfr.set(key,fr)    -- insert again in the dictionary
	WRITE("dsr= %s (size=%d)\n",dfr.asString(),dfr.size())
	dfr.getPtr(2,key,frPtr) -- obtain a pointer to the object
	frPtr.setPhone(222222)   -- change phone directly
	WRITE("dsr= %s (size=%d)\n",dfr.asString(),dfr.size())
END FUNCTION

COMPONENT dictionaryTest
INIT
		testDictionaryReal()
		testDictionaryFriends()
		testDictionaryMatrixVectorFriends()
		testDictionaryFriendsPtr()
END COMPONENT


-- The next Class only compiles in PROOSIS as the Dictionary MAP is only valid on it.

TYPEDEF CLASS DictionaryMapasBasic   IS_A EDictionaryInt<MAP>

CLASS DictionaryMapas IS_A DictionaryMapasBasic
METHODS
	METHOD STRING asString()
	DECLS
		INTEGER keyInt
		STRING st
	OBJECTS
		MAP mvf
	BODY	
	     FOR(i IN 1,size())
			  get(i,keyInt,mvf)
		  	  WRITES(st,"%s <%d,%s>",st,keyInt,mvf.getName() )
		  END FOR
		  RETURN st
	END METHOD
END CLASS