/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: using_pointers_to_function_effectively
 // Using pointers to function effectively
EL allows you to program pointers to functions. The basic type of pointer to a function is FUNC_PTR. We
have seen that it can be used as such when external functions in FORTRAN, C or C++ are used, and it is not
necessary to pass what type of function to point to, though the external routine has to be called with the correct
arguments for our own function in EL.
This section describes how to use pointers to specific functions with strict checking of types, when used. As
already mentioned, a new type of generic function is defined with TYPEDEF, which allows users to define
both the arguments and the type of data that the functions return.
-----------------------------------------------------------------------------------------*/
//Using a function pointer inside a component
TYPEDEF FUNCTION REAL func_ftype2 ( REAL a, REAL b)
FUNCTION REAL func_added( REAL a, REAL b)
	BODY
		RETURN a+b
END FUNCTION
FUNCTION REAL func_subs ( REAL a, REAL b)
	BODY
		RETURN a-b
END FUNCTION
COMPONENT comp_usingPointersFunction
	DECLS
		FUNC_PTR <func_ftype2 > fun = func_added
	INIT
		WRITE ("2 + 2 = %g\n", fun (2 ,2))
		fun = func_subs
		WRITE ("2 - 2 = %g\n", fun (2 ,2))
END COMPONENT
//Using a function pointer as function argument
FUNCTION REAL func_fCallre ( FUNC_PTR <func_ftype2 > f2 , REAL a, REAL b)
	DECLS
		REAL val2
	BODY
		val2 = f2(a,b)
	RETURN val2
END FUNCTION
FUNCTION NO_TYPE func_ptrfun ()
	DECLS
		REAL res =0
	BODY
		res = func_fCallre (func_added ,50 ,20)
		WRITE ("50+20= %g\n",res)
		res = func_fCallre (func_subs ,50 ,20)
		WRITE ("50-20= %g\n",res)
END FUNCTION
//Function pointers and classes
TYPEDEF FUNCTION NO_TYPE func_ftype1 ()
FUNCTION NO_TYPE func_voidFun ()
	BODY
END FUNCTION
CLASS class_CFunPointerExample
	DECLS
		FUNC_PTR <func_ftype1 > m_fptr = func_voidFun
		INTEGER m_ntimes
	METHODS
	--init the function pointer and number of calls
		METHOD NO_TYPE init ( FUNC_PTR <func_ftype1 > fptr , REAL ntimes )
			BODY
				m_fptr = fptr
				m_ntimes = ntimes
		END METHOD
	--call ntimes the function pointer
		METHOD BOOLEAN run ()
			BODY
				FOR (i IN 1, m_ntimes )
					WRITE (" Call #%d\n",i)
					m_fptr ()
				END FOR
				RETURN TRUE
		END METHOD
END CLASS


//Modelling components with function pointers
/*
Another example of advanced modelling with function pointers would be the creation of a component calling
a function that can change during the simulation. In fact, it is initialized with a function and after 5 seconds,
the function pointer is changed to another function returning negative
*/
TYPEDEF FUNCTION REAL func_ptrFunMat (REAL a)
FUNCTION REAL func_addOne (IN REAL a)
	BODY
		RETURN a+1
END FUNCTION
FUNCTION REAL func_subsOne (IN REAL a)
	BODY
		RETURN a-1
END FUNCTION
COMPONENT comp_modellingComponentsWithFunctionPointer
	DECLS
		FUNC_PTR <func_ptrFunMat> fptr = func_addOne
		REAL x
	DISCRETE
	WHEN ( TIME > 5 ) THEN
		fptr = func_subsOne -- change now the function pointer
	END WHEN
	CONTINUOUS
		x= fptr ( TIME )
END COMPONENT
//Changing function pointers when instantiation is done
FUNCTION REAL func_sin10plus (IN REAL a)
	BODY
		RETURN sin(a) + 10
END FUNCTION
FUNCTION REAL func_cos10minus (IN REAL a)
	BODY
		RETURN cos(a) - 10
END FUNCTION
COMPONENT comp_testFuncPtr3
	DATA
		FUNC_PTR < func_ptrFunMat > fptr = func_addOne
	DECLS
		REAL x
	CONTINUOUS
		x= fptr ( TIME )
END COMPONENT
COMPONENT comp_testFuncPtr4
	DATA
		FUNC_PTR < func_ptrFunMat > xvf= func_cos10minus
	DECLS
		REAL z
	TOPOLOGY
		comp_testFuncPtr3 t1 ( fptr = func_sin10plus )
		comp_testFuncPtr3 t2 ( fptr = xvf)
	CONTINUOUS
		z= t1.x + t2.x
END COMPONENT
