--------------------------------------------------------------------------------
-- EcosimPro MATH library - Polynomial utilities
--
--    FILE NAME:  MATH_f_Polynomials.el
--    FILE TYPE:  Functions of the MATH library
--    DESCRIPTION:  Defines polynomial-related math functions for the MATH library
--    NOTES:  Based on the original EcosimPro MATH library implementation
--    AUTHOR:  Ramon Perez Vara
--    CREATION DATE:  12-Jan-2004
--------------------------------------------------------------------------------


-- Functions

--------------------------------------------------------------------------------
-- Function fac
--------------------------------------------------------------------------------
-- Purpose:
--    Compute the factorial n! of a non-negative integer n:
--
--       n! = n * (n-1) * ... * 2 * 1   ,  for n >= 1
--       0! = 1
--
-- Arguments:
--    n  Integer number for which the factorial is evaluated (n >= 0).
--
-- Returns:
--    Real value y = n!.
--------------------------------------------------------------------------------
FUNCTION REAL fac
   (
   IN INTEGER n   "Integer number for which the factorial is evaluated"
   ) "Function to compute the factorial n! of a non-negative integer n"

   DECLS
      REAL y         UNITS no_units          "Output value (factorial result)"

   BODY
      y = 1.

      FOR (k IN 2, n)
         y = y * k
      END FOR

      RETURN y

END FUNCTION


--------------------------------------------------------------------------------
-- Function poly
--------------------------------------------------------------------------------
-- Purpose:
--    Evaluate a polynomial p(x) of degree (n-1) using Horner's method:
--
--       p(x) = A[1] + A[2]*x + ... + A[n]*x**(n-1)
--
-- Arguments:
--    x  Real value at which the polynomial is evaluated.
--    n  Order of the polynomial plus 1 (number of coefficients).
--    A  Array of coefficients, where:
--          A[1] = constant term,
--          A[2] = coefficient of x,
--          ...
--          A[n] = coefficient of x**(n-1).
--
-- Returns:
--    Real value y = p(x).
--------------------------------------------------------------------------------
FUNCTION REAL poly
   (
   IN REAL x                      "Real value to be substituted",
   IN INTEGER n                   "Order of the polynomial plus 1",
   IN REAL A[n]                   "Real array of polynomial coefficients"
   )  "Function to evaluate a polynomial"

   DECLS
      INTEGER j        UNITS no_units           "Loop counter"
      REAL y           UNITS no_units           "Output value (polynomial evaluation)"

   BODY
      -- Horner's scheme, evaluating from highest to lowest degree
      FOR (j = n, y = 0.; j > 0; j = j - 1)
         y = y * x + A[j]
      END FOR

      RETURN y

END FUNCTION


--------------------------------------------------------------------------------
-- Function poly_int
--------------------------------------------------------------------------------
-- Purpose:
--    Evaluate the integral F(x) of a polynomial p(x):
--
--       p(x) = A[1] + A[2]*x + ... + A[n]*x**(n-1)
--
--    The integral (with zero integration constant) is:
--
--       F(x) = A[1]*x + A[2]*x**2/2 + ... + A[n]*x**n/n
--
-- Arguments:
--    x  Real value at which the integral is evaluated.
--    n  Order of the polynomial plus 1 (number of coefficients).
--    A  Array of polynomial coefficients, as in poly.
--
-- Returns:
--    Real value y = F(x).
--------------------------------------------------------------------------------
FUNCTION REAL poly_int
   (
   IN REAL x                      "Real value to be substituted",
   IN INTEGER n                   "Order of the polynomial plus 1",
   IN REAL A[n]                   "Real array of polynomial coefficients"
   )  "Function to evaluate the integral of a polynomial"

   DECLS
      INTEGER j       UNITS no_units            "Loop counter"
      REAL y          UNITS no_units            "Output value (integral evaluation)"

   BODY
      -- Horner-like scheme applied to the integral coefficients A[j]/j
      FOR (j = n, y = 0.; j > 0; j = j - 1)
         y = y * x + A[j] / j
      END FOR

      -- Final multiplication by x to complete integration
      y = y * x

      RETURN y

END FUNCTION


--------------------------------------------------------------------------------
-- Function poly_dx_int
--------------------------------------------------------------------------------
-- Purpose:
--    Evaluate the integral of p(x)/x, where p(x) is a polynomial:
--
--       p(x)     = A[1] + A[2]*x + ... + A[n]*x**(n-1)
--       p(x)/x   = A[1]/x + A[2] + ... + A[n]*x**(n-2)
--
--    The integral (for x > 0) is:
--
--       F(x) = A[1]*log(x) + A[2]*x + A[3]*x**2/2 + ... +
--              A[n]*x**(n-1)/(n-1)
--
-- Arguments:
--    x  Real value at which the integral is evaluated (x > 0).
--    n  Order of the polynomial plus 1 (number of coefficients).
--    A  Array of polynomial coefficients, as in poly.
--
-- Returns:
--    Real value y = F(x).
--------------------------------------------------------------------------------
FUNCTION REAL poly_dx_int
   (
   IN REAL x                      "Real value to be substituted",
   IN INTEGER n                   "Order of the polynomial plus 1",
   IN REAL A[n]                   "Real array of polynomial coefficients"
   )  "Function to evaluate the integral of a polynomial divided by x"

   DECLS
      INTEGER j      UNITS no_units       "Loop counter"
      REAL y         UNITS no_units       "Output value (integral of p(x)/x)"

   BODY
      -- Horner-like scheme for the polynomial part excluding the A[1]/x term
      FOR (j = n, y = 0.; j > 1; j = j - 1)
         y = y * x + A[j] / (j - 1.)
      END FOR

      -- Add the logarithmic term corresponding to A[1]/x
      y = y * x + A[1] * log(x)

      RETURN y

END FUNCTION


--------------------------------------------------------------------------------
-- Function PolyMult
--------------------------------------------------------------------------------
-- Purpose:
--    Compute the product of two polynomials a(x) and b(x):
--
--       a(x) = a[1] + a[2]*x + ... + a[k]*x**(k-1)
--       b(x) = b[1] + b[2]*x + ... + b[l]*x**(l-1)
--
--    The result is a polynomial c(x) of degree (k + l - 2):
--
--       c(x) = c[1] + c[2]*x + ... + c[n]*x**(n-1)
--       with n = k + l
--
-- Arguments:
--    k    Number of coefficients of polynomial a(x).
--    a    Coefficient array of a(x).
--    l    Number of coefficients of polynomial b(x).
--    b    Coefficient array of b(x).
--    n    (OUT) Number of coefficients of the resulting polynomial c(x),
--              equal to k + l.
--    c    (OUT) Coefficient array of the product polynomial c(x).
--
-- Notes:
--    - Coefficients are stored in increasing powers of x:
--         index i corresponds to x**(i-1).
--    - The function assumes that the arrays a, b, and c are correctly sized.
--------------------------------------------------------------------------------
FUNCTION NO_TYPE PolyMult
   (
   INTEGER k      UNITS no_units    "Number of coefficients of polynomial a(x)",
   REAL a[k]      UNITS no_units    "Coefficient array of a(x)",
   INTEGER l      UNITS no_units    "Number of coefficients of polynomial b(x)",
   REAL b[l]      UNITS no_units    "Coefficient array of b(x)",
   OUT INTEGER n  UNITS no_units    "Number of coefficients of the resulting polynomial c(x)",
   OUT REAL c[n]  UNITS no_units    "Coefficient array of the product polynomial c(x)"
   )  "Function to compute the product of two polynomials"

   --DECLS
      --INTEGER k
   BODY
      --k = sizeArrayReal(a[1],0)
   
      -- Degree and number of coefficients of the resulting polynomial
      n = k + l - 1

      -- Initialise result coefficients to zero
      FOR (i IN 1, n)
         c[i] = 0.
      END FOR

      -- Convolution-like multiplication of the two polynomials
      FOR (i IN 1, k)
         FOR (j IN 1, l)
            c[i + j - 1] = c[i + j - 1] + a[i] * b[j]
         END FOR
      END FOR

END FUNCTION
