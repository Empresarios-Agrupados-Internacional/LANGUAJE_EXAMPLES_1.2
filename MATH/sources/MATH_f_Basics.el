--------------------------------------------------------------------------------
-- EA Internacional    EcosimPro Simulation Source Code
--
--    FILE NAME     : MATH_f_Basics.el
--    FILE TYPE     : MATH library functions
--    DESCRIPTION   : Basic math utility functions (max/min, sign, bounds, sums, array helpers).
--    NOTES         : Legacy implementation retained for backward compatibility with older models.
--    AUTHOR        : Ramon Perez Vara
--    CREATION DATE : 12-Jan-2004
--------------------------------------------------------------------------------


-- Functions (basic utilities)
--------------------------------------------------------------------------------
-- Function: max
-- Purpose : Return the larger of two REAL values.
-- Inputs  : x, y (REAL) Values to compare.
-- Returns : max(x, y).
-- Notes   : Pure function; no side effects.
--------------------------------------------------------------------------------

FUNCTION REAL max
   (
   REAL x      "First input number",
   REAL y      "Second input number"
   )  "Function to calculate the maximum of two numbers"

   BODY
      IF (x > y) THEN
         RETURN x
      END IF

      RETURN y

END FUNCTION

--------------------------------------------------------------------------------
-- Function: min
-- Purpose : Return the smaller of two REAL values.
-- Inputs  : x, y (REAL) Values to compare.
-- Returns : min(x, y).
-- Notes   : Pure function; no side effects.
--------------------------------------------------------------------------------

FUNCTION REAL min
   (
   REAL x      "First input number",
   REAL y      "Second input number"
   )  "Function to calculate the minimum of two numbers"

   BODY
      IF (x < y) THEN
         RETURN x
      END IF

      RETURN y

END FUNCTION

--------------------------------------------------------------------------------
-- Function: max_impl
-- Purpose : Update an accumulator with the maximum value seen so far.
-- Inputs  : x (REAL) Candidate value.
-- Outputs : z (REAL) Accumulator (updated in-place if x > z).
-- Returns : The updated accumulator value.
-- Notes   : Use when accumulating a maximum through a loop.
--------------------------------------------------------------------------------

FUNCTION REAL max_impl(IN REAL x "Candidate value", OUT REAL z "Maximum accumulator")   
"Function to calculate the maximum of two numbers and update the second number with it"
BODY
        IF (x > z ) THEN
            z = x
            RETURN x
        END IF
        RETURN z
END FUNCTION


--------------------------------------------------------------------------------
-- Function: min_impl
-- Purpose : Update an accumulator with the minimum value seen so far.
-- Inputs  : x (REAL) Candidate value.
-- Outputs : z (REAL) Accumulator (updated in-place if x < z).
-- Returns : The updated accumulator value.
-- Notes   : Use when accumulating a minimum through a loop.
--------------------------------------------------------------------------------

FUNCTION REAL min_impl(IN REAL x "Candidate value", OUT REAL z "Minimum accumulator") 
"Function to calculate the minimum of two numbers and update the second number with it"
BODY
        IF (x < z ) THEN
           	z = x
	     		RETURN x
        END IF
        RETURN z
END FUNCTION

--------------------------------------------------------------------------------
-- Function: max_array
-- Purpose : Return the maximum element of a 1D REAL array.
-- Inputs  : x[] (REAL) Array of values (must have at least one element).
-- Returns : max(x[i]) over i = 1..N.
-- Notes   : Array length N is obtained with sizeArrayReal(x[1], 0).
--          No explicit check is performed for empty arrays.
--------------------------------------------------------------------------------

FUNCTION REAL max_array(IN REAL x[] "Input array")   "Function to calculate the maximum of a real array"
DECLS
   INTEGER N   "Number of elements in the array"
   REAL max    "Maximum of the array"
BODY
      N = sizeArrayReal( x[1], 0 )
      max = x[1] 
      FOR (i IN 2,N)
         IF (max < x[i]) THEN
           	max = x[i]
         END IF
      END FOR
      RETURN max
END FUNCTION

--------------------------------------------------------------------------------
-- Function: min_array
-- Purpose : Return the minimum element of a 1D REAL array.
-- Inputs  : x[] (REAL) Array of values (must have at least one element).
-- Returns : min(x[i]) over i = 1..N.
-- Notes   : Array length N is obtained with sizeArrayReal(x[1], 0).
--          No explicit check is performed for empty arrays.
--------------------------------------------------------------------------------

FUNCTION REAL min_array(IN REAL x[] "Input array")   "Function to calculate the maximum of an array"
DECLS
   INTEGER N   "Number of elements in the array"
   REAL min    "Minimum of the array"
BODY
      N = sizeArrayReal( x[1], 0 )
      min = x[1] 
      FOR (i IN 2,N)
         IF (min > x[i]) THEN
           	min = x[i]
         END IF
      END FOR
      RETURN min
END FUNCTION

--------------------------------------------------------------------------------
-- Function: max_arr_int
-- Purpose : Return the maximum element of a 1D INTEGER array.
-- Inputs  : x[] (INTEGER) Array of values (must have at least one element).
-- Returns : Maximum element (returned as REAL by implicit conversion).
-- Notes   : Array length N is obtained with sizeArrayInt(x[1], 0).
--          No explicit check is performed for empty arrays.
--------------------------------------------------------------------------------

FUNCTION INTEGER max_arr_int(IN INTEGER x[] "Input array") "Function to calculate the maximum of an integer array"
DECLS
   INTEGER N      "Number of elements in the array"
   INTEGER max    "Maximum of the array"
BODY
      N = sizeArrayInt( x[1], 0 )
      max = x[1] 
      FOR (i IN 2,N)
         IF (max < x[i]) THEN
           	max = x[i]
         END IF
      END FOR
      RETURN max
END FUNCTION

--------------------------------------------------------------------------------
-- Function: min_arr_int
-- Purpose : Return the minimum element of a 1D INTEGER array.
-- Inputs  : x[] (INTEGER) Array of values (must have at least one element).
-- Returns : Minimum element (returned as REAL by implicit conversion).
-- Notes   : Array length N is obtained with sizeArrayInt(x[1], 0).
--          No explicit check is performed for empty arrays.
--------------------------------------------------------------------------------

FUNCTION INTEGER min_arr_int(IN INTEGER x[] "Input array") "Function to calculate the minimum of an integer array"
DECLS
   INTEGER N      "Number of elements in the array"
   INTEGER min    "Minimum of the array"
BODY
      N = sizeArrayInt( x[1], 0 )
      min = x[1] 
      FOR (i IN 2,N)
         IF (min > x[i]) THEN
           	min = x[i]
         END IF
      END FOR
      RETURN min
END FUNCTION

--------------------------------------------------------------------------------
-- Function: sign
-- Purpose : Return the sign of x with the convention sign(0) = +1.
-- Inputs  : x (REAL) Input value.
-- Returns : +1 if x >= 0, otherwise -1.
-- Notes   : Useful for direction selection; discontinuous at x = 0.
--------------------------------------------------------------------------------

FUNCTION REAL sign
   (
   REAL x      "Input value"
   )     "Function to get the sign of a real number"

   BODY 
      IF (x >= 0.) THEN
         RETURN 1.
      END IF

      RETURN -1.

END FUNCTION

--------------------------------------------------------------------------------
-- Function: sign2
-- Purpose : Smoothed sign function with a linear transition around zero.
-- Inputs  : x (REAL) Input value; eps (REAL) Smoothing half-width (eps > 0).
-- Returns : +1 if x >= eps, -1 if x <= -eps, otherwise x/eps.
-- Notes   : Provides a continuous approximation to sign(x) in (-eps, eps).
--------------------------------------------------------------------------------

FUNCTION REAL sign2
   (
   REAL x      "Input value",
   REAL eps    "Tolerance"
   )  "Smoothed sign function with a linear transition around zero"

   BODY 
      IF (x >= eps) THEN
         RETURN 1.
      ELSEIF (x<=-eps) THEN
         RETURN -1.
      ELSE
         RETURN x/eps
      END IF

      RETURN -1.

END FUNCTION

--------------------------------------------------------------------------------
-- Function: sign3
-- Purpose : Variant of sign2 using a ratio x/y for the positive threshold.
-- Inputs  : x (REAL) Numerator; y (REAL) Denominator; eps (REAL) Threshold (eps > 0).
-- Returns : As implemented: +1 if (x/y) >= eps, -1 if x <= -eps, otherwise x/eps.
-- Notes   : Ensure y is not zero before calling to avoid division by zero.
--          Negative threshold uses x (not x/y) as implemented in this legacy version.
--------------------------------------------------------------------------------

FUNCTION REAL sign3
   (
   REAL x      "First input value",
   REAL y      "Second input value",
   REAL eps    "Tolerance"
   )  "Smoothed sign function with a linear transition around zero. It uses a ratio x/y for the positive threshold"

   BODY 
      IF (x/y >= eps) THEN
         RETURN 1.
      ELSEIF (x<=-eps) THEN
         RETURN -1.
      ELSE
         RETURN x/eps
      END IF

      RETURN -1.

END FUNCTION
--------------------------------------------------------------------------------
-- Function: bound
-- Purpose : Clamp (saturate) x to the interval [xmin, xmax].
-- Inputs  : x (REAL) Input value; xmin/xmax (REAL) Lower/upper bounds.
-- Returns : xmin if x < xmin, xmax if x > xmax, else x.
-- Notes   : Equivalent to min(max(x, xmin), xmax).
--------------------------------------------------------------------------------

FUNCTION REAL bound
   (
   IN REAL x                      "Input value",
   IN REAL xmin                   "Lower bound",
   IN REAL xmax                   "Upper bound"
   )  "Function to saturate an input value between a lower and an upper bound."

   DECLS
      REAL y                      "Output value"

   BODY
      IF (x < xmin) THEN
         y = xmin
      ELSEIF (x > xmax) THEN
         y = xmax
      ELSE
         y = x
      END IF

      RETURN y

END FUNCTION

--------------------------------------------------------------------------------
-- Function sum1D
--------------------------------------------------------------------------------
-- Function: sum1D
-- Purpose : Sum all elements of a 1D REAL array.
-- Inputs  : Nx (INTEGER) Number of elements; A[Nx] (REAL) Array values.
-- Returns : Sum over i = 1..Nx of A[i].
-- Notes   : Uses an explicit FOR loop (1-based indexing).
--------------------------------------------------------------------------------

FUNCTION REAL sum1D
   (
   IN INTEGER Nx     UNITS no_units       "Number of array elements",
   IN REAL A[Nx]     UNITS no_units       "Array of elements"
   )  "Function to sum a 1D real array"

   DECLS
      REAL sum = 0.

   BODY
      FOR (i IN 1,Nx)
         sum = sum + A[i]
      END FOR

   RETURN sum

END FUNCTION

--------------------------------------------------------------------------------
-- Function sum2D
--------------------------------------------------------------------------------
-- Function: sum2D
-- Purpose : Sum all elements of a 2D REAL array (matrix).
-- Inputs  : Nx (INTEGER) Number of rows; Ny (INTEGER) Number of columns; A[Nx,Ny] (REAL) Matrix values.
-- Returns : Sum over i = 1..Nx and j = 1..Ny of A[i,j].
-- Notes   : Uses nested FOR loops (1-based indexing).
--------------------------------------------------------------------------------

FUNCTION REAL sum2D
   (
   IN INTEGER Nx        UNITS no_units       "Number of rows of matrix",
   IN INTEGER Ny        UNITS no_units       "Number of columns of matrix",
   IN REAL A[Nx,Ny]     UNITS no_units       "Matrix of elements"
   )  "Function to sum a 2D real array"

   DECLS
      REAL sum = 0.

   BODY
      FOR (i IN 1,Nx)
         FOR (j IN 1,Ny)
            sum = sum + A[i,j]
         END FOR
      END FOR

   RETURN sum

END FUNCTION

--------------------------------------------------------------------------------
-- Function sumND
--------------------------------------------------------------------------------
-- Function: sumND
-- Purpose : Sum all elements of a REAL array with dynamic/enumerative sizing.
-- Inputs  : A[] (REAL) Array values (must have at least one element).
-- Returns : Sum over i = 1..Nx of A[i].
-- Notes   : Array length Nx is obtained with sizeArrayReal(A[1], 0).
--          Uses the SUM(i IN 1,Nx; ...) expression.
--------------------------------------------------------------------------------

FUNCTION REAL sumND
   (
   IN REAL A[]          UNITS no_units       "Array of elements"
   )  "Function to sum a real array"

   DECLS
      INTEGER Nx        UNITS no_units       "Number of elements"
      REAL sum = 0.     UNITS no_units       "Sum of the elements of the array (output)"

   BODY
      Nx = sizeArrayReal( A[1], 0 )
      sum = SUM (i IN 1,Nx; A[i])
      RETURN sum

END FUNCTION

--------------------------------------------------------------------------------
-- Function sumND_int
--------------------------------------------------------------------------------
-- Function: sumND_int
-- Purpose : Sum all elements of an INTEGER array with dynamic/enumerative sizing.
-- Inputs  : A[] (INTEGER) Array values (must have at least one element).
-- Returns : Integer sum over i = 1..Nx of A[i].
-- Notes   : Array length Nx is obtained with sizeArrayInt(A[1], 0).
--          Uses an explicit FOR loop.
--------------------------------------------------------------------------------

FUNCTION INTEGER sumND_int
   (
   IN INTEGER A[]          UNITS no_units       "Array of elements"
   )  "Function to sum an integer array"

   DECLS
      INTEGER Nx           UNITS no_units       "Number of elements"
      INTEGER sum = 0      UNITS no_units       "Sum of the elements of the array (output)"

   BODY
      Nx = sizeArrayInt( A[1], 0 )
      FOR (i IN 1,Nx)
         sum = sum + A[i]
      END FOR

      RETURN sum

END FUNCTION

--------------------------------------------------------------------------------
-- Function: discr
-- Purpose: 
--    Empty function for solve boundary problems with non assigned
--    variables in CONTINUOUS block.
--------------------------------------------------------------------------------

FUNCTION NO_TYPE discr
   (
   OUT REAL y
   )  "Function to mark a real variable as discrete"

   BODY
      RETURN

END FUNCTION

--------------------------------------------------------------------------------
-- Function: discr_array
-- Purpose: 
--    Empty function for solve boundary problems with non assigned
--    array variables in CONTINUOUS block.
--------------------------------------------------------------------------------

FUNCTION NO_TYPE discr_array
   (
   OUT REAL y[]
   )  "Function to mark an array of real variables as discrete"

   BODY
      RETURN

END FUNCTION

--------------------------------------------------------------------------------
-- Function remainder
--------------------------------------------------------------------------------
-- Purpose:
--    Defines a function that returns the remainder of the division of two
--    integers.
--------------------------------------------------------------------------------
FUNCTION INTEGER remainder
   (
   IN INTEGER dividend  "Dividend",
   IN INTEGER divisor   "Divisor",
   IN BOOLEAN w_zero = TRUE   "Option to return the divisor instead of 0 when it's an exact division"
   )  "Function to calculate the remainder of an integer division"

   DECLS
      INTEGER i_quotient
      REAL quotient
      
      INTEGER res

   BODY
      quotient = dividend / divisor
      i_quotient = quotient
      
      res = dividend - i_quotient * divisor

      IF ((NOT w_zero) AND (res == 0)) THEN
         RETURN divisor
      END IF

      RETURN res

END FUNCTION

--------------------------------------------------------------------------------
-- Function int
--------------------------------------------------------------------------------
-- Purpose:
--    Function calculating the integer part of a real number. It truncates the
--    fractional part of the input.
--------------------------------------------------------------------------------
FUNCTION INTEGER int
   (
   IN REAL real_number  UNITS no_units    "Input value"
   )  "Function to calculate the integer part of a real number"

   BODY

      RETURN real_number

END FUNCTION

--------------------------------------------------------------------------------
-- Function roundN
--------------------------------------------------------------------------------
-- Purpose:
--    Rounds real values to a given index position.
--    Max number length: 10 characters.
--------------------------------------------------------------------------------
FUNCTION REAL roundN 
   (
   IN REAL num             UNITS no_units    "Input value", 
   IN INTEGER idx = 0      UNITS no_units    "Number of decimals to round. Default: round to integer"
   )  "Function to round a real number with a given number of decimals"

   BODY
      num = num*10**(idx)
		
      IF((num - int(num)) < 0.5) THEN
         num = int(num)	
      ELSEIF ((num - int(num)) >= 0.5) THEN
         num = int(num) + 1
      END IF
		
      num = num*10**(-idx)
      RETURN num
END FUNCTION


--------------------------------------------------------------------------------
-- Function: GetRealArrayItem
-- Purpose : Return element i from a REAL array.
-- Inputs  : input[] (REAL) Array; i (INTEGER) 1-based index.
-- Returns : input[i].
-- Notes   : No bounds checking is performed.
--------------------------------------------------------------------------------

FUNCTION REAL GetRealArrayItem
   (
   IN REAL input[]     "Real array",
   IN INTEGER i        "Index"
   )  "Function to get an element of a real array"   

   BODY
      RETURN input[i]
END FUNCTION
 
--------------------------------------------------------------------------------
-- Function: sort
-- Purpose : Sort the elements of a real array from highest to lowest (h_to_l = TRUE, default) or from lowest to highest (h_to_l = FALSE)
-- Inputs  : x[] (REAL) Array; h_to_l (BOOLEAN, opt) TRUE to sort from highest to lowest (default), FALSE to sort from lowest to highest 
-- Returns : x_ord (REAL) Sorted array
--------------------------------------------------------------------------------

FUNCTION NO_TYPE sort(
      REAL x[]                "Input array", 
      OUT REAL x_ord[]        "Ordered array", 
      BOOLEAN h_to_l = TRUE   "Boolean to decide whether to sort from highest to lowest"
      )  "Function to sort the elements of an array from highest to lowest or vice versa"

DECLS
   INTEGER  N        "Number of elements"
   REAL     max      "Auxiliar variable to store the maximum of each iteration"
   INTEGER  idx      "Auxiliar variable to store the index of the of maximum of each iteration"

BODY
   -- Calculate N
   N = sizeArrayReal(x[1],0)
   
   -- Initialize the ordered array
   IF h_to_l THEN
      FOR (i IN 1,N)
         x_ord[i] = x[i]
      END FOR
   ELSE
      FOR (i IN 1,N)
         x_ord[i] = -x[i] -- Change the sign if it's from lowest to highest
      END FOR
   END IF
   
   -- Loop: sort from max to min of x if h_to_l or of -x if not h_to_l
   FOR (k IN 1,N-1)
      idx = k
      max = x_ord[k]
      FOR (j IN k+1,N)
         IF (x_ord[j] > max) THEN
            max = x_ord[j]
            idx = j
         END IF
      END FOR
      x_ord[idx] = x_ord[k]
      x_ord[k] = max
   END FOR
   
   -- Change the sign again if it's from lowest to highest
   IF NOT h_to_l THEN
      FOR (i IN 1,N)
         x_ord[i] = -x_ord[i]
      END FOR
   END IF
   
END FUNCTION

--------------------------------------------------------------------------------
-- Function: sort_int
-- Purpose : Sort the elements of an integer array from highest to lowest (h_to_l = TRUE, default) or from lowest to highest (h_to_l = FALSE)
-- Inputs  : x[] (INTEGER) Array; h_to_l (BOOLEAN, opt) TRUE to sort from highest to lowest(default), FALSE to sort from lowest to highest 
-- Returns : x_ord (INTEGER) Sorted array
--------------------------------------------------------------------------------

FUNCTION NO_TYPE sort_int(
      INTEGER x[]             "Input array", 
      OUT INTEGER x_ord[]     "Ordered array", 
      BOOLEAN h_to_l = TRUE   "Boolean to choose whether to sort from highest to lowest"
      ) "Function to sort the elements of an integer array from highest to lowest or vice versa"

DECLS
   INTEGER N      "Number of elements"
   INTEGER max    "Auxiliar variable to store the maximum of each iteration"
   INTEGER idx    "Auxiliar variable to store the index of the of maximum of each iteration"

BODY
   -- Calculate N
   N = sizeArrayInt(x[1],0)
   
   -- Initialize the ordered array
   IF h_to_l THEN
      FOR (i IN 1,N)
         x_ord[i] = x[i]
      END FOR
   ELSE
      FOR (i IN 1,N)
         x_ord[i] = -x[i] -- Change the sign if it's from lowest to highest
      END FOR
   END IF
   
   -- Loop
   FOR (k IN 1,N-1)
      idx = k
      max = x_ord[k]
      FOR (j IN k+1,N)
         IF (x_ord[j] > max) THEN
            max = x_ord[j]
            idx = j
         END IF
      END FOR
      x_ord[idx] = x_ord[k]
      x_ord[k] = max
   END FOR
   
   -- Change the sign again if it's from lowest to highest
   IF NOT h_to_l THEN
      FOR (i IN 1,N)
         x_ord[i] = -x_ord[i]
      END FOR
   END IF
   
END FUNCTION

--------------------------------------------------------------------------------
-- Function: reverse
-- Purpose : Inverse the order of the elements of a real array.
--------------------------------------------------------------------------------

FUNCTION NO_TYPE reverse (
      REAL x[]             "Input array", 
      OUT REAL x_out[]     "Array with elements in reversed order"
      ) "Function to inverse the order of the elements of an array."
      
DECLS
   INTEGER N      "Number of elements in the array"

BODY
   -- Calculate N
   N = sizeArrayReal(x[1],0)
   
   -- Loop
   FOR (i IN 1,N)
      x_out[i] = x[N+1-i]
   END FOR
   
END FUNCTION

--------------------------------------------------------------------------------
-- Function: reverse_int
-- Purpose : 
-- Inputs  : 
-- Returns : 
--------------------------------------------------------------------------------

FUNCTION NO_TYPE reverse_int(
      INTEGER x[]             "Input array", 
      OUT INTEGER x_out[]     "Array with elements in reversed order"
      ) "Function to inverse the order of the elements of an integer array."
DECLS
   INTEGER N

BODY
   -- Calculate N
   N = sizeArrayInt(x[1],0)
   
   -- Loop
   FOR (i IN 1,N)
      x_out[i] = x[N+1-i]
   END FOR
   
END FUNCTION

--------------------------------------------------------------------------------
-- Function: count
-- Purpose : This function counts the number of matches of values in the range (value-tol,value+tol) in the real array x[], and returns it as an integer.
--------------------------------------------------------------------------------

FUNCTION INTEGER count (
      REAL value        "Input value", 
      REAL x[]          "Input array", 
      REAL tol = 1e-8   "Tolerance"
      ) "Function to count the number of matches of values in the range (value-tol,value+tol) in the array x[]"
DECLS
   INTEGER N      "Number of elements in the array"
   INTEGER times  "Number of matches of value in x[]"

BODY
   -- Calculate N
   N = sizeArrayReal(x[1],0)
   
   -- Loop
   times = 0
   FOR (i IN 1,N)
      IF (abs(x[i] - value) < tol) THEN
         times = times + 1
      END IF
   END FOR
   
   RETURN times
   
END FUNCTION

--------------------------------------------------------------------------------
-- Function: count_int
-- Purpose : This function counts the number of matches of value in the integer array x[], and returns it as an integer.
--------------------------------------------------------------------------------

FUNCTION INTEGER count_int (
         INTEGER value     "Input value", 
         INTEGER x[]       "Input array"
         ) "Function to count the number of matches of a value in an integer array x[]"
         
DECLS
   INTEGER N
   INTEGER times

BODY
   -- Calculate N
   N = sizeArrayInt(x[1],0)
   
   -- Loop
   times = 0
   FOR (i IN 1,N)
      IF (x[i] == value) THEN
         times = times + 1
      END IF
   END FOR
   
   RETURN times
   
END FUNCTION

--------------------------------------------------------------------------------
-- Function: find
-- Purpose : This function searches for an element in a real array that matches a given value and returns its index.
-- If there is no match, a 0 is returned.
-- The tolerance can be varied (default: 1e.8)
--------------------------------------------------------------------------------

FUNCTION INTEGER find (
      REAL value           "Value to search", 
      REAL x[]             "Input array", 
      REAL tol = 1e-8      "Tolerance"
      )  "Function to get the first index of an array that matches a certain value with a tolerance. If there's no match, a 0 is returned."
      
DECLS
   INTEGER N   "Number of elements in the array"

BODY
   -- Calculate N
   N = sizeArrayReal(x[1],0)
   
   -- Loop
   FOR (i IN 1,N)
      IF (abs(x[i] - value) < tol) THEN
         RETURN i
      END IF
   END FOR
   
   RETURN 0
   
END FUNCTION

--------------------------------------------------------------------------------
-- Function: find_int
-- Purpose : This function searches for an element in an integer array that matches a given value and returns its index.
-- If there is no match, a 0 is returned.
--------------------------------------------------------------------------------

FUNCTION INTEGER find_int (
         INTEGER value     "Value to search", 
         INTEGER x[]       "Input array"
         ) "Function to get the first index of an array that matches a certain value. If there's no match, a 0 is returned."
         
DECLS
   INTEGER N

BODY
   -- Calculate N
   N = sizeArrayInt(x[1],0)
   
   -- Loop
   FOR (i IN 1,N)
      IF (x[i] == value) THEN
         RETURN i
      END IF
   END FOR
   
   RETURN 0
   
END FUNCTION


--------------------------------------------------------------------------------
-- Function numDerivReal
--------------------------------------------------------------------------------
-- Purpose:
--    Boolean function to estimate the numerical derivative of a variable
--------------------------------------------------------------------------------
FUNCTION BOOLEAN numDerivReal(
      IN REAL x                                       UNITS no_units    "Variable at current time stamp",
      OUT REAL xprimeNumeric                          UNITS u_1_s       "Estimated time derivative",
      IN REAL timeNow                                 UNITS u_s         "Current time",
      OUT REAL x_old[2]                               UNITS no_units    "Variable at previous time stamp",
      OUT REAL timePrev                               UNITS u_s         "Previous time stamp")
      "Function to estimate the numerical derivative of a variable"

   BODY
      x_old[1] = x_old[2]
      x_old[2] = x
      IF (timeNow > timePrev) THEN
         xprimeNumeric = (x_old[2] - x_old[1]) / (timeNow - timePrev)
      END IF
      timePrev = timeNow

      RETURN TRUE

END FUNCTION
