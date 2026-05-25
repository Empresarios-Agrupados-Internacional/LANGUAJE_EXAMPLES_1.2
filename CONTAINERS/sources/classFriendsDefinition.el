/*-----------------------------------------------------------------------------------------
 LIBRARY: CONTAINERS
 FILE: classFriendsDefinition
 CONTENTS: Definition of a simple Friends class with some variables and methods
 CREATION DATE: 18/11/2017
-----------------------------------------------------------------------------------------*/

CLASS Friends "Friend information class"
DECLS
	PRIVATE STRING m_name= "" "friend name"
	PRIVATE INTEGER m_phone=0 "friend phone number"
METHODS
	METHOD NO_TYPE setFriend(STRING name, INTEGER phone)
	"Set a new friend and phone number"
	BODY
		m_name= name
		m_phone= phone
	END METHOD
	----------------------------
	METHOD STRING getName() "get the friend name"
	BODY
		RETURN m_name
	END METHOD
	----------------------------
	METHOD INTEGER getPhone() "get the phone number"
	BODY
		RETURN m_phone
	END METHOD
	----------------------------
	METHOD NO_TYPE setPhone(INTEGER phone) "set the phone"
	BODY
		m_phone= phone
	END METHOD
	METHOD STRING asString() "return friend info as string"
	DECLS
		STRING st
	BODY
		WRITES(st,"[%s,%d]",m_name,m_phone)
		RETURN st
	END METHOD
END CLASS
