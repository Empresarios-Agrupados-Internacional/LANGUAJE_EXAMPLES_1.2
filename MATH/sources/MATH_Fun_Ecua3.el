--------------------------------------------------------------------------------
-- EcosimPro MATH library - Equation utilities
--
-- This file defines helper functions to solve:
--   - Quadratic equations (ecua2)
--   - Cubic equations (ecua3)
--
-- The functions return their roots through OUT arguments. When no valid
-- solution is found (e.g. no real roots, or degenerate cases), the
-- corresponding root variables remain set to a large sentinel value
-- (1e40) to indicate "no solution".
--------------------------------------------------------------------------------

-- Global numeric tolerance used to decide if a coefficient is considered zero
CONST REAL tol = 1.e-12      "Numeric tolerance for coefficient comparisons"


--------------------------------------------------------------------------------
-- Function ecua2
--------------------------------------------------------------------------------
-- Purpose:
--    Solve a quadratic equation of the form:
--       a1*x^2 + a2*x + a3 = 0
--
-- Arguments:
--    a1   Coefficient of x^2 (quadratic term)
--    a2   Coefficient of x   (linear term)
--    a3   Coefficient of x^0 (independent term)
--    r1   First solution of the quadratic equation
--    r2   Second solution of the quadratic equation
--
-- Behaviour:
--    - If |a1| > tol, the equation is treated as quadratic and:
--        * If the discriminant (det) is positive:
--            - Two real roots exist.
--            - r1 is computed using the numerically more stable formula.
--            - r2 is computed using r2 = (a3/a1) / r1.
--        * If the discriminant is zero:
--            - One real root exists.
--            - r1 is the repeated root; r2 remains at the sentinel value.
--    - If |a1| <= tol, the equation is treated as linear:
--        * a2*x + a3 = 0  =>  x = -a3/a2
--        * The solution is stored in r1.
--
-- Notes:
--    - Both r1 and r2 are initialized to 1e40 to mark “no solution”.
--    - This function only computes real roots.
--------------------------------------------------------------------------------
FUNCTION NO_TYPE ecua2
   ( 
      IN REAL  a1      "Coefficient of the quadratic term", 
      IN REAL  a2      "Coefficient of the linear term", 
      IN REAL  a3      "Coefficient of the independent term",
      OUT REAL r1      "First solution of the quadratic equation", 
      OUT REAL r2      "Second solution of the quadratic equation",
      OUT INTEGER n_roots = DUMMY_INTEGER    "Number of distinct real roots found" 
   )
"Function to solve a quadratic equation"

   DECLS
      REAL det   "Auxiliary variable: discriminant"

   BODY

      -- Initialise roots to sentinel value (no solution)
      r1 = 1e40
      r2 = 1e40
      n_roots = 0

      IF (abs(a1) > tol) THEN
         -- Quadratic equation: a1*x^2 + a2*x + a3 = 0
         det = a2*a2 - 4*a1*a3

         IF  (det > 0) THEN
            -- Two distinct real roots
            n_roots = 2
            -- Compute the root with greatest absolute value
            IF (a2 >= 0) THEN
               r1 = (-a2 - sqrt(det)) / (2*a1)
            ELSE
               r1 = (-a2 + sqrt(det)) / (2*a1)
            END IF   

            -- Compute the root with smallest absolute value using:
            --   r1 * r2 = a3 / a1  =>  r2 = (a3/a1) / r1
            r2 = (a3/a1) / r1

         ELSEIF (det == 0) THEN
            -- One repeated real root
            n_roots = 1
            r1 = -a2 / (2*a1)
            -- r2 remains at sentinel value (no second distinct root)
         END IF

      ELSE
         -- Degenerate case: treat as linear equation a2*x + a3 = 0
         n_roots = 1
         r1 = -a3/a2
      END IF

      RETURN

END FUNCTION


--------------------------------------------------------------------------------
-- Function ecua3
--------------------------------------------------------------------------------
-- Purpose:
--    Solve a cubic equation of the form:
--       a[1]*x^3 + a[2]*x^2 + a[3]*x + a[4] = 0
--
-- Arguments:
--    a[1]   Coefficient of x^3
--    a[2]   Coefficient of x^2
--    a[3]   Coefficient of x
--    a[4]   Constant term
--    r1     First solution of the cubic equation
--    r2     Second solution of the cubic equation
--    r3     Third solution of the cubic equation
--
-- Behaviour:
--    - If |a[1]| > tol, the equation is treated as cubic and reduced to
--      its depressed form. Depending on the discriminant (delta):
--        * delta > 0: three distinct real roots.
--        * delta <= 0: one or two distinct real roots.
--    - If a[1] is approximately zero, the function falls back to:
--        * Quadratic equation (via ecua2) if |a[2]| > tol.
--        * Linear equation if |a[3]| > tol.
--
-- Notes:
--    - r1, r2, r3 are initialised to 1e40 (sentinel “no solution” value).
--    - n_roots stores the number of valid real roots found (1, 2 or 3).
--    - Only real roots are returned; complex roots are not handled.
--------------------------------------------------------------------------------
FUNCTION NO_TYPE ecua3
   (
      IN REAL a[4]      "Array of the equation coefficients", 
      OUT REAL r1       "First solution of the cubic equation", 
      OUT REAL r2       "Second solution of the cubic equation", 
      OUT REAL r3       "Third solution of the cubic equation",
      OUT INTEGER n_roots = DUMMY_INTEGER    "Number of different real roots found" 
   )
"Function to solve a cubic equation"
   DECLS
      REAL Q            "Intermediate variable"
      REAL Q3           "Cubic value of Q"
      REAL R            "Intermediate variable"
      REAL theta        "Angle used in trigonometric solution"
      REAL aux          "Auxiliary variable"

      REAL delta        "Discriminant-like term"

   BODY
      -- Initialise roots to sentinel value (no solution)
      r1 = 1e40
      r2 = 1e40
      r3 = 1e40
      n_roots = 0

      IF (abs(a[1]) > tol) THEN 
         -- Cubic equation: normalise coefficients by a[1]
         a[2] = a[2] / a[1]
         a[3] = a[3] / a[1]
         a[4] = a[4] / a[1]

         -- Depressed cubic parameters
         Q = (a[2]*a[2] - 3*a[3]) / 9.
         R = (2*a[2]*a[2]*a[2] - 9.*a[2]*a[3] + 27*a[4]) / 54.

         Q3 = Q*Q*Q
         delta = Q3 - R*R

         IF (delta > 0) THEN 
            -- Three distinct real roots
            theta = acos(R/ssqrt(Q3))

            r1 = -2*ssqrt(Q) * cos(theta/3.)        - a[2]/3
            r2 = -2*ssqrt(Q) * cos((theta+2*PI)/3.) - a[2]/3
            r3 = -2*ssqrt(Q) * cos((theta+4*PI)/3.) - a[2]/3

            n_roots = 3

         ELSE
            -- One real root
            aux = (ssqrt(R*R - Q3) + abs(R))**(1./3.)

            IF (R >= 0) THEN
               r1 = -(aux + Q/aux) - a[2]/3.
            ELSE
               r1 =  (aux + Q/aux) - a[2]/3.
            END IF

            n_roots = 1

            -- Check if a second distinct root exists
            -- Expression in parentheses is Ruffini's remainder.
            -- Condition ensures that r2 != r1.
            IF (abs(a[3] + 2*a[2]*r1 + 3*r1*r1) > tol) AND (abs(a[2]+3*r1) > tol) THEN
               r2 = - (a[2] + r1) / 2
               n_roots = 2
            END IF

         END IF

      ELSEIF (abs(a[2]) > tol) THEN
         -- Quadratic equation: fall back to ecua2
         ecua2(a[2], a[3], a[4], r1, r2, n_roots)

      ELSEIF (abs(a[3]) > tol) THEN
         -- Linear equation: a[3]*x + a[4] = 0
         r1 = -a[4] / a[3]
         n_roots = 1
      END IF

      RETURN

END FUNCTION
