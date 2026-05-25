/*-----------------------------------------------------------------------------------------
 LIBRARY: CONTAINERS
 FILE: constructionParamExamples
 CONTENTS: Creation of some examples of classes with construction parameters
 CREATION DATE: 18/11/2017
-----------------------------------------------------------------------------------------*/


CLASS BestFriends (INTEGER N)
DECLS
	 STRING m_name= ""
	 INTEGER m_phones[N]
METHODS
	METHOD NO_TYPE setFriend(STRING name, INTEGER n, INTEGER phones[])
	BODY
		m_name= name
		FOR(i IN 1,n)
			m_phones[i]= phones[i]
		END FOR
	END METHOD
	METHOD STRING asString()
	DECLS
		STRING st
	BODY
		WRITES(st,"%s phones:",m_name)
		FOR(i IN 1,N)
			WRITES(st,"%s %d",st,m_phones[i])
		END FOR
		RETURN st
	END METHOD
END CLASS

FUNCTION NO_TYPE testConstructionPars1()
DECLS
	CONST INTEGER nphones=3
	INTEGER phones[nphones] = { 11111,22222,33333 }
OBJECTS
	BestFriends (N=3) fr
	--BestFriends (N=4) fk[4]  -- Not allowed
BODY
	WRITE("\n\n*************** testConstructionPars1()\n")
	fr.setFriend("Lucas",nphones,phones)
	WRITE("Friend: %s\n",fr.asString())
END FUNCTION

FUNCTION NO_TYPE testConstructionPars2(INTEGER N)
DECLS
	REAL v[N]
	TABLE_1D tab1d= { {0, 5, 10 }, { 0, 35.2, 58.4 }}
	REAL result
OBJECTS
	TABLE tab[N]
BODY
	WRITE("\n\n*************** testConstructionPars2()\n")
	FOR(i IN 1,N)
		v[i]= 1.0
		tab[i].copyFromTable1D(tab1d)
	END FOR
	result= tab[2].interpd1D(5)
	WRITE("v[2]= %g\n",v[2])
	WRITE("result= %g\n",result)
END FUNCTION

COMPONENT constructionPars
INIT
		testConstructionPars1()
		testConstructionPars2(3)
END COMPONENT
