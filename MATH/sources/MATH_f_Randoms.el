--------------------------------------------------------------------------------
-- EA Internacional    EcosimPro Simulation Source Code
--
--    FILE NAME:  MATH_f_Randoms.el
--    FILE TYPE:  External objects and functions of the MATH library
--    DESCRIPTION:  Defines math functions for the MATH library
--    NOTES:  Based on EcosimPro MATH library
--    AUTHOR:  Ramon Perez Vara
--    CREATION DATE:  12-Jan-2004
--------------------------------------------------------------------------------


-- External Objects
--------------------------------------------------------------------------------
-- Purpose:
--    To declare in EcosimPro Language some C functions from the book
--    "Numerical Recipes in C", that calculate random numbers.
--------------------------------------------------------------------------------
"C" FUNCTION REAL c_ran1
   (
   OUT INTEGER iseed "Seed"
   )  "Function to generate a pseudorandom deviate from a uniform distribution in the interval (0,1)" IN "MATH.lib"   

"C" FUNCTION REAL c_gasdev
   (
   OUT INTEGER iseed "Seed"
   )  "Function to generate a pseudorandom deviate from a normal distribution N(0,1)" IN "MATH.lib"

"C" FUNCTION REAL c_poidev
   (
   IN REAL xm        "Parameter",
   OUT INTEGER iseed "Seed"
   )  "Function to generate a pseudorandom deviate from a Poisson distribution Poi(xm)" IN "MATH.lib"

"C" FUNCTION REAL c_bnldev
   (
   IN REAL pp        "Probability of success",
   IN INTEGER n      "Number of trials",
   OUT INTEGER iseed "Seed"
   )  "Function to generate a pseudorandom deviate from a binomial distribution B(n,pp)" IN "MATH.lib"

"C" FUNCTION REAL c_gamdev
   (
   IN INTEGER ia     "Shape parameter",
   OUT INTEGER iseed "Seed"
   )  "Function to generate a pseudorandom deviate from a gamma distribution Gamma(ia,1)" IN "MATH.lib"

"C" FUNCTION REAL c_expdev
   (
   OUT INTEGER iseed "Seed"
   )  "Function to generate a pseudorandom deviate from an exponential distribution Exp(1)" IN "MATH.lib"


-- Functions

--------------------------------------------------------------------------------
-- Function gammln
--------------------------------------------------------------------------------
-- Purpose:
--    Function calculating the natural logarithm of the gamma function of its
--    argument, that is: f(x) = ln(gamma(x)). This is an exact function only
--    for values x > 1.
--------------------------------------------------------------------------------
FUNCTION REAL gammln
   (
   IN REAL x      "Input value"
   )  "Function calculating the natural logarithm of the gamma function of its argument"

   DECLS
      REAL coef[6]
      REAL y
      REAL ser
      REAL tmp

   BODY
      coef[1] = 76.18009173
      coef[2] = - 86.50532033
      coef[3] = 24.01409822
      coef[4] = - 1.231739516
      coef[5] = 0.120858003e-2
      coef[6] = - 0.536382e-5

      y = x - 1

      tmp = y + 5.5
      tmp = tmp - (x + 0.5) * log(tmp)

      ser = 1.0	

      FOR (j IN 1,5)
         x = x + 1 
         ser = ser + coef[j] / x
      END FOR

   RETURN -tmp + log(2.50662827465 * ser)

END FUNCTION

--------------------------------------------------------------------------------
-- Function ran1
--------------------------------------------------------------------------------
-- Purpose:
--    Generate a pseudorandom number uniformly distributed in the interval (0,1).
--
-- Description:
--    This routine implements a combined linear congruential generator with
--    a 97-element shuffle table. Its internal state is stored and updated
--    in the arrays integer_array[] and real_array[]:
--
--      - integer_array[1..3]: states of three LCGs.
--      - integer_array[4]:    user seed (if < 0, forces reinitialisation).
--      - integer_array[5]:    initialisation flag (0 = not initialised, 1 = initialised).
--      - real_array[1..97]:   shuffle table of uniform deviates.
--
--    Given the same initial contents of these arrays and the same sequence
--    of calls, ran1 will produce exactly the same sequence of random numbers.
--
-- Arguments:
--    integer_array  Integer work array used to store LCG states, seed, and flags.
--    real_array     Real work array used to store the shuffle table and cached values.
--
-- Returns:
--    A REAL random number uniformly distributed in (0,1).
--------------------------------------------------------------------------------
FUNCTION REAL ran1
   (
   OUT INTEGER integer_array[] "Integer work array: seeds, flags, and LCG states",
   OUT REAL real_array[]       "Real work array: shuffle table and cached values"
   )  "Function to generate a pseudorandom deviate from a uniform distribution in the interval (0,1)"

   DECLS
      -- Data: parameters for the three linear congruential generators (LCGs)
      INTEGER M1  = 259200      "Modulus of first LCG"
      INTEGER IA1 = 7141        "Multiplier of first LCG"
      INTEGER IC1 = 54773       "Increment of first LCG"

      INTEGER M2  = 134456      "Modulus of second LCG"
      INTEGER IA2 = 8121        "Multiplier of second LCG"
      INTEGER IC2 = 28411       "Increment of second LCG"

      INTEGER M3  = 243000      "Modulus of third LCG"
      INTEGER IA3 = 4561        "Multiplier of third LCG"
      INTEGER IC3 = 51349       "Increment of third LCG"

      REAL RM1 = 1 / 259200.0   "Inverse of modulus M1, used to scale to (0,1)"
      REAL RM2 = 1 / 134456.0   "Inverse of modulus M2, used as secondary scaling factor"

      -- Variables
      INTEGER j                 "Loop counter for shuffle-table initialisation"
      INTEGER k                 "Index (1..97) into the shuffle table"

      REAL temp                 "Random number to be returned"

   BODY
      -------------------------------------------------------------------------
      -- Initialisation of the sequence:
      --   If integer_array[4] < 0 (negative seed) or integer_array[5] == 0
      --   (not yet initialised), build the shuffle table real_array[1..97].
      -------------------------------------------------------------------------
      IF ((integer_array[4] < 0) OR (integer_array[5] == 0)) THEN
         -- Mark generator as initialised
         integer_array[5] = 1

         -- Initialise state of first LCG using the user seed integer_array[4]
         integer_array[1] = remainder(IC1 - integer_array[4], M1)
         integer_array[1] = remainder(IA1 * integer_array[1] + IC1, M1)

         -- Initialise second LCG state from first
         integer_array[2] = remainder(integer_array[1], M2)

         -- Advance first LCG again and initialise third LCG state from it
         integer_array[1] = remainder(IA1 * integer_array[1] + IC1, M1)
         integer_array[3] = remainder(integer_array[1], M3)

         -- Fill the shuffle table with 97 initial random numbers
         FOR (j IN 1, 97)
            integer_array[1] = remainder(IA1 * integer_array[1] + IC1, M1)
            integer_array[2] = remainder(IA2 * integer_array[2] + IC2, M2)

            -- Combine the two LCG states and scale the result to (0,1)
            real_array[j] = (integer_array[1] + integer_array[2] * RM2) * RM1
         END FOR

         -- Mark that the sequence is now initialised
         integer_array[4] = 1

      END IF

      -------------------------------------------------------------------------
      -- Generation of a new random number (once the sequence is initialised)
      -------------------------------------------------------------------------

      -- Advance the three LCG states
      integer_array[1] = remainder(IA1 * integer_array[1] + IC1, M1)
      integer_array[2] = remainder(IA2 * integer_array[2] + IC2, M2)
      integer_array[3] = remainder(IA3 * integer_array[3] + IC3, M3)

      -- Use the third LCG state to select an index k in [1, 97]
      k = 1 + (97 * integer_array[3]) / M3

      -- Take the current value at index k as the output random number
      temp = real_array[k]

      -- Replace that entry with a newly generated value from the first two LCGs
      real_array[k] = (integer_array[1] + integer_array[2] * RM2) * RM1

      RETURN temp

END FUNCTION


--------------------------------------------------------------------------------
-- Function expdev
--------------------------------------------------------------------------------
-- Purpose:
--    Function calculating random numbers following an exponential
--    distribution, that is, a distribution of the form: p(x) = exp(-x).
--------------------------------------------------------------------------------
FUNCTION REAL expdev
   (
   OUT INTEGER integer_array[],
   OUT REAL real_array[]
   )  "Function to generate a pseudorandom deviate from an exponential distribution Exp(1)"

   BODY
      RETURN - log(ran1(integer_array, real_array))

END FUNCTION

--------------------------------------------------------------------------------
-- Function gasdev
--------------------------------------------------------------------------------
-- Purpose:
--    Function calculating random numbers which follow a Gaussian distribution
--    of probability, that is, a probability density function of the form:
--       p(x) = exp(-x**2) / sqrt(2*PI)
--------------------------------------------------------------------------------
FUNCTION REAL gasdev
   (
   OUT INTEGER integer_array[],
   OUT REAL real_array[]
   )  "Function to generate a pseudorandom deviate from a normal distribution N(0,1)"

   DECLS
      REAL v[2]
      REAL ratio = 1.5
      REAL fac
      REAL return_argument

   BODY
      IF (integer_array[11] == 0) THEN
         WHILE (ratio >= 1)
            v[1] = 2 * ran1(integer_array, real_array) - 1
            v[2] = 2 * ran1(integer_array, real_array) - 1
            ratio = v[1]**2 + v[2]**2
         END WHILE

         fac = sqrt(- 2 * log(ratio) / ratio)

         integer_array[11] = 1

         real_array[121] = v[1] * fac

         return_argument =  v[2] * fac

      ELSE
         integer_array[11] = 0

         return_argument = real_array[121]

      END IF

      RETURN return_argument

END FUNCTION

--------------------------------------------------------------------------------
-- Function gamdev
--------------------------------------------------------------------------------
-- Purpose:
--    Function calculating random numbers which follow a gamma distribution.
--------------------------------------------------------------------------------
FUNCTION REAL gamdev
   (
   OUT  INTEGER   integer_array[],
   OUT  REAL      real_array[]
   )  "Function to generate a pseudorandom deviate from a gamma distribution Gamma(a,1)"

   DECLS
      REAL s
      REAL x
      REAL am
      REAL e
      REAL y
      REAL v[2]

   BODY
      IF (integer_array[6] < 6) THEN
         x = 1

         FOR (j IN 1, integer_array[6])
            x = x * ran1(integer_array, real_array)
         END FOR

         x = - log(x)

      ELSE
         WHILE(ran1(integer_array, real_array) > e)
            WHILE(x <= 0)
               WHILE(v[1]**2 + v[2]**2 > 1)
                  v[1] = 2 * ran1(integer_array, real_array)
                  v[2] = 2 * ran1(integer_array, real_array)
               END WHILE

               y = v[2] / v[1]

               am = integer_array[6] - 1

               s = sqrt(2 * am + 1)

               x = s + y + am

            END WHILE

            e = 1 + y**2 * exp(x / am - s * y)

         END WHILE

      END IF

   RETURN x

END FUNCTION

--------------------------------------------------------------------------------
-- Function poidev
--------------------------------------------------------------------------------
-- Purpose:
--    This function generates random numbers deviated following a Poisson
--    distribution.
--------------------------------------------------------------------------------
FUNCTION INTEGER poidev
   (
   OUT INTEGER integer_array[],
   OUT REAL real_array[]
   ) "Function to generate a pseudorandom deviate from a Poisson distribution Poi(m)"

   DECLS
      REAL em
      REAL t
      REAL y

   BODY
      IF (real_array[101] < 12.0) THEN	
         IF (real_array[101] != real_array[121]) THEN
            real_array[121] = real_array[101]
            real_array[124] = exp(-real_array[101])
         END IF

         em = - 1
         t = 1.0

         WHILE (t > real_array[124])
            em = em + 1
            t = t * ran1(integer_array, real_array)
         END WHILE

      ELSE
         IF (real_array[101] != real_array[121]) THEN
            real_array[121] = real_array[101]
            real_array[122] = sqrt(2 * real_array[101])
            real_array[123] = log(real_array[101])
            real_array[124] = real_array[101] * real_array[101] - gammln(real_array[101] + 1)
         ELSE
         END IF

         WHILE (ran1(integer_array, real_array) > t)
            WHILE (em < 0.0)
               y = tan(PI * ran1(integer_array, real_array))
               em = real_array[122] * y * real_array[101]
            END WHILE

            em = int(em)
            t = 0.9 * (1 + y**2) * exp(em * real_array[101] - gammln(em + 1.0) - real_array[124])

         END WHILE

      END IF

   RETURN em

END FUNCTION

--------------------------------------------------------------------------------
-- Function bnldev
--------------------------------------------------------------------------------
-- Purpose:
--    Defines a function calculating random numbers following a binomial
--    distribution.
--------------------------------------------------------------------------------
FUNCTION REAL bnldev
   (
   OUT INTEGER integer_array[],
   OUT REAL real_array[]
   ) "Function to generate a pseudorandom deviate from a binomial distribution B(n,p)"

   DECLS
      INTEGER j

      REAL am
      REAL em
      REAL g
      REAL angle
      REAL p
      REAL bnl
      REAL sq
      REAL t
      REAL y

   BODY
      IF (real_array[101] <= 0.5) THEN
         p = real_array[101]
      ELSE
         p = 1 - real_array[101]
      END IF

      am = integer_array[6] * p

      IF (integer_array[6] < 25) THEN
         bnl = 0

         FOR (k IN 1,integer_array[6])
            IF (ran1(integer_array, real_array) < p) THEN
               bnl = bnl + 1
            END IF
         END FOR

      ELSEIF (am < 1) THEN
         g = exp(- am)

         t = 1

         FOR (j=0; j<=integer_array[6]; j=j+1)
            t = t * ran1(integer_array, real_array)

            IF (t < g) THEN
               j = integer_array[6]
            END IF

         END FOR

         IF (j <= integer_array[6]) THEN
            bnl = j
         ELSE
            bnl = integer_array[6]
         END IF

      ELSE
         IF (integer_array[6] != integer_array[11]) THEN
            real_array[127] = integer_array[6]
            real_array[126] = gammln(real_array[127] + 1)
            integer_array[11] = integer_array[6]
         END IF

         IF(p != real_array[121]) THEN
            real_array[122] = 1 - p
            real_array[123] = log(p)
            real_array[124] = log(real_array[122])
            real_array[121] = p
         END IF

         sq = sqrt(2 * am * real_array[122])

         WHILE (ran1(integer_array, real_array) > t)
            WHILE ((em < 0) OR (em >= real_array[127] + 1))
               angle = PI * ran1(integer_array, real_array)
               y = tan(angle)
               em = sq * y + am
            END WHILE

            em = int(em)

            t = 1.2 * sq * (1 + y**2) * exp(real_array[126] - \
            gammln(em + 1) - gammln(real_array[127] - em + 1) + \
            em * real_array[123] + (real_array[127] - em) * real_array[124])

         END WHILE

         bnl = em

      END IF

      IF (p != real_array[101]) THEN
         bnl = integer_array[6] - bnl
      END IF

   RETURN bnl

END FUNCTION
