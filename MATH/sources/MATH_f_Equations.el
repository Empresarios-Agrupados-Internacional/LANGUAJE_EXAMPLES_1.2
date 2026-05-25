--------------------------------------------------------------------------------
-- EA Internacional    EcosimPro Simulation Source Code
--
--    FILE NAME:  MATH_f_Equations.el
--    FILE TYPE:  External objects of the MATH library
--    DESCRIPTION:  Defines a non-linear system of equations solver for the
--                  MATH library
--    NOTES:  Based on EcosimPro MATH library
--    AUTHOR:  Borja Garcia Gutierrez
--    CREATION DATE:  12-Jan-2004
--------------------------------------------------------------------------------


-- External Objects

--------------------------------------------------------------------------------
-- Function EcoNonLinearEqnSolver
--------------------------------------------------------------------------------
-- Purpose: to find a zero of a system of N nonlinear functions in N variables X by a modification of the Powell hybrid method: FVEC (X) = 0.
-- How to use:
/*
 ILAST: IN, OUT, INTEGER, reverse communication parameter ILAST is an integer variable hat must be set by the user to a non-positive value initially, in order to indicate the start of the calculation. 
The value of ILAST on each return indicates the reason for the return. 
If it is 1,3 or 4, then the user's program has to provide new values of FVEC, and then recall the subroutine with ILAST still set to this number. 
If it is 2, then the user's program has to provide new values of FVEC and FJAC, and then recall the subroutine with ILAST set to 2.
         ILAST on return
            = 0: Solver terminated
            = 1: Calculate FVEC at starting point
            = 2: Calculate FVEC and FJAC (only if IOPT=1)
            = 3: Calculate FVEC to compute Jacobian approximation
            = 4: Calculate FVEC to compute next step)
 IOPT  : IN, INTEGER, selection parameter
         IOPT specifies how the Jacobian will be calculated.
         1: the user must supply the Jacobian.
         2: the code will approximate the Jacobian by forward-differencing.
         3: same as IOPT=2, but for the first call (INVREF<=0) the user must supply the Jacobian.
 N     : IN, INTEGER, N.gt.0
         Number of functions and variables.
 X     : IN, OUT, DOUBLE(N)
         On input X must contain an initial estimate of the solution vector.
         On output X contains the values for which FVEC has to be computed in the next iteration step (ILAST=1,2,3 or 4) or the final estimate of the solution vector (ILAST=0).

 FVEC  : IN, DOUBLE(N)
        FVEC has to contain the functions evaluated at X  (ILAST=1,2,3,4).
 FJAC  : IN, DOUBLE(N,N)
         FJAC has to contain the Jacobian (ILAST=2) The Jacobian has to be provided only if IOPT=1.
         If IOPT=2 or 3, FJAC is used as a work array.  It contains the approximation of the Jacobian.
 TOL   : IN, DOUBLE, TOL.ge.0.d0
         Termination occurs when the algorithm estimates that the relative error between X and the solution is at most TOL.
         If TOL=0.D0 is given, a tolerance of sqrt(machine precision) is assumed.
 INFO  : OUT, INTEGER
		 IF ILAST > 0 THEN  Iteration continues
					INFO =  0  Internal step
						 = 10  Internal step completed
		  ELSEIF ILAST = 0 THEN Iteration terminated. Termination status:
					INFO =  0  Improper input parameters (wrong initialization)
					INFO =  1  Algorithm estimates that the relative error between X and the solution is at most TOL  (regular end).
					INFO =  2  Number of calls to FCN has reached or exceeded 100(N+1) for IOPT=1 or 200(N+1) for IOPT=2.
					INFO =  3  TOL is too small.  No further improvement in the approximate solution X is possible.
					INFO =  4  Iteration is not making good progress.
		 ENDIF
 DUM   : OUT, DOUBLE( (N2+13N)/2 )
         work array of length LDUM = 20 + (N2+13N)/2
 LDUM  : IN, INTEGER
         Provided length of the work array DUM. LDUM must not be less than 20 + (N2+13N)/2.
 IDUM  : IN, INTEGER
         work array of length 20.
 EPSFCN: IN, DOUBLE
         Used in determining a suitable step for the forward-difference approximation. This approximation assumes that the relative errors in the functions are of the order of epsfcn. If epsfcn  is less than the machine precision, it is assumed that the relative errors in the functions are of the order of the  machine precision. If iopt=1, then epsfcn can be ignored (treat it as a dummy argument).
*/

"FORTRAN" FUNCTION NO_TYPE EcoNonLinearEqnSolver (     
    OUT INTEGER ILAST,
    IN INTEGER IOPT,
    IN INTEGER N,
    OUT REAL X[],
    OUT REAL FVEC[],
    OUT REAL FJAC[],
    IN REAL tol,
    OUT INTEGER INFO,
    IN REAL DUM[],
    IN INTEGER LDUM,
    IN INTEGER IDUM[],
    IN REAL EPSFCN)  "Function to find a zero of a system of N nonlinear functions in N variables X by a modification of the Powell hybrid method" IN "MATH.lib"     
    

--------------------------------------------------------------------------------
-- Function EcoMachDep
--------------------------------------------------------------------------------

"FORTRAN" FUNCTION NO_TYPE EcoMachDep ()     "Function to determine machine precision"     IN "MATH.lib"     

--------------------------------------------------------------------------------
-- Function treatfft
--------------------------------------------------------------------------------
-- Purpose:
--    Compute Fourier-based spectra and transfer functions from time histories
--    of two signals x(t) and y(t), using FFT.
--
-- Interface:
--    "FORTRAN" FUNCTION NO_TYPE treatfft(
--       INTEGER iff,            -- Type of spectral processing required
--       REAL    time,           -- Total time window of the data (s)
--       INTEGER np,             -- Number of time samples in px, py
--       REAL    px[],           -- Time history of x(t), evenly spaced in time
--       REAL    py[],           -- Time history of y(t), evenly spaced in time
--       REAL    fr1,            -- Minimum frequency of interest (Hz)
--       REAL    fr2,            -- Maximum frequency of interest (Hz)
--       OUT INTEGER lnp,        -- Number of valid frequency points returned
--       OUT REAL xfft[],        -- Frequency vector (Hz)
--       OUT REAL yfft[]         -- Result spectrum / transfer function
--    ) IN "MATH.lib"
--
-- Parameter iff (type of spectral treatment):
--    iff = 1  -> Fourier transform of y(t) in amplitude
--    iff = 2  -> Fourier transform of y(t) in phase
--    iff = 3  -> Fourier transform of y(t) in spectral density
--    iff = 4  -> Transfer function amplitude |Y(jw)/X(jw)|
--    iff = 5  -> Transfer function phase     arg{Y(jw)/X(jw)}
--
-- Notes:
--    - px and py must contain np samples of x(t) and y(t) with constant
--      sampling interval Δt = time/(np-1).
--    - The output yfft is:
--         * a spectrum of y(t) if iff ∈ {1,2,3},
--         * a transfer function y/x if iff ∈ {4,5}.
--    - xfft contains the corresponding frequency values for each point in yfft.
--
-- First version of this interface (not fully tested).

"FORTRAN" FUNCTION NO_TYPE treatfft(
	INTEGER iff, REAL time, INTEGER np, REAL px[],REAL py[], REAL fr1, REAL fr2, 
	OUT INTEGER lnp, OUT REAL xfft[], OUT REAL yfft[])  "Function to compute Fourier-based spectra and transfer functions from time histories of two signals x(t) and y(t), using FFT."     IN "MATH.lib"


--------------------------------------------------------------------------------
-- Function solveNonLinearSystem
--------------------------------------------------------------------------------
-- Purpose:
--    This is a wrapper of the Fortran function EcoNonLinearEqnSolver to protect outputs
--  when detecting nan values.
--  The purpose of this function  is to find a zero of a system of N nonlinear functions in N variables X by a modification of the
--  Powell hybrid method. The user is required to provide initial values of the variables
--  and code for evaluating FVEC. Termination occurs when the algorithm estimates that the
--  relative error between X and the solution is at most tol.
--
--  EcoNonLinearEqnSolver is a modification of the Powell Hybrid method.  Two of
-- its main characteristics involve the choice of the correction as
-- a convex combination of the Newton and scaled gradient directions,
-- and the updating of the Jacobian by the rank-1 method of Broyden.
-- The choice of the correction guarantees (under reasonable conditions)
-- global convergence for starting points far from the solution and a
-- fast rate of convergence. The Jacobian is calculated at the starting
-- point by either the user-supplied code or a forward-difference
-- approximation, but it is not recalculated until the rank-1 method
--  fails to produce satisfactory progress.
-- Ilast output values:
--            ilast < 0 Start the process
--            ilast = 0 End loop (termination condition), if info = 1 results are ok,if info= 4 iteration  is not making good progress
--            ilast =1,2,3,4 continue de loop
-- Info output values:
--            info =  0  Internal step
--            info =  1  Algorithm estimates that the relative error
--                       between X and the solution is at most TOL
--                       (regular end).
--            info =  2  Number of calls to FCN has reached or exceeded
--                       100*(N+1) for IOPT=1 or 200*(N+1) for IOPT=2.
--            info =  3  TOL is too small.  No further improvement in the
--                       approximate solution X is possible.
--            info =  4  Iteration is not making good progress.
--            info = 10  Internal step completed
--------------------------------------------------------------------------------
FUNCTION BOOLEAN solveNonLinearSystem(
    OUT INTEGER ilast,
    IN INTEGER iopt,
    IN INTEGER n,
    OUT REAL x[],
    OUT REAL fvec[],
    OUT REAL fjac[],
    IN REAL tol,
    OUT INTEGER info,
    IN REAL dum[],
    IN INTEGER ldum,
    IN INTEGER idum[],
    IN REAL EPSFCN)
  DECLS
       BOOLEAN nan_detected= FALSE
  OBJECTS
       EVectorReal xp
  BODY
       -- save initial solution
       FOR(i IN 1,n)
         xp.push_back(x[i])
       END FOR
       -- solve the algebraic equations systems
       EcoNonLinearEqnSolver(ilast, iopt, n, x, fvec, fjac, tol, info, dum, ldum, idum, EPSFCN)
       -- detect nan or inf in the solution
        FOR(i IN 1,n)
             IF(validReal(x[i]) == FALSE) THEN
                 nan_detected=TRUE
                 BREAK
             END IF
        END FOR
        
        -- if nan/inf detected return to initial values and set ilast=0 to terminate the outer loop
         IF (nan_detected == TRUE) THEN
            FOR(i IN 1,n)
               x[i]= xp.at(i)
            END FOR
            ilast = 0
            RETURN FALSE
         END IF
         RETURN TRUE
END FUNCTION

