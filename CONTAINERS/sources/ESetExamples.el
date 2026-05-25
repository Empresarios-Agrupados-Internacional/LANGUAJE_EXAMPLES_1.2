/*-----------------------------------------------------------------------------------------
 LIBRARY: CONTAINERS
 FILE: ESetExamples
 CONTENTS: Examples of ESet classes
 CREATION DATE: 18/11/2017
-----------------------------------------------------------------------------------------*/

TYPEDEF CLASS SetEnumColorsBasic     IS_A ESet<TM_colors>

CLASS SetEnumColors IS_A SetEnumColorsBasic
METHODS
	METHOD STRING asString()
	DECLS
		ENUM TM_colors val
		STRING st
	BODY
		  WRITES(st,"{")
	     FOR(i IN 1,size())
		  	 	 get(i,val)
				 WRITES(st,"%s %s",st,gvalEnum2("TM_colors",val))
		  END FOR
		  WRITES(st,"%s}",st)
		  RETURN st
	END METHOD
END CLASS

FUNCTION NO_TYPE testSetReal()
DECLS
	REAL v
OBJECTS
	ESetReal esr
BODY
	WRITE("\n\n***************testSetReal()\n")
	esr.insert(2.23)
	esr.insert(-34.23456856679)
	esr.insert(.34E-3)
	esr.insert(3563.34)
	WRITE("ESetReal(size %d): %s\n",esr.size(),esr.asString() )

	IF ( esr.find(2.23) == TRUE ) THEN
	    WRITE("Found value 2.23 in ESet\n")
	ELSE
	    WRITE("Not found value 2.23 in ESet\n")
	END IF
	
	WRITE("Erase item\n" )
	esr.erase(.34E-3)
	WRITE("ESetReal(size %d): %s\n",esr.size(),esr.asString() )
	FOR(i IN 1,esr.size())
		esr.get(i,v)
		WRITE("Pos=%d value=%g\n",i,v)
	END FOR
END FUNCTION

FUNCTION NO_TYPE testSetString()
DECLS
	STRING v
OBJECTS
	ESetString esr
BODY
	WRITE("\n\n***************testSetString()\n")
	esr.insert("set")
	esr.insert("dictionary")
	esr.insert("vector")
	esr.insert("matrix")
	WRITE("ESetString(size %d): %s\n",esr.size(),esr.asString() )

	IF ( esr.find("vector") == TRUE ) THEN
	    WRITE("Found value vector in ESet\n")
	ELSE
	    WRITE("Not found value vector in ESet\n")
	END IF
	
	WRITE("Erase item\n" )
	esr.erase("dictionary")
	WRITE("ESetString(size %d): %s\n",esr.size(),esr.asString() )
	FOR(i IN 1,esr.size())
		esr.get(i,v)
		WRITE("Pos=%d value=\"%s\"\n",i,v)
	END FOR
END FUNCTION


FUNCTION NO_TYPE testSetEnumColors()
DECLS
	STRING v
OBJECTS
	SetEnumColors esr
BODY
	WRITE("\n\n***************testSetEnumColors()\n")
	esr.insert(brown)
	esr.insert(white)
	esr.insert(blue)
	WRITE("ESetEnum(size %d): %s\n",esr.size(),esr.asString() )

	IF ( esr.find(white) == TRUE ) THEN
	    WRITE("Found value white in ESet\n")
	ELSE
	    WRITE("Not found value white in ESet\n")
	END IF
	
	WRITE("Erase item blue\n" )
	esr.erase(blue)
	WRITE("ESetEnum(size %d): %s\n",esr.size(),esr.asString() )
END FUNCTION

COMPONENT setTest
INIT
	testSetReal()
   testSetString()
	testSetEnumColors()
END COMPONENT

