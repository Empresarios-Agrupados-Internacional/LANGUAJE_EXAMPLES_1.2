/*-----------------------------------------------------------------------------------------
 LIBRARY: CONTAINERS
 FILE: EVectorExamples
 CONTENTS: Examples of EVector classes
 CREATION DATE: 18/11/2017
-----------------------------------------------------------------------------------------*/

-- Creates a new class that represents a vector of Friends
TYPEDEF CLASS VectorFriendsBasic IS_A EVector<Friends>

-- Creates a subclass for implementing a asString() method
CLASS VectorFriends IS_A VectorFriendsBasic
METHODS
	METHOD STRING asString()
	DECLS
		STRING st
	BODY	
	     FOR(i IN 1,size())
		  	  WRITES(st,"%s [%s(%d)] ",st,at(i).getName(),at(i).getPhone())
		  END FOR
		  RETURN st
	END METHOD
END CLASS

-- Create a simplified Friends but using construction paramenters
CLASS Friends2(INTEGER N, STRING st, REAL ab, BOOLEAN bo)
DECLS
	 STRING m_name    = ""         "friend name"
	 INTEGER m_phone[N,N]= 44  "friend phone"
METHODS
	METHOD NO_TYPE setFriend(STRING name, INTEGER phone) "set a new friend"
	BODY
		m_name= name
		m_phone[1,1]= phone
	END METHOD
END CLASS
	
	
TYPEDEF CLASS VectorFriendsBasic2 IS_A EVector<Friends2>

CLASS VectorFriends2 IS_A VectorFriendsBasic2
METHODS
	METHOD STRING asString()
	DECLS
		STRING st
	BODY	
	     FOR(i IN 1,size())
		  	  WRITES(st,"%s [%s(%d)] ",st,at(i).m_name,at(i).m_phone[1,1])
		  END FOR
		  RETURN st
	END METHOD
END CLASS

-- define the new class for storing a vector of TM_colors
ENUM TM_colors = { red, blue, green, black, brown, white }
TYPEDEF CLASS VectorColorsBasic   IS_A EVector<TM_colors>

-- create a subclass for creating the asString() method
CLASS VectorColors IS_A VectorColorsBasic
METHODS
	METHOD STRING asString()
	DECLS
		STRING st
	BODY	
	     FOR(i IN 1,size())
		  	  WRITES(st,"%s %s",st,gvalEnum2("TM_colors",at(i)) )
		  END FOR
		  RETURN st -- return vector in string format
	END METHOD
END CLASS


FUNCTION NO_TYPE testVectorReal()
DECLS
OBJECTS
	EVectorReal vr
BODY
	WRITE("\n\n***************testVectorReal()\n")
	
   FOR(i IN 1,11)
		vr.append(100+i ) -- Add 11 elements to vr
	END FOR

	WRITE("vr element 2 is %g\n",vr.at(2)) -- print position 2
	WRITE("vr= %s (size=%d)\n",vr.asString(),vr.size())

	vr.clear()  -- clear the vector
   vr.assign(7,8) -- create 7 objects with value 8
   vr.replace(4,9) -- replace number at position 4
   vr.insert(7,6) -- insert a new element at position 7
	WRITE("vr= %s (size=%d)\n",vr.asString(),vr.size())

	vr.clear() -- clear the vector
	vr.set(5,6) -- set at position 5 the value 6
	vr.append(7) -- append at the end the value 7
	WRITE("vr= %s (size=%d)\n",vr.asString(),vr.size())
END FUNCTION

FUNCTION NO_TYPE testVectorMix()
DECLS
OBJECTS
	EVectorInt    vi
	EVectorString vs
	EVectorBool vb
BODY
	WRITE("\n\n***************testVectorMix()\n")
	vi.append(34)  -- add an element to vi
	vi.set(3,-56) -- change the value at position 3
	WRITE("vi= %s (size=%d)\n",vi.asString(),vi.size())
	
   vs.set(3,"hello") -- set some strings in vs
	vs.set(5,"world!")
	WRITE("vs= %s (size=%d)\n",vs.asString(),vs.size())
	
	vb.assign(5,FALSE) -- dimension vector vb to size 5
	vb.replace(3,TRUE) -- replace value at position 3 to TRUE
	WRITE("vb= %s (size=%d)\n",vb.asString(),vb.size())
END FUNCTION



FUNCTION NO_TYPE testVectorFriend()
OBJECTS
   VectorFriends vf
   Friends f
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


FUNCTION NO_TYPE testVectorFriendWithParamConstruction()
DECLS
OBJECTS
	VectorFriends2 vf
	Friends2 (N=3, st=" hello ",ab =3.4 , bo= TRUE ) f -- set the parameters here
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

FUNCTION NO_TYPE testVectorEnumColors()
DECLS
	ENUM TM_colors c
OBJECTS
	VectorColors    ve

BODY
	WRITE("\n\n***************testVectorEnumColors()\n")
	ve.assign(6,black) -- set dimension=6 with value black as default
	ve.set(3,green)  -- set color green at pos=3
	ve.set(6,blue)   -- set color blue at pos=6
	WRITE("ve= %s (size=%d)\n",ve.asString(),ve.size())
END FUNCTION


COMPONENT vectorTest
INIT
	testVectorReal()
	testVectorMix()
	testVectorEnumColors()
	testVectorFriend()
   testVectorFriendWithParamConstruction() 
END COMPONENT
