--------------------------------------------------------------------------------
-- EA Internacional    EcosimPro Simulation Source Code
--
--    FILE NAME:  MATH_f_Fluids.el
--    FILE TYPE:  Functions of the MATH library
--    DESCRIPTION:  Defines math functions for Fluid Simulation
--    NOTES:  Based on EcosimPro MATH library
--    AUTHOR:  Ramon Perez Vara
--    CREATION DATE:  12-Jan-2004
--------------------------------------------------------------------------------

-----------------------------------------------------------------------
-- Function deadband
-----------------------------------------------------------------------
-- Purpose:
--    Apply a dead band to an input signal.
--
-- Behaviour:
--    - If x is outside the interval [x_low, x_up], the output y is x.
--    - If x is inside the interval [x_low, x_up], the output y is 0.
--
-- Arguments:
--    x      Input variable.
--    x_up   Upper limit of the dead band.
--    x_low  Lower limit of the dead band.
-----------------------------------------------------------------------
FUNCTION REAL deadband
   (
      REAL x         "Input variable", 
      REAL x_up      "Upper limit of the dead band", 
      REAL x_low     "Lower limit of the dead band"
   )
"Function to apply a dead band to an input signal"

    DECLS 
        REAL y   "Output value after applying the dead band"
    BODY
        IF (x > x_up OR x < x_low) THEN 
           y = x
        ELSE 
           y = 0
        END IF

        RETURN y
END FUNCTION

-----------------------------------------------------------------------
-- Functions div_safe/div_safe2
-----------------------------------------------------------------------
-- Purpose:
--    Perform a numerically safe division, avoiding division by zero or
--    by very small denominators.
--    In case of division by zero, they return the previous value-

--    div_safe is a no_type function, and the result is returned as an output parameter (y)
--    div_safe2 is a real function, and the result is returned as a real
-----------------------------------------------------------------------
FUNCTION NO_TYPE div_safe
   (
      REAL num                "Numerator", 
      REAL den                "Denominator", 
      OUT REAL y              "Result of the division",
      REAL math_tol = 1e-8    "Tolerance"
   )
"Function to perform a numerically safe division, avoiding division by zero. \
If the denominator is too small, the previous value of the result is returned as an output parameter."

BODY
    IF (abs(den) > math_tol) THEN
        y = num / den
    END IF

END FUNCTION

FUNCTION REAL div_safe2
   (
      REAL num                "Numerator", 
      REAL den                "Denominator",
      REAL math_tol = 1e-8    "Tolerance"
   )
"Function to perform a numerically safe division, avoiding division by zero. If the denominator is too small, the previous value of the result is returned as a real."

DECLS
    REAL y           "Result of the division"
    
BODY
    IF (abs(den) > math_tol) THEN
        y = num / den
    END IF

    RETURN y
END FUNCTION

-----------------------------------------------------------------------
-- Function donor_cell
-----------------------------------------------------------------------
-- Purpose:
--    Compute the convected value of a fluid property at an interface
--    using the donor-cell (upwind) scheme.
--
-- Behaviour:
--    - If flow > 0:
--        The upstream (donor) side is the inlet, so the upstream
--        property is used.
--    - If flow < 0:
--        The upstream (donor) side is the outlet, so the downstream
--        property is used.
--    - A small tolerance is added in the denominator to avoid
--      numerical problems around zero flow.
--
-- Arguments:
--    flow            Mass or volumetric flow rate (defines flow direction).
--    upstream_prop   Value of the property in the upstream cell.
--    downstream_prop Value of the property in the downstream cell.
--    math_tol        Small value to avoid division by zero. Optional, 1e-8 by default.
-----------------------------------------------------------------------
FUNCTION REAL donor_cell 
   (
      REAL flow               UNITS no_units    "Flow variable", 
      REAL upstream_prop      UNITS no_units    "Upstream value of the property", 
      REAL downstream_prop    UNITS no_units    "Downstream value of the property",
      REAL math_tol = 1e-10    UNITS no_units    "Tolerance"
   )
"Function to calculate the convected fluid property using the donor-cell (upwind) scheme"

DECLS
    REAL c            "Smoothed indicator of the flow direction (-1 <= c <= 1)"
    REAL prop         "Convected value of the fluid property at the interface"

BODY
    -- c is approximately sign(flow), regularised with math_tol to avoid division by zero
    c = flow / (abs(flow) + math_tol)

    -- Upwind interpolation of the property
    prop = 0.5 * ((1. + c) * upstream_prop + (1. - c) * downstream_prop)

    RETURN prop
END FUNCTION 



-----------------------------------------------------------------------
-- Function fpow_gt_one
-----------------------------------------------------------------------
-- Purpose:
--    Compute a signed power y^n with a linear regularisation zone near
--    zero, for exponents n >= 1.
--
-- Behaviour:
--    - For |y| > ylam or ylam == 0:
--        x = sign(y) * |y|^n
--    - For |y| <= ylam:
--        A quadratic polynomial is used to ensure continuity and smooth
--        behaviour around zero.
--
-- Arguments:
--    y     Input number that is raised to the power n.
--    ylam  Parameter defining the linear regularisation zone.
--    n     Exponent (n >= 1).
-----------------------------------------------------------------------
FUNCTION REAL fpow_gt_one
   (
      IN REAL y         UNITS no_units   "Number that is raised", 
      IN REAL ylam      UNITS no_units   "Parameter defining the linear regularisation zone", 
      IN REAL n         UNITS no_units   "Exponent (n >= 1)"
   )
"Function to calculate a signed power with a linear zone near zero (n >= 1)"

   DECLS
      REAL x      "Result of the signed power with linear regularisation"

      REAL xlam   "Auxiliary variable related to the regularisation zone"
      REAL a      "Quadratic coefficient of an internal quadratic equation" 
      REAL b      "Linear coefficient of an internal quadratic equation"
      REAL c      "Independent term of an internal quadratic equation"
   BODY
        ASSERT (n >= 1) ERROR "Wrong exponent in function fpow_gt_one"

      IF (abs(y) > ylam OR ylam == 0) THEN
         x = MATH.sign(y) * abs(y)**n
      ELSE
         xlam = abs(ylam)**n
         a = (1./n - 1.) / xlam**(2. - 1./n)
         b = (2. - 1./n)   / xlam**(1. - 1/n)
         c = -abs(y)

         -- Solve quadratic equation a*x^2 + b*x + c = 0 (only one root is used)
         x = MATH.sign(y) * (-b + sqrt(abs(b**2 - 4 * a * c))) / (2 * a)
      END IF

      RETURN x
END FUNCTION

-----------------------------------------------------------------------
-- Function fpow_lt_one
-----------------------------------------------------------------------
-- Purpose:
--    Compute a signed power x^n with a linear regularisation zone near
--    zero, for exponents 0 <= n <= 1.
--
-- Behaviour:
--    - For |x| > xlam or xlam == 0:
--        y = sign(x) * |x|^n
--    - For |x| <= xlam:
--        A smooth polynomial is used so that y and its derivative are
--        continuous at |x| = xlam.
--
-- Arguments:
--    x     Input number.
--    xlam  Width of the linear regularisation zone around zero.
--    n     Exponent (0 <= n <= 1).
-----------------------------------------------------------------------
FUNCTION REAL fpow_lt_one
   (
      IN REAL x         UNITS no_units    "Input number", 
      IN REAL xlam      UNITS no_units    "Parameter defining the linear regularisation zone", 
      IN REAL n         UNITS no_units    "Exponent (0 <= n <= 1)"
   )
"Function to calculate a signed power with a linear zone near zero (0 <= n <= 1)"

   DECLS
      REAL y   "Result of the signed power with linear regularisation near zero"
   BODY
      ASSERT (n <= 1 AND n >= 0) ERROR "Wrong order of the root in function fpow_lt_one"

      IF (abs(x) > xlam OR xlam == 0) THEN
         y = MATH.sign(x) * abs(x)**n
      ELSE
         -- Polynomial expression ensuring continuity of y and dy/dx at |x| = xlam
         y = (2. - n) * (x / xlam**(1. - n)) + (n - 1.) * (x * abs(x) / xlam**(2. - n))
      END IF

      RETURN y
END FUNCTION

-----------------------------------------------------------------------
-- Function fpow
-----------------------------------------------------------------------
-- Purpose:
--    Wrapper for fpow_lt_one and fpow_gt_one that computes a signed
--    power with linear regularisation near zero for arbitrary n >= 0.
--
-- Behaviour:
--    - If n = 1:
--        x = y
--    - If n > 1:
--        x = fpow_gt_one(y, ylam, n)
--    - If 0 <= n < 1:
--        x = fpow_lt_one(y, ylam, n)
--
-- Arguments:
--    y     Input number that is raised to the power n.
--    ylam  Parameter defining the linear regularisation zone.
--    n     Exponent (n >= 0).
--
-- Notes:
--    - The functions fpow_lt_one and fpow_gt_one are inverse to each
--      other in the sense that:
--         y = fpow(x, xlam, n)
--         x = fpow(y, xlam**n, 1/n)
-----------------------------------------------------------------------
FUNCTION REAL fpow
   (
      IN REAL y         UNITS no_units    "Number that is raised", 
      IN REAL ylam      UNITS no_units    "Parameter defining the linear regularisation zone", 
      IN REAL n         UNITS no_units    "Exponent (n >= 0)"
   ) "Function to calculate a signed power with a linear zone near zero"
   DECLS
      REAL x      "Result of the signed power with linear regularisation"

   BODY
        ASSERT (n >= 0) ERROR "Wrong exponent in function fpow"

      IF (n == 1) THEN
         x = y
      ELSEIF (n > 1) THEN
         x = fpow_gt_one(y, ylam, n)
      ELSE
         x = fpow_lt_one(y, ylam, n)
      END IF

   RETURN x
END FUNCTION

--------------------------------------------------------------------------------
-- Function rev_fri
--------------------------------------------------------------------------------
-- Purpose:
--    Compute a Coulomb friction force with different magnitudes for
--    forward and reverse motion, using a smooth transition around zero
--    velocity.
--
-- Behaviour:
--    - For v > 0: friction tends to -fc1.
--    - For v < 0: friction tends to -fc2.
--    - The function tanh(v*1.e4) is used to approximate the sign
--      function with a continuous and differentiable profile near
--      v = 0.
--
-- Arguments:
--    v    Velocity (m/s).
--    fc1  Direct Coulomb friction (N) for positive velocity.
--    fc2  Reverse Coulomb friction (N) for negative velocity.
--------------------------------------------------------------------------------
FUNCTION REAL rev_fri 
(   
    REAL v        UNITS u_m_s    "Velocity",
    REAL fc1      UNITS u_N      "Direct Coulomb friction",
    REAL fc2      UNITS u_N      "Reverse Coulomb friction"
)  "Function to compute a Coulomb friction force"
DECLS
    REAL ffric    UNITS u_N      "Coulomb friction force"
BODY
    IF (v <= 0) THEN
      ffric = -fc2 * tanh(v * 1.e4)
    ELSE
      ffric = -fc1 * tanh(v * 1.e4)
    END IF

    RETURN ffric
END FUNCTION 

-----------------------------------------------------------------------
-- Function errorFunc
-----------------------------------------------------------------------
-- Purpose:
--    Calculate the error function following the next formula:
--     f = 2 / sqrt(PI) * int(exp(-t**2) * dt) from 0 to x
--    Used Bürmann series aproximation with the first two terms
--
--    The result is returned as a real
--
-- Arguments:
--    x
-----------------------------------------------------------------------
FUNCTION REAL errorFunc (
      IN REAL x)
      "Computation of error function based on the Bürmann series aproximation" 
   DECLS
      REAL f = 0                 UNITS no_units             "Error function value"

   BODY
      f = 2 / sqrt(PI) * sign(x) * sqrt(1 - exp(-x**2)) *\
            (sqrt(PI) / 2 + 31/200 *  exp(-x**2) - 341/8000 * exp(-2*x**2))
      
      RETURN f
END FUNCTION
