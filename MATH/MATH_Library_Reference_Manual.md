---
input_mode: dir
title: docs \> MATH \> source_files \> MATH_Library_Reference_Manual
---

# 1 Overview of the library

## 1.1 Introduction

The MATH library is a core component of the EcosimPro simulation environment, and provides the essential mathematical backbone required by all other libraries. It offers a broad set of constants, units, mathematical functions, and external objects that are fundamental for performing accurate numerical calculations and for developing reliable simulation models. Its integration is vital for the seamless operation of more specialized libraries to ensure a consistent and efficient simulation workflow.

## 1.2 Purpose of This Manual

This reference manual is intended as a comprehensive guide for users to understand and correctly utilize the functionalities offered by the MATH library within EcosimPro. It aims to:

- Explain the structure and contents of the library.

- Describe the role and use of constants, units, and functions.

- Provide developers and modellers with clear documentation for integrating MATH elements into their simulations.

- Ensure consistent and accurate mathematical modelling across different projects.

By detailing the elements of the library and their practical usage, this manual supports the development of high-quality simulation models and promotes best practices in mathematical and engineering computations.

## 1.3 Description

The MATH library provides the foundational tools and resources needed by other libraries in the EcosimPro environment. Its main features include:

- Mathematical and scientific constants such as $\pi$ (Pi), e (Euler's number), and other numerical values essential in computations.

- Standardized units that facilitate modelling and interpretation of results among EcosimPro users.

Mathematical functions used in equations, modelling tasks, and numerical methods. All the functions described here are accompanied by a usage example. All these examples are available in the MATH_EXAMPLES library.

- External objects that expand the library's capabilities and interface with external functions and classes when necessary.

The MATH library is designed to support both general-purpose and domain-specific modelling needs, enhancing the robustness, modularity, and scalability of simulation projects in EcosimPro.

## 1.4 Change log

+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Version | New Features                                                                                                                                                                          |
+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 3.4.0   | - New function to round numbers has been added.                                                                                                                                       |
|         |                                                                                                                                                                                       |
|         | - New units have been added.                                                                                                                                                          |
+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 3.4.4   | - New function roundD has been added.                                                                                                                                                 |
+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 3.4.6   | - New function errorFunc has been added.                                                                                                                                              |
|         |                                                                                                                                                                                       |
|         | - New argument representing the tolerance has been added to div_safe and donnor_cell functions.                                                                                       |
+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 3.4.8   | - Deprecated compiler platforms have been removed.                                                                                                                                    |
|         |                                                                                                                                                                                       |
|         | - Function solveNonLinearSystem has been added. This function is a wrapper of the Fortran function EcoNonLinearEqnSolver to protect outputs when detecting Nan values.                |
|         |                                                                                                                                                                                       |
|         | - Function numDerivReal has been added. It estimates the numerical derivative of a variable.                                                                                          |
|         |                                                                                                                                                                                       |
|         | - Functions count/count_int have been added. These functions count the number of matches with a given number within a list of numbers stored in an array and return it as an integer. |
|         |                                                                                                                                                                                       |
|         | - Functions find/find_int have been added. These function search for an element in an array that matches a given value and return its index.                                          |
|         |                                                                                                                                                                                       |
|         | - Functions reverse/reverse_int have been added. These functions inverse the order of the elements of an array.                                                                       |
|         |                                                                                                                                                                                       |
|         | - Functions sort/sort_int have been added. These functions sort the elements of an array from highest to lowest or from lowest to highest depending on the value of an argument.      |
|         |                                                                                                                                                                                       |
|         | - Function sumND has been added. It sums all elements of a REAL array with dynamic/enumerative sizing.                                                                                |
|         |                                                                                                                                                                                       |
|         | - Functions max_array, min_array and their integer versions have been added.                                                                                                          |
|         |                                                                                                                                                                                       |
|         | - Item categories have been implemented in the library.                                                                                                                               |
|         |                                                                                                                                                                                       |
|         | - Function div_safe2 has been added. Unlike div_safe, the new function is of a real type.                                                                                             |
|         |                                                                                                                                                                                       |
|         | - Macros to handle vectors, matrices and tensors have been added.                                                                                                                     |
|         |                                                                                                                                                                                       |
|         | - Functions csv_to_tab1d, csv_to_ntab1d have been added. These functions read a CSV file and store their values in 1D TABLEs sharing the same X column.                               |
|         |                                                                                                                                                                                       |
|         | - Components testFFT and CompLinearInterp1D have been moved to MATH_EXAMPLES library.                                                                                                 |
+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

# 2 MATH Library Items

## 2.1 MATH Global Variables

### 2.1.1 Mathematical and scientific constants

These constants are essential in any scientific or mathematical modelling, especially when performing calculations involving fundamental mathematical functions.

  ------------- --------- ------------------------- -------------------------------------------------- ---------
  NAME          TYPE      VALUE                     DESCRIPTION                                        UNITS

  E             REAL      2.71828...                Euler\'s Number                                    \-

  GAMMA         REAL      0.5772...                 Euler\'s Constant (or Euler-Mascheroni constant)   \-

  PI            REAL      3.1415...                 Pi number                                          \-
  ------------- --------- ------------------------- -------------------------------------------------- ---------

### 2.1.2 Thermal constants

These constants are specifically related to thermodynamics and are commonly used in environmental or physical simulations involving temperature and heat transfer.

  --------------------------------------------------------------------------------------------------------------------------------------------------------
  NAME               VALUE            DESCRIPTION                                                                                         UNITS
  ------------------ ---------------- --------------------------------------------------------------------------------------------------- ----------------
  STEFAN             5.6696e-8        Stefan-Boltzmann constant                                                                           W/(m^2^·K^4^)

  TZERO              273.15           Temperature offset between the Celsius and Kelvin scales.                                           K

  TMAX               1.e5             A maximum threshold for temperature. If a temperature exceeds this value, a warning may be issued   K
  --------------------------------------------------------------------------------------------------------------------------------------------------------

### 2.1.3 Other constants

These constants represent basic values used across many mathematical functions and simulations:

  ------------- ------------- --------------- ---------------------------------------------------------------------------------------------------------------------- ------------
  NAME          TYPE          VALUE           DESCRIPTION                                                                                                            UNITS

  Eps           REAL          $$10^{- 8}$$    Small number used to handle precision issues in floating-point comparisons (epsilon value).                            \-

  Inf           REAL          $$10^{38}$$     Large number used as a practical representation of infinity.                                                           \-

  Inf_int       INTEGER       2147483647      The maximum value for a 32-bit signed integer. It is used as a placeholder for infinity in integer-based operations.   \-

  Small         REAL          $$10^{- 16}$$   Real constant. A very small number used in simulations to avoid numerical errors or underflows.                        \-

  tol           REAL          $$10^{- 12}$$   Numeric tolerance. Used to solve quadratic and cubic equations.                                                        

  ZERO          REAL          0               Real constant. Represents zero, typically used as a reference value for many calculations.                             \-
  ------------- ------------- --------------- ---------------------------------------------------------------------------------------------------------------------- ------------

### 2.1.4 Units conversion constants

These constants are used to convert the units of variables.

  -------------- ----------- ------------- ----------------------
  NAME           TYPE        VALUE         DESCRIPTION

  DtoR           REAL        PI / 180      Degree to radian

  RtoD           REAL        180 / PI      Radian to degrees

  D2R            REAL        PI/180        Degree to radian

  R2D            REAL        180./PI       Radian to degrees

  in2cm          REAL        2.54          In to centimetre

  cm2in          REAL        1/in2cm       Centimetre to inch

  m2ft           REAL        3.28084       Metre to foot

  ft2m           REAL        1/m2ft        Foot to metre

  kg2lb          REAL        2.20462       Kilogram to pound

  lb2kg          REAL        1/kg2lb       Pound to kilogram

  bar2Pa         REAL        100000        Bar to pascal

  Pa2bar         REAL        1/bar2Pa      Pascal to bar

  atm2bar        REAL        1.01325       Atmosphere to bar

  bar2atm        REAL        1/atm2bar     Bar to atmosphere

  atm2Pa         REAL        101325        Atmosphere to pascal

  Pa2atm         REAL        1/atm2Pa      Pascal to atmosphere

  Wh2J           REAL        3600          Watts-hour to Joule
  -------------- ----------- ------------- ----------------------

## 2.2 MATH Units

Units are string-type variables that can be attached to constant, data, parameters and variables. Its purpose is informative and helps users write coherent equations and interpret results correctly. By explicitly defining units, users can make their code more robust, self-explanatory, and easier to maintain, especially in complex systems or collaborative environments where assumptions about value types and scales might differ.

Using units ensures clarity and uniformity across the codebase. They must be written as a string after the reserved word UNITS and before the description (if it exists):

COMPONENT units1

DATA

REAL v0 = 10 UNITS \"m/s\" \"Initial velocity\"

END COMPONENT

After this units have been set, they can be viewed in the attributes editor or in the monitor.

![](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image3.png){width="5.130250437445319in" height="1.966298118985127in"}

Also, in the monitor, the user can filter the variables with the same variables. This may not work as expected if, for example, variables exist in the following form:

COMPONENT units2

DATA

REAL U_mat_1 = 1.2 UNITS \"W/(m2·K)\" \"Thermal transmitance of material 1\"

REAL U_mat_2 = 0.8 UNITS \"W/Km2\" \"Thermal transmitance of material 2\"

END COMPONENT

Here, there are two variables with the same units, but that have been expressed differently. In this case, EcosimPro would interpret them as if they were different. To avoid confusion arising from this situation, the MATH library provides a set of standardized units that replace the strings. If these are used, the above code would be replaced by the following:

COMPONENT units3

DATA

REAL U_mat_1 = 1.2 UNITS u_W_m2K \"Thermal transmitance of material 1\"

REAL U_mat_2 = 0.8 UNITS u_W_m2K \"Thermal transmitance of material 2\"

END COMPONENT

This units are defined in the MATH_Units.el file of the MATH library as:

PRIVATE CONST STRING u_W_m2K = \"W/(m\^2·K)\" \"Watts per square metre Kelvin\"

Their purpose is to provide a standardized way of annotating units. This helps create a shared understanding of what each element represents and avoids common mistakes caused by ambiguity or inconsistent conventions.

In some cases, we may need to use units that are not described in MATH. Before writing them as strings, it may be advisable to check if they are written differently in MATH (for example, u_W_Km2 will give an error, but not u_W_m2K).

All MATH units are described in \[1\], Appendix G. However, some of them are included as examples.

  --------------------------------------------------------------------------
  NAME               VALUE            DESCRIPTION
  ------------------ ---------------- --------------------------------------
  u_m                m                Metre

  u_kg               kg               Kilograme

  u_1_s              s^-1^            Inverse second

  u_kg_m3            kg/m^3^          Kilograms per cubic metre

  u_J_kgK            J/(kg·K)         Joules per kilogram -- Kelvin

  u_W_m2K            W/(m^2^·K)       Watts per square metre -- Kelvin

  u_mol_m2s          mol/(m^2^·s)     Moles per square metre -- second

  u_V_m              V/m              Volts per metre

  u_Pas              Pa·s             Pascal -- second (dynamic viscosity)

  u_cd_m2            cd/m^2^          Candela per square metre (luminance)
  --------------------------------------------------------------------------

##### 2.2.0.0.1 Example: Assigning units to a variable

USE MATH

COMPONENT units4

DATA

p = 101.3 UNITS u_kPa \"Pressure\"

v = 10 UNITS u_m_s \"Velocity\"

END COMPONENT

In this case, the units \`\`u_kPa\'\' (kilopascal) and \`\`u_m_s\'\' (meters per second) clarify how the value should be interpreted.

## 2.3 MATH Functions 

This section gathers and explains all the different functions included in the math library.

### 2.3.1 Overview

  --------------------------------------------------------------------------------------------------------------------------------
  Function         Type         Description
  ---------------- ------------ --------------------------------------------------------------------------------------------------
  bnldev           REAL         Generate a binomial-distributed random deviate.

  bound            REAL         Saturates a real value between a lower and an upper bound.

  c_bnldev         REAL         External C function: generate a binomial-distributed random deviate.

  c_expdev         REAL         External C function: generate an exponential-distributed random deviate.

  c_gamdev         REAL         External C function: generate a gamma-distributed random deviate.

  c_gasdev         REAL         External C function: generate a Gaussian (normal) random deviate.

  c_poidev         REAL         External C function: generate a Poisson-distributed random deviate.

  c_ran1           REAL         External C function: generate a uniform random number in (0,1).

  count            INTEGER      Count elements in a real array that match a given value.

  count_int        INTEGER      Count elements in an integer array that match a given value.

  deadband         REAL         Apply a dead band: returns input outside \[x_low, x_up\], zero inside.

  discr            NO_TYPE      Mark a real variable as discrete-time (updated only at events).

  discr_array      NO_TYPE      Mark all elements of a real array as discrete-time.

  div_safe         NO_TYPE      Perform a safe division num/den, avoiding division by very small denominators. NO_TYPE function.
  --------------------------------------------------------------------------------------------------------------------------------

  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Function                Type         Description
  ----------------------- ------------ ----------------------------------------------------------------------------------------------------------------------------------
  div_safe2               REAL         Perform a safe division num/den, avoiding division by very small denominators. It returns a real value.

  donor_cell              REAL         Compute an upwind (donor-cell) value of a convected fluid property.

  EcoMachDep              NO_TYPE      External FORTRAN routine for Mach-dependent thermodynamic calculations.

  EcoNonLinearEqnSolver   NO_TYPE      External FORTRAN routine: nonlinear equation solver using reverse communication.

  ecua2                   NO_TYPE      Solve a quadratic equation a1\*x\^2 + a2\*x + a3 = 0 and return its real roots.

  ecua3                   NO_TYPE      Solve a cubic equation with coefficients a\[1..4\] and return its real roots.

  expdev                  REAL         Generate an exponential random deviate with unit rate (Exp(1)).

  fac                     REAL         Compute the factorial of an integer argument (n! as a real value).

  find                    INTEGER      Find the first index of a real array that matches a given value with a tolerance.

  find_int                INTEGER      Find the first index of an integer array that matches a given value.

  fpow                    REAL         Signed power with linear regularisation near zero for arbitrary exponent n ≥ 0.

  fpow_gt_one             REAL         Signed power with regularisation near zero for exponents n ≥ 1.

  fpow_lt_one             REAL         Signed power with regularisation near zero for exponents 0 ≤ n ≤ 1.

  gamdev                  REAL         Generate a gamma-distributed random deviate with integer shape parameter.

  gammln                  REAL         Compute ln(Gamma(x)) using a Lanczos-type approximation.

  gasdev                  REAL         Generate a standard normal random deviate N(0,1).

  GetRealArrayItem        REAL         Retrieve one element from a real array (possibly multidimensional) by index.

  int                     INTEGER      Integer part of a real value (truncation toward zero).

  max                     REAL         Maximum of two real values.

  max_arr_int             INTEGER      Maximum value in an integer array.

  max_array               REAL         Maximum value in a real array.

  max_impl                REAL         In-place running maximum: returns max(x,z) and updates z.

  min                     REAL         Minimum of two real values.

  min_arr_int             INTEGER      Minimum value in an integer array.

  min_array               REAL         Minimum value in a real array.

  min_impl                REAL         In-place running minimum: returns min(x,z) and updates z.

  numDerivReal            BOOLEAN      Estimate the numerical derivative of a variable

  poidev                  INTEGER      Generate a Poisson-distributed random deviate with mean lambda.

  poly                    REAL         Evaluate a polynomial $p(x)\  = \ A\lbrack 1\rbrack\  + \ A\lbrack 2\rbrack*x\  + \ ...\  + \ A\lbrack n\rbrack*x\hat{}(n - 1)$.

  poly_dx_int             REAL         Compute $\int p(x)/x\ dx$ dx for a polynomial $p(x)$.

  poly_int                REAL         Compute $\int p(x)\ dx$ for a polynomial $p(x)$.

  PolyMult                NO_TYPE      Multiply two polynomials and return the coefficient array of the product.

  ran1                    REAL         Generate a uniform random number in (0,1) using a combined LCG + shuffle table.

  remainder               INTEGER      Integer remainder of the division dividend/divisor.

  rev_fri                 REAL         Asymmetric Coulomb friction law with smooth transition around zero velocity.

  reverse                 NO_TYPE      Inverse the order of the elements of a real array.

  reverse_int             NO_TYPE      Inverse the order of the elements of an integer array.

  roundN                  REAL         Round a real number to a given number of decimals.

  sign                    REAL         Return -1, 0 or +1 depending on the sign of the input.

  sign2                   REAL         Smoothed sign function with a linear transition around zero

  sign3                   REAL         Variant of sign2 using a ratio x/y for the positive threshold.

  sort                    NO_TYPE      Sort a real array (optionally copying into an output array).

  sort_int                NO_TYPE      Sort an integer array (optionally copying into an output array).

  sum1D                   REAL         Sum all elements of a 1D real array.

  sum2D                   REAL         Sum all elements of a 2D real array.

  sumND                   REAL         Sum all elements of an N-dimensional real array.

  sumND_int               INTEGER      Sum all elements of an N-dimensional integer array.

  treatfft                NO_TYPE      External FORTRAN function to compute Fourier/transfer functions (amplitude/phase) from time histories via FFT.
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 2.3.2 Basic Functions

Defines basic math functions for the MATH library. These functions are quite useful in various simulation contexts, where operations such as finding maxima, minima, summing array elements, and evaluating signs of values are common.

#### 2.3.2.1 Function bound

This REAL function bounds a real value x between a minimum (xmin) and maximum (xmax).

##### 2.3.2.1.1 Parameters

  ------------- ------------- -------------- ------------
  NAME          TYPE          DESCRIPTION    UNITS

  x             IN REAL       Input value    \-

  xmin          IN REAL       Bottom value   \-

  xmax          IN REAL       Top value      \-
  ------------- ------------- -------------- ------------

##### 2.3.2.1.2 Return value

The function returns a real value:

- xmin if x \< xmin

- x if xmin \<= x \<= xmax

- xmax if x \> xmax

##### 2.3.2.1.3 Example

The following component uses the bound function to truncate a sine wave between -0.5 and 0.5. The result is stored in the variable bounded_sin.

COMPONENT bound_ex

DATA

REAL min_value = -0.5

REAL max_value = 0.5

DECLS

REAL x

REAL bounded_sin

CONTINUOUS

x = sin(TIME)

bounded_sin = bound(x,min_value,max_value)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                bound_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

This gives the following result:

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_bound.default\\exp1\\Tab_1#Plot_1_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image4.png){width="5.552239720034995in" height="2.5892957130358707in"}

#### 2.3.2.2 Functions count/count_int

This integer function counts the number of matches of a value in an array. Use count for real arrays, count_int for integer arrays.

##### 2.3.2.2.1 Parameters

  ----------- ------------- ----------------- ---------------------- -----------
  NAME        TYPE          DEFAULT           DESCRIPTION            UNITS

  tol \*      IN REAL       1e-8              Tolerance (optional)   \-

  value       IN REAL\*\*                     Input value            \-

  x           IN REAL\*\*                     Input array            \-
  ----------- ------------- ----------------- ---------------------- -----------

\* The integer version has no tolerance and only considers exact matches.

\*\* IN INTEGER in the integer version.

##### 2.3.2.2.2 Internal variables

  ------------- ------------- --------------------------------- ------------
  NAME          TYPE          DESCRIPTION                       UNITS

  N             INTEGER       Number of elements in the array   \-

  times         INTEGER       Number of coincidences            \-
  ------------- ------------- --------------------------------- ------------

##### 2.3.2.2.3 Return value

The function returns the integer times, the number of matches of elements in (value-tol,value+tol) in the array x\[N\].

##### 2.3.2.2.4 Example

The following example counts the number of matches of the input data value in the array x, with a given tolerance tol, and prints the result.

COMPONENT count_ex (INTEGER N = 5 \"Number of elements\")

DATA

REAL x\[5\] = {3,2.5,1.92,-1,PI}

REAL tol = 0.5

REAL value = 3

DECLS

INTEGER times

INIT

times = count(value, x, tol)

PRINT(\"times = \$times\")

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                count_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

With tol = 0.5, the printed message is:

times = 2

#### 2.3.2.3 Function discr

This function allows to use a variable as if it were discrete without having defined it as discrete, without causing problems with the boundary conditions. It\'s useful to avoid boundary-condition errors when a variable is intentionally left unassigned in a CONTINUOUS block. It is usually placed inside an IF-INSERT block.

##### 2.3.2.3.1 Parameters

  ------------- ------------- ------------- ------------
  NAME          TYPE          DESCRIPTION   UNITS

  y             IN REAL       Input value   \-
  ------------- ------------- ------------- ------------

##### 2.3.2.3.2 Return value

This function doesn\'t perform any calculations and is used as a placeholder.

##### 2.3.2.3.3 Example

In the following example, the boolean parameter discr_val is used to decide whether the variable x behaves as a discrete or dynamic variable.

COMPONENT discr_ex (BOOLEAN discr_var = FALSE)

DECLS

REAL x

REAL sint

INIT

x = 1

DISCRETE

WHEN sint \> 0.5 THEN

x = 1

END WHEN

WHEN sint \< -0.5 THEN

x = -1

END WHEN

CONTINUOUS

sint = sin(TIME)

IF(NOT discr_var) INSERT

x\' = sin(TIME)

ELSE

discr(x)

END IF

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                discr_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

Setting discr_var to TRUE, the variable x changes its value only in the discrete events:

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\WORKSPACES\\STANDARD_2.6.1\\libs\\MY_THERMAL\\experiments\\comp_discr.default\\exp1\\Tab_1#Plot_1_3.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image5.png){width="5.074627077865267in" height="2.375184820647419in"}

If discr_var is set to FALSE, the variable x varies dynamically and in the discrete events

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\WORKSPACES\\STANDARD_2.6.1\\libs\\MY_THERMAL\\experiments\\comp_discr.default\\exp1\\Tab_1#Plot_1_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image6.png){width="5.111940069991251in" height="2.392648731408574in"}

#### 2.3.2.4 Function discr_array

Similar to discr function (§[2.3.2.2.](#functions-countcount_int) ), this is an empty function used for boundary problems with an unassigned array of variables.

##### 2.3.2.4.1 Parameters

  ------------- ------------- ------------- ------------
  NAME          TYPE          DESCRIPTION   UNITS

  y\[\]         IN REAL       Input value   \-
  ------------- ------------- ------------- ------------

##### 2.3.2.4.2 Return value

This function doesn\'t perform any calculations and is used as a placeholder.

##### 2.3.2.4.3 Example

In the following example, the Boolean parameter discr_val is used to decide whether the array of variables array_var behaves as a discrete variable or as a dynamic variable.

COMPONENT discr_array_ex (BOOLEAN discr_var = TRUE, INTEGER N = 5)

DECLS

REAL array_var\[N\]

INIT

FOR (i IN 1,N)

array_var\[i\] = i

END FOR

DISCRETE

WHEN (TIME == TSTOP/2) THEN

FOR (i IN 1,N)

array_var\[i\] = array_var\[i\]\*2

END FOR

END WHEN

CONTINUOUS

IF(NOT discr_var) INSERT

EXPAND (i IN 1,N) array_var\[i\]\' = i\*sin(TIME)

ELSE

discr_array(array_var)

END IF

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                discr_array_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

Setting discr_var to TRUE, this gives the following result:

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\WORKSPACES\\STANDARD_2.6.1\\libs\\MY_THERMAL\\experiments\\comp_discr_arr.default\\exp1\\Tab_1#Plot_1_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image7.png){width="5.686567147856518in" height="2.7888495188101485in"}

If discr_var is set to FALSE, the result is the following:

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\WORKSPACES\\STANDARD_2.6.1\\libs\\MY_THERMAL\\experiments\\comp_discr_arr.default\\exp1\\Tab_1#Plot_1_3.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image8.png){width="5.582088801399825in" height="2.7376093613298336in"}

#### 2.3.2.5 Functions find/find_int

This function searches for an element in an array that matches a given value and returns its index. The tolerance can be varied; the default is $10^{- 8}$. If there are multiple matches, only the smallest index is returned. If there are no matches, a 0 is returned. Use find for real arrays, find_int for integer input arrays.

##### 2.3.2.5.1 Parameters

  ----------- ------------- ----------------- ---------------------- -----------
  NAME        TYPE          DEFAULT           DESCRIPTION            UNITS

  tol \*      IN REAL       1e-8              Tolerance (optional)   \-

  value       IN REAL\*\*                     Input value            \-

  x           IN REAL\*\*                     Input array            \-
  ----------- ------------- ----------------- ---------------------- -----------

\* The integer version has no tolerance and only considers exact matches.

\*\* IN INTEGER in the integer version.

##### 2.3.2.5.2 Internal variables

  ------------- ------------- --------------------------------- ------------
  NAME          TYPE          DESCRIPTION                       UNITS

  N             INTEGER       Number of elements in the array   \-
  ------------- ------------- --------------------------------- ------------

##### 2.3.2.5.3 Return value

The function returns the first index of the array x\[N\] that matches a given value with a tolerance. If there is no match, a 0 is returned.

##### 2.3.2.5.4 Example

The following example finds the first match of value in the array x, with a given tolerance tol, and prints the result.

COMPONENT find_ex

DATA

REAL x\[5\] = {3,2.5,1.92,-1,PI} \"Input array\"

REAL tol = 0.1 \"Tolerance\"

REAL value = 2 \"Value to count\"

DECLS

INTEGER idx

INIT

idx = find(value, x, tol)

PRINT(\"index = \$idx\")

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                find_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

With tol = 0.1, the printed message is:

index = 3

#### 2.3.2.6 Function GetRealArrayItem

This function extracts a specific item from a real array.

##### 2.3.2.6.1 Parameters

  ------------- ------------- ------------------- ------------
  NAME          TYPE          DESCRIPTION         UNITS

  input\[\]     IN REAL       Input value         \-

  i             IN INTEGER    Index of the item   \-
  ------------- ------------- ------------------- ------------

##### 2.3.2.6.2 Return value

The function returns the i-th element of the real array.

It is important to note that when the arrays you are passing as arguments have more than one dimension, they have to be treated as one-dimensional in the function. To do this, you have to calculate the equivalent one-dimensional index in the array. This real index is calculated knowing that the arrays are stored as follows (see \[1\], section 17.30):

V\[3,2\] is stored as:

index 1= v\[1,1\]

index 2= v\[1,2\]

index 3= v\[2,1\]

index 4= v\[2,2\]

index 5= v\[3,1\]

index 6= v\[3,2\]

##### 2.3.2.6.3 Example 1

The component defines an array of gains, a 1-based index sel, and an input u. In the CONTINUOUS block, it uses GetRealArrayItem(gains, sel) to fetch the selected gain and computes y = gain \* u.

COMPONENT GetRealArrayItem_ex

DATA

REAL gains\[3\] = {0.8, 1.0, 1.2} \"Available gains\"

INTEGER sel = 2 \"Selected index (1..3)\"

REAL u = 5.0 \"Input signal (constant for this demo)\"

DECLS

REAL y \"Output\"

REAL item

CONTINUOUS

item = GetRealArrayItem(gains, sel)

y = item \* u

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                GetRealArrayItem_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

With the given values (gains = {0.8, 1.0, 1.2}, sel = 2, u = 5.0), the result is y = 5.0.

In general, the results are the following:

  ---------------------------------------------------------
  Name           sel (1..3)     item          y
  -------------- -------------- ------------- -------------
  Alias          \--            \--           \--

  1              1              0.8           4

  2              2              1             5

  3              3              1.2           6
  ---------------------------------------------------------

##### 2.3.2.6.4 Example 2

This example is analogous to the previous one, but replacing the earnings array with a 2D one. However, the index remains 1D, so it varies between 1 and 6.

COMPONENT GetRealArrayItem_2D_ex

DATA

REAL gains\[2,3\] = {{0.8, 1.0, 1.2},{1.4, 1.6, 1.8}} \"Available gains\"

INTEGER sel = 2 \"Selected index (1..3)\"

REAL u = 5.0 \"Input signal (constant for this demo)\"

DECLS

REAL y \"Output\"

REAL item

CONTINUOUS

item = GetRealArrayItem(gains, sel)

y = item \* u

END COMPONENT

**Experiment configuration**

  ----------------------------------- -------------------------------------
  Name                                GetRealArrayItem_2D_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -------------------------------------

**Results**

In this case, the results are the following:

  ---------------------------------------------------------
  Name           sel (1..3)     item          y
  -------------- -------------- ------------- -------------
  Alias          \--            \--           \--

  1              1              0.8           4

  2              2              1             5

  3              3              1.2           6

  4              4              1.4           7

  5              5              1.6           8

  6              6              1.8           9
  ---------------------------------------------------------

#### 2.3.2.7 Function int

This function returns the integer part of a real number. It truncates the fractional part of the given real number. It\'s equivalent to the internal function floor.

*Note: to round it, use the roundN function (see §*[*2.3.2.14.*](#functions-reversereverse_int) *). To calculate the minimum integer above, use the internal function ceil.*

##### 2.3.2.7.1 Parameters

  ------------- ------------- ------------------- ------------
  NAME          TYPE          DESCRIPTION         UNITS

  x             IN REAL       First input value   \-
  ------------- ------------- ------------------- ------------

##### 2.3.2.7.2 Return value

Returns the real number cast to integer (implicitly truncates toward zero).

##### 2.3.2.7.3 Example

The following component calculates the integer part of a real value and prints it.

COMPONENT int_ex

DECLS

DISCR REAL x = 1.2 UNITS no_units \"Input value\"

INTEGER x_int UNITS no_units \"Integer part of the input\"

INIT

x_int = int(x)

PRINT(\"The integer part of \$x is \$x_int.\")

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                int_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

The integer part of 1.2 is 1.

The integer part of 3.14159265 is 3.

The integer part of 0.92 is 0.

#### 2.3.2.8 Function max

This function calculates the maximum of two real values (x and y).

##### 2.3.2.8.1 Parameters

  ------------- ------------- -------------------- ---------
  NAME          TYPE          DESCRIPTION          UNITS

  x             IN REAL       First input value    \-

  y             IN REAL       Second input value   \-
  ------------- ------------- -------------------- ---------

##### 2.3.2.8.2 Return value

The function returns the larger of the two real values:

- $x$ if $x \geq \ y$

- $y$ if $y > \ x$

##### 2.3.2.8.3 Example

In the following example, the max function is used to define the variable bounded_y, which is a non-negative function that behaves like a sine when its value is positive and is 0 otherwise.

COMPONENT max_ex \"Example component: uses max(x,y) to select the largest REAL of two values.\"

DATA

REAL lower_limit = 0.0 \-- Threshold

DECLS

REAL y \-- Saturated value

REAL bounded_y

CONTINUOUS

y = cos(TIME)

bounded_y = max(lower_limit, y)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                max_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The variable bounded_y constantly assumes the maximum value between y and the lower limit.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_max.default\\exp1\\Tab_1#Plot_1_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image9.png){width="5.343284120734908in" height="2.5009306649168854in"}

#### 2.3.2.9 Function max_impl

This function calculates the maximum of two real values, and simultaneously updates the second argument with the maximum value.

##### 2.3.2.9.1 Parameters

  ------------- ------------- ----------- --------------------- ------------
  NAME          TYPE          PURPOSE     DESCRIPTION           UNITS

  x             IN REAL       IN          Candidate value       \-

  z             OUT REAL      IN          Maximum accumulator   \-
  ------------- ------------- ----------- --------------------- ------------

##### 2.3.2.9.2 Return value

The function updates z with the maximum value between x and z.

##### 2.3.2.9.3 Example

In this example, current_max is both the OUT parameter and the assigned result, so each evaluation ensures current_max stores the maximum between the input u and its previous value---i.e., a simple running maximum.

COMPONENT max_impl_ex \"Example: uses max_impl(x, z) to keep a running maximum.\"

DECLS

REAL u

REAL current_max \-- Will hold the running maximum

INIT

current_max = 0 \-- Start from zero (change as needed)

CONTINUOUS

\-- max_impl returns max(u, current_max) and ALSO writes the result into \'current_max\'

u = sin(TIME)\*TIME\*\*2

max_impl(u, current_max)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                max_impl_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The variable current_max constantly assumes the running maximum of u.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\WORKSPACES\\STANDARD_2.6.1\\libs\\MY_THERMAL\\experiments\\comp_max_impl.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image10.png){width="5.298507217847769in" height="2.4799737532808397in"}

#### 2.3.2.10 Function min

This function calculates the minimum of two real values (x and y).

##### 2.3.2.10.1 Parameters

  ------------- ------------- -------------------- ------------
  NAME          TYPE          DESCRIPTION          UNITS

  x             IN REAL       First input value    \-

  y             IN REAL       Second input value   \-
  ------------- ------------- -------------------- ------------

##### 2.3.2.10.2 Return value

The function returns the larger of the two real values:

- $x$ if $x \leq \ y$

- $y$ if $y < \ x$

##### 2.3.2.10.3 Example

In the following example, the min function is used to define the variable bounded_y, which is a non-positive function that behaves like a sine when its value is negative and is 0 otherwise.

COMPONENT min_ex \"Example component: uses min(x,y) to select the smallest REAL of two values.\"

DATA

REAL upper_limit = 0.0 \-- Threshold

DECLS

REAL y \-- Saturated value

REAL bounded_y

CONTINUOUS

y = cos(TIME)

bounded_y = min(upper_limit, y)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                min_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The variable bounded_y constantly assumes the maximum between y and the upper limit.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\WORKSPACES\\STANDARD_2.6.1\\libs\\MY_THERMAL\\experiments\\comp_min.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image11.png){width="5.246268591426071in" height="2.455521653543307in"}

#### 2.3.2.11 Function min_impl

This function calculates the minimum of two real values, and simultaneously updates the second argument with the minimum value.

##### 2.3.2.11.1 Parameters

  ------------- ------------- --------------------- ------------
  NAME          TYPE          DESCRIPTION           UNITS

  x             IN REAL       Candidate value       \-

  z             OUT REAL      Minimum accumulator   \-
  ------------- ------------- --------------------- ------------

##### 2.3.2.11.2 Return value

The function updates z with the minimum value between x and z.

##### 2.3.2.11.3 Example

In this example, current_min is both the OUT parameter and the assigned result, so each evaluation ensures current_min stores the minimum between the input u and its previous value---i.e., a simple running minimum.

COMPONENT min_impl_ex \"Example: uses min_impl(x, z) to keep a running minimum.\"

DECLS

REAL u

REAL current_min \-- Will hold the running minimum

INIT

current_min = 0 \-- Start from zero (change as needed)

CONTINUOUS

\-- min_impl returns min(u, current_min) and ALSO writes the result into \'current_min\'

u = sin(TIME)\*TIME\*\*2

min_impl(u, current_min)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                min_impl_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The variable current_min constantly assumes the running minimum of u.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_min_impl.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image12.png){width="5.417911198600175in" height="2.5358595800524935in"}

#### 2.3.2.12 Function numDerivReal

This function estimates the numerical derivative of a variable and updates the stamp of the variable x_old with the current simulation time.

##### 2.3.2.12.1 Parameters

  --------------- ------------- --------------------------------- -------
  NAME            TYPE          DESCRIPTION                       UNITS

  timeNow         IN REAL       Current time                      s

  timePrev        OUT REAL      Previous time stamp               s

  x               IN REAL       Variable at current time stamp    \-

  xprimeNumeric   OUT REAL      Estimated time derivative         s^-1^

  x_old\[2\]      OUT REAL      Variable at previous time stamp   \-
  --------------- ------------- --------------------------------- -------

##### 2.3.2.12.2 Return value

The function returns the value TRUE.

The output parameter xprimeNumeric is estimated using the two values of x_old and current (timeNow) and previous (timePrev) time stamps.

The variables x_old and timePrev are updated after calling the function with the current time stamp, so they are IN/OUT variables.

##### 2.3.2.12.3 Example

The following example uses the function numDerivReal to calculate the derivative of the function:

$$x(t) = sin(\omega \cdot t)$$

and compares this estimation with its exact derivative:

$$x'(t) = \omega \cdot cos(\omega \cdot t)$$

COMPONENT numDerivReal_ex \"Example component using numDerivReal to estimate a numerical derivative\"

DATA

REAL omega = 1.0 UNITS u_rad_s \"Angular frequency of the input signal\"

DECLS

\-- Continuous signal and its derivatives

REAL x UNITS no_units \"Input signal x(TIME) = sin(omega \* TIME)\"

REAL xprime_exact UNITS u_1_s \"Analytical time derivative: omega \* cos(omega \* TIME)\"

REAL xprime_numeric UNITS u_1_s \"Numerical derivative estimated by numDerivReal\"

REAL error_rel UNITS no_units \"Difference xprime_numeric - xprime_exact\"

\-- Internal memory for numDerivReal (previous value and previous time)

DISCR REAL x_hist\[2\] UNITS no_units \"History of x used by numDerivReal (x_old\[1\], x_old\[2\])\"

DISCR REAL time_prev UNITS u_s \"Previous time stamp used by numDerivReal\"

INIT

\-- Initialize time_prev

time_prev = TIME

CONTINUOUS

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\-- Input signal and derivative

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

x = sin(omega \* TIME)

xprime_exact = omega \* cos(omega \* TIME)

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\-- Call numDerivReal to estimate the numerical derivative of x(TIME)

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

numDerivReal(x, xprime_numeric, TIME, x_hist, time_prev)

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\-- Error between numerical and analytical derivatives

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

error_rel = div_safe2((xprime_numeric - xprime_exact),xprime_exact)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                numDerivReal_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The graphs for xprime_exact and sprim_numeric are identical, except that xprime_exact is slightly ahead in time. There are small errors when xprime_exact becomes 0 and around TIME=0, due to incorrect initialization.

![C:\\Users\\LPU\\SIMULATIONS\\WORKSPACES\\STANDARD_2.6.1\\libs\\MATH_EXAMPLES\\experiments\\num+deriv+real_ex.default\\exp1\\Tab_1#Plot_1_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image13.png){width="6.495833333333334in" height="2.9776640419947507in"}

The time lag can be reduced by setting a shorter communication interval, for example **CINT = 0.01**:

![C:\\Users\\LPU\\SIMULATIONS\\WORKSPACES\\STANDARD_2.6.1\\libs\\MATH_EXAMPLES\\experiments\\num+deriv+real_ex.default\\exp1\\Tab_1#Plot_1_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image14.png){width="6.212121609798775in" height="2.862824803149606in"}

#### 2.3.2.13 Function remainder

This function computes the remainder of the division between two integers (dividend and divisor). The formula used is:

$$remainder = dividend - (quotient \times divisor)$$

*Note: to compute the remainder of the division between two reals, use the internal function rem.*

##### 2.3.2.13.1 Parameters

  ------------- ------------- ------------- ------------
  NAME          TYPE          DESCRIPTION   UNITS

  dividend      IN INTEGER    Dividend      \-

  divisor       IN INTEGER    Divisor       \-
  ------------- ------------- ------------- ------------

##### 2.3.2.13.2 Return value

The function returns an integer value, the remainder of the integer division between the variables dividend and divisor.

##### 2.3.2.13.3 Example

The following component calculates the remainder of an integer division and prints it.

COMPONENT remainder_ex

DATA

INTEGER dividend = 15 UNITS no_units \"Dividend\"

INTEGER divisor = 2 UNITS no_units \"Divisor\"

DECLS

INTEGER re UNITS no_units \"Remainder\"

INIT

re = remainder(dividend, divisor)

PRINT(\"\$dividend mod \$divisor = \$re\")

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                remainder_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

15 mod 2 = 1

127 mod 19 = 13

#### 2.3.2.14 Functions reverse/reverse_int

This function reverses the order of the elements in an array. If the array has N elements, the output array x_out is defined as:

x_out\[i\] = x\[N+1-i\] for i in 1,...,N

Use reverse for real arrays, reverse_int for integer arrays.

##### 2.3.2.14.1 Parameters

  --------------------------------------------------------------------------------
  NAME        TYPE          DEFAULT   DESCRIPTION                        UNITS
  ----------- ------------- --------- ---------------------------------- ---------
  x\[\]       IN REAL \*              Input array                        \-

  x_ord\[\]   OUT REAL \*             Ordered array                      \-
  --------------------------------------------------------------------------------

\* IN INTEGER in the integer version.

\*\* OUT INTEGER in the integer version.

##### 2.3.2.14.2 Return value

This function does not return any value and fills the array x_out with the elements of x in inverse order.

##### 2.3.2.14.3 Example

The following component reverses the order of the elements of an array and prints the results.

COMPONENT reverse_ex (INTEGER N = 5 \"Number of elements\")

DATA

REAL x\[5\] = {3,2.5,1.92,-1,PI}

DECLS

DISCR REAL x_sorted\[N\] UNITS no_units \"Sorted array\"

STRING result = \"x_sorted = (\"

INIT

sort(x,x_sorted,h_to_l)

FOR (i IN 1,N-1)

result += realToString(x_sorted\[i\]) + \", \"

END FOR

result += realToString(x_sorted\[N\]) + \")\"

PRINT(result)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                reverse_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

The results are:

x_rev = (3.14159265358979, -1, 1.92, 2.5, 3)

#### 2.3.2.15 Function roundN

This function rounds real values with a given number of decimals. By default, it rounds to the nearest integer. There is a maximum number length of 10 digits; working with longer numbers will cause misleading results.

*Note: to truncate its integer part, use the int function (see §*[*2.3.2.14.*](#functions-reversereverse_int) *). To calculate the minimum integer above or the maximum integer below, the internal functions ceil and floor can be used, respectively.*

##### 2.3.2.15.1 Parameters

  ------------- ------------- ----------- -------------------------------------------------------- ------------
  NAME          TYPE          DEFAULT     DESCRIPTION                                              UNITS

  idx           IN INTEGER    0           Number of decimals to round. Default: round to integer   \-

  num           IN REAL       \-          Input value                                              \-
  ------------- ------------- ----------- -------------------------------------------------------- ------------

##### 2.3.2.15.2 Return value

The function returns the rounded number as a real.

##### 2.3.2.15.3 Example

The following component rounds a real number with a given number of decimals and prints the result.

COMPONENT roundN_ex

DATA

REAL x = 1.2 UNITS no_units \"Input value\"

INTEGER n_dec = 2 UNITS no_units \"Number of decimals\"

DECLS

DISCR REAL x_r = 1.2 UNITS no_units \"Rounded number\"

INIT

x_r = roundN(x,n_dec)

PRINT(\"The number \$x rounded with \$n_dec decimals is \$x_r.\")

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                roundN_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

The number 2.71828183 rounded with 2 decimals is 2.72.

The number 84.7785847 rounded with 10 decimals is -0.214748365.

The number 84.7785847 rounded with 7 decimals is 84.7785847.

#### 2.3.2.16 Function sign

This function returns the sign of a real number.

##### 2.3.2.16.1 Parameters

  ------------- ------------- ------------- ------------
  NAME          TYPE          DESCRIPTION   UNITS

  x             IN REAL       Input value   \-
  ------------- ------------- ------------- ------------

##### 2.3.2.16.2 Return value

The function returns a real value:

- $1\ if\ x \geq \ 0$

- $- 1\ if\ x\  < \ 0$

##### 2.3.2.16.3 Example

In the following example, the sign of the following function is calculated:

$$input(t) = \sin(t) \cdot t^{2}$$

and then stored in the variable output.

COMPONENT sign_ex

DATA

REAL y_o = 0

DECLS

REAL input

REAL output

CONTINUOUS

input = sin(TIME)\*TIME\*\*2

output = sign(input)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                sign_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

Output takes on the values 1 and -1, depending on whether the input is positive or negative.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_sign.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image15.png){width="5.291044400699913in" height="2.482380796150481in"}

#### 2.3.2.17 Function sign2

This function returns the sign of a real number, but with a tolerance eps.

##### 2.3.2.17.1 Parameters

  ------------- ------------- ------------- ------------
  NAME          TYPE          DESCRIPTION   UNITS

  x             IN REAL       Input value   \-

  eps           IN REAL       Tolerance     \-
  ------------- ------------- ------------- ------------

##### 2.3.2.17.2 Return value

The function returns a real value:

- 1 if x \>= eps

- -1 if x \<= -eps

- x/eps if -eps \< x \< eps

##### 2.3.2.17.3 Example

In the following example, the sign of the following function is calculated:

$$input(t) = \sin(t) \cdot t^{2}$$

It\'s stored without tolerance in the variable output (this is the output of the previous example) and with a tolerance of 1 in the variable output2, using the sign2 function.

COMPONENT sign2_ex

DATA

REAL y_o = 0

REAL tol = 1

DECLS

REAL input

REAL output1

REAL output

CONTINUOUS

input = sin(TIME)\*TIME\*\*2

output = sign(input)

output2 = sign2(input,tol)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                sign2_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

In the following plot, both outputs can be compared.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_sign2.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image16.png){width="5.462121609798775in" height="2.6764905949256343in"}

#### 2.3.2.18 Function sign3

Similar to sign2, this function evaluates the sign of the ratio of x to y with a tolerance eps.

##### 2.3.2.18.1 Parameters

  ------------- ------------- -------------------- ------------
  NAME          TYPE          DESCRIPTION          UNITS

  x             IN REAL       First input value    \-

  y             IN REAL       Second input value   \-

  eps           IN REAL       Tolerance            \-
  ------------- ------------- -------------------- ------------

##### 2.3.2.18.2 Return value

The function returns a real value:

- 1 if x/y $\geq$ eps

- -1 if x $\leq$ -eps

- x/eps in other case

##### 2.3.2.18.3 Example

In this example, the operation of the sign3 function is shown using the following functions as arguments:

$$input(t) = \sin(t) \cdot \frac{t^{2}}{50}$$

$$den(t) = \sin(t) \cdot \frac{t^{2}}{50} - 1\ $$

Then, its output (output3) is compared with that of the sign (output) and sign2 (output2) functions.

COMPONENT sign3_ex

DATA

REAL y_o = 0

DECLS

REAL input

REAL den

REAL res

REAL output

REAL output2

REAL output3

CONTINUOUS

input = sin(TIME)\*TIME\*\*2/50

den = input+1

res = input/den

output = sign(input)

output2 = sign2(input,tol)

output3 = sign3(input,den,tol)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                sign3_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The results are included below:

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_sign3.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image17.png){width="5.04477580927384in" height="2.372735126859143in"}

#### 2.3.2.19 Functions sort/sort_int

This functions sort arrays from greater to lower or vice versa. Use sort for real arrays, sort_int for integer arrays.

##### 2.3.2.19.1 Parameters

  ----------- --------------- --------- ----------------------------------------------------------------------------------------------------- ---------
  NAME        TYPE            DEFAULT   DESCRIPTION                                                                                           UNITS

  h_to_l      IN BOOLEAN      TRUE      Boolean to decide whether to sort from highest to lowest or vice versa. Default: highest to lowest.   \-

  x\[\]       IN REAL \*                Input array                                                                                           \-

  x_ord\[\]   OUT REAL \*\*             Ordered array                                                                                         \-
  ----------- --------------- --------- ----------------------------------------------------------------------------------------------------- ---------

\* IN INTEGER in the integer version.

\*\* OUT INTEGER in the integer version.

##### 2.3.2.19.2 Return value

This function doesn\'t return any value and fills the x_ord array with the sorted values of x.

##### 2.3.2.19.3 Example

The following component sorts the values of an array from highest to lowest or vice versa and prints the results.

COMPONENT sort_ex (INTEGER N = 5 \"Number of elements\")

DATA

REAL x\[5\] = {3,2.5,1.92,-1,PI}

BOOLEAN h_to_l = FALSE

DECLS

DISCR REAL x_sorted\[N\] UNITS no_units \"Sorted array\"

STRING result = \"x_sorted = (\"

INIT

sort(x,x_sorted,h_to_l)

FOR (i IN 1,N-1)

result += realToString(x_sorted\[i\]) + \", \"

END FOR

result += realToString(x_sorted\[N\]) + \")\"

PRINT(result)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                sort_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

Setting h_to_l = TRUE, the results are:

x_sorted = (3.14159265358979, 3, 2.5, 1.92, -1)

Setting it to FALSE:

x_sorted = (-1, 1.92, 2.5, 3, 3.14159265358979)

#### 2.3.2.20 Function sum1D

This function calculates the sum of all elements in a 1D array.

##### 2.3.2.20.1 Parameters

  ------------- ------------- --------------------------------- ------------
  NAME          TYPE          DESCRIPTION                       UNITS

  A\[Nx\]       IN REAL       Array of elements                 \-

  Nx            IN INTEGER    Number of elements in the array   \-
  ------------- ------------- --------------------------------- ------------

##### 2.3.2.20.2 Return value

The function returns the sum of all elements in the array as a real number.

##### 2.3.2.20.3 Example

In the following component, the sum of the array_data array is calculated and stored in the sum_1 variable. The sum of the array_var variable array is also calculated and stored in sum_2.

COMPONENT sum1D_ex (INTEGER N = 4)

DATA

REAL array\[5\] = {1, 1.7, 8.2, 3, 4/2}

DECLS

REAL array_var\[N\]

REAL sum_1

REAL sum_2

CONTINUOUS

sum_1 = sum1D(5, array)

EXPAND (i IN 1,N) array_var\[i\] = sin(TIME+i)

sum_2 = sum1D(N, array_var)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                sum1D_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The variable sum_1 is always equal to 15.9. The evolution of sum_2 is shown below.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_sum1+d.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image18.png){width="4.828358486439195in" height="2.270945975503062in"}

#### 2.3.2.21 Function sum2D

This function calculates the sum of all elements in a 2D array (matrix).

##### 2.3.2.21.1 Parameters

  ------------- ------------- --------------------------------- ------------
  NAME          TYPE          DESCRIPTION                       UNITS

  A\[Nx,Ny\]    IN REAL       Matrix of elements                \-

  Nx            IN INTEGER    Number of rows in the matrix      \-

  Ny            IN INTEGER    Number of columns in the matrix   \-
  ------------- ------------- --------------------------------- ------------

##### 2.3.2.21.2 Return value

The function returns the sum of all elements in the matrix as a real number.

##### 2.3.2.21.3 Example

In the following component, the sum of the array_data array is calculated and stored in the sum_1 variable. The sum of the array_var variable array is also calculated and stored in sum_2.

COMPONENT sum2D_ex (INTEGER Nx = 3, INTEGER Ny = 2)

DATA

REAL array\[2,5\] = {{1, 1.7, 8.2, 3, 4/2},{3\*0.5,6,1.1,4.3,2}}

DECLS

REAL array_var\[Nx,Ny\]

REAL sum_1

REAL sum_2

CONTINUOUS

sum_1 = sum2D(2,5, array)

EXPAND (i IN 1,Nx) EXPAND (j IN 1,Ny) array_var\[i,j\] = j\*sin(TIME+i)

sum_2 = sum2D(Nx, Ny, array_var)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                sum2D_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The variable sum_1 is always equal to 30.8. The evolution of sum_2 is shown below.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_sum2+d.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image19.png){width="4.746268591426071in" height="2.2323359580052493in"}

### 2.3.3 Quadratic and Cubic Equations

#### 2.3.3.1 Function ecua2

This function solves quadratic equations of the form:

$$a_{1} \cdot x^{2} + a_{2} \cdot x + a_{3} = 0$$

It only calculates the real solutions.

##### 2.3.3.1.1 Parameters

  --------- ----------- ------------------------------------------- ------------
  NAME      TYPE        DESCRIPTION                                 UNITS

  a1        IN REAL     Coefficient of x^2^ (quadratic term)        \-

  a2        IN REAL     Coefficient of x (linear term)              \-

  a3        IN REAL     Coefficient of x^0^ (constant term)         \-

  r1        OUT REAL    First solution of the quadratic equation    \-

  r2        OUT REAL    Second solution of the quadratic equation   \-
  --------- ----------- ------------------------------------------- ------------

##### 2.3.3.1.2 Formulation

- Linear case ($a_{1}$ close to 0)

If the coefficient $a_{1}$ is small (absolute value less than the tolerance tol, see §[2.1.1.](#mathematical-and-scientific-constants) ), the equation is treated as a linear equation:

$a_{2} \cdot x + a_{3} =$`<!-- -->`{=html}0

and the solution is $r_{1} = - \frac{a_{3}}{a_{2}}$

- Quadratic case (when a~1~ is large):

The discriminant (det) is calculated as:

$$det = a_{2}^{2} - 4 \cdot a_{1} \cdot a_{3}$$

- If det \> 0, it indicates two distinct real solutions. The function calculates both solutions:

- $r_{1}$ is the root with the greatest absolute value (based on the sign of $a_{2}$).

$$r_{1} = \frac{- a_{2} - \sqrt{\det}}{2a_{1}}$$

- $r_{2}$ is the root with the smallest absolute value.

$$r_{2} = \frac{a_{3}/a_{1}}{r_{1}}$$

- If det = 0, it indicates one real solution. The function calculates it as:

$$r_{1} = - \frac{a_{2}}{2a_{1}}$$

##### 2.3.3.1.3 Return values

The two roots $r_{1}$ and $r_{2}$ are returned as the solutions. If there are no solutions, the function returns $r_{1} = r_{2} = 10^{40}$. If there is only one solution, $r_{1}$, then it returns $r_{2} =$ $10^{40}$.

##### 2.3.3.1.4 Example

The following component uses the ecua2 function to calculate the roots of the equation:

$$a_{1}x^{2} + a_{2}x + a_{3} = 0$$

characterized to the case $a_{1} = 1,\ a_{2} = - 5,a_{3} = 6$.

COMPONENT ecua2_ex

\"Example: direct call to ecua2(a1,a2,a3,r1,r2) and real-root check\"

DATA

REAL a1 = 1. UNITS no_units \"x\^2 coefficient\"

REAL a2 = -5. UNITS no_units \"x coefficient\"

REAL a3 = 6. UNITS no_units \"Independent term\"

DECLS

REAL r1 UNITS no_units \"Root 1\"

REAL r2 UNITS no_units \"Root 2\"

INIT

ecua2(a1, a2, a3, r1, r2)

IF (r1 == 1e40) THEN

PRINT(\"ecua2: no real roots (r1=1e40)\")

ELSEIF (r2 == 1e40) THEN

PRINT(\"ecua2: one real root: r1=\$r1 (r2=1e40)\")

ELSE

PRINT(\"ecua2: two real roots: r1=\$r1, r2=\$r2\")

END IF

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                ecua2_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

This gives the following result:

ecua2: two real roots: r1=3, r2=2

#### 2.3.3.2 Function ecua3

This function solves cubic equations of the form:

$${a_{1} \cdot x}^{3} + a_{2} \cdot x^{2} + a_{3} \cdot x + a_{4}\  = 0$$

It only calculates the real solutions.

##### 2.3.3.2.1 Parameters

  --------- ------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ ------------
  NAME      TYPE               DESCRIPTION                                                                                                                                                                                                                                      UNITS

  a\[4\]    IN REAL            Array containing the coefficients$\ \lbrack a_{1},\ a_{2},\ a_{3},\ a_{4}\rbrack\$where $a_{1}$ is the coefficient of $x^{3}$, $a_{2}$ is the coefficient of $x^{2}$, $a_{3}$ is the coefficient of $x^{1}$, and $a_{4}$ is the constant term.   \-

  r1        OUT REAL           First solution of the quadratic equation                                                                                                                                                                                                         \-

  r2        OUT REAL           Second solution of the quadratic equation                                                                                                                                                                                                        \-

  r3        OUT REAL           Third solution of the quadratic equation                                                                                                                                                                                                         \-
  --------- ------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ ------------

##### 2.3.3.2.2 Internal variables

The coefficients are normalized by dividing $a_{2}$, $a_{3}$, and $a_{4}$ by $a_{1}$ (making $a_{1}$ = 1). This way the equation becomes:

$$x^{3} + b_{2}*x^{2} + b_{3}*x + b_{4} = 0$$

where:

$b_{2} = \frac{a_{2}}{a_{1}}$

$b_{3}\  = \frac{a_{3}}{a_{1}}$

$$b_{4} = \frac{a_{4}}{a_{1}}$$

Based on the normalized coefficients, auxiliary variables can be calculated as indicated below.

$$Q = \frac{b_{2}^{2} - 3b_{3}}{9}$$

$$R = \frac{2b_{2}^{3} - 9b_{2}b_{3} + 27b_{4}}{54}$$

$$aux\  = \ \left( \sqrt{R^{2} - Q^{3}} + |R| \right)^{\frac{1}{3}}$$

##### 2.3.3.2.3 Formulation

- **Linear case**

If $a_{1}$ and $a_{2}$ are near zero, the equation reduces to the linear equation $a_{3}\ x\  + \ a_{4}\  = \ 0$, and the solution is:

$$r_{1} = \  - \frac{a_{4}}{a_{3}}$$

- **Quadratic case**

If $a_{1}$ is near but $a_{2}$ isn\'t, the equation reduces to the quadratic equation $a_{2}x^{2} + a_{3}\ x\  + \ a_{4}\  = \ 0$ and the function calls the ecua2 (see §[2.3.3.1.](#function-ecua2) ) function to solve it.

- **Cubic case**

If $a_{1}$ and $a_{2}$ have an absolute value greater than 0, then the equation has up to three solutions.

- If Q^3^ \> R^2^, then there are **three real roots,** which are calculated using trigonometric identities, specifically the inverse cosine function, $\theta = \cos^{- 1}\left( R/\sqrt{Q^{3}} \right)$. The roots are computed as:

$r_{1}\  = \  - 2\sqrt{Q}\cos\left( \frac{\theta}{3} \right) - \frac{a_{2}}{3}$

$$r_{2}\  = \  - 2\sqrt{Q}\cos{(\left( \theta + 2\pi)/3 \right)} - \frac{a_{2}}{3}$$

$$r_{3}\  = \  - 2\sqrt{Q}\cos{(\left( \theta + 4\pi)/3 \right)} - \frac{a_{2}}{3}$$

- If Q^3^ $\leq$ R^2^, the equation has **one or two real roots**.

- **Calculation of r**~1~**.** The first root is calculated using:

$r_{1} = - \left( aux + \frac{Q}{aux} \right) - \frac{a_{2}}{3}$ if $R \geq 0$

$r_{1} = \left( aux + \frac{Q}{aux} \right) - \frac{a_{2}}{3}$ if $R < 0$

- **Calculation of r**~2~**.** The second root exists if and only if $\left| a_{3} + 2a_{2} \cdot r_{1} + 3 \cdot r_{1}^{2} \right| > 0$. In this case, it\'s calculated as:

$$r_{2} = \  - \frac{a_{2} + r_{1}}{2}$$

##### 2.3.3.2.4 Return values

The function returns $r_{1}$, $r_{2}$ and $r_{3}$ containing the solutions or, failing that, the value $10^{40}$.

##### 2.3.3.2.5 Example

The following component uses the ecua2 function to calculate the roots of the equation:

$$a_{1}x^{3} + a_{2}x^{2} + a_{3}x + a_{4} = 0$$

characterized to the case $a_{1} = 1,\ a_{2} = - 5,a_{3} = 6$.

COMPONENT ecua3_ex

\"Example: direct call to ecua3(a\[4\],r1,r2,r3) and real-root reporting\"

DATA

REAL a\[4\] = {1., -6., 11., -6.} UNITS no_units \"Coefficients: a1\*x\^3 + a2\*x\^2 + a3\*x + a4 = 0\"

DECLS

DISCR REAL r1 UNITS no_units

DISCR REAL r2 UNITS no_units

DISCR REAL r3 UNITS no_units

INIT

ecua3(a, r1, r2, r3)

IF (r1 == 1e40) THEN

PRINT(\"ecua3: no real roots detected (r1=1e40)\")

ELSEIF (r2 == 1e40) THEN

PRINT(\"ecua3: one real root: r1=\$r1 (r2=1e40)\")

ELSEIF (r3 == 1e40) THEN

PRINT(\"ecua3: two real roots: r1=\$r1, r2=\$r2 (r3=1e40)\")

ELSE

PRINT(\"ecua3: three real roots: r1=\$r1, r2=\$r2, r3=\$r3\")

END IF

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                ecua3_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

This provides the following output:

ecua3: two real roots: r1=0, r2=1 (r3=1e40)

### 2.3.4 Equations

This section explains the functions described in the document MATH_f_Equations.el, which include a set of functions and components for solving non-linear systems of equations and performing transfer function calculations using Fast Fourier Transform (FFT). The code includes several functions and a simulation experiment, as well as configuration and settings to control the solver and error handling.

#### 2.3.4.1 Function EcoMachDep

The Ecomachdep function is used to determine machine precision. This is especially useful in mathematical computations or numerical solvers where precision control is critical for performance or stability.

Machine precision (or machine epsilon) refers to the smallest number that can be added to 1.0 to get a result different from 1.0 due to floating-point limitations. This function ensures that this value is computed consistently across different platforms and compilers.

Ecomachdep can be invoked within the body of functions to ensure precision-related constants are initialized appropriately.

It\'s an external function coded in FORTRAN.

##### 2.3.4.1.1 Example

Calling ecomachdep inside a function (see \[2\], section 3.6.3.2)

FUNCTION REAL fun_temperature_N2(REAL H UNITS \"kJ/kg\" \"Specific enthalpy\")

DECLS

REAL T UNITS \"K\" \"Temperature\"

CONST INTEGER n = 1 \"Size of the non-linear system\"

CONST INTEGER ldum = 20 + (n\*\*2+13\*n)/2 \"Length of the work array\"

REAL xx\[n\] \"Values of the iteration variables\"

REAL fvec\[n\] \"Residue functions\" REAL dum\[ldum\] \"Work array\"

REAL fjac\[n\*n\] \"Jacobian\" REAL tol \"Tolerance of the calculation\"

INTEGER idum\[20\] \"Work array\"

INTEGER info \"Information message of the calculation\"

INTEGER ilast \"Status of the calculation\"

INTEGER iopt \"Option for specifying how the Jacobian is calculated\"

STRING str_error\[4\] = {\"Convergence reached\",

\"Number of calls to FCN has reached or exceeded the maximum value\",

\"TOL is too small. No further improvement in the calculation is possible\",

\"Iteration is not making good progress.\"}

\"Information and error messages\"

BODY

\--Initialization of the calculation options and iteration variables

iopt = 2 \--The Jacobian calculated by forward-differencing

ilast = -1 \--Indicate the start of the calculation

tol = 1e-12 \--Tolerance xx\[1\] = 298.15 \--Initialisation of iteration variable

EcoMachDep() \--Function to calculate the machine precision

\--Iteration calculation

WHILE (ilast != 0)

EcoNonLinearEqnSolver(ilast,iopt,n,xx,fvec,fjac,tol,info,dum,ldum,idum,0)

T = xx\[1\]

fvec\[1\] = H - fun_enthalpy_N2(T) \--closing equation

END WHILE

\--Checking whether the convergence has been sucessfull

IF(info \> 1 AND info \< 5) THEN

ASSERT(FALSE) ERROR str_error\[info\]

ELSEIF(info == 0) THEN

ASSERT(FALSE) ERROR \"Improper input parameters (wrong initialization)\"

END IF

\--Return the calculated value

RETURN T

END FUNCTION

#### 2.3.4.2 Function EcoNonLinearEqnSolver

The library MATH includes an external FORTRAN subroutines for the resolution of systems of non-linear equations within EL functions called EcoNonLinearEqnSolver

The purpose of EcoNonLinearEqnSolver is to find a zero of a system of N nonlinear functions in N variables X by a modification of the Powell hybrid method: FVEC (X) = 0

The user is required to provide initial values of the variables and code for evaluating FVEC or/and the Jacobian FJAC. The user may either provide FJAC or let the code calculate it by a forward-difference approximation. Scaling the problem is not necessary, but it may help convergence.

This function is usually called inside another function.

This section includes an example, although more can be found in \[4\], section 5.3.

##### 2.3.4.2.1 Parameters

+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| ARGUMENT  | Description                                                                                                                                                                                                                   |
+===========+===============================================================================================================================================================================================================================+
| **ILAST** | It is an integer variable that must be set by the user to a non-positive value initially, in order to indicate the start of the calculation. The value of this parameter on each return indicates the reasons for the return: |
|           |                                                                                                                                                                                                                               |
|           | 0: Solver terminated                                                                                                                                                                                                          |
|           |                                                                                                                                                                                                                               |
|           | 1: Calculate FVEC at starting point                                                                                                                                                                                           |
|           |                                                                                                                                                                                                                               |
|           | 2: Calculate FVEC and FJAC (only if IOPT=1)                                                                                                                                                                                   |
|           |                                                                                                                                                                                                                               |
|           | 3: Calculate FVEC to compute Jacobian approximation                                                                                                                                                                           |
|           |                                                                                                                                                                                                                               |
|           | 4: Calculate FVEC to compute next step)                                                                                                                                                                                       |
+-----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| ARGUMENT      | Description                                                                                                                                                                                                                                                                                                                                                                                         |
+===============+=====================================================================================================================================================================================================================================================================================================================================================================================================+
| **IOPT**      | It specifies how the Jacobian will be calculated.                                                                                                                                                                                                                                                                                                                                                   |
|               |                                                                                                                                                                                                                                                                                                                                                                                                     |
|               | 1: the user must supply the Jacobian.                                                                                                                                                                                                                                                                                                                                                               |
|               |                                                                                                                                                                                                                                                                                                                                                                                                     |
|               | 2: the code will approximate the Jacobian by forward-differencing.                                                                                                                                                                                                                                                                                                                                  |
|               |                                                                                                                                                                                                                                                                                                                                                                                                     |
|               | 3: same as IOPT=2, but for the first call (INVREF\<=0) the user must supply the Jacobian.                                                                                                                                                                                                                                                                                                           |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **N**         | Number of functions and variables                                                                                                                                                                                                                                                                                                                                                                   |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **X\[ \]**    | X contains the values for which FVEC has to be computed in the next iteration step or the final solution                                                                                                                                                                                                                                                                                            |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **FVEC\[ \]** | It has to contain the functions evaluated at X                                                                                                                                                                                                                                                                                                                                                      |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **FJAC\[ \]** | It has to contain the Jacobian. The Jacobian has to be provided only if IOPT=1. If IOPT=2 or 3, FJAC is used as a work array. It contains the approximation of the Jacobian                                                                                                                                                                                                                         |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **tol**       | It is the tolerance of the calculation. Termination occurs when the algorithm estimates that the relative error between X and the solution is at most TOL. If TOL=0.e0 is given, a tolerance of sqrt(machine precision) is assumed                                                                                                                                                                  |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **INFO**      | If ILAST \> 0, the iteration continues: INFO = 0 (Internal step), INFO = 10 (Internal step completed)                                                                                                                                                                                                                                                                                               |
|               |                                                                                                                                                                                                                                                                                                                                                                                                     |
|               | If ILAST = 0, the iteration is terminated and INFO gives the termination status:                                                                                                                                                                                                                                                                                                                    |
|               |                                                                                                                                                                                                                                                                                                                                                                                                     |
|               | - INFO = 0 Improper input parameters (wrong initialization)                                                                                                                                                                                                                                                                                                                                         |
|               |                                                                                                                                                                                                                                                                                                                                                                                                     |
|               | - INFO = 1 Algorithm estimates that the relative error between X and the solution is at most TOL (regular end).                                                                                                                                                                                                                                                                                     |
|               |                                                                                                                                                                                                                                                                                                                                                                                                     |
|               | - INFO = 2 Number of calls to FCN has reached or exceeded 100\*(N+1) for IOPT=1 or 200\*(N+1) for IOPT=2.                                                                                                                                                                                                                                                                                           |
|               |                                                                                                                                                                                                                                                                                                                                                                                                     |
|               | - INFO = 3 TOL is too small. No further improvement in the approximate solution X is possible.                                                                                                                                                                                                                                                                                                      |
|               |                                                                                                                                                                                                                                                                                                                                                                                                     |
|               | - INFO = 4 Iteration is not making good progress.                                                                                                                                                                                                                                                                                                                                                   |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **DUM\[ \]**  | Work array of length LDUM = 20 + (N\*\*2+13\*N)/2                                                                                                                                                                                                                                                                                                                                                   |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **LDUM**      | Provided length of the work array DUM. LDUM must not be less than 20 + (N\*\*2+13\*N)/2                                                                                                                                                                                                                                                                                                             |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **IDUM\[ \]** | Work array of length 20                                                                                                                                                                                                                                                                                                                                                                             |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **EPSFCN**    | Used in determining a suitable step for the forward-difference approximation. This approximation assumes that the relative errors in the functions are of the order of EPSFCN If EPSFCN is less than the machine precision, it is assumed that the relative errors in the functions are of the order of the machine precision. If IOPT=1, then EPSFCN can be ignored (treat it as a dummy argument) |
+---------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

##### 2.3.4.2.2 Formulation

This function employs the Powell hybrid method, a well-known approach for solving nonlinear systems. It uses reverse communication to allow the solver to return control to the user for computing function values and optionally the Jacobian matrix. This iterative approach continues until a solution is found or until termination criteria are met.

The typical structure that must be follow to use the function EcoNonLinearEqnSolver is the following:

\--Defining the input arguments of the subroutine EcoNonLinearEqnSolver

k = 0

iopt = 2

ilast = -1

tol = 1e-12

\--Initialisation of the solution

xx\[1\] = x_ini

\--Iteration loop

WHILE(ilast != 0)

k = k + 1 \--Number of iterations

EcoNonLinearEqnSolver(ilast,iopt,n,xx,fvec,fjac,tol,info,dum,ldum,idum,1e-9)

sol = max(1e-20, xx\[1\]) \--Asignation of the solution

\--Intermedtiate Steps for the calculation of the closing equation (residue

\--function fvec)

equation1

\...

equation3

fvec\[1\] = equation1 -- equation3 \-- closing equation

END WHILE

\--Calculation of other variables from the solution

\--Checking of the info value

IF(info != 1 AND info != 3) THEN

ier = 1

ELSE

ier = 0

END IF

##### 2.3.4.2.3 Example

Below is a complete EL component example showing how to use EcoNonLinearEqnSolver with reverse communication to solve a simple 2x2 nonlinear system:

$$\left\{ \begin{array}{r}
f_{1}(x,y): = x^{2} + y^{2} - 1 = 0 \\
f_{2}(x,y): = x - y = 0
\end{array} \right.\ $$

It converges to $x = y = \pm 1/\sqrt{2}$ depending on the initial guess.

COMPONENT EcoNonLinearEqnSolver_2eq_ex (INTEGER N = 2 \"Number of equations/unknowns\", INTEGER LDUM = 50 \"Work array length (must be \>= 20 + (N\^2+13N)/2; for N=2 -\> \>= 35)\")

\"Example: Solve a 2x2 nonlinear system with EcoNonLinearEqnSolver using reverse communication\"

DATA

INTEGER IOPT = 2 \"2 = solver approximates Jacobian by finite differences (no user Jacobian)\"

REAL tol = 1e-10 \"Convergence tolerance\"

REAL EPSFCN = 1e-8 \"Step control for finite-difference Jacobian\"

DECLS

INTEGER ILAST \"Reverse communication flag\"

INTEGER INFO \"Termination / internal status\"

DISCR REAL X\[N\] \"Unknowns vector: X\[1\]=x, X\[2\]=y\"

DISCR REAL FVEC\[N\] \"Functions vector\"

DISCR REAL FJAC\[N,N\] \"Jacobian (only required when IOPT=1; otherwise used as work array)\"

DISCR REAL DUM\[LDUM\] \"Real work array\"

INTEGER IDUM\[20\] \"Integer work array (length 20)\"

INTEGER iter \"Safety counter\"

INIT

\-- Initial guess (choose near +1/sqrt(2) to converge to the positive solution)

X\[1\] = 0.7

X\[2\] = 0.7

\-- Initialize work arrays (recommended)

FOR (i IN 1, LDUM)

DUM\[i\] = 0.

END FOR

FOR (i IN 1, 20)

IDUM\[i\] = 0

END FOR

\-- Start reverse-communication process (must be \<= 0 initially)

ILAST = -1

INFO = 0

iter = 0

\-- First call: solver returns requesting FVEC/FJAC evaluations (ILAST \> 0)

EcoNonLinearEqnSolver(ILAST, IOPT, N, X, FVEC, FJAC, tol, INFO, DUM, LDUM, IDUM, EPSFCN)

WHILE (ILAST \> 0)

PRINT(\"EcoNonLinearEqnSolver in progress. steps = \$iter, ILAST = \$ILAST, INFO = \$INFO\")

\-- Compute FVEC at the current X requested by the solver

\-- f1(x,y) = x\^2 + y\^2 - 1

FVEC\[1\] = X\[1\]\*X\[1\] + X\[2\]\*X\[2\] - 1.

\-- f2(x,y) = x - y

FVEC\[2\] = X\[1\] - X\[2\]

\-- If you use IOPT=1, the solver may return ILAST=2 and requires Jacobian FJAC:

IF (ILAST == 2 AND IOPT == 1) THEN

\-- J = \[ df1/dx df1/dy \]

\-- \[ df2/dx df2/dy \]

FJAC\[1,1\] = 2.\*X\[1\]

FJAC\[1,2\] = 2.\*X\[2\]

FJAC\[2,1\] = 1.

FJAC\[2,2\] = -1.

END IF

\-- Recall the solver with ILAST unchanged (reverse communication)

EcoNonLinearEqnSolver(ILAST, IOPT, N, X, FVEC, FJAC, tol, INFO, DUM, LDUM, IDUM, EPSFCN)

iter = iter + 1

IF (iter \> 2000) THEN

STOP \"EcoNonLinearEqnSolver: too many reverse-communication steps\"

END IF

END WHILE

\-- Here ILAST == 0 =\> solver terminated. INFO contains the termination status.

PRINT(\"EcoNonLinearEqnSolver finished. INFO = \$INFO, x = \$X\[1\], y = \$X\[2\], steps = \$iter, INFO = \$INFO\")

END COMPONENT

**Experiment configuration**

  ----------------------------------- ----------------------------------------
  Name                                EcoNonLinearEqnSolver_2eq_ex.par1.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- ----------------------------------------

**Results**

The output is the following:

EcoNonLinearEqnSolver in progress. steps = 0, ILAST = 1, INFO = 0

EcoNonLinearEqnSolver in progress. steps = 1, ILAST = 3, INFO = 10

EcoNonLinearEqnSolver in progress. steps = 2, ILAST = 3, INFO = 10

EcoNonLinearEqnSolver in progress. steps = 3, ILAST = 4, INFO = 10

EcoNonLinearEqnSolver in progress. steps = 4, ILAST = 4, INFO = 10

EcoNonLinearEqnSolver in progress. steps = 5, ILAST = 4, INFO = 10

EcoNonLinearEqnSolver in progress. steps = 6, ILAST = 4, INFO = 10

EcoNonLinearEqnSolver in progress. steps = 7, ILAST = 4, INFO = 10

EcoNonLinearEqnSolver finished. INFO = 1, x = 0.707106781, y = 0.707106781, steps = 8, INFO = 1

It has converged in 8 iterations to the positive solution, with an error smaller than the tolerance.

#### 2.3.4.3 Function solveNonLinearSystem

This is a wrapper of the FORTRAN function EcoNonLinearEqnSolver (see §[2.3.4.2.](#function-econonlineareqnsolver) ) to protect outputs when NaN or Inf values are detected.

The purpose of this function is to find a zero of a system of N nonlinear functions in N variables X by a modification of the Powell hybrid method. The user is required to provide initial values of the variables and code for evaluating FVEC. Termination occurs when the algorithm estimates that the relative error between X and the solution is at most tol.

##### 2.3.4.3.1 Parameters

The parameters are the same as in EcoNonLinearEqnSolver.

##### 2.3.4.3.2 Example

Below is a complete EL component example showing how to use solveNonLinearSystem with reverse communication to solve a simple 2x2 nonlinear system:

$$\left\{ \begin{array}{r}
f_{1}(x,y): = x^{2} + y^{2} - 37 = 0 \\
f_{2}(x,y): = x - y^{2} - 5 = 0
\end{array} \right.\ $$

It converges to $x = 6,\ y = 1$.

COMPONENT solveNonLinearSystem_ex (

INTEGER n = 2, \"Number of nonlinear equations and unknowns\"

INTEGER ldum = 35 \"Length of the real work array required by the solver\"

) \"Example component that solves a nonlinear system using solveNonLinearSystem\"

DECLS

DISCR REAL x1 \"First solution variable\"

DISCR REAL x2 \"Second solution variable\"

INTEGER solver_info \"Solver termination status\"

INTEGER ilast \"Reverse communication status flag\"

INTEGER info \"Internal solver status code\"

INTEGER iopt \"Jacobian evaluation option\"

INTEGER idum\[20\] \"Integer work array\"

DISCR REAL tol \"Relative convergence tolerance\"

DISCR REAL epsfcn \"Finite-difference step control parameter\"

DISCR REAL x\[n\] \"Current estimate of the solution vector\"

DISCR REAL fvec\[n\] \"Residual vector evaluated at the current solution\"

DISCR REAL fjac\[n,n\] \"Jacobian matrix or real workspace depending on iopt\"

DISCR REAL dum\[ldum\] \"Real work array used by the solver\"

BOOLEAN ok \"TRUE if the solver step completed without NaN/Inf detection\"

INIT

\-- Solver configuration

ilast = -1

info = 0

iopt = 2

tol = 1.e-8

epsfcn = 1.e-8

ok = TRUE

\-- Initialize integer work array

FOR(i IN 1,20)

idum\[i\] = 0

END FOR

\-- Initialize real work arrays

FOR(i IN 1,n)

fvec\[i\] = 0.

x\[i\] = 0.

FOR(j IN 1,n)

fjac\[i,j\] = 0.

END FOR

END FOR

FOR(i IN 1,ldum)

dum\[i\] = 0.

END FOR

\-- Initial guess

x\[1\] = 5.

x\[2\] = 1.

\-- Reverse communication loop

WHILE (ilast != 0 AND ok == TRUE)

ok = solveNonLinearSystem(ilast, iopt, n, x, fvec, fjac, tol, info, dum, ldum, idum, epsfcn)

IF (ok == FALSE) THEN

WRITE(\"NaN/Inf detected during nonlinear solve\\n\")

BREAK

END IF

IF (ilast == 1 OR ilast == 3 OR ilast == 4) THEN

\-- Evaluate the residual vector at the current point

fvec\[1\] = x\[1\]\*\*2 + x\[2\] - 37.

fvec\[2\] = x\[1\] - x\[2\]\*\*2 - 5.

ELSEIF (ilast == 2) THEN

\-- Evaluate residuals

fvec\[1\] = x\[1\]\*\*2 + x\[2\] - 37.

fvec\[2\] = x\[1\] - x\[2\]\*\*2 - 5.

\-- Evaluate the Jacobian if requested

fjac\[1,1\] = 2. \* x\[1\]

fjac\[1,2\] = 1.

fjac\[2,1\] = 1.

fjac\[2,2\] = -2. \* x\[2\]

END IF

END WHILE

\-- Store results

x1 = x\[1\]

x2 = x\[2\]

solver_info = info

IF (ok == TRUE AND info == 1) THEN

WRITE(\"Successful convergence\\n\")

WRITE(\"x1 = %g\\n\", x1)

WRITE(\"x2 = %g\\n\", x2)

ELSE

WRITE(\"Solver finished with info = %d\\n\", solver_info)

WRITE(\"Last value: x1 = %g, x2 = %g\\n\", x1, x2)

END IF

END COMPONENT

**Experiment configuration**

  ----------------------------------- --------------------------------------
  Name                                solveNonLinearSystem_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- --------------------------------------

**Results**

The output is the following:

Successful convergence

x1 = 6

x2 = 1

#### 2.3.4.4 Function treatfft

This function calculates the transfer function using the Fast Fourier Transform (FFT). It\'s used to analyse and process data in the frequency domain. It\'s an external function coded in FORTRAN.

##### 2.3.4.4.1 Parameters

  ------------- ------------- -------------------------------------------------------------- ---------------
  NAME          TYPE          DESCRIPTION                                                    UNITS

  fr1           IN REAL       Minimum frequency of interest                                  Hz

  fr2           IN REAL       Maximum frequency of interest                                  Hz

  iff           IN INTEGER    Type of spectral processing required (possible values below)   \-

  np            IN INTEGER    Number of time samples in px, py                               \-

  px\[\]        IN REAL       Time history of x(t), evenly spaced in time                    Hz

  py\[\]        IN REAL       Time history of y(t), evenly spaced in time                    \-

  time          IN REAL       Total time window of the data                                  s

  OUT INTEGER   lnp           Number of valid frequency points returned                      \-

  OUT REAL      xfft\[\]      Frequency vector (Hz)                                          Hz

  OUT REAL      yfft\[\]      Result spectrum / transfer function                            \-
  ------------- ------------- -------------------------------------------------------------- ---------------

The possible values of iff are the following:

- 1: Fourier transform in amplitude.

- 2: Fourier transform in phase.

- 3: Fourier transform in spectral density.

- 4: Transfer function in amplitude.

- 5: Transfer function in phase.

This function is designed to compute the transfer function from time-domain data using the FFT. It performs the transformation in various formats (amplitude, phase, spectral density, etc.) based on the value of iff.

##### 2.3.4.4.2 Example

To ilustrate the use of treatfft, the testfft component has been created, which serves as the basis for the experiment that calls treatfft to obtain transfer functions between signals. This component defines a simple model for a mechanical system with a spring and viscous damping. The displacement z is governed by a second-order differential equation:

$$m\ z^{''} = K_{spr}\ z - c\ z' + Fx$$

COMPONENT testFFT

DATA

REAL f = 10 \"Excitation frequency (Hz)\"

REAL phase = 10 \"Phase (deg) of input signal\"

REAL m = 1 \"Mass (kg)\"

REAL K_spr = 1 \"Spring constant (N/m)\"

REAL cv = 1.0 \"Viscous friction coefficient (N/(m\*s))\"

REAL for = 1 \"Force gain factor\"

DECLS

REAL x \"Auxiliary input (used in experiment)\"

REAL y \"Excitation signal\"

REAL z \"Displacement of the mass\"

CONTINUOUS

\-- Harmonic input signal (can be combined with other harmonics if needed)

y = 1 + sin(2\*PI\*f\*TIME + phase/180\*PI) \-- + sin(4\*PI\*f\*TIME)

\-- Mass-spring-damper equation in differential form:

\-- m\*z\'\' = -K_spr\*z - cv\*z\' + for\*x

m\*z\'\' = -K_spr\*z - cv\*z\' + for\*x

END COMPONENT

Its experiment provides a ready-to-use template for computing transfer functions in the frequency domain using the treatfft routine. It shows how to:

- Run transient simulations of the component testFFT.

- Store the time histories of several signals (x, y, z) in arrays with a constant sampling interval.

- Call treatfft to obtain transfer functions in amplitude and phase from these time histories.

**Workflow**

- Initial transient

A first integration is performed over the interval TIME $\in$ \[0, To\] to allow the system to reach a quasi steady-state response before recording data for the FFT.

- Definition of FFT sampling

The number of FFT samples np_fft is chosen (as a power of two, e.g.$2^{11}$) and the communication interval CINT is computed so that the time step is constant:

$$CINT = \frac{TSTOP - TIME}{np\_ fft - 1}$$

This ensures evenly-spaced samples, which is required by the FFT.

- Data acquisition

A second transient is run while filling the arrays:

px\[i\] = x(T_i)

py\[i\] = y(T_i)

pz\[i\] = z(T_i)

for i = 1 ... np_fft. At the end, a consistency check verifies that the expected number of samples has been collected.

- FFT and transfer functions

The stored time histories are passed to treatfft to compute:

- yfft_amy: magnitude of the transfer function $\left( \left| Y(j\omega)/X(j\omega) \right| \right)$ (amplitude of y/x),

- yfft_phy: phase of $\left( \left| Y(j\omega)/X(j\omega) \right| \right)$ (phase of y/x),

- yfft_amz: magnitude of the transfer function $\left( \left| Z(j\omega)/X(j\omega) \right| \right)$ (amplitude of z/x), over a specified frequency range (e.g. 0--50 Hz). The frequency grid is returned in xfft.

<!-- -->

- Usage

This experiment is intended as a generic template: by adapting the base model (testFFT), the signals to be stored, and the treatfft calls, the same structure can be reused to obtain FFT-based transfer functions for other systems and variables.

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                testFFT.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

treatfft(4, TIME - To, ic, px, py, 0, 50., lnp, xfft, yfft_amy)

treatfft(5, TIME - To, ic, px, py, 0, 50., lnp, xfft, yfft_phy)

treatfft(4, TIME - To, ic, px, pz, 0, 50., lnp, xfft, yfft_amz)

After the second transient, the solver reports:

\[TIME: 6\] Integration period 2047

End of transient-2 (Status: OK, Runtime: 0.031s, Jacob.: 35, Residues: 4199)

This indicates that 2047 time steps were used in the second transient (the data-acquisition window for the FFT). The integration finished successfully and provided the evenly spaced samples used by treatfft.

The following three blocks correspond to least-squares fits of analytical transfer-function models to the FFT results:

- First fit -- amplitude of Y/X (in dB)

iter = 42, errm = 1.68E-7

The table lists the fitted coefficients (Ro, Ai, Bi, Ci, Di, \...) for the magnitude of the transfer function $\left( \left| Y(j\omega)/X(j\omega) \right| \right)$ over the frequency range 0--50 Hz.

The maximum fitting error is reported as 40.11 (db) and the mean error errm is extremely small, indicating that the analytic model closely reproduces the FFT magnitude response in the whole band.

- Second fit -- phase of Y/X (in degrees)

iter = 42, errm = 1.68E-7

Uses the same type of analytical model, now applied to the phase of $\left( \left| Y(j\omega)/X(j\omega) \right| \right)$ in degrees.

The maximum phase deviation between the fitted model and the FFT is 333.2 (grd) over 0--50 Hz. The small mean error shows that the global trend of the phase is captured accurately, even though phase is more sensitive to noise and unwrap issues.

- Third fit -- amplitude of Z/X (in dB)

iter = 79, errm = 1.06E-5

This block corresponds to the magnitude of the transfer function $\left( \left| Z(j\omega)/X(j\omega) \right| \right)$.

The fitted coefficients describe the amplitude response in dB, again over 0--50 Hz.

The maximum magnitude error is 0.1951 (db), i.e. below 0.2 dB in the entire band, which indicates an excellent quality fit. The mean error errm remains very small.

Overall, the experiment shows that:

- The FFT-based transfer functions Y/X and Z/X are computed correctly from the simulated time histories.

- The subsequent identification step produces analytical models whose responses closely match the FFT results in the frequency range of interest (0--50 Hz), especially for the magnitude of Z/X, which is fitted with very high accuracy.

### 2.3.5 Fluid Functions

#### 2.3.5.1 Function deadband

This function calculates a \`\`dead band\'\', which is a range around a variable where no response occurs. Any value within this range is effectively treated as zero, while values outside this range are passed through as-is.

##### 2.3.5.1.1 Parameters

  ------------- ------------- ----------------------------------- ---------------
  NAME          TYPE          DESCRIPTION                         UNITS

  x             IN REAL       The input variable to check.        \-

  x_up          IN REAL       The upper limit of the dead band.   \-

  x_low         IN REAL       The lower limit of the dead band.   \-
  ------------- ------------- ----------------------------------- ---------------

##### 2.3.5.1.2 Return value

- If the input variable x is outside the dead band (i.e., x \> x_up or x \< x_low), the function returns the value of x itself.

- If x is within the dead band (i.e., between x_low and x_up), it returns 0.

##### 2.3.5.1.3 Example

In the following example, the deadband function is applied to a sine function, with limits -0.2 and 0.2.

COMPONENT deadband_ex \"Example component using the deadband function\"

DATA

REAL x_low = -0.2 \"Lower limit of the dead band\"

REAL x_up = 0.2 \"Upper limit of the dead band\"

DECLS

REAL u \"Raw input signal, e.g. noisy measurement\"

REAL y \"Output after applying the dead band\"

CONTINUOUS

\-- Example input signal: sinusoidal variation over time

u = sin(TIME)

\-- Apply dead band:

\-- - y = 0 when u is within \[x_low, x_up\]

\-- - y = u when u is outside \[x_low, x_up\]

y = deadband(u, x_up, x_low)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                deadband_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The following graph shows how the variable y takes the value 0 when u is between the limits.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_deadband.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image20.png){width="6.090909886264217in" height="2.6844750656167977in"}

#### 2.3.5.2 Functions div_safe/div_safe2

These functions performs a division while preventing division by zero. If the denominator is too small (absolute value less than math_tol), the function will return the previous value instead of performing the division.

Div_safe is a NO_TYPE function, while div_safe2 is a REAL function. This means that the result of the division in div_safe is an output attribute of the function, but in div_safe2 it's returned.

##### 2.3.5.2.1 Parameters

  ---------- --------- ---------- ------------------------------------ --------
  NAME       TYPE      DEFAULT    DESCRIPTION                          UNITS

  den        IN REAL              The denominator for the division.    \-

  math_tol   IN REAL   1e-8       Numerical tolerance (optional).      \-

  num        IN REAL              The numerator for the division.      \-

  y \*       IN REAL              The result of the division.          \-
  ---------- --------- ---------- ------------------------------------ --------

\* Only in div_safe.

##### 2.3.5.2.2 Return value

The function checks if the absolute value of the denominator den is greater in absolute value than the tolerance math_tol. If true, it performs the division: y = num / den.

If the denominator is too small (i.e., within math_tol), it does not perform any division. As a result, y will remain the same as the previous value.

##### 2.3.5.2.3 Example

The following example uses the div_safe function to protect a division between a null denominator. The protected division is stored in the variable y_safe, while the normal division is stored in the variable y.

COMPONENT div_safe_ex \"Example component using the div_safe function for safe division\"

DATA

REAL num_init = 1.0 \"Initial value for the numerator\"

DECLS

DISCR REAL num \"Numerator used in the division\"

REAL den \"Denominator used in the division\"

REAL y_safe \"Result of the safe division num/den using div_safe\"

REAL y_safe2 \"Result of the safe division num/den using div_safe2\"

REAL y \"Result of the division num/den\"

INIT

\-- Initialise numerator and denominator

num = num_init

\-- Initial value of y (used when division is not safe)

y = 0.0

CONTINUOUS

\-- Example time-varying denominator that crosses zero:

\-- den oscillates between -1 and +1.

den = sin(TIME)

\-- Regular division

y = num/den

\-- Safe division:

\-- - If \|den\| \> math_tol, y is updated as num / den.

\-- - Otherwise, y keeps its previous value.

\-- Using div_safe:

div_safe(num, den, y_safe)

\-- Using div_safe2:

y_safe2 = div_safe2(num, den)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                div_safe_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The following plots show how the unprotected division reaches values of the order of 107.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_div_safe.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image21.png){width="6.319444444444445in" height="2.46869750656168in"}

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_div_safe.default\\exp1\\Tab_1#Plot_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image22.png){width="6.118055555555555in" height="2.3900240594925632in"}

#### 2.3.5.3 Function donor_cell

This function calculates the fluid property in a donor-cell, which is often used in numerical simulations where a value from neighbouring cells (upstream and downstream) is averaged, weighted by the flow direction.

##### 2.3.5.3.1 Parameters

  ----------------- --------- ---------- --------------------------------------------------------------- -------
  NAME              TYPE      DEFAULT    DESCRIPTION                                                     UNITS

  downstream_prop   IN REAL              The fluid property in the downstream cell.                      \-

  flow              IN REAL              The flow variable, which indicates the direction of the flow.   \-

  math_tol          IN REAL   1e-10      Numerical tolerance (optional).                                 \-

  upstream_prop     IN REAL              The fluid property in the upstream cell.                        \-
  ----------------- --------- ---------- --------------------------------------------------------------- -------

##### 2.3.5.3.2 Return value

The fluid property prop in the donor-cell, based on the flow direction and the properties of the neighbouring cells, which is calculated as a weighted average of the upstream and downstream properties, depending on the flow direction:

$$prop = 0.5\  \times \lbrack(1 + c) \times upstream_{prop} + (1 - c) \times downstream_{prop}\rbrack$$

The variable c represents the direction of the flow. It\'s calculated as follows:

$$c\  = \ \frac{flow}{abs(flow)\  + \ math\_ tol}\ \ \ \ $$

If the flow is positive, c will be close to 1, and if the flow is negative, c will be close to -1. It avoids division by zero by adding a small tolerance (math_tol) to the denominator.

##### 2.3.5.3.3 Example

In the following example, the donor_cell function is used to calculate the value of the prop_int property based on the flow sign, which behaves sinusoidally. The upstream property is considered to have a constant value of 300, while the downstream property has a constant value of 350.

COMPONENT donor_cell_ex \"Example component using the donor_cell function (upwind scheme)\"

DATA

REAL upstream_prop = 300 \"Upstream property, e.g. temperature in K\"

REAL downstream_prop = 350 \"Downstream property, e.g. temperature in K\"

DECLS

REAL flow \"Time-varying flow rate. Defines flow direction\"

REAL prop_int \"Property at the interface\"

CONTINUOUS

\-- Example: sinusoidal flow that changes direction over time

\-- flow(TIME) \> 0 =\> convection from upstream to downstream

\-- flow(TIME) \< 0 =\> convection from downstream to upstream

flow = sin(2\*PI\*TIME)

\-- Compute the convected property at the interface using donor_cell:

\-- - uses upstream_prop when flow \> 0,

\-- - uses downstream_prop when flow \< 0,

\-- - uses a smoothed sign around flow close to 0.

prop_int = donor_cell(flow, upstream_prop, downstream_prop)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                donor_cell_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The prop_int variable jumps between the upstream and downstream properties depending on the sign of the flow.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_donor_cell.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image23.png){width="6.050505249343832in" height="2.6666666666666665in"}

#### 2.3.5.4 Function fpow_gt_one

This function calculates the signed power of a number for cases where the exponent is greater than 1, again with special handling for values near zero.

##### 2.3.5.4.1 Parameters

  --------- ----------- ------------------------------------------------------------- ------------
  NAME      TYPE        DESCRIPTION                                                   UNITS

  y         IN REAL     Input number (base).                                          \-

  ylam      IN REAL     Parameter defining the linear regularisation zone around 0.   \-

  n         IN REAL     The exponent, where the assumption is that n≥1.               \-
  --------- ----------- ------------------------------------------------------------- ------------

##### 2.3.5.4.2 Internal variables

  --------- ----------- ----------------------------------------------------------------------------------------------------- ------------
  NAME      TYPE        DESCRIPTION                                                                                           UNITS

  x         REAL        The result of the calculation (the signed power).                                                     \-

  xlam      REAL        A variable related to ylam that adjusts the behavior of the approximation based on the linear zone.   \-

  a, b, c   REAL        Coefficients for a quadratic equation used to approximate the power in the linear zone.               \-
  --------- ----------- ----------------------------------------------------------------------------------------------------- ------------

##### 2.3.5.4.3 Formulation

- Assertion: The line ASSERT (n \>= 1) ensures that the exponent n is at least 1. If n is less than 1, the function will raise an error with the message \`\`Wrong exponent in function fpow_gt_one\'\'.

- Power Calculation:

  - If abs(y) \> ylam or ylam = 0: If the absolute value of y is greater than ylam or if ylam is zero (meaning no linear zone), the function calculates the power normally. The MATH.sign(y) ensures the result retains the correct sign (i.e., the result of y^n^ has the same sign as y):

$$x = MATH.sign(y) \times \ {|y|}^{n}$$

This formula calculates the signed power by first finding the absolute value raised to the power of n, and then multiplying by the sign of y.

- If abs(y) \<= ylam: xlam is the value of ${|ylam|}^{n}$, which is used to adjust the quadratic approximation. If y is within the linear zone near zero, the function uses a quadratic equation to smoothly calculate the signed power:

- 1\. Define an auxiliary variable:

$$xlam = |ylam|^{n}$$

- 2\. Define coefficients for the quadratic equation:

$$\alpha = \frac{1/n - 1}{xlam^{\left( 2.\  - \frac{1}{n} \right)}}$$

$$b = \frac{2.\  - \frac{1}{n}}{xlam^{1.\  - \frac{1}{n}}}$$

$$c = \  - |y|
$$

- a and b are functions of n and ylam and determine how the quadratic behaves.

- $c = \  - |y|$ ensures that the solution has the correct direction for small values of y.

- 3\. Solve the quadratic equation using the quadratic formula:

$$x = MATH.sign(y) \cdot \ \frac{- b \pm \sqrt{b^{2} - 4ac}}{2a}$$

The quadratic formula is used to compute the result, ensuring smooth behavior near zero.

##### 2.3.5.4.4 Return value

The function returns the smoothed signed power.

##### 2.3.5.4.5 Example

The following example component illustrates how to use the function fpow_gt_one to compute a signed power with a smooth regularisation zone near zero for exponents $n \geq 1$. A sinusoidal input signal is raised to the power (n) both with regularisation (x_reg = fpow_gt_one(y, ylam, n)) and without it (x_std = sign(y)\*y\*\*n), so their behaviour can be directly compared, especially in the vicinity of (y = 0).

COMPONENT fpow_gt_one_ex \"Example component using fpow_gt_one (n \>= 1)\"

DATA

REAL n = 2.0 \"Exponent (n \>= 1, e.g. squared behaviour)\"

REAL ylam = 0.3 \"Half-width of the linear/regularisation zone\"

DECLS

REAL y \"Input signal to be raised to power n\"

REAL x_reg \"Regularised signed power: fpow_gt_one(y, ylam, n)\"

REAL x_std \"Standard signed power y\^n (for comparison)\"

CONTINUOUS

\-- Time-varying input signal (can be negative and positive)

y = sin(2\*PI\*TIME)

\-- Regularised power:

\-- - For \|y\| \> ylam or ylam == 0: x_reg near sign(y)\*\|y\|\^n

\-- - For \|y\| \<= ylam: smooth quadratic regularisation

x_reg = fpow_gt_one(y, ylam, n)

\-- Non-regularised reference: standard power

x_std = sign(y)\*y\*\*n

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                fpow_gt_one_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 4

  Communication interval (s)          0.01
  ----------------------------------- -----------------------------------

**Results**\
The next plot shows the time evolution of the input signal y, the regularised power x_reg = fpow_gt_one(y, ylam, n), the standard power x_std = y\*\*n, and the limit ylam.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_fpow_gt_one.default\\exp1\\Tab_1#Plot_1_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image24.png){width="5.486111111111111in" height="1.990508530183727in"}

The following figure zooms in around y = 0 with ylam = 0.3 and highlights how x_reg is smoothed in the neighbourhood of the origin: the curve is softer and almost linear inside the band \|y\| ≤ ylam, while x_std keeps the steeper, purely polynomial shape.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_fpow_gt_one.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image25.png){width="5.6860094050743655in" height="2.0625in"}

The next figure (with ylam = 0) shows that, when the regularisation width is set to zero, x_reg and x_std become identical, confirming that fpow_gt_one reduces to the standard signed power when no regularisation is requested.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_fpow_gt_one.default\\exp1\\Tab_1#Plot_1_4.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image26.png){width="6.105606955380577in" height="2.2152777777777777in"}

#### 2.3.5.5 Function fpow_lt_one

This function calculates the signed power of a number for cases where the exponent is less than 1, with special handling for values near zero.

##### 2.3.5.5.1 Parameters

  --------- ----------- --------- --------------------------------------------------------------- ------------
  NAME      TYPE        PURPOSE   DESCRIPTION                                                     UNITS

  x         REAL        IN        Input number (base).                                            \-

  xlam      REAL        IN        Parameter defining the linear regularisation zone around 0.     \-

  n         REAL        IN        The exponent, where the assumption is that $0 \leq n \leq 1$.   \-
  --------- ----------- --------- --------------------------------------------------------------- ------------

##### 2.3.5.5.2 Internal variables

  --------- ----------- --------------------------------------------------- ------------
  NAME      TYPE        DESCRIPTION                                         UNITS

  y         REAL        The result of the calculation (the signed power).   \-
  --------- ----------- --------------------------------------------------- ------------

##### 2.3.5.5.3 Formulation

- Assertion: The line ASSERT (n \<= 1 AND n \>= 0) ensures that the exponent n is between 0 and 1 (inclusive). If n falls outside this range, an error is triggered with the message \`\`Wrong order of the root in function fpow_lt_one\'\'.

- Power Calculation:

  - If abs(x) \> xlam or xlam = 0: If the absolute value of x is greater than xlam or if xlam is zero, no special treatment applies for values near zero. The function simply calculates the power using the standard formula for fractional exponents:

$$y = MATH.sign(x) \times |x|^{n}$$

Here, MATH.sign(x) preserves the sign of x (positive or negative), and abs(x)\*\*n computes the power of the absolute value of x.

- If abs(x) \<= xlam: If x is near zero (i.e., within the \`\`linear zone\'\' defined by xlam), a polynomial expression is used to ensure continuity and derivability of y near zero:

$$y = (2. - n) \times \frac{x}{xlam^{1. - n}} + (n - 1.) \times \frac{\left( x \times |x| \right)}{xlam^{2. - n}}$$

This formula adjusts the behavior for small values of x to avoid sudden changes in the result and provides a linear transition near zero.

##### 2.3.5.5.4 Return value

The function returns the result y, which is the signed power of x raised to the power n, with special treatment for small values of x.

##### 2.3.5.5.5 Example

The following example component illustrates how to use the function fpow_gt_one to compute a signed power with a smooth regularisation zone near zero for exponents $n \geq 1$. A sinusoidal input signal is raised to the power (n) both with regularisation (x_reg = fpow_gt_one(y, ylam, n)) and without it (x_std = sign(y)\*y\*\*n), so their behaviour can be directly compared, especially in the vicinity of (y = 0).

COMPONENT fpow_gt_one_ex \"Example component using fpow_gt_one (n \>= 1)\"

DATA

REAL n = 2.0 \"Exponent (n \>= 1, e.g. squared behaviour)\"

REAL ylam = 0.3 \"Half-width of the linear/regularisation zone\"

DECLS

REAL y \"Input signal to be raised to power n\"

REAL x_reg \"Regularised signed power: fpow_gt_one(y, ylam, n)\"

REAL x_std \"Standard signed power y\^n (for comparison)\"

CONTINUOUS

\-- Time-varying input signal (can be negative and positive)

y = sin(2\*PI\*TIME)

\-- Regularised power:

\-- - For \|y\| \> ylam or ylam == 0: x_reg near sign(y)\*\|y\|\^n

\-- - For \|y\| \<= ylam: smooth quadratic regularisation

x_reg = fpow_gt_one(y, ylam, n)

\-- Non-regularised reference: standard power

x_std = sign(y)\*y\*\*n

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                fpow_lt_one_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 4

  Communication interval (s)          0.001
  ----------------------------------- -----------------------------------

**Results**\
The next plot shows the time evolution of the input signal y, the regularised power x_reg = fpow_lt_one(y, ylam, n), the standard power x_std = y\*\*n, and the limit ylam.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_fpow_lt_one.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image27.png){width="5.593565179352581in" height="2.4652777777777777in"}

The following figure zooms in around y = 0 with ylam = 0.3 and highlights how x_reg is smoothed in the neighbourhood of the origin: the curve is softer and almost linear inside the band \|y\| ≤ ylam, while x_std keeps the steeper, purely polynomial shape.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_fpow_lt_one.default\\exp1\\Tab_1#Plot_1_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image28.png){width="5.719617235345582in" height="2.5208333333333335in"}

The next figure (with ylam = 0) shows that, when the regularisation width is set to zero, x_reg and x_std become identical, confirming that fpow_gt_one reduces to the standard signed power when no regularisation is requested.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_fpow_lt_one.default\\exp1\\Tab_1#Plot_1_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image29.png){width="5.291666666666667in" height="2.332221128608924in"}

#### 2.3.5.6 Function fpow

This function is designed to calculate a signed power of a number with a linear zone near 0, for exponents greater than 1 or less than 1.

##### 2.3.5.6.1 Parameters

  --------- ----------- --------- ------------------------------------------------------------------------------------- ------------
  NAME      TYPE        PURPOSE   DESCRIPTION                                                                           UNITS

  x         REAL        IN        Input number (base).                                                                  \-

  xlam      REAL        IN        Parameter defining the linear regularisation zone around 0.                           \-

  n         REAL        IN        The exponent, where the assumption is that $0 \leq n$. If not, an error will occur.   \-
  --------- ----------- --------- ------------------------------------------------------------------------------------- ------------

##### 2.3.5.6.2 Internal variables

  --------- ----------- --------------------------------------------------- ------------
  NAME      TYPE        DESCRIPTION                                         UNITS

  y         REAL        The result of the calculation (the signed power).   \-
  --------- ----------- --------------------------------------------------- ------------

##### 2.3.5.6.3 Return value

The function returns the result x, which is the signed power of y raised to the power n, with special treatment for values near zero using a quadratic formula that depends on n.

- If n = 1, the result is x = y.

- If n \> 1, the result is x = fpow_gt_one(y, ylam, n) (see §[2.3.5.4.](#function-fpow_gt_one) ).

- If n \< 1, the result is x = fpow_lt_one(y, ylam, n) (see §[2.3.5.5.](#function-fpow_lt_one) ).

##### 2.3.5.6.4 Example

The following example component illustrates how to use the function fpow to compute a signed power with a smooth regularisation zone near zero. A sinusoidal input signal is raised to the power (n) both with regularisation (x_reg = fpow (y, ylam, n)) and without it (x_std = sign(y)\*y\*\*n), so their behaviour can be directly compared, especially in the vicinity of (y = 0).

COMPONENT fpow_ex \"Example component using the fpow wrapper (n \>= 0)\"

DATA

REAL n = 0.5 \"Exponent (n \>= 0). Try n=0.5, 1.0, 2.0 to see different behaviours\"

REAL ylam = 0.3 \"Width of the regularisation zone around zero\"

DECLS

REAL y \"Input signal to be raised to power n\"

REAL x_reg \"Regularised signed power\"

REAL x_std \"Standard signed power sign(y)\*\|y\|\^n\"

CONTINUOUS

\-- Time-varying input: can be positive, negative, and pass through zero

y = sin(2\*PI\*TIME)

\-- Unified regularised signed power:

\-- - n = 1: x_reg = y

\-- - n \> 1: fpow_gt_one path (power-like with regularisation)

\-- - 0\<=n\<1: fpow_lt_one path (root-like with regularisation)

x_reg = fpow(y, ylam, n)

\-- Non-regularised reference: signed power (useful for plotting comparison)

x_std = sign(y) \* abs(y)\*\*n

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                fpow_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  Simulation time (s)                 4

  Communication interval (s)          0.001
  ----------------------------------- -----------------------------------

**Results**

The next plot shows the time evolution of the input signal y, the regularised power x_reg = fpow (y, ylam, n), the standard power x_std = y\*\*n, and the limit ylam when n = 0.5.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_fpow.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image30.png){width="5.92948709536308in" height="2.6143482064741908in"}

When n = 2, the evolution of the variables is the following:

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_fpow.default\\exp1\\Tab_1#Plot_1_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image31.png){width="6.057638888888889in" height="2.6708508311461068in"}

#### 2.3.5.7 Function rev_fri

This function calculates the Coulomb friction force, which is commonly used in physics and engineering to model the force opposing the relative motion of two objects. It applies different friction coefficients for positive and negative velocities, with a hyperbolic tangent (tanh) used for smoothing.

##### 2.3.5.7.1 Parameters

  --------- ----------- -------------------------- ------------
  NAME      TYPE        DESCRIPTION                UNITS

  fc1       IN REAL     Direct Coulomb friction    N

  fc2       IN REAL     Reverse Coulomb friction   N

  v         IN REAL     Velocity of the object     m/s
  --------- ----------- -------------------------- ------------

##### 2.3.5.7.2 Internal variables

  --------- ----------- --------------------------------------------------- ------------
  NAME      TYPE        DESCRIPTION                                         UNITS

  y         REAL        The result of the calculation (the signed power).   \-
  --------- ----------- --------------------------------------------------- ------------

##### 2.3.5.7.3 Formulation

- Friction Force Calculation:

  - If the velocity v is less than or equal to 0, the function calculates the friction force using fc~2~:

$$ffric = - fc_{2} \times tanh(v \times 10^{4})$$

- If the velocity v is greater than 0, the function calculates the friction force using fc~1~:

$$ffric = - fc_{1} \times tanh(v \times 10^{4})$$

- The tanh (v \* 1.e4) function smooths the friction force response. It makes the friction force approach zero quickly as the velocity approaches zero and asymptotically reaches fc~1~ or fc~2~ for large velocities.

##### 2.3.5.7.4 Return Value

The calculated friction force ffric, depending on the direction of velocity.

##### 2.3.5.7.5 Example

In the following example, we simulate the motion of a mass m subjected to a sinusoidal external force, a viscous damping force, and Coulomb friction computed using the rev_fri function.

COMPONENT rev_fri_ex \"Example component using rev_fri for asymmetric Coulomb friction\"

DATA

REAL m = 1.0 UNITS u_kg \"Mass\"

REAL cv = 0.5 UNITS no_units \"Viscous damping coefficient\"

REAL fc1 = 10.0 UNITS u_N \"Coulomb friction for positive velocity\"

REAL fc2 = 15.0 UNITS u_N \"Coulomb friction for negative velocity\"

REAL A_for = 20.0 UNITS u_N \"Amplitude of external sinusoidal force\"

REAL f_for = 0.5 UNITS u_Hz \"Frequency of external force\"

DECLS

REAL x UNITS u_m \"Position\"

REAL v UNITS u_m_s \"Velocity, unit from MATH/DEFAULT units\"

REAL F_ext UNITS u_N \"External force\"

REAL F_fric UNITS u_N \"Coulomb friction force\"

INIT

\-- Initial conditions

x = 0.0

v = 0.0

CONTINUOUS

\-- Time-varying external excitation force

F_ext = A_for \* sin(2 \* PI \* f_for \* TIME)

\-- Asymmetric Coulomb friction with smooth transition near v = 0

F_fric = rev_fri(v, fc1, fc2)

\-- Equation of motion:

m \* v\' = F_ext - cv \* v + F_fric

\-- Kinematic relation

x\' = v

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                rev_fri_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  10                                  10

  Communication interval (s)          0.001
  ----------------------------------- -----------------------------------

**Results**

In the following graph, we see how friction F_fric moves between -10 (-fc~1~) and 15 (fc~2~) depending on the sign of velocity, v. The transition between these limits does not occur in a straight line, but is smoothed by a hyperbolic tangent when the velocity is close to 0.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_rev_fri.default\\exp1\\Tab_1#Plot_1_3.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image32.png){width="6.495833333333334in" height="2.270107174103237in"}

### 2.3.6 Polynomials

This section gathers mathematical functions that deal with polynomials, including basic operations like polynomial evaluation, integration, and multiplication. Below is an explanation of each function:

#### 2.3.6.1 Function fac

This function calculates the factorial of an integer n, which is defined as:

$n! = n \cdot (n - 1) \cdot (n - 2) \cdot \ldots \cdot 1$ if $n \geq 1$

$n! = 1$ if $n = 0$

##### 2.3.6.1.1 Parameters

  --------- ------------ ----------------------------------------------------- ------------
  NAME      TYPE         DESCRIPTION                                           UNITS

  n         IN INTEGER   Integer number for which the factorial is evaluated   \-
  --------- ------------ ----------------------------------------------------- ------------

##### 2.3.6.1.2 Internal variables

  --------- ----------- -------------------- ------------
  NAME      TYPE        DESCRIPTION          UNITS

  y         REAL        Factorial result     \-
  --------- ----------- -------------------- ------------

##### 2.3.6.1.3 Return value

The function returns y, the factorial of n.

##### 2.3.6.1.4 Example

The following component computes the factorial of an integer n using the math function fac and prints the result.

COMPONENT fac_ex

DATA

INTEGER n = 7

DECLS

INTEGER y

INIT

y = fac(n)

PRINT(\"\$n! = \$y\")

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                fac_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

Modifying the value of n in the component or in the body of the experiment, this leads to the following results:

2! = 2

0! = 1

7! = 5040

#### 2.3.6.2 Function poly

This function calculates the value of a polynomial given an input value x.

##### 2.3.6.2.1 Parameters

  --------- ------------ -------------------------------------------------------- ------------
  NAME      TYPE         DESCRIPTION                                              UNITS

  A\[n\]    IN REAL      Array of real coefficients for the polynomial.           \-

  n         IN INTEGER   Order of the polynomial plus one.                        \-

  x         IN REAL      Real value at which the polynomial is to be evaluated.   \-
  --------- ------------ -------------------------------------------------------- ------------

##### 2.3.6.2.2 Internal variables

  --------- ----------- ----------------------- ------------
  NAME      TYPE        DESCRIPTION             UNITS

  j         INTEGER     Loop counter            \-

  y         REAL        Polynomial evaluation   \-
  --------- ----------- ----------------------- ------------

##### 2.3.6.2.3 Return value

The value of the polynomial at x, y, calculated as:

$$y = A\lbrack 1\rbrack + A\lbrack 2\rbrack \cdot x + A\lbrack 3\rbrack \cdot x^{2} + \ldots + A\lbrack n\rbrack \cdot x^{n - 1}$$

##### 2.3.6.2.4 Example

This component evaluates a sinusoidal input in the polynomial:

$$p(x) = 1 - 3x + 2x^{2} + \frac{1}{2}x^{3}$$

COMPONENT poly_ex \"Example component using the poly function\"

DATA

INTEGER n = 4 UNITS no_units \"Order of the polynomial plus 1 (number of coefficients)\"

REAL A\[4\] = {1., -3., 2., 0.5} UNITS no_units \"Polynomial coefficients: p(x) = A\[1\] + A\[2\]\*x + A\[3\]\*x\^2 + A\[4\]\*x\^3\"

DECLS

REAL x_input UNITS no_units \"Input variable at which the polynomial is evaluated\"

REAL y_poly UNITS no_units \"Polynomial value p(x_input) = poly(x_input, n, A)\"

CONTINUOUS

\-- Time-varying input: here a simple sinusoidal signal

x_input = sin(TIME)

\-- Evaluate the polynomial p(x_input) with the MATH.poly function

y_poly = poly(x_input, n, A)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                poly_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  10                                  15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_poly.default\\exp1\\Tab_1#Plot_1_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image33.png){width="6.495833333333334in" height="2.2930938320209973in"}

#### 2.3.6.3 Function poly_dx_int

This function calculates the integral of the polynomial p(x) divided by x at a given value x. This integral includes a logarithmic term for the first coefficient.

##### 2.3.6.3.1 Parameters

  --------- ------------ -------------------------------------------------------- ------------
  NAME      TYPE         DESCRIPTION                                              UNITS

  x         IN REAL      Real value at which the polynomial is to be evaluated.   \-

  n         IN INTEGER   Order of the polynomial plus one.                        \-

  A\[n\]    IN REAL      Array of real coefficients for the polynomial.           \-
  --------- ------------ -------------------------------------------------------- ------------

##### 2.3.6.3.2 Internal variables

  --------- ----------- ----------------------- ------------
  NAME      TYPE        DESCRIPTION             UNITS

  j         INTEGER     Loop counter            \-

  y         REAL        Polynomial evaluation   \-
  --------- ----------- ----------------------- ------------

##### 2.3.6.3.3 Return value

The integral of the polynomial divided by x is:

$$f(x) = A\lbrack 1\rbrack \cdot ln(x) + A\lbrack 2\rbrack \cdot x + \frac{A\lbrack 3\rbrack}{2} \cdot x^{2} + \ldots + \frac{A\lbrack n\rbrack}{n - 1} \cdot x^{n - 1}$$

##### 2.3.6.3.4 Example

This component evaluates a sinusoidal input in y(x), which is the integral of the expression $p(x)/x$, where:

$$p(x) = 1 - 3x + 2x^{2} + \frac{1}{2}x^{3}$$

$$y(x) = \ln(x) - 3 + x + \frac{1}{6}x^{2}\ $$

For a varying x:

$$x(t)\  = \ sin\ (t)\  + \ 2$$

COMPONENT poly_dx_int_ex \"Example component using the poly_dx_int function\"

DATA

INTEGER n = 4 UNITS no_units \"Order of the polynomial plus 1 (number of coefficients)\"

REAL A\[4\] = {1., -3., 2., 0.5} UNITS no_units \"Polynomial coefficients: p(x) = A\[1\] + A\[2\]\*x + A\[3\]\*x\^2 + A\[4\]\*x\^3\"

DECLS

REAL x_input UNITS no_units \"Input variable at which the polynomial is evaluated\"

REAL y UNITS no_units \"Output value y = poly_dx_int(x_input, n, A)\"

CONTINUOUS

\-- Time-varying input

x_input = sin(TIME) + 2

\-- Evaluate the integral of p(x_input)/x_input with the MATH.poly_dx_int function

y = poly_dx_int(x_input, n, A)

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                poly_dx_int_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  10                                  15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The following plot shows the evaluation of x in the integral of p(x)/x.

![C:\\Users\\LPU\\SIMULATIONS\\WORKSPACES\\STANDARD_2.6.1\\libs\\MATH_EXAMPLES\\experiments\\poly_dx_int_ex.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image34.png){width="5.532051618547682in" height="2.535819116360455in"}

#### 2.3.6.4 Function poly_int

This function calculates the integral of the polynomial p(x) at a given value x.

##### 2.3.6.4.1 Parameters

  --------- ------------ -------------------------------------------------------- ------------
  NAME      TYPE         DESCRIPTION                                              UNITS

  x         IN REAL      Real value at which the polynomial is to be evaluated.   \-

  n         IN INTEGER   Order of the polynomial plus one.                        \-

  A\[n\]    IN REAL      Array of real coefficients for the polynomial.           \-
  --------- ------------ -------------------------------------------------------- ------------

##### 2.3.6.4.2 Internal variables

  --------- ----------- ----------------------- ------------
  NAME      TYPE        DESCRIPTION             UNITS

  j         INTEGER     Loop counter            \-

  y         REAL        Polynomial evaluation   \-
  --------- ----------- ----------------------- ------------

##### 2.3.6.4.3 Return value

The integral of the polynomial is:

$$f(x) = A\lbrack 1\rbrack \cdot x + \frac{A\lbrack 2\rbrack}{2} \cdot x^{2} + \frac{A\lbrack 3\rbrack}{3} \cdot x^{3} + \ldots + \frac{A\lbrack n\rbrack}{n} \cdot x^{n}$$

##### 2.3.6.4.4 Example

This component evaluates a sinusoidal input in y(x), which is the integral of the expression $p(x)/x$, where:

$$p(x) = 1 - 3x + 2x^{2} + \frac{1}{2}x^{3}$$

$$y(x) = \int_{0}^{x}{\frac{p(y)}{y}dy} = x - \frac{3}{2}x^{2} + \frac{2}{3}x^{3} + \frac{1}{8}x^{4}\ $$

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                poly_int_ex.default.exp1

  Type                                Transient

  Method                              CVODE_BDF

  10                                  15

  Communication interval (s)          0.1
  ----------------------------------- -----------------------------------

**Results**

The following plot shows the evaluation of x in the integral of p(x).

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_poly_int.default\\exp1\\Tab_1#Plot_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image35.png){width="6.128205380577428in" height="2.7019641294838146in"}

#### 2.3.6.5 Function PolyMult

This function multiplies two polynomials.

##### 2.3.6.5.1 Parameters

  --------- ------------- ------------------------------------------------------------------------------- ------------
  NAME      TYPE          DESCRIPTION                                                                     UNITS

  a\[k\]    IN REAL       Coefficient array of a(x)                                                       \-

  b\[l\]    IN REAL       Coefficient array of b(x)                                                       \-

  c\[n\]    OUT REAL      Coefficient array of the product polynomial c(x)                                \-

  k         IN INTEGER    Number of coefficients of polynomial a(x) (its degree plus one)                 \-

  l         IN INTEGER    Number of coefficients of polynomial b(x) (its degree plus one)                 \-

  n         OUT INTEGER   Number of coefficients of the resulting polynomial c(x) (its degree plus one)   \-
  --------- ------------- ------------------------------------------------------------------------------- ------------

##### 2.3.6.5.2 Return value

The function computes the product of two polynomials by multiplying each term of the first polynomial with each term of the second polynomial. The resulting coefficients are stored in c, and its degree plus one is stored in n.

##### 2.3.6.5.3 Example

In the following example, the function PolyMult will be used to compute the product of two polynomials. The resulting polynomial will be stored as a string in the variable result, its coefficients as a real array in c and its degree plus one as an integer in n.

COMPONENT poly_mult_ex \"Example component using the PolyMult function\"

DATA

INTEGER k = 3 UNITS no_units \"Number of coefficients of polynomial a(x)\"

REAL a\[3\] = {1., 2., 3.} UNITS no_units \"Coefficients of a(x) = 1 + 2\*x + 3\*x\^2\"

INTEGER l = 2 UNITS no_units \"Number of coefficients of polynomial b(x)\"

REAL b\[2\] = {1., -1.} UNITS no_units \"Coefficients of b(x) = 1 - x\"

DECLS

INTEGER n UNITS no_units \"Number of coefficients of the product polynomial c(x)\"

DISCR REAL c\[5\] UNITS no_units \"Coefficient array of c(x) = a(x)\*b(x); only c\[1..n\] are used\"

STRING result = \"\"

INIT

\-- Compute the product polynomial c(x) = a(x)\*b(x)

PolyMult(k, a, l, b, n, c)

\-- Report the result:

\-- n : number of coefficients of c(x)

\-- c\[i\]: coefficients of c(x) = c\[1\] + c\[2\]\*x + \... + c\[n\]\*x\^(n-1)

PRINT(\"PolyMult example: a(x) = 1 + 2\*x + 3\*x\^2, b(x) = 1 - x\")

PRINT(\"Number of coefficients of c(x): n = \$n\")

IF (abs(c\[1\]) \> tol) THEN

result = realToString(c\[1\])

END IF

FOR (i IN 2,n)

IF (c\[i\] \> tol) THEN

result = result + \" + \" + realToString(c\[i\]) + \"\*x\^\" + integerToString(i-1)

ELSEIF (c\[i\] \< -tol) THEN

result = result + \" - \" + realToString(-c\[i\]) + \"\*x\^\" + integerToString(i-1)

END IF

END FOR

PRINT(\"Result: c(x) = \$result\\n\")

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                poly_mult_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

This provides the following result:

PolyMult example: a(x) = 1 + 2\*x + 3\*x\^2, b(x) = 1 - x

Number of coefficients of c(x): n = 5

Result: c(x) = 1 + 1\*x\^1 + 1\*x\^2 - 3\*x\^3

### 2.3.7 Random functions

This code defines a group of functions and external objects related to random number generation, specifically used for simulating random processes following different probability distributions (uniform, Gaussian, exponential, Gamma, Poisson, binomial). These functions utilize various algorithms to generate random values based on specified distributions, which are critical for simulations in fields such as statistics, physics and engineering.

#### 2.3.7.1 Function bnldev

This function generates a pseudorandom deviate from a binomial distribution $Bi(n,p)$ using internal state stored in two work arrays. It returns a single sample from a binomial distribution with parameters:

- n= integer_array\[6\] (number of trials),

- p= real_array\[101\] (probability of success per trial).

The algorithm automatically chooses between three methods depending on the values of n and n·p:

- direct summation of Bernoulli trials (small n),

- Poisson approximation (very small mean np),

- rejection method based on a normal/gamma approximation (general case).

Some intermediate values are cached in integer_array and real_array to improve efficiency in subsequent calls. Although the return type is REAL, the value produced is always an integer in the range \[0,n\], represented as a real.

It relies on the uniform generator ran1 (see §[2.3.7.11.](#function-c_poidev) ) and the gamma-logarithm function gammln (see §[2.3.7.6.](#function-c_gamdev) ).

##### 2.3.7.1.1 Parameters

  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  NAME                TYPE          DESCRIPTION                                                                                                                    UNITS
  ------------------- ------------- ------------------------------------------------------------------------------------------------------------------------------ -------
  integer_array\[\]   OUT INTEGER   Integer work array. Must contain integer_array\[6\] = n (number of trials). Also uses integer_array\[11\] as a cache flag.     --

  real_array\[\]      OUT REAL      Real work array. Must contain real_array\[101\] = p (probability of success). Uses real_array\[121..127\] for cached values.   --
  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Although declared as OUT in EL, both arrays are effectively IN/OUT: they are read and updated on each call and must be preserved between calls to generate a consistent sequence of binomial deviates. They must be dimensioned large enough to hold at least:

- integer_array\[11\],

- real_array\[127\].

##### 2.3.7.1.2 Internal variables

  ------------------------------------------------------------------------------------------------------------------------------
  NAME    TYPE      DESCRIPTION                                                                                          UNITS
  ------- --------- ---------------------------------------------------------------------------------------------------- -------
  am      REAL      Mean of the binomial distribution: am = integer_array\[6\] \* p = n \* p.                            --

  angle   REAL      Angle used in the rejection method: angle = PI \* ran1(\...).                                        rad

  bnl     REAL      Final binomial deviate returned by the function (conceptually an integer), output of the function.   --

  em      REAL      Candidate binomial deviate in the rejection method (later coerced to an integer).                    --

  g       REAL      Auxiliary value g = exp(-am) used in the Poisson approximation.                                      --

  j       INTEGER   Loop counter / temporary index used in Poisson approximation.                                        --

  p       REAL      Effective probability of success, symmetrised to p \<= 0.5.                                          --

  sq      REAL      Scale factor sq = sqrt(2 \* am \* (1 - p)) used in the rejection method.                             --

  t       REAL      Threshold used in Poisson and rejection tests to accept/reject candidate values.                     --

  y       REAL      Auxiliary variable y = tan(angle) used in the rejection method.                                      --
  ------------------------------------------------------------------------------------------------------------------------------

Some entries inside real_array and integer_array are:

- real_array\[101\] : original p used as input by the user.

- real_array\[121\] : cached effective p (≤ 0.5) used internally.

- real_array\[122\] : cached value 1-p.

- real_array\[123\] : cached value log(p).

- real_array\[124\] : cached value log(1 - p).

- real_array\[126\] : cached value gammln(n + 1) with n = integer_array\[6\].

- real_array\[127\] : cached copy of n in real form.

- integer_array\[11\] : cache flag indicating whether n has changed since the last call.

##### 2.3.7.1.3 Formulation

- At the beginning of the function, the binomial parameters are read from the work arrays:

  - Number of trials:

n=integer_array\[6\]

- Probability of success:

p=real_array\[101\]

To improve numerical stability and efficiency, the function symmetrises the probability so that the internal p is always ≤ 0.5:

IF (real_array\[101\] \<= 0.5) THEN

p = real_array\[101\]

ELSE\
p = 1 - real_array\[101\]

END IF

Then the mean of the binomial distribution is computed as:

$am = n \cdot p = integer\_ array\lbrack 6\rbrack \cdot p$

This am is used to decide which algorithm to use.

- Case 1 -- Small number of trials (n \< 25)

If integer_array\[6\] \< 25, the function uses direct Bernoulli summation:

- Initialise the binomial deviate:

bnl = 0

- For each trial k=1...n:

- Draw a uniform deviate u = ran1(integer_array, real_array).

- If u \< p, increment the success counter:

FOR (k IN 1, integer_array\[6\])

IF (ran1(integer_array, real_array) \< p) THEN

bnl = bnl + 1

END IF

END FOR

At the end of this loop, bnl holds the number of successes in n independent Bernoulli trials, i.e. a binomial deviate.

- Case 2 -- Small mean (am \< 1)

If n is larger but the mean am = n·p is very small (am \< 1), the function switches to a Poisson approximation of the binomial distribution:

- Compute

$$g = \exp{( - am)}$$

- Initialise t = 1. Repeatedly multiply t by independent uniform deviates until the threshold is crossed:

g = exp(- am)

t = 1

FOR (j = 0; j \<= integer_array\[6\]; j = j + 1)

t = t \* ran1(integer_array, real_array)

IF (t \< g) THEN

j = integer_array\[6\]

END IF

END FOR

The loop count j corresponds to the number of events before crossing the threshold; the final binomial deviate is:

IF (j \<= integer_array\[6\]) THEN

bnl = j

ELSE

bnl = integer_array\[6\]

END IF

This approximates a Poisson-distributed number of successes, capped at n.

- Case 3 -- General case (large n and am \>= 1)

For the general case, when n is not small and am \>= 1, the function uses an acceptance--rejection method based on a normal/gamma approximation:

- Caching factorial-related terms when n changes. If integer_array\[6\] has changed since the last call, factorial-related terms are recomputed and stored:

IF (integer_array\[6\] != integer_array\[11\]) THEN

real_array\[127\] = integer_array\[6\]

real_array\[126\] = gammln(real_array\[127\] + 1)

integer_array\[11\] = integer_array\[6\]

END IF

- Caching logarithms when p changes. If the effective p is different from the cached one:

IF (p != real_array\[121\]) THEN

real_array\[122\] = 1 - p

real_array\[123\] = log(p)

real_array\[124\] = log(real_array\[122\])

real_array\[121\] = p

END IF

- Compute scaling factor for the normal approximation

sq =$\sqrt{np(1 - p)}$= sqrt(2 \* am \* real_array\[122\])

- Rejection loop. The algorithm then enters a nested rejection loop:

WHILE (ran1(integer_array, real_array) \> t)

WHILE ((em \< 0) OR (em \>= real_array\[127\] + 1))

angle = PI \* ran1(integer_array, real_array)

y = tan(angle)

em = sq \* y + am

END WHILE

em = int(em)

t = 1.2 \* sq \* (1 + y\*\*2) \* exp(real_array\[126\] - \\

gammln(em + 1) - gammln(real_array\[127\] - em + 1) + \\

em \* real_array\[123\] + (real_array\[127\] - em) \* real_array\[124\])

END WHILE

bnl = em

- The inner loop proposes a candidate em by sampling:

angle = PI \* ran1(\...)

y = tan(angle)

em = sq \* y + am

- The candidate is forced into the valid range \[0,n\]\[0, n\]\[0,n\] by the condition (em \< 0) OR (em \>= real_array\[127\] + 1).

- em = int(em) ensures the candidate is an integer.

- The acceptance threshold t uses gamma logs and cached values to approximate the exact binomial probabilities.

The outer loop repeats until the candidate passes the rejection test.

- Symmetry correction for original p

If the internal probability p differs from the original user-provided probability real_array\[101\] (i.e. p = 1 - real_array\[101\] was used for symmetry), the deviate is adjusted:

IF (p != real_array\[101\]) THEN

bnl = integer_array\[6\] - bnl

END IF

This uses the fact that if $X \sim \ Binomial(n,\ p)$ then $n - X \sim \ Binomial(n,1 - \ p)$.

##### 2.3.7.1.4 Return value

The function returns a REAL value bnl, which is a binomial deviate:

- Conceptually an integer in the set:

{0,1,2,...,n}

- Represented as a real number (e.g. 0.0, 1.0, 2.0, ...).

The underlying random numbers used in the algorithm are generated by ran1, and the work arrays integer_array and real_array must be preserved between calls to maintain the state and caching.

##### 2.3.7.1.5 Example

The following example component shows how to initialise and use bnldev to generate a sequence of binomial random deviates with:

- n=10 trials,

- p=0.3 probability of success.

COMPONENT bnldev_ex (INTEGER N = 200 \"Number of random numbers generated\") \"Example: generate binomial deviates with bnldev\"

DATA

\-- Binomial parameters: Bin(n_trials, p_succ)

INTEGER n_trials = 10

REAL p_succ = 0.3

DECLS

INTEGER integer_array\[20\] \"Work array: RNG state and binomial cache\"

DISCR REAL real_array\[200\] \"Work array: shuffle table and cached values\"

DISCR REAL ran\[N\] \"Binomial samples\"

DISCR REAL ran_ord\[N\] \"Sorted binomial samples\"

INIT

\-- Reset work arrays (recommended)

FOR (i IN 1, 20)

integer_array\[i\] = 0

END FOR

FOR (i IN 1, 200)

real_array\[i\] = 0.0

END FOR

\-- Set RNG seed and \"not initialised\" flag

integer_array\[4\] = -1

integer_array\[5\] = 0

\-- Set binomial parameters for bnldev

integer_array\[6\] = n_trials \-- n

real_array\[101\] = p_succ \-- p

integer_array\[11\] = -1 \-- force recache of factorial-related terms

\-- Generate 200 binomial samples

FOR (i IN 1, N)

ran\[i\] = bnldev(integer_array, real_array)

END FOR

\-- Sort the samples (ascending order)

sort(ran, ran_ord)

END COMPONENT

In this example, each element of ran\[i\] is a random draw from Binomial(10, 0.3), taking integer values between 0 and 10 (stored as REAL). Running the component again with the same initial seed and state will reproduce the same sequence of binomial deviates. The array ran_ord stores all the random values generated but sorted from highest to lowest for better visualization.

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                bnldev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

With a probability of success of 0.3, out of 200 samples of 10 trials, there is one with eight successes and seven with no success. There are none with more than eight successes.

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_bnldev.default\\exp1\\Tab_1#BarGraph_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image36.png){width="6.495833333333334in" height="1.5016786964129485in"}

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_bnldev.default\\exp1\\Tab_1#BarGraph_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image37.png){width="6.495833333333334in" height="1.5121008311461068in"}

#### 2.3.7.2 Function c_bnldev

This function generates a pseudorandom deviate from a binomial distribution $Bin(n,p)$ using internal state stored in a real variable. The difference between this and bnldev (see §[2.3.7.1.](#function-bnldev) ) is that it is an external function programmed in C, and its parameters and usage vary slightly.

##### 2.3.7.2.1 Parameters

  ---------------------------------------------------------------------------------------------------------------------------
  NAME    TYPE          DESCRIPTION                                                                                   UNITS
  ------- ------------- --------------------------------------------------------------------------------------------- -------
  iseed   OUT INTEGER   Seed. Declared as OUT but IN/OUT, since it\'s read and updated by the call to the function.   \-

  n       IN INTEGER    Number of trials                                                                              \-

  pp      IN REAL       Probability of success                                                                        \-
  ---------------------------------------------------------------------------------------------------------------------------

##### 2.3.7.2.2 Formulation

The formulation of this function can be consulted at \[3\].

##### 2.3.7.2.3 Example

The following example shows the usage of the c_bnldev function and prints the results.

COMPONENT cbnldev_ex (INTEGER N = 5 \"Number of random numbers generated\")

\"Example: generate binomial deviates with c_bnldev\"

DATA

\-- Binomial parameters: X Bin(n_trials, p_succ)

INTEGER n_trials = 10 UNITS no_units \"Number of trials in the binomial distribution\"

REAL p_succ = 0.3 UNITS no_units \"Probability of success in each trial\"

DECLS

DISCR REAL ran\[N\] UNITS no_units \"Binomial samples X Bin(n_trials, p_succ) using the external function\"

INTEGER seed UNITS no_units \"Seed for the pseudorandom numbers generator\"

INIT

\-- Generate N binomial samples with the specified parameters

FOR (i IN 1, N)

ran\[i\] = c_bnldev(p_succ,n_trials,seed)

PRINT(realToString(ran\[i\]))

END FOR

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                cbnldev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

3

5

2

3

1

#### 2.3.7.3 Function expdev

This function generates a pseudorandom deviate from an exponential distribution with parameter $\lambda = 1$, and probability density function:

$p(x) = e^{- x},\ x \geq 0$

It uses the inverse transform method applied to a uniform random deviate U generated by ran1 (see §[2.3.7.11.](#function-c_poidev) ). Specifically, if $U \sim Uniform(0,1)$, then:

$$X = - \frac{1}{\lambda}\ log(U)\ $$

follows an exponential distribution with mean $\mu = 1/\lambda = 1$ and rate parameter $\lambda\  = \ 1$.

The internal state of the uniform generator is stored and updated in the work arrays integer_array and real_array, which must be preserved between calls.

If an exponential with parameter $\lambda \neq 1$ is needed, the returned value x can be scaled as:

$X_{\lambda} = \frac{1}{\lambda} \cdot x \sim Exp(\lambda)$

##### 2.3.7.3.1 Parameters

  ------------------------------------------------------------------------------------------------------------------------------------------------
  NAME                TYPE          DESCRIPTION                                                                                            UNITS
  ------------------- ------------- ------------------------------------------------------------------------------------------------------ -------
  integer_array\[\]   OUT INTEGER   Integer work array used as state for the underlying uniform RNG ran1 (seeds, flags, LCG states).       --

  real_array\[\]      OUT REAL      Real work array used as state for the underlying uniform RNG ran1 (shuffle table and cached values).   --
  ------------------------------------------------------------------------------------------------------------------------------------------------

Although declared as OUT in EL, both arrays are effectively IN/OUT, since they are read and updated by the call to ran1(integer_array, real_array).

They must be dimensioned large enough and kept between calls to continue the same pseudorandom sequence, which are sizes of at least:

- integer_array\[5\],

- real_array\[97\].

##### 2.3.7.3.2 Formulation

expdev implements the inverse transform method for an exponential distribution:

- Draw a uniform random number U in (0, 1) using ran1:

U=ran1(integer_array,real_array)

- Apply the exponential inverse CDF:

$$X = - log(U)\ $$

- Return X as the exponential deviate:

RETURN - log(ran1(integer_array, real_array))

Because ran1 never returns 0 or 1 exactly (only values strictly inside (0, 1)), the logarithm is well-defined (finite) and X is always non-negative.

##### 2.3.7.3.3 Return value

The function returns a REAL value:

- An exponential random deviate $X \geq 0$ with density $p(x) = e^{- x}$.

- The mean of this distribution is 1, and the variance is 1.

The randomness and reproducibility of the sequence depend on the state stored in integer_array and real_array and on how ran1 is seeded and used.

##### 2.3.7.3.4 Example

The following example component shows how to initialise the RNG state and generate a sequence of exponential random numbers with parameter $\lambda$ using expdev:

COMPONENT expdev_ex (INTEGER N = 100 \"Number of random numbers generated\") \"Example component using expdev to generate exponential random deviates\"

DATA

REAL lambda = 1

DECLS

INTEGER integer_array\[20\] \"Integer work array storing RNG state (seeds, flags, LCG states)\"

DISCR REAL real_array\[200\] \"Real work array storing shuffle table and cached values\"

DISCR REAL ran\[N\] \"Array of exponential samples Exp(lambda)\"

DISCR REAL ran_ord\[N\] \"Sorted array of exponential samples Exp(lambda)\"

INIT

\-- Recommended: initialise work arrays

FOR (i IN 1, 20)

integer_array\[i\] = 0

END FOR

FOR (i IN 1, 200)

real_array\[i\] = 0.0

END FOR

\-- Set RNG seed and \'not initialised\' flag for ran1

integer_array\[4\] = -1 \-- negative seed forces initialisation

integer_array\[5\] = 0 \-- generator not initialised yet

\-- Generate N exponential random samples using expdev

FOR (i IN 1, N)

ran\[i\] = 1/lambda\*expdev(integer_array, real_array)

END FOR

sort(ran,ran_ord)

END COMPONENT

Each ran\[i\] is a sample from an exponential distribution with PDF $p(x) = \lambda e^{- \lambda x}$. Running the component again with the same seed and initial conditions will generate the same sequence of exponential deviates, ensuring reproducibility.

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                expdev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_expdev.default\\exp1\\Tab_1#BarGraph_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image38.png){width="6.495833333333334in" height="1.516505905511811in"}

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_expdev.default\\exp1\\Tab_1#BarGraph_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image39.png){width="6.495833333333334in" height="1.5193985126859142in"}

#### 2.3.7.4 Function c_expdev

This function generates a pseudorandom deviate from an exponential distribution $Exp(1)$ using internal state stored in a real variable. The difference between this and expdev (see §[2.3.7.2.](#function-c_bnldev) ) is that it is an external function programmed in C, and its parameters and usage vary slightly.

##### 2.3.7.4.1 Parameters

  ---------------------------------------------------------------------------------------------------------------------------
  NAME    TYPE          DESCRIPTION                                                                                   UNITS
  ------- ------------- --------------------------------------------------------------------------------------------- -------
  iseed   OUT INTEGER   Seed. Declared as OUT but IN/OUT, since it\'s read and updated by the call to the function.   \-

  ---------------------------------------------------------------------------------------------------------------------------

##### 2.3.7.4.2 Formulation

The formulation of this function can be consulted at \[3\].

##### 2.3.7.4.3 Example

The following example shows the usage of the c_expdev function and prints the results.

COMPONENT cexpdev_ex (INTEGER N = 5 \"Number of random numbers generated\")

\"Example: generate exponential deviates with c_expdev\"

DATA

REAL lambda = 1 UNITS no_units \"Rate parameter lambda (\> 0) of the exponential distribution\"

DECLS

DISCR REAL ran\[N\] UNITS no_units \"Exponential samples X Exp(lambda) using the external function\"

INTEGER seed UNITS no_units \"Seed for the pseudorandom numbers generator\"

INIT

\-- Generate N exponential samples with the specified parameters

FOR (i IN 1, N)

ran\[i\] = 1/lambda\*c_expdev(seed)

PRINT(realToString(ran\[i\]))

END FOR

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                cexpdev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

1.29363490876562

0.563767896814526

1.12299841597841

2.88081699588673

0.289850220688005

#### 2.3.7.5 Function gamdev

This function generates a pseudorandom deviate from a gamma distribution with integer shape parameter using internal state stored in two work arrays. It returns a sample from a gamma distribution with:

- Shape parameter k= integer_array\[6\] (positive integer),

- Scale parameter $\theta\  = \ 1$,

that is, a Gamma(k, 1) distribution with probability density:

$$p(x) = \frac{x^{k - 1}e^{- x}}{\Gamma(k)},x \geq 0\ $$

For small integer shape k, the algorithm uses the product of uniforms; for larger k, it uses an acceptance--rejection method based on a normal approximation. The underlying uniform generator is ran1 (see §[2.3.7.11.](#function-c_poidev) ).

If a gamma with scale $\theta \neq 1$ is needed, the returned value x can be scaled as:

$$X_{\theta} = \theta \cdot x \sim \Gamma(k,\theta)$$

##### 2.3.7.5.1 Parameters

  --------------------------------------------------------------------------------------------------------------------------------------------------------------
  NAME                TYPE          DESCRIPTION                                                                                                          UNITS
  ------------------- ------------- -------------------------------------------------------------------------------------------------------------------- -------
  integer_array\[\]   OUT INTEGER   Integer work array. Must contain integer_array\[6\] = k (integer shape parameter). Also stores RNG state for ran1.   --

  real_array\[\]      OUT REAL      Real work array used as the state of the underlying uniform RNG ran1 (shuffle table and cached values).              --
  --------------------------------------------------------------------------------------------------------------------------------------------------------------

Although declared as OUT in EL, both arrays are effectively IN/OUT:

- They are read and updated on every call (through ran1).

- They must be dimensioned and preserved between calls to maintain a consistent pseudorandom sequence.

Typical dimensions used with the MATH random functions are:

- INTEGER integer_array\[20\]

- REAL real_array\[200\]

##### 2.3.7.5.2 Internal variables

  -----------------------------------------------------------------------------------------------------------------------------------------------------------
  NAME     TYPE   DESCRIPTION                                                                                                                         UNITS
  -------- ------ ----------------------------------------------------------------------------------------------------------------------------------- -------
  am       REAL   Auxiliary value, typically am=k-1, used in the rejection algorithm.                                                                 --

  e        REAL   Acceptance threshold in the outer rejection loop (updated from the candidate x and y).                                              --

  s        REAL   Scale-like parameter $s = \sqrt{2 \cdot \ (k - 1) + \ 1}$ used in the normal-approximation branch ($k \geq \ 6$).                   --

  v\[2\]   REAL   Auxiliary 2D vector used to sample a point inside the unit circle ($v\lbrack 1\rbrack^{2}\  + \ v\lbrack 2\rbrack^{2} \leq \ 1$).   --

  x        REAL   Gamma deviate returned by the function.                                                                                             --

  y        REAL   Ratio v\[2\] / v\[1\], used to build the candidate x in the rejection method.                                                       --
  -----------------------------------------------------------------------------------------------------------------------------------------------------------

The function also uses implicit loop counters (e.g. j) and repeatedly calls the uniform RNG ran1(integer_array, real_array).

##### 2.3.7.5.3 Formulation

- The gamma shape parameter is read from:

k=integer_array\[6\]

The function assumes k is a positive integer. It then branches depending on whether k\<6 or k$\geq$`<!-- -->`{=html}6.

- Case 1 -- Small shape k\<6: product of uniforms

For small integer shape k, the gamma deviate is generated by exploiting the fact that:

If $U_{1},\ldots,U_{k} \sim i.i.d.\ Uniform(0,1),\$then $- \log{\left( \prod_{i = 1}^{k}U_{i}\  \right) \sim Gamma(k,1)}$

IF (integer_array\[6\] \< 6) THEN

x = 1

FOR (j IN 1, integer_array\[6\])

x = x \* ran1(integer_array, real_array)

END FOR

x = - log(x)

Steps:

- Initialise x = 1.

- Multiply x by independent uniform deviates U_j = ran1(\...) for j = 1..k.

- Compute x = -log(x), which yields a gamma deviate with shape k and scale 1.

<!-- -->

- Case 2 -- General case $k \geq 6$: rejection method

For larger shape parameters (integer_array\[6\] $\geq$ 6), the function uses an acceptance--rejection algorithm based on a normal approximation to the gamma distribution.

The structure is:

ELSE

WHILE (ran1(integer_array, real_array) \> e)

WHILE (x \<= 0)

WHILE (v\[1\]\*\*2 + v\[2\]\*\*2 \> 1)

v\[1\] = 2 \* ran1(integer_array, real_array)

v\[2\] = 2 \* ran1(integer_array, real_array)

END WHILE

y = v\[2\] / v\[1\]

am = integer_array\[6\] - 1

s = sqrt(2 \* am + 1)

x = s + y + am

END WHILE

e = 1 + y\*\*2 \* exp(x / am - s \* y)

END WHILE

END IF

The logic can be summarised as:

- Generate a candidate x using a transformed normal-like variable:

- Draw a random point $(v\lbrack 1\rbrack,v\lbrack 2\rbrack)$ inside the unit circle ($v\lbrack 1\rbrack^{2}\  + \ v\lbrack 2\rbrack^{2} \leq \ 1$).

- Compute $y\  = \ v\lbrack 2\rbrack\ /\ v\lbrack 1\rbrack$ (a ratio of two nearly-normal variables).

- Set:

$am = k - 1$, $s = \sqrt{2am + 1}$, $x = s + y + am$

- This produces a candidate x related to a gamma distribution with shape k.

- The inner WHILE ($x \leq \ 0$) loop ensures only positive candidates are considered, as required for a gamma deviate.

- Compute acceptance threshold:

- Once x \> 0:

e = 1 + y\*\*2 \* exp(x / am - s \* y)

- This e defines an acceptance probability depending on the candidate x and auxiliary variable y.

- Acceptance--rejection test. An outer WHILE (ran1(\...) \> e) loop compares a fresh uniform deviate with e:

- If ran1 \<= e, the candidate x is accepted.

- Otherwise, a new candidate is generated and the process repeats.

When the outer loop terminates, x is a gamma deviate with shape k = integer_array\[6\] and scale 1.

##### 2.3.7.5.4 Return value

The function returns a REAL value x:

- A gamma-distributed random number $x \geq 0$ with:

- Shape parameter k = integer_array\[6\] (integer \>0),

- Scale parameter $\theta = 1$,

- Density function:

$$p(x) = \frac{x^{k - 1}e^{- x}}{\Gamma(k)},x \geq 0\ $$

If a gamma distribution with scale $\theta \neq 1$ is required, the user can multiply the returned value by $\theta$:

$$X_{\theta} = \theta \cdot x \sim Gamma(k,\theta)$$

##### 2.3.7.5.5 Example

The following example component shows how to initialise the RNG state and generate a sequence of gamma random deviates with integer shape k and scale theta:

COMPONENT gamdev_ex (INTEGER N = 100 \"Number of random numbers generated\")

\"Example component using gamdev to generate gamma random deviates\"

DATA

INTEGER k_shape = 5 UNITS no_units \"Gamma shape parameter k (integer \> 0)\"

REAL theta = 2.0 UNITS no_units \"Gamma scale parameter theta (\> 0)\"

DECLS

INTEGER integer_array\[20\] UNITS no_units \"Integer work array storing RNG state and gamma parameters\"

DISCR REAL real_array\[200\] UNITS no_units \"Real work array storing shuffle table and cached values\"

DISCR REAL ran\[N\] UNITS no_units \"Array of gamma samples Gamma(k_shape, theta)\"

DISCR REAL ran_ord\[N\] UNITS no_units \"Sorted array of gamma samples Gamma(k_shape, theta)\"

DISCR REAL c_ran\[N\] UNITS no_units \"Array of gamma samples Gamma(k_shape, theta) using the external function\"

INTEGER seed UNITS no_units \"Seed for the pseudorandom numbers generator\"

INIT

\-- Basic checks to ensure the parameters are valid

ASSERT (k_shape \> 0) ERROR \"k_shape must be positive in gamdev_ex \"

ASSERT (theta \> 0) ERROR \"theta must be positive in gamdev_ex \"

\-- Initialise work arrays (optional but recommended)

FOR (i IN 1, 20)

integer_array\[i\] = 0

END FOR

FOR (i IN 1, 200)

real_array\[i\] = 0.0

END FOR

\-- Set RNG seed and \'not initialised\' flag for ran1 (used by gamdev)

integer_array\[4\] = -1

integer_array\[5\] = 0

\-- Set gamma shape parameter k in integer_array\[6\] for gamdev

integer_array\[6\] = k_shape

\-- Generate N gamma samples:

\-- gamdev(\...) - Gamma(k_shape, 1)

\-- ran - Gamma(k_shape, theta) after scaling by theta

FOR (i IN 1, N)

ran\[i\] = theta \* gamdev(integer_array, real_array)

c_ran\[i\] = theta \* c_gamdev(k_shape, seed)

END FOR

\-- Sort gamma samples

sort(ran, ran_ord)

END COMPONENT

Each ran\[i\] is a gamma deviate with shape k_shape and scale theta. Running the component again with the same seed and initial conditions will produce exactly the same sequence, ensuring reproducibility.

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                gamdev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_gamdev.default\\exp1\\Tab_1#BarGraph_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image40.png){width="6.495833333333334in" height="1.3098140857392826in"}

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_gamdev.default\\exp1\\Tab_1#BarGraph_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image41.png){width="6.495833333333334in" height="1.3114916885389327in"}

#### 2.3.7.6 Function c_gamdev

This function generates a pseudorandom deviate from a gamma distribution $\Gamma(k,1)$ using internal state stored in a real variable. The difference between this and gamdev (see §[2.3.7.4.](#function-c_expdev) ) is that it is an external function programmed in C, and it works with different parameters.

##### 2.3.7.6.1 Parameters

  ---------------------------------------------------------------------------------------------------------------------------
  NAME    TYPE          DESCRIPTION                                                                                   UNITS
  ------- ------------- --------------------------------------------------------------------------------------------- -------
  ia      IN INTEGER    Shape parameter, k.                                                                           \-

  iseed   OUT INTEGER   Seed. Declared as OUT but IN/OUT, since it\'s read and updated by the call to the function.   \-
  ---------------------------------------------------------------------------------------------------------------------------

##### 2.3.7.6.2 Formulation

The formulation of this function can be consulted at \[3\].

##### 2.3.7.6.3 Example

The following example shows the usage of the c_gamdev function and prints the results.

COMPONENT cgamdev_ex (INTEGER N = 5 \"Number of random numbers generated\")

\"Example: generate gamma deviates with c_gamdev\"

DATA

INTEGER k_shape = 5 UNITS no_units \"Gamma shape parameter k (integer \> 0)\"

REAL theta = 2.0 UNITS no_units \"Gamma scale parameter theta (\> 0)\"

DECLS

DISCR REAL ran\[N\] UNITS no_units \"Gamma samples X Gamma(k_shape, theta) using the external function\"

INTEGER seed UNITS no_units \"Seed for the pseudorandom numbers generator\"

INIT

\-- Generate N gamma samples with the specified parameters

FOR (i IN 1, N)

ran\[i\] = theta \* c_gamdev(k_shape, seed)

PRINT(realToString(ran\[i\]))

END FOR

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                cgamdev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

12.3021368762666

11.3006986052333

16.4104774833952

12.9895529353141

9.54064573134195

#### 2.3.7.7 Function gammln

This function computes the natural logarithm of the gamma function of its argument:

$$f(x) = \ln\left( \Gamma(x) \right)\ $$

It implements a Lanczos-type approximation, which is a standard, numerically stable method for evaluating $\ln\left( \Gamma(x) \right)\$for positive real arguments.

##### 2.3.7.7.1 Parameters

  ----------------------------------------------------------------------------------------------------
  NAME   TYPE      DESCRIPTION                                                                 UNITS
  ------ --------- --------------------------------------------------------------------------- -------
  x      IN REAL   Input argument of the gamma function. The function computes ln(gamma(x)).   --

  ----------------------------------------------------------------------------------------------------

The function assumes x is a positive real number. Behaviour for non-positive values (e.g. $x \leq 0$) is not defined and may lead to invalid results.

##### 2.3.7.7.2 Internal variables

  -------------------------------------------------------------------------------------------------------------------------
  NAME        TYPE   DESCRIPTION                                                                                    UNITS
  ----------- ------ ---------------------------------------------------------------------------------------------- -------
  coef\[6\]   REAL   Coefficient array used by the Lanczos-type approximation.                                      --

  ser         REAL   Accumulator of the series term in the Lanczos approximation.                                   --

  tmp         REAL   Auxiliary variable used to build the main exponential/logarithmic term of the approximation.   --

  y           REAL   Shifted argument: y = x - 1, used to simplify the formula.                                     --
  -------------------------------------------------------------------------------------------------------------------------

##### 2.3.7.7.3 Formulation

The implementation follows a classical Lanczos approximation of $\ln\left( \Gamma(x) \right)$, using precomputed coefficients stored in coef\[1..6\].

- Set coefficients

The array coef\[1..6\] is initialised with fixed constants:

coef\[1\] = 76.18009173

coef\[2\] = - 86.50532033

coef\[3\] = 24.01409822

coef\[4\] = - 1.231739516

coef\[5\] = 0.120858003e-2

coef\[6\] = - 0.536382e-5

These constants define the particular Lanczos approximation used.

- Shift the argument

y = x - 1

The argument is shifted to simplify the polynomial/series part of the approximation.

- Compute the main term tmp

tmp = y + 5.5

tmp = tmp - (x + 0.5) \* log(tmp)

This builds a core term that will appear with a minus sign in the final result. It corresponds to the combination of the Gaussian-like factor and part of the normalisation in the Lanczos formula.

- Initialise the series accumulator

ser = 1.0

- Evaluate the series

FOR (j IN 1,5)

x = x + 1

ser = ser + coef\[j\] / x

END FOR

Inside the loop:

- The argument x is incremented,

- ser accumulates the terms coef\[j\] / x.

Note: coef\[6\] is not used explicitly in the loop; the final expression incorporates the effect of the full set of coefficients.

- Compute final value

At the end, the function returns:

$\ln\left( \Gamma(x) \right) \approx - tmp + \ln\left( \sqrt{2\pi} \cdot ser \right)$,

which in code is:

RETURN -tmp + log(2.50662827465 \* ser)

where 2.506... is approximately $\sqrt{2\pi}$.

##### 2.3.7.7.4 Return value

The function returns a REAL value:

- An approximation of $\ln\left( \Gamma(x) \right)$ (natural logarithm of the gamma function evaluated at x),

- Intended for positive arguments, and described as exact (within numerical precision) for values x \> 1.

This function is typically used internally in statistical and random-generation routines to avoid numerical overflow/underflow when working with large factorials or gamma-related expressions (e.g. log of factorials, binomial coefficients, etc.).

##### 2.3.7.7.5 Example

The following example component shows how to call gammln for a set of values and store the results:

COMPONENT gammln_ex (INTEGER N = 5 \"Number of points to evaluate\") \"Example component using gammln to compute ln(Gamma(x))\"

DATA

REAL x_values\[5\] = {1,2,3,4.5,5} \"Input values x \> 1 where ln(Gamma(x)) will be evaluated\"

DECLS

DISCR REAL lgamma_values\[N\] \"Computed values ln(Gamma(x)) = gammln(x)\"

INIT

\-- Compute ln(Gamma(x)) for each point

FOR (i IN 1, N)

lgamma_values\[i\] = gammln(x_values\[i\])

PRINT(\"ln(gamma(\"+realToString(x_values\[i\])+\")) = \"+realToString(lgamma_values\[i\]))

END FOR

END COMPONENT

This example can be used to compare gammln(x) with analytical values for simple cases (e.g. $\Gamma(1) = 1,\ \Gamma(2) = 1!,\ \Gamma(3) = 2!,\ \Gamma(3) = 2!$, etc.), or to feed more complex statistical computations.

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                gamln_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

ln(gamma(1)) = 0.749418920781474

ln(gamma(2)) = 1.33539514294171

ln(gamma(3)) = 2.35368855945613

ln(gamma(4.5)) = 4.43101150022822

ln(gamma(5)) = 5.23703283654163

#### 2.3.7.8 Function gasdev

This function generates pseudorandom numbers with a standard Gaussian (normal) distribution of mean 0 and variance 1, with probability density function:

$$p(x) = \frac{1}{\sqrt{2\pi}}e^{- x^{2}/2}$$

The implementation uses the Box--Muller / Marsaglia polar method based on pairs of independent uniform deviates generated by ran1 (see §[2.3.7.11.](#function-c_poidev) ). Each call produces two independent normal deviates internally, but only one is returned immediately; the other is stored in real_array\[121\] and returned on the next call. A flag in integer_array\[11\] indicates whether a stored deviate is available.

If a gaussian distribution with parameters $\mu \neq 0\$ or $\sigma \neq 1$, the returned value x can be scaled as:

$$X_{\mu,\sigma^{2}} = \sigma \cdot x + \mu \sim N\left( \mu,\sigma^{2} \right)$$

##### 2.3.7.8.1 Parameters

  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  NAME                TYPE          DESCRIPTION                                                                                                                              UNITS
  ------------------- ------------- ---------------------------------------------------------------------------------------------------------------------------------------- -------
  integer_array\[\]   OUT INTEGER   Integer work array used as state for the generator. Uses and updates integer_array\[11\] as a flag and also passes RNG state to ran1.    --

  real_array\[\]      OUT REAL      Real work array used as state for the generator. Uses and updates real_array\[121\] to store the second Gaussian deviate of each pair.   --
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Although declared as OUT in EL, both arrays are effectively IN/OUT:

- They are read and updated on each call.

- They must be preserved between calls to ensure consistent random sequences and correct reuse of the stored deviate.

Both arrays must be large enough to allow access to integer_array\[11\] and real_array\[121\].

##### 2.3.7.8.2 Internal variables

  -------------------------------------------------------------------------------------------------------------------------------------------------
  NAME              TYPE   DESCRIPTION                                                                                                      UNITS
  ----------------- ------ ---------------------------------------------------------------------------------------------------------------- -------
  v\[2\]            REAL   Auxiliary 2D vector $(v_{1},\ v_{2})$ sampled in the square $\lbrack - 1,1\rbrack \times \lbrack - 1,1\rbrack$   --

  ratio             REAL   Squared radius $r^{2} = v_{1}^{2} + v_{2}^{2}$, used to reject points outside the unit circle.                   --

  fac               REAL   Scaling factor $\sqrt{- 2\ln{(ratio)}/ratio}$ used in the Box--Muller transform.                                 --

  return_argument   REAL   Gaussian deviate returned by the function.                                                                       --
  -------------------------------------------------------------------------------------------------------------------------------------------------

Additionally:

- integer_array\[11\] is used as a flag:

  - 0: no stored deviate available; a new pair must be generated.

  - 1: one stored deviate is available in real_array\[121\].

- real_array\[121\] temporarily stores the second Gaussian deviate from the previous pair.

##### 2.3.7.8.3 Formulation

Gasdev implements the polar form of the Box--Muller transform. If first checks if a stored deviate is available

IF (integer_array\[11\] == 0) THEN

\...

ELSE

\...

END IF

If it\'s 0, no stored deviate is available. The function will generate a new pair of Gaussian deviates. Otherise, a previously stored deviate is available in real_array\[121\] and will be returned directly.

- Case 1 -- Generate a new pair of Gaussian deviates

When integer_array\[11\] == 0:

WHILE (ratio \>= 1)

v\[1\] = 2 \* ran1(integer_array, real_array) - 1

v\[2\] = 2 \* ran1(integer_array, real_array) - 1

ratio = v\[1\]\*\*2 + v\[2\]\*\*2

END WHILE

- Repeatedly generate pairs $(v_{1},\ v_{2})$ uniformly in the square $\lbrack - 1,1\rbrack \times \lbrack - 1,1\rbrack$ using ran1.

- Compute:

$$r^{2} = v_{1}^{2} + v_{2}^{2}$$

- Reject the pair if $ratio \geq \ 1$ (outside the unit circle), and repeat until a pair inside the unit disk is obtained. The accepted pair is uniformly distributed in the unit circle.

Then compute the scaling factor:

fac = sqrt(- 2 \* log(ratio) / ratio)

This is the Box--Muller polar transform factor. The two independent standard normal deviates are:

$z_{1} = v_{1} \cdot fac$, $z_{2} = v_{2} \cdot fac$

They are handled as follows:

integer_array\[11\] = 1

real_array\[121\] = v\[1\] \* fac

return_argument = v\[2\] \* fac

- integer_array\[11\] is set to 1 to indicate that a stored deviate is now available.

- real_array\[121\] stores $z_{1}\  = \ v\lbrack 1\rbrack\ *\ fac$ for the next call.

- return_argument is set to $z_{2}\  = \ v\lbrack 2\rbrack\ *\ fac$, which is returned on this call.

<!-- -->

- Case 2 -- Return stored deviate

When integer_array\[11\] != 0:

integer_array\[11\] = 0

return_argument = real_array\[121\]

- The flag is reset to 0 to indicate that the stored deviate has been consumed.

- return_argument is set to the previously stored value in real_array\[121\], which is the second Gaussian deviate of the last generated pair.

- No new random pair is generated in this branch, so every second call is cheaper: it just returns the stored deviate.

Finally, the function returns:

RETURN return_argument

which is a standard normal deviate with:

- Mean 0,

- Variance 1,

- Density $p(x) = \frac{1}{\sqrt{2\pi}}e^{- x^{2}/2}$.

##### 2.3.7.8.4 Return value

The function returns a REAL value, a pseudorandom sample from the standard normal distribution N(0,1).

##### 2.3.7.8.5 Example

The following example component shows how to initialise the RNG and generate a set of Gaussian random deviates using gasdev:

COMPONENT gasdev_ex (INTEGER N = 100 \"Number of samples to generate\")

\"Example component using gasdev to generate Gaussian random deviates\"

DATA

REAL mu = 0 \"Mean of the Gaussian distribution\"

REAL sigma = 1 \"Standard deviation of the Gaussian distribution\"

DECLS

INTEGER integer_array\[20\] \"Integer work array storing RNG state and gasdev internal flag\"

DISCR REAL real_array\[200\] \"Real work array storing shuffle table and cached values\"

DISCR REAL ran\[N\] \"Array of Gaussian samples N(mu, sigma\^2)\"

DISCR REAL ran_ord\[N\] \"Sorted array of Gaussian samples N(mu, sigma\^2)\"

INIT

\-- (Optional) initialise work arrays so the RNG state starts from a known value

FOR (i IN 1, 20)

integer_array\[i\] = 0

END FOR

FOR (i IN 1, 200)

real_array\[i\] = 0.0

END FOR

\-- Seed the underlying RNG used by ran1/gasdev

integer_array\[4\] = -1

integer_array\[5\] = 0

\-- Generate N Gaussian random samples:

\-- gasdev(\...) - N(0,1)

\-- ran\[i\] - N(mu, sigma\^2) after affine transformation

FOR (i IN 1, N)

ran\[i\] = mu + sigma \* gasdev(integer_array, real_array)

END FOR

\-- Sort Gaussian samples

sort(ran, ran_ord)

END COMPONENT

Each ran\[i\] is a sample from N(0,1). For a normal distribution with mean mu and standard deviation sigma, you can transform the result as:

$$X_{\mu,\sigma} = \mu + \sigma \cdot gasdev(\ldots)$$

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                gasdev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

With $\mu = 0,\sigma = 1$, the ordered results are the following:

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_gasdev.default\\exp1\\Tab_1#BarGraph_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image42.png){width="6.495833333333334in" height="1.2880150918635171in"}

Increasing the standard deviation to $\sigma = 2$, they are the following:

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_gasdev.default\\exp1\\Tab_1#BarGraph_2_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image43.png){width="6.495833333333334in" height="1.286910542432196in"}

#### 2.3.7.9 Function c_gasdev

This function generates a pseudorandom deviate from a gaussian distribution $N(0,1)$ using internal state stored in a real variable. The difference between this and gasdev (see §[2.3.7.8.](#function-gasdev) ) is that it is an external function programmed in C, and its parameters and usage vary slightly.

##### 2.3.7.9.1 Parameters

  ---------------------------------------------------------------------------------------------------------------------------
  NAME    TYPE          DESCRIPTION                                                                                   UNITS
  ------- ------------- --------------------------------------------------------------------------------------------- -------
  ia      IN INTEGER    Shape parameter, k.                                                                           \-

  iseed   OUT INTEGER   Seed. Declared as OUT but IN/OUT, since it\'s read and updated by the call to the function.   \-
  ---------------------------------------------------------------------------------------------------------------------------

##### 2.3.7.9.2 Formulation

The formulation of this function can be consulted at \[3\].

##### 2.3.7.9.3 Example

The following example shows the usage of the c_gasdev function and prints the results.

COMPONENT cgasdev_ex (INTEGER N = 5 \"Number of random numbers generated\")

\"Example: generate gaussian deviates with c_gasdev\"

DATA

REAL mu = 0 UNITS no_units \"Mean of the Gaussian distribution\"

REAL sigma = 1 UNITS no_units \"Standard deviation of the Gaussian distribution\"

DECLS

DISCR REAL ran\[N\] UNITS no_units \"Gaussian samples X N(mu, sigma\^2) using the external function\"

INTEGER seed UNITS no_units \"Seed for the pseudorandom numbers generator\"

INIT

\-- Generate N gaussian samples with the specified parameters

FOR (i IN 1, N)

ran\[i\] = sigma \* c_gasdev(seed) + mu

PRINT(realToString(ran\[i\]))

END FOR

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                cgasdev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

0.506912465905909

-1.65686229323634

-0.403419183159865

-0.158761854466592

-0.526755167590805

#### 2.3.7.10 Function poidev

This function generates pseudorandom integers following a Poisson distribution with mean (rate) parameter

$\lambda$=real_array\[101\]

The returned value is a non-negative integer $k \in \{ 0,1,2,\ldots\,\}$ with probability

$$P(K = k) = \frac{\lambda^{k}e^{- \lambda}}{k!}\ $$

The implementation uses two different algorithms depending on the value of $\lambda$:

- Direct (product) method for small $\lambda < 12$.

- Acceptance--rejection method based on a normal/gamma approximation for larger $\lambda \geq 12$.

Several intermediate values are cached in real_array to improve efficiency if poidev is called repeatedly with the same $\lambda$.

##### 2.3.7.10.1 Parameters

  ----------------------------------------------------------------------------------------------------------------------------------------------------------
  NAME                TYPE          DESCRIPTION                                                                                                      UNITS
  ------------------- ------------- ---------------------------------------------------------------------------------------------------------------- -------
  integer_array\[\]   OUT INTEGER   Integer work array. Used as RNG state for ran1 and as general work space. Must be preserved between calls.       --

  real_array\[\]      OUT REAL      Real work array. Must contain real_array\[101\] = lambda (Poisson mean). Uses real_array\[121..124\] as cache.   --
  ----------------------------------------------------------------------------------------------------------------------------------------------------------

Although declared as OUT in EL, both arrays are effectively IN/OUT, since they are read and updated on every call.

They must be dimensioned large enough to allow access to at least indices integer_array\[5\] as used by ran1 (see §[2.3.7.11.](#function-c_poidev) ) and real_array\[124\].

##### 2.3.7.10.2 Internal variables

  -----------------------------------------------------------------------------------------------------------
  NAME   TYPE   DESCRIPTION                                                                           UNITS
  ------ ------ ------------------------------------------------------------------------------------- -------
  em     REAL   Current Poisson deviate (candidate or final value). Conceptually an integer.          --

  t      REAL   Threshold / accumulator used in the direct and rejection methods.                     --

  y      REAL   Auxiliary variable used in the rejection method (related to the tangent transform).   --
  -----------------------------------------------------------------------------------------------------------

Some entries inside real_array:

- real_array\[101\] : Input mean $\lambda$ of the Poisson distribution.

- real_array\[121\] : Cached copy of $\lambda$ to detect changes between calls.

- real_array\[122\] : Cached value $\sqrt{2\lambda}$ used in the rejection method (for large $\lambda$).

- real_array\[123\] : Cached value log($\lambda$).

- real_array\[124\] : In the small $\lambda$ branch: $\exp{( - \lambda)}$; in the large-$\ \lambda$ branch: $\lambda^{2} - gammln(\lambda + 1)$.

These values avoid recomputing expensive operations (logarithms, square roots, gamma-logarithms) if poidev is called repeatedly with the same $\lambda$.

##### 2.3.7.10.3 Formulation

Let $\lambda = real\_ array\lbrack 101\rbrack$.

The function chooses the algorithm based on whether $\lambda < 12\$or $\lambda \geq 12$.

- Case 1 -- Small mean $\lambda < 12$: direct (product) method

  - If $\lambda$ has changed since the last call (real_array\[101\] != real_array\[121\]), the cache is updated:

  - real_array\[121\] = lambda

  - real_array\[124\] = exp(-lambda)

  - Initialise:

  - em = -1 (counter for events),

  - t = 1.0.

  - Loop:

  - At each iteration:

em = em + 1

t = t \* ran1(integer_array, real_array)

- The loop terminates once t \<= exp(-lambda).

This is the classic Knuth algorithm for Poisson deviates: it generates a number of uniform random variables until their product drops below exp(-lambda). The count em then follows a Poisson distribution with mean $\lambda$.

After this branch, em is the Poisson deviate.

- Case 2 -- Large mean $\ \lambda \geq 12$: rejection method

For larger means, the direct product method becomes inefficient. The code switches to an acceptance--rejection algorithm using an approximation based on a normal/gamma-like distribution.

- Cache update when $\lambda$ changes. If real_array\[101\] != real_array\[121\], recompute and store:

- real_array\[121\] = lambda

- real_array\[122\] = sqrt(2 \* lambda)

- real_array\[123\] = log(lambda)

- real_array\[124\] = lambda \* lambda - gammln(lambda + 1)

- Rejection loop. The algorithm uses a nested loop:

- Draw a uniform deviate; transform it via y = tan(PI \* ran1(\...)).

- Use y, $\sqrt{2\lambda}$ and $\lambda$ to form a preliminary candidate around the mean:

$$em = \sqrt{2\lambda} \cdot y \cdot \lambda$$

- Repeat until em $\geq$ 0, then em is projected to an integer with:

em = int(em)

- The acceptance threshold t is computed as:

t = 0.9 \* (1 + y\*\*2) \* exp(

em \* real_array\[101\]

\- gammln(em + 1.0)

\- real_array\[124\]

)

- This expression comes from comparing the target Poisson probability with an envelope function. It involves:

$gammln(em\  + \ 1.0) \approx \ln{(em!)}$

$$real\_ array\lbrack 124\rbrack \approx \lambda^{2}\  - \ln\left( \Gamma(\lambda\  + \ 1) \right)\ \ $$

$0.9\ \ (1\  + \ y^{2})$ (correction factor)

- The outer loop then compares:

WHILE (ran1(integer_array, real_array) \> t)

\...

END WHILE

- A new uniform deviate from ran1 is drawn; if it is greater than t, the candidate is rejected and a new one is proposed. If it is less than or equal to t, the candidate em is accepted.

After this branch, em is the accepted Poisson deviate.

##### 2.3.7.10.4 Return value

The function returns the INTEGER em, which is a Poisson-distributed random deviate with mean $\lambda$ = real_array\[101\].

For small $\lambda$, the result is produced by the direct multiplicative method, and for large $\lambda$, by a rejection method.

##### 2.3.7.10.5 Example

The following example component shows how to initialise the RNG state and generate a sequence of Poisson random deviates with a given mean lambda:

COMPONENT poidev_ex (INTEGER N = 100 UNITS no_units \"Number of Poisson samples to generate\") \"Example component using poidev to generate Poisson random deviates\"

DATA

REAL lambda = 4.0 UNITS no_units \"Mean (rate) of the Poisson distribution (lambda \> 0)\"

DECLS

INTEGER integer_array\[20\] UNITS no_units \"Integer work array storing RNG state and Poisson-related caches\"

DISCR REAL real_array\[200\] UNITS no_units \"Real work array storing shuffle table and cached values\"

INTEGER ran\[N\] UNITS no_units \"Array of Poisson samples Poisson(lambda)\"

INTEGER ran_ord\[N\] UNITS no_units \"Sorted array of Poisson samples Poisson(lambda)\"

INIT

ASSERT (lambda \> 0) ERROR \"lambda must be positive in poidev_ex \"

\-- Initialise work arrays (optional but recommended)

FOR (i IN 1, 20)

integer_array\[i\] = 0

END FOR

FOR (i IN 1, 200)

real_array\[i\] = 0.0

END FOR

\-- Seed the underlying RNG used by ran1/poidev

integer_array\[4\] = -1

integer_array\[5\] = 0

\-- Set Poisson mean lambda in real_array\[101\]

real_array\[101\] = lambda

\-- It is good practice to reset caches so poidev recomputes them

real_array\[121\] = -1.0

\-- Generate N Poisson samples with mean lambda

FOR (i IN 1, N)

ran\[i\] = poidev(integer_array, real_array)

END FOR

sort_int(ran,ran_ord)

END COMPONENT

Each ran\[i\] is a Poisson deviate with mean lambda. Running the component again with the same seed and initial state will reproduce the same sequence, ensuring reproducibility.

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                poidev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_poidev.default\\exp1\\Tab_1#BarGraph_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image44.png){width="6.495833333333334in" height="1.3208737970253719in"}

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_poidev.default\\exp1\\Tab_1#BarGraph_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image45.png){width="6.495833333333334in" height="1.3216994750656168in"}

#### 2.3.7.11 Function c_poidev

This function generates a pseudorandom deviate from a Poisson distribution $Poi(\lambda)$ using internal state stored in a real variable. The difference between this and poidev (see §[2.3.7.9.](#function-c_gasdev) ) is that it is an external function programmed in C, and its parameters and usage vary slightly.

##### 2.3.7.11.1 Parameters

  ----------------------------------------------------------------------------------------------------------------------------
  NAME     TYPE          DESCRIPTION                                                                                   UNITS
  -------- ------------- --------------------------------------------------------------------------------------------- -------
  lambda   IN INTEGER    Parameter                                                                                     \-

  iseed    OUT INTEGER   Seed. Declared as OUT but IN/OUT, since it\'s read and updated by the call to the function.   \-
  ----------------------------------------------------------------------------------------------------------------------------

##### 2.3.7.11.2 Formulation

The formulation of this function can be consulted at \[3\].

##### 2.3.7.11.3 Example

The following example shows the usage of the c_poidev function and prints the results.

COMPONENT cpoidev_ex (INTEGER N = 5 \"Number of random numbers generated\")

\"Example: generate Poisson deviates with c_poidev\"

DATA

REAL lambda = 4.0 UNITS no_units \"Mean (rate) of the Poisson distribution (lambda \> 0)\"

DECLS

DISCR REAL ran\[N\] UNITS no_units \"Poisson samples X Poi(lambda) using the external function\"

INTEGER seed UNITS no_units \"Seed for the pseudorandom numbers generator\"

INIT

\-- Generate N Poisson samples with the specified parameters

FOR (i IN 1, N)

ran\[i\] = c_poidev(lambda,seed)

PRINT(realToString(ran\[i\]))

END FOR

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                cpoidev_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

3

3

5

2

0

#### 2.3.7.12 Function ran1

This function generates pseudorandom numbers with uniform distribution in the interval (0, 1). It is based on a combination of three linear congruential generators (LCGs) and a 97-element shuffle table. The internal state of the generator is stored and updated in two work arrays: integer_array and real_array. Given the same initial state and the same sequence of calls, ran1 produces exactly the same sequence of numbers (deterministic pseudorandom generator).

It can be used as a building block for generating random numbers with different distributions.

If a uniform distribution in an interval (a,b) is needed, the returned value x can be scaled as:

$$X_{a,b} = (b - a) \cdot x + a \sim U(a,b)$$

##### 2.3.7.12.1 Parameters

  ------------------- ------------- ------------------------------------------------------------------------------------------------------------------- ------------
  NAME                TYPE          DESCRIPTION                                                                                                         UNITS

  integer_array\[\]   OUT INTEGER   Integer work array that stores the internal state of the RNG (seeds, flags, cached values).                         \-

  real_array\[\]      OUT REAL      Real work array that stores the shuffle table (real_array\[1..97\]) and may be shared with other random routines.   \-
  ------------------- ------------- ------------------------------------------------------------------------------------------------------------------- ------------

Although declared as OUT in EL, both arrays are effectively IN/OUT: they are read and updated on each call and must be preserved between calls to continue the sequence.

##### 2.3.7.12.2 Internal variables

  ---------- ----------- --------------------------------------------------------------------------------------------- ------------
  NAME       TYPE        DESCRIPTION                                                                                   UNITS

  IA1        INTEGER     First LCG multiplier (7141).                                                                  --

  IA2        INTEGER     Second LCG multiplier (8121).                                                                 --

  IA3        INTEGER     Third LCG multiplier (4561).                                                                  --

  IC1        INTEGER     First LCG increment (54773).                                                                  --

  IC2        INTEGER     Second LCG increment (28411).                                                                 --

  IC3        INTEGER     Third LCG increment (51349).                                                                  --

  j          INTEGER     Loop counter used during the initial fill of the shuffle table.                               --

  k          INTEGER     Index in the range \[1, 97\] selecting a position in the shuffle table real_array\[1..97\].   --

  M1         INTEGER     First LCG modulus (259200).                                                                   --

  M2         INTEGER     Second LCG modulus (134456).                                                                  --

  M3         INTEGER     Third LCG modulus (243000).                                                                   --

  RM1        REAL        Inverse of M1 (1/259200), used to scale integers to (0, 1).                                   --

  RM2        REAL        Inverse of M2 (1/134456), used as secondary scaling factor.                                   --

  temp       REAL        Temporary variable storing the random number that will be returned.                           --
  ---------- ----------- --------------------------------------------------------------------------------------------- ------------

##### 2.3.7.12.3 Formulation

- Initialisation of the random sequence:

  At the beginning of the function, the generator checks whether it must initialise the internal state:

  - If integer_array\[4\] \< 0 (seed \< 0) or integer_array\[5\] == 0 (not initialised), then:

  - integer_array\[5\] is set to 1 to mark the generator as initialised.

  - The initial states of the three LCGs are computed from the seed integer_array\[4\]:

    integer_array\[1\] is initialised modulo M1.

    integer_array\[2\] is derived from integer_array\[1\] modulo M2.

    integer_array\[3\] is derived from integer_array\[1\] modulo M3.

    Then, the shuffle table is filled:

  - For j = 1..97:

  - Update integer_array\[1\] using LCG 1:

integer_array\[1\] = remainder(IA1 \* integer_array\[1\] + IC1, M1)

- Update integer_array\[2\] using LCG 2:

integer_array\[2\] = remainder(IA2 \* integer_array\[2\] + IC2, M2)

- Combine and scale both states into a uniform deviate in (0, 1):

real_array\[j\] = (integer_array\[1\] + integer_array\[2\] \* RM2) \* RM1

Finally, integer_array\[4\] is set to 1 to indicate that the sequence has been seeded and the table initialised.

- Generation of a new random number

  Once the sequence is initialised, every call to ran1 performs:

  - Advance the three LCG states:

integer_array\[1\] = remainder(IA1 · integer_array\[1\] + IC1, M1)

integer_array\[2\] = remainder(IA2 · integer_array\[2\] + IC2, M2)

integer_array\[3\] = remainder(IA3 · integer_array\[3\] + IC3, M3)

- Compute a shuffle index k in the range \[1, 97\] to map the third LCG state into a table index.

$$k = 1 + \frac{97 \cdot integer\_ array\lbrack 3\rbrack}{M3}$$

- Take the current value at position k as the random number:

$$temp = real\_ array\lbrack k\rbrack\ $$

- Replace real_array\[k\] with a new combined LCG value:

$$real\_ array\lbrack k\rbrack = \left( integer\_ array\lbrack 1\rbrack + integer\_ array\lbrack 2\rbrack \cdot RM2 \right) \cdot RM1$$

- Return temp as the final uniform random number in (0, 1).

The use of the shuffle table reduces correlations in the sequence compared to a single LCG.

##### 2.3.7.12.4 Return value

The function returns a REAL value temp in the interval (0, 1), which is a pseudorandom deviate from a uniform distribution, based on the current internal state stored in integer_array and real_array.

- If not initialized, seeds are generated.

- On each call, new values are computed and stored cyclically.

##### 2.3.7.12.5 Example 1

The following example component shows how to initialise and use ran1 to generate a sequence of uniform random numbers between a min and a max:

COMPONENT ran1_ex (INTEGER N = 100 \"Number of random numbers generated\")

\"Example component using ran1 to generate uniform random numbers\"

DATA

REAL min = 0 \"Minimum value generated\"

REAL max = 1 \"Maximum value generated\"

DECLS

INTEGER integer_array\[5\] \"Integer work array storing RNG state: seeds, flags and LCG states\"

DISCR REAL real_array\[97\] \"Real work array storing the 97-element shuffle table\"

DISCR REAL ran\[N\] \"Array of uniform random numbers in (0,1) generated by ran1\"

DISCR REAL ran_ord\[N\] \"Sorted array of uniform random numbers generated by ran1\"

INIT

\-- Mark generator as \'not initialised\' and set a negative seed

\-- integer_array\[4\] \< 0 =\> force initialisation on first call

\-- integer_array\[5\] = 0 =\> flag: RNG not initialised yet

integer_array\[4\] = -1

integer_array\[5\] = 0

\-- First call (i = 1): initialises the generator and fills the shuffle table

\-- Subsequent calls (i = 2..N): continue the pseudorandom sequence

FOR (i IN 1, N)

ran\[i\] = ran1(integer_array, real_array)\*(max - min) + min

END FOR

\-- Sort the samples.

sort(ran, ran_ord, FALSE)

END COMPONENT

This component initialises the random generator with a fixed seed (-1) and then generates six uniform random numbers. Re-running the component with the same seed and initial conditions will produce the same sequence, ensuring reproducibility.

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                ran1_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_ran1.default\\exp1\\Tab_1#BarGraph_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image46.png){width="6.143940288713911in" height="2.7568569553805773in"}

Increasing the sample to 100 values, and modifying min = -1, max=3, the ordered array is the following:

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_ran1.default\\exp1\\Tab_1#BarGraph_3_2.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image47.png){width="6.495833333333334in" height="1.3758902012248468in"}

##### 2.3.7.12.6 Example 2

The following example component shows how to reset ran1 to generate two equal sequences of three uniform random numbers each:

COMPONENT ran1_reset_ex \"Example component using ran1 to generate uniform random numbers\"

DECLS

INTEGER integer_array\[5\] \"Integer work array storing RNG state (seeds, flags, LCG states)\"

DISCR REAL real_array\[97\] \"Real work array storing shuffle table and other cached values\"

DISCR REAL ran\[6\] \"Random numbers\"

INIT

\-- Mark generator as \"not initialised\" yet

integer_array\[4\] = -1

integer_array\[5\] = 0

\-- First call (i=1): initialises the generator and fills the shuffle table

\-- Subsequent calls (i=2,3): continue the sequence using the updated state

FOR (i IN 1,3)

ran\[i\] = ran1(integer_array, real_array)

END FOR

\-- Reset the generator

integer_array\[4\] = -1

\-- First call (i=4): initialises the generator and fills the shuffle table

\-- Subsequent calls (i=5,6): continue the sequence using the updated state

FOR (i IN 4,6)

ran\[i\] = ran1(integer_array, real_array)

END FOR

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                ran1_reset_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

Since the generator was reset after generating the third random, ran\[4\] = ran\[1\], ran\[5\] = ran\[2\] and ran\[6\] = ran\[3\].

![C:\\Users\\LPU\\OneDrive - EEAA\\Documentos\\SIMULATIONS\\LIBRARIES\\MATH_EXAMPLES\\experiments\\comp_ran1.default\\exp1\\Tab_1#BarGraph_2_1.png](C:\Users\LPU\EcosimPro\02_Toolkits\STANDARD_DEMO\docs_md\MATH\source_files\MATH_Library_Reference_Manual_media/media/image48.png){width="5.818182414698163in" height="2.610685695538058in"}

#### 2.3.7.13 Function c_ran1

This function generates a pseudorandom deviate from a uniform distribution $U(0,1)$ using internal state stored in a real variable. The difference between this and ran1 (see §[2.3.7.11.](#function-c_poidev) ) is that it is an external function programmed in C, and its parameters and usage vary slightly.

##### 2.3.7.13.1 Parameters

  ---------------------------------------------------------------------------------------------------------------------------
  NAME    TYPE          DESCRIPTION                                                                                   UNITS
  ------- ------------- --------------------------------------------------------------------------------------------- -------
  a       IN REAL       Lower bound of the interval                                                                   \-

  b       IN REAL       Upper bound of the interval                                                                   \-

  iseed   OUT INTEGER   Seed. Declared as OUT but IN/OUT, since it\'s read and updated by the call to the function.   \-
  ---------------------------------------------------------------------------------------------------------------------------

##### 2.3.7.13.2 Formulation

The formulation of this function can be consulted at \[3\].

##### 2.3.7.13.3 Example

The following example shows the usage of the c_poidev function and prints the results.

COMPONENT cran1_ex (INTEGER N = 5 \"Number of random numbers generated\")

\"Example: generate uniform deviates with c_ran1\"

DATA

REAL a = 0 UNITS no_units \"Lower bound of the interval\"

REAL b = 2 UNITS no_units \"Upper bound of the interval\"

DECLS

DISCR REAL ran\[N\] UNITS no_units \"Uniform samples X U(a,b) using the external function\"

INTEGER seed UNITS no_units \"Seed for the pseudorandom numbers generator\"

INIT

\-- Generate N uniform samples with the specified parameters

FOR (i IN 1, N)

ran\[i\] = c_ran1(seed)\*(b-a) + a

PRINT(realToString(ran\[i\]))

END FOR

END COMPONENT

**Experiment configuration**

  ----------------------------------- -----------------------------------
  Name                                cran1_ex.default.exp1

  Type                                Steady

  Convergence criteria                RELTOL
  ----------------------------------- -----------------------------------

**Results**

0.548544030444215

1.13812171337936

0.650605874635109

0.112177839386348

1.49675130074908

### 2.3.8 CSV to table conversion

#### 2.3.8.1 Function csv_to_tab1d

This function allows converting a CSV file to a table object.

Each time this function is executed, an auxiliary CSV file with the same name as the original and the suffix \_aux is generated in the same path.

##### 2.3.8.1.1 Parameters

  -----------------------------------------------------------------------------------------
  NAME         TYPE          DEFAULT   DESCRIPTION                                  UNITS
  ------------ ------------- --------- -------------------------------------------- -------
  col1         IN INTEGER              Index of the first column                    \-

  col2         IN INTEGER              Index of the second column                   \-

  file         IN FILEPATH             CSV file                                     \-

  headerRows   IN INTEGER    1         Number of header rows to avoid. Default: 1   \-

  sep          IN STRING     \",\"     Separator. Default: comma.                   \-

  tab          OUT TABLE               Output table                                 \-
  -----------------------------------------------------------------------------------------

##### 2.3.8.1.2 Internal variables

  --------------------------------------------------------------------------------
  NAME         TYPE     DESCRIPTION                                    UNITS
  ------------ -------- ---------------------------------------------- -----------
  file_aux     STRING   Auxiliar file to fill in the table             \-

  string_aux   STRING   Auxiliar string to fill in the auxiliar file   \-
  --------------------------------------------------------------------------------

##### 2.3.8.1.3 Objects

  ---------------------------------------------------------------------------------
  NAME   TYPE            DESCRIPTION                                       UNITS
  ------ --------------- ------------------------------------------------- --------
  csv    EFileCsv        CSV class instance to generate the auxiliar CSV   \-

  fi     PARSER_FILE     Parser file class instance for reading            \-

  str    PARSER_STRING   Parser string class instance for writing          \-
  ---------------------------------------------------------------------------------

##### 2.3.8.1.4 Return value

This function returns the table object tab, containing the columns col1 and col2 of the CSV in file.

##### 2.3.8.1.5 Example

The following example csv_to_tab1d to fill in the table tab with the first and third column of the CSV csv_example. Then, it interpolates it in time with the interp1d method.

This CSV uses commas as separators (sep = \",\") and has no header (headerRows = 0).

COMPONENT csv_to_tab1d_ex

DATA

FILEPATH fpath = \"@MATH_EXAMPLES@/tables/csv_example.csv\"

DECLS

REAL y

OBJECTS

TABLE tab

INIT

csv_to_tab1d(fpath,1,3,tab,\",\",0)

CONTINUOUS

y = tab.interpd1D(TIME)

END COMPONENT

#### 2.3.8.2 Function csv_to_ntab1d

This function allows converting a CSV file to multiple table objects.

Each time this function is executed, an auxiliary CSV file with the same name as the original and the suffix \_aux is generated in the same path.

##### 2.3.8.2.1 Parameters

  --------------------------------------------------------------------------------------------------------------------------------------------------------------------
  NAME          TYPE          DEFAULT   DESCRIPTION                                                                                                            UNITS
  ------------- ------------- --------- ---------------------------------------------------------------------------------------------------------------------- -------
  cols\[N+1\]   IN INTEGER              Array containing N+1 column indexes. The first element in this array corresponds to the first column of every table.   \-

  file          IN FILEPATH             CSV file                                                                                                               \-

  headerRows    IN INTEGER    1         Number of header rows to avoid. Default: 1                                                                             \-

  sep           IN STRING     \",\"     Separator. Default: comma.                                                                                             \-

  tab\[N\]      OUT TABLE               Output N tables                                                                                                        \-
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------

##### 2.3.8.2.2 Internal variables

  ---------------------------------------------------------------------------------
  NAME         TYPE      DESCRIPTION                                    UNITS
  ------------ --------- ---------------------------------------------- -----------
  file_aux     STRING    Auxiliar file to fill in the table             \-

  N            INTEGER   Number of output tables                        \-

  string_aux   STRING    Auxiliar string to fill in the auxiliar file   \-
  ---------------------------------------------------------------------------------

##### 2.3.8.2.3 Objects

  -------------------------------------------------------------------------------------
  NAME    TYPE            DESCRIPTION                                       UNITS
  ------- --------------- ------------------------------------------------- -----------
  csv     EFileCsv        CSV class instance to generate the auxiliar CSV   \-

  fi      PARSER_FILE     Parser file class instance for reading            \-

  str     PARSER_STRING   Parser string class instance for writing          \-
  -------------------------------------------------------------------------------------

##### 2.3.8.2.4 Return value

This function returns N table objects tab\[1\],...,tab\[N\] , containing the columns cols\[1\] and, respectively, cols\[2\],..,cols\[N+1\] of the CSV file.

##### 2.3.8.2.5 Example

The following example uses csv_to_ntab1d to create the array of tables tab\[2\]. The first one consists of columns 1 and 3 and the second of columns 1 and 4. This CSV uses commas as separators (sep = \",\") and has no header (headerRows = 0). Then, these tables are interpolated in time using interp1D.

COMPONENT csv_to_ntab1d_ex

DATA

FILEPATH fpath = \"@MATH_EXAMPLES@/tables/csv_example.csv\"

INTEGER cols\[3\] = {1,3,4}

DECLS

REAL y

REAL z

OBJECTS

TABLE tab\[2\]

INIT

csv_to_ntab1d(fpath,cols,tab,\",\",0)

CONTINUOUS

y = tab\[1\].interpd1D(TIME)

z = tab\[2\].interpd1D(TIME)

END COMPONENT

## 2.4 MATH Macros

This section describes the macros included in the MATH/include/macros.el file. These macros are designed to facilitate the handling of vectors, matrices, and tensors.

Remember that there are a series of linear algebra classes, described in \[1\], chapter 25, \`\`Linear algebra classes.\'\'

This section includes a brief description of each of the macros.

In general, these macros have been added to facilitate the most basic operations with arrays, such as scalar or vector products, matrix sums, calculation of the determinant of a 3x3 matrix, etc. Two different approaches have been taken to create them:

- Some of the macros return a single component of the array they calculate. Their input parameters are the numbers that define the position of this component. They are described in §[2.4.1.1.](#macros-that-return-a-value)

- Other macros return an entire array, which must be included among the macro parameters. They are described in §[2.4.1.2.](#macros-that-fill-an-array)

- In either case, some of the macro names contain the suffix \_en. This means that it is used to work with macros that have been dimensioned with enumerative type variables, which will have to be added as a macro parameter.

### 2.4.1 Overview

#### 2.4.1.1 Macros that return a value

  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Name                   Parameters                                          Description
  ---------------------- --------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------
  CROSS_i/CROSS_en_i     (V1, V2, i) / (enu_var, V1, V2, i)                  Calculates the i-th component of the cross product of two 3D vectors V1 and V2 (with/without enumeration enu_var).

  CROSS3_i               (V1, V2, V3, i)                                     Calculates the i-th component of the triple vector V1 $\times$ (V2 $\times$ V3).

  CROSS3B_i              (V1, V2, V3, i)                                     Calculates the i-th component of the triple vector (V1 $\times$ V2) $\times$ V3.

  DINV_i                 (Dia, i)                                            Calculates the i-th diagonal element of the inverse of a diagonal matrix Dia.

  DV_i                   (Dia, V1, i)                                        Calculates the i-th component of the product between a diagonal matrix Dia and a vector V1.

  MADD_ij                (M1, M2, i, j)                                      Calculates the (i,j)-th component of the sum of two matrices M1 and M2.

  MMUL_ij/MMUL_en_ij     (c, M1, M2, i, j) / (enu_var, M1, M2, i, j)         Calculates the (i,j)-th component of the product between two matrices M1 and M2 (with/without enumeration enu_var).

  MSMUL_ij               (k, M1, i, j)                                       Calculates the (i,j)-th component of the product between scalar k and matrix M1.

  MV_i/MV_en_i           (c, M1, V1, i) / (enu_var, M1, V1, i)               Calculates the i-th component of the product between matrix M1 and vector V1 (with/without enumeration or dimension c).

  TT_x_ijk/TT_x_en_ijk   (N, T1, T2, i, j, k) / (enu_var, T1, T2, i, j, k)   Calculates the (i,j,k)-th component of the tensor contraction over x between tensors T1 and T2 (with/without enumeration enu_var).

  TT_y_ijk/TT_y_en_ijk   (N, T1, T2, i, j, k) / (enu_var, T1, T2, i, j, k)   Calculates the (i,j,k)-th component of the tensor contraction over y between tensors T1 and T2 (with/without enumeration enu_var).

  TT_z_ijk/TT_z_en_ijk   (N, T1, T2, i, j, k) / (enu_var, T1, T2, i, j, k)   Calculates the (i,j,k)-th component of the tensor contraction over z between tensors T1 and T2 (with/without enumeration enu_var).

  VADD_i                 (V1, V2, i)                                         Calculates the i-th component of the sum of two n-dimensional vectors V1 and V2.

  VSMUL_i                (k, V1, i)                                          Calculates the i-th component of the product between scalar k and vector V1.
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### 2.4.1.2 Macros that fill an array

  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Name             Parameters                                      Description
  ---------------- ----------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------
  CROSS/CROSS_en   (V1, V2, V3) / (enu_var, V1, V2, V3)            Calculates the cross product of two 3D vectors V1 and V2, storing the result in V3 (with/without enumeration enu_var).

  CROSS3           (V1, V2, V3, V4)                                Calculates the triple vector V1 $\times$ (V2 $\times$ V3), storing the result in V4.

  CROSS3B          (V1, V2, V3, V4)                                Calculates the triple vector (V1 $\times$ V2) $\times$ V3, storing the result in V4.

  DET/DET_en       (M1) / (enu_var, M1)                            Calculates the determinant of a 3$\times$`<!-- -->`{=html}3 matrix M1 (with/without enumeration enu_var).

  DINV             (N, Dia, Inv)                                   Calculates the inverse of a diagonal matrix Dia of size N$\times$N, storing the result in Inv.

  DOT/DOT_en       (N, V1, V2) / (enu_var, V1, V2)                 Calculates the scalar (dot) product of two N-dimensional vectors V1 and V2 (with/without enumeration enu_var).

  DV               (N, Dia, V1, V2)                                Calculates the product between a diagonal matrix Dia and a vector V1, storing the result in V2.

  MADD             (r, c, M1, M2, M3)                              Adds two r$\times$c matrices M1 and M2 and stores the result in M3.

  MINV/MINV_en     (Mat, Inv) / (enu_var, Mat, Inv)                Calculates the inverse of a 3$\times$`<!-- -->`{=html}3 matrix Mat, storing it in Inv (with/without enumeration enu_var).

  MMUL/MMUL_en     (r, n, c, M1, M2, M3) / (enu_var, M1, M2, M3)   Calculates the product between matrices M1 (r$\times$n) and M2 (n$\times$c), storing the result in M3 (with/without enumeration enu_var).

  MSMUL            (r, c, k, M1, M2)                               Calculates the product between scalar k and an r$\times$c matrix M1, storing the result in M2.

  MV/MV_en         (r, c, M1, V1, V2) / (enu_var, M1, V1, V2)      Calculates the product between an r$\times$c matrix M1 and a c-dimensional vector V1, storing the result in V2 (with/without enumeration enu_var).

  NORM/NORM_en     (N, V1) / (enu_var, V1)                         Calculates the Euclidean norm of an N-dimensional vector V1 (with/without enumeration enu_var).

  SKEW/SKEW_en     (V, M) / (enu_var, V, M)                        Calculates the 3$\times$`<!-- -->`{=html}3 skew-symmetric matrix M associated with a 3D vector V (with/without enumeration enu_var).

  TT_x/TT_x_en     (N, T1, T2, T3) / (enu_var, T1, T2, T3)         Calculates the tensor contraction over x between tensors T1 and T2, storing the result in T3 (with/without enumeration enu_var).

  TT_y/TT_y_en     (N, T1, T2, T3) / (enu_var, T1, T2, T3)         Calculates the tensor contraction over y between tensors T1 and T2, storing the result in T3 (with/without enumeration enu_var).

  TT_z/TT_z_en     (N, T1, T2, T3) / (enu_var, T1, T2, T3)         Calculates the tensor contraction over z between tensors T1 and T2, storing the result in T3 (with/without enumeration enu_var).

  VADD/VADD_en     (N, V1, V2, V3) / (enu_var, V1, V2, V3)         Adds two vectors V1 and V2 of length N and stores the result in V3 (with/without enumeration enu_var).

  VSMUL            (N, k, V1, V2)                                  Calculates the product between scalar k and an N-dimensional vector V1, storing the result in V2.
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 2.4.2 How to use the MATH Macros

To use macros, it is not enough to import the MATH library; you must also include its file by writing at the top of the EL file you are working on:

#include \"@MATH@/include/macros.el\"

This file includes the import of MATH, so there is no need to import it on another line to use its units or any of its other elements.

The difference between a macro and a function is that a macro is a code substitution before compilation, while a function is an element of the language that the compiler understands as such and the solver evaluates at simulation time.

The main advantage of a macro over a function is that, since all the code is written within the component itself, it allows EcosimPro to detect major mathematical problems such as algebraic boxes which, depending on how they are written, can be skipped when functions are called.

### 2.4.3 Examples

#### 2.4.3.1 Example 1: sum of two vectors

This example shows how to compute the sum of two 3D vectors defined over an enumeration. The result is obtained both with an EXPAND loop and with the VADD_en macro, allowing a direct comparison between explicit indexed code and the macro-based implementation.

#include \"@MATH@/include/macros.el\"

ENUM axes = {X, Y, Z}

COMPONENT VelSum3D

DATA

REAL v_body\[axes\] = { 10.0, 0.0, 0.0 } UNITS u_m_s \"Velocity of the body\"

REAL v_wind\[axes\] = { -2.0, 1.0, 0.0 } UNITS u_m_s \"Relative velocity of the wind\"

DECLS

REAL v_rel\[axes\] UNITS u_m_s \"Relative velocity of the body\"

REAL v_rel_m\[axes\] UNITS u_m_s \"Relative velocity of the body (calculated using macros)\"

CONTINUOUS

\-- v_rel = v_body + v_wind

\-- Calculation using expand

EXPAND (i IN axes)

v_rel\[i\] = ( v_body\[i\] + v_wind\[i\] )

\-- Calculation using macros

VADD_en(axes, v_body, v_wind, v_rel_m)

END COMPONENT

#### 2.4.3.2 Example 2: cross product of two vectors

This example shows how to calculate the cross product of two 3D vectors to obtain the resulting torque. The operation is implemented both explicitly with EXPAND and index manipulation, and with the CROSS_en macro.

#include \"@MATH@/include/macros.el\"

ENUM axes = {X, Y, Z}

COMPONENT Torque3D

DATA

REAL r\[axes\] = { 0.0, 0.0, 1.0 } UNITS u_m \"Lever arm of 1 m in Z axis\"

REAL F\[axes\] = { 5.0, 0.0, 0.0 } UNITS u_N \"Applied force of 5 N in X axis\"

DECLS

REAL tau\[axes\] UNITS u_Nm \"Resulting torque\"

REAL tau_m\[axes\] UNITS u_Nm \"Resulting torque (calculated using macros)\"

CONTINUOUS

\-- tau = r x F

\-- Calculation using expand

EXPAND (i IN 1,3)

tau\[setofElem(axes,i)\] = (r\[setofElem(axes,remainder(i+1,3,FALSE))\] \* F\[setofElem(axes,remainder(i+2,3,FALSE))\] \\

\- r\[setofElem(axes,remainder(i+2,3,FALSE))\] \* F\[setofElem(axes,remainder(i+1,3,FALSE))\])

\-- Calculation using macros

CROSS_en(axes, r, F, tau_m)

END COMPONENT

#### 2.4.3.3 Example 3: product between a matrix and a vector

This example shows how to compute the product of a square matrix and a vector to obtain a generalized force vector. The same operation is written using an explicit summation with EXPAND and using the MV macro.

#include \"@MATH@/include/macros.el\"

COMPONENT GeneralizedForce (INTEGER N = 3 \"Number of components\")

DATA

REAL M\[3,3\] = {{ 1.0, 0.0, 0.0 },

{ 0.0, 2.0, 0.0 },

{ 0.0, 0.0, 3.0 }} UNITS u_kg \"Generalized mass matrix\"

REAL a\[3\] = { 0.1, 0.2, 0.3 } UNITS u_m_s2 \"Generalized accelerations\"

DECLS

REAL F\[N\] UNITS u_N \"Generalized force\"

REAL F_m\[N\] UNITS u_N \"Generalized force (calculated using macros)\"

CONTINUOUS

\-- F = M · a

\-- Calculation using expand

EXPAND (i IN 1,N)

F\[i\] = SUM(j IN 1,N; M\[i,j\]\*a\[j\] )

\-- Calculation using macros

MV(N, N, M, a, F_m)

END COMPONENT

#### 2.4.3.4 Example 4: tensor contraction over x

This example shows how to perform a tensor contraction between two third-order tensors along the x-direction. The result is obtained both with nested EXPAND statements and with the TT_x macro.

#include \"@MATH@/include/macros.el\"

COMPONENT TensorProductX

DATA

REAL A\[3,3,3\] = {

{ {1.0, 1.0, 1.0}, {1.0, 1.0, 1.0}, {1.0, 1.0, 1.0} },

{ {1.0, 1.0, 1.0}, {1.0, 1.0, 1.0}, {1.0, 1.0, 1.0} },

{ {1.0, 1.0, 1.0}, {1.0, 1.0, 1.0}, {1.0, 1.0, 1.0} }

} UNITS no_units \"Input tensor A\"

REAL B\[3,3,3\] = {

{ {1.0, 0.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 0.0, 1.0} },

{ {1.0, 0.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 0.0, 1.0} },

{ {1.0, 0.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 0.0, 1.0} }

} UNITS no_units \"Input tensor B\"

DECLS

REAL T\[3,3,3\] UNITS no_units \"Resulting tensor T\"

REAL T_m\[3,3,3\] UNITS no_units \"Resulting tensor T (calculated using macros)\"

CONTINUOUS

\-- Calculation using expand

EXPAND (i IN 1,3)

EXPAND (j IN 1,3)

EXPAND (k IN 1,3)

T\[i,j,k\] = SUM(l IN 1,3; A\[i,j,l\]\*B\[i,l,k\] )

\-- Calculation using macros

TT_x(3, A, B, T_m)

# 3 References

\[1\] EL modelling Languaje

\[2\] EL user manual

\[3\] *Numerical recipes in C. The art of scientific computing*. William H. Press, William T. Vetterling. Cambridge University Press - 9780521431088

\[4\] EcosimPro Simulation Guide
