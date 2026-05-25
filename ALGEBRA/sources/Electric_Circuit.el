/*-----------------------------------------------------------------------------------------
 LIBRARY: EIGEN
 FILE: Electric_Circuit
 CREATION DATE: 26/06/2017
 Electric_Circuit_Example at Matlab book page 224
-----------------------------------------------------------------------------------------*/

-- *** IMPORTANT: When using EigenMatrix and EigenVector classes is recommended to activate the flag for optimizing object code
-- ***        (see Edit->Options->Simulation->Optimize generated object code

FUNCTION	NO_TYPE Electric_Circuit_Resistances()
DECLS
	REAL error
OBJECTS
	EigenMatrix Resistances
	EigenMatrix Voltages
	EigenMatrix Currents

	EigenHandler	Linear_System
	
BODY
        WRITE("\n*******************\nFUNCTION: Linear System Solvers\n")

	Resistances.resize(6, 6)
	Voltages.resize(6,1)
	Currents.resize(6,1)
	
	Resistances.set(1, 1, 1)
	Resistances.set(1, 2, 1)
	Resistances.set(1, 3, 1)
	Resistances.set(1, 4, 0)
	Resistances.set(1, 5, 0)
	Resistances.set(1, 6, 0)
	
	Resistances.set(2, 1, 0)
	Resistances.set(2, 2, -1)
	Resistances.set(2, 3, 0)
	Resistances.set(2, 4, 1)
	Resistances.set(2, 5, -1)
	Resistances.set(2, 6, 0)

	Resistances.set(3, 1, 0)
	Resistances.set(3, 2, 0)
	Resistances.set(3, 3, -1)
	Resistances.set(3, 4, 0)
	Resistances.set(3, 5, 0)
	Resistances.set(3, 6, 1)
	
	Resistances.set(4, 1, 0)
	Resistances.set(4, 2, 0)
	Resistances.set(4, 3, 0)
	Resistances.set(4, 4, 0)
	Resistances.set(4, 5, 1)
	Resistances.set(4, 6, -1)
	
	Resistances.set(5, 1, 0)
	Resistances.set(5, 2, 10)
	Resistances.set(5, 3, -10)
	Resistances.set(5, 4, 0)
	Resistances.set(5, 5, -15)
	Resistances.set(5, 6, -5)
	
	Resistances.set(6, 1, 5)
	Resistances.set(6, 2, -10)
	Resistances.set(6, 3, 0)
	Resistances.set(6, 4, -20)
	Resistances.set(6, 5, 0)
	Resistances.set(6, 6, 0)
		
	Voltages.set(1,1,0)
	Voltages.set(2,1,0)
	Voltages.set(3,1,0)
	Voltages.set(4,1,0)
	Voltages.set(5,1,0)
	Voltages.set(6,1,200)

	
	WRITE("Resistances=\n%s \n", Resistances.asString())
	WRITE("Voltages=\n%s \n", Voltages.asString())

   WRITE("\n*******************\nMethod: Solve Linear System of equations to calculate the currents\n")

	Linear_System.solve (Resistances, Voltages, Currents)
	WRITE("Currents (Result)=\n%s \n", Currents.asString())
END FUNCTION

FUNCTION	NO_TYPE Electric_Circuit_Admitances ()

OBJECTS
	EigenMatrix Resistances
	EigenMatrix Admitances
	EigenMatrix Voltages
	EigenMatrix Currents
	
BODY
	Resistances.resize(6, 6)
	Voltages.resize(6,1)
	Currents.resize(6,1)
	
	Resistances.set(1, 1, 1)
	Resistances.set(1, 2, 1)
	Resistances.set(1, 3, 1)
	Resistances.set(1, 4, 0)
	Resistances.set(1, 5, 0)
	Resistances.set(1, 6, 0)
	
	Resistances.set(2, 1, 0)
	Resistances.set(2, 2, -1)
	Resistances.set(2, 3, 0)
	Resistances.set(2, 4, 1)
	Resistances.set(2, 5, -1)
	Resistances.set(2, 6, 0)

	Resistances.set(3, 1, 0)
	Resistances.set(3, 2, 0)
	Resistances.set(3, 3, -1)
	Resistances.set(3, 4, 0)
	Resistances.set(3, 5, 0)
	Resistances.set(3, 6, 1)
	
	Resistances.set(4, 1, 0)
	Resistances.set(4, 2, 0)
	Resistances.set(4, 3, 0)
	Resistances.set(4, 4, 0)
	Resistances.set(4, 5, 1)
	Resistances.set(4, 6, -1)
	
	Resistances.set(5, 1, 0)
	Resistances.set(5, 2, 10)
	Resistances.set(5, 3, -10)
	Resistances.set(5, 4, 0)
	Resistances.set(5, 5, -15)
	Resistances.set(5, 6, -5)
	
	Resistances.set(6, 1, 5)
	Resistances.set(6, 2, -10)
	Resistances.set(6, 3, 0)
	Resistances.set(6, 4, -20)
	Resistances.set(6, 5, 0)
	Resistances.set(6, 6, 0)
	
	Voltages.set(1,1,0)
	Voltages.set(2,1,0)
	Voltages.set(3,1,0)
	Voltages.set(4,1,0)
	Voltages.set(5,1,0)
	Voltages.set(6,1,200)
	
	Admitances = Resistances.inverse()
	
	Currents = Admitances*Voltages
	
	WRITE("\n*******************\nMethod: Multiplying by inverse (admitances)\n")
	
	WRITE("Resistances=\n%s \n", Resistances.asString())
	WRITE("Admitances (as inverse of Resistance matrix)=\n%s \n", Admitances.asString())	
	WRITE("Voltages=\n%s \n", Voltages.asString())


	WRITE("\n*******************\nCurrents = Admitances * Voltages (should be identical to Electric_Circuit_Resistances() function\n")	
	WRITE("Currents=\n%s \n", Currents.asString())
	
END FUNCTION

COMPONENT	Electric_Circuit_Execution

INIT
	Electric_Circuit_Resistances()
	Electric_Circuit_Admitances()

END COMPONENT
