/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: advanced_extended_calculations
 This chapter contains some examples showing how to perform advanced calculations with the PROOSIS, including
the low-level use of the nonlinear solver and its variants, how to extend the mathematical model
(partition) for including additional equations for transient and steady calculations, and the use of inequalities
groups within the different type of calculations (only in PROOSIS).
The examples are presented in increased order of complexity, each one including some additional functionality
and explanations to the previous one, so it is recommended to follow them in the proposed order.
 Using the nlsolver function
 residues function in Experiment
 residues function in Experiment + Component
 Using the INEQUALITIES class (available only in PROOSIS)
 Dominating group
 Saturated group
 Extending the mathematical model
 Steady calculations
􀀀 Without inequalities groups
􀀀 With inequalities groups (available only in PROOSIS)
 Transient calculations
􀀀 Without inequalities groups
􀀀 With inequalities groups (available only in PROOSIS)

-----------------------------------------------------------------------------------------*/
//Using the nlsolver() function
/*
We want to solve the nonlinear problem known as the "Powell badly scaled function":
f[1] = 10000.0 * x[1] * x [2] - 1.0 = 0
f[2] = exp ( - x[1] ) + exp ( - x [2] ) - 1.0001 = 0
In this section we will solve the above problem using the nlsolver in two ways:
 In the first example, we will code the problem totally in the experiment
 In the second example, the problem will be partially stated in a component
*/
COMPONENT comp_usingNldsolver
END COMPONENT
--We will now solve the same problem with nlsolver, but partially coded in a component. Let us consider the
--’test_powell_1’ component, in which one of the equations of the system has been implemented:
COMPONENT comp_test_powell_1
	DECLS
		REAL x, y
		REAL F
	CONTINUOUS
		F = exp(- x) + exp (-y) - 1.0001
END COMPONENT
//Using the inequalities class for adding constraints
/*
In the context of program, ’inequality group’ refers to an equality condition represented by a set of inequality
relations; one of the relations of the group is chosen to be an equality (the ’active’ constraint), so that the rest
of the inequality relations are fulfilled. These kinds of relations are also referred to as ’conditional equations’
or ’limiters’ in other tools and in the bibliography. In PROOSIS, there are two types of inequality groups:
dominating and saturated. They differ (very briefly speaking) in how the signs of the inequalities are managed
and how the active equality is chosen.
It is worth while noting that each inequality group is equivalent to an equation. It is a ’complex’ equation, as
the actual equality used depends on fulfilling some other inequalities. They should not be confused with the
use of inequalities in optimization problems, which are normally used for defining a search space.
For configuring calculations (steady or transient) including inequalities groups in PROOSIS, we use the INEQUALITIES
class. This class includes the functionalities for creating the inequalities groups and includes
them in the constraints. The calculation can then be solved with the non-linear algebraic solver included in the
class (nlsolver), or by extending the mathematical model and the usual solvers STEADY()/INTEG().
In this section, we present two examples using the nlsolver() with inequality groups:
 INEQ-1: A very simple of ’dominating’ group problem is stated and solved in an experiment
 INEQ-2: A more advanced example solves a problem with a ’saturated’ group. We add some complexity
as the problem is now partially stated in a component and in the experiment
*/
//Dominating INEQUALITIES group (this example can be only executed in PROOSIS as the INEQUALITIES class is only available in PROOSIS)
/*
In this first example, we state a very simple problem consisting of just one dominating inequality group with
two inequalities:
DOMINATING :
F_1 =2 -2x <0
F_2 =1 -0.5x <0
The first constraint is normally called the "main" inequality. One of the relations behaves as an active equality,
while the rest of them act as inequalities.
In a dominating group, when the main relation becomes an inequality, its sign is always the same, regardless
of which associated inequality has become the active equality.
In this case, this means that the solution is the one that fulfils one of the following conditions
F_1 =2 -2x=0 AND F_2 =1 -0.5x <0
OR
F_2 =1 -0.5x=0 AND F_1 =2 -2x <0
*/
COMPONENT comp_dominatingInequalities
END COMPONENT
//Saturated inequality group
/*
As we saw in previous example, in a dominating group, when the main equation becomes an inequality, its
sign is always the same (greater or lower), regardless of which associated inequality has become active.
The saturated groups add more flexibility: the sign of the main equation when it becomes an inequality depends
on which inequality has become active as an equation. The users then needs to provide a new parameter
to each associated equation describing the sign that the main equation will take. Let
The problem is stated in PROOSIS as:
SATURATED
F_1 = -2 + x=0
F_2 = -3 + x >0 LOWER
F_3 = 1 - x <0 UPPER
This is equivalent to:
F_1 = -2 + x=0 AND F_2= -3 + x >0 AND F_3= 1 - x <0
OR
F_2 = -3 + x = 0 AND F_1= -2 + x >0 AND F_3 = 1 - x <0
OR
F_3 = 1 - x=0 AND F_1= -2 + x <0 AND F_2 = -3 + x >0
When F_2 is the active equality, the right hand side of F_1 becomes a LOWER limit, ie F_1>0. When F_3 is the
active equality, the right hand side of F_1 becomes an UPPER limit, ie F_1<0.
At first glance, there are three potential solutions to the problem: x1=2, x2=3 and x3=1, corresponding to the
roots of F_1, F_2 and F_3. However, only x_2 fulfils the whole inequality group, in the case of F_2 being the
active equation.
*/
COMPONENT comp_saturatedInequalityGroup
	DECLS
		REAL x
		REAL F_1 , F_2 , F_3
	CONTINUOUS
		F_1 = -2 + x
		F_2 = -3 + x
		F_3 = 1 - x
END COMPONENT
//Extended calculations
/*
Normally, in the calculations configured in the experiment, the inputs for the calculations are the boundaries
of the mathematical model ("partition"). However, it is possible to extend the mathematical model with additional
constraints in the experiment, so that the boundaries are calculated in order to fulfil the new conditions.
Moreover, the additional constraints can be stated in terms of inequalities groups. Once the mathematical
model has been extended, the steady or transient response calling the usual directives STEADY() or INTEG()
can be computed.
Following are four examples:
 Extended steady problem
 EST-1:Without inequality groups, equivalent to
 EST-2: With inequality groups
 Extended transient problem
 TRAN-1: Without inequality groups
 TRAN-2: With inequality groups
*/
COMPONENT comp_extended_steady_without_inequality_group
	DECLS
		REAL x, y
		REAL F
	CONTINUOUS
		F = exp(- x) + exp (-y) - 1.0001
END COMPONENT
//Extended steady with inequalities groups (available only in PROOSIS)
/*
We can extend the mathematical model including not only equations, but also inequalities groups, combining
the use of the addExtraEquationsToPartition() function and the INEQUALITIES class. As an example, and
following a similar approach as in the previous section, we will solve the same problem as in example EST-1,
but extending the mathematical model instead of coding the residues function.
*/
COMPONENT comp_extended_steady_with_inequality_group
DECLS
REAL x
REAL F_1 , F_2 , F_3
CONTINUOUS
F_1 = -2 + x
F_2 = -3 + x
F_3 = 1 - x
END COMPONENT
//Extended transient
/*
In a common transient calculation, we simulate the response of a model to a given evolution of the boundary
variables. In an extended transient calculation, however, we calculate the required time evolution of the
boundary variables so that some other variables follow a prescribed path, represented as a new constraint to
the model; ie the input of the simulation is not the boundary variable. This constraint is normally represented
as an equation, but it is also possible to represent it as an inequality group.
In this section, we present two examples of extended transient calculation, both involving the simulation of the
motion of a lunar descent vehicle; in the first one we impose a prescribed descent path in terms of an equality
condition. In the second one, the path is stated in terms of inequalities groups.
Let us consider the one dimensional vertical motion of a (very) simplified lunar lander vehicle. We assume
that the vehicle is subject only to gravitational (assumed to be constant) and thrust forces. The vehicle has only
one engine generating force in the positive vertical direction
*/
COMPONENT comp_extendedTransient
	DATA
		REAL g = 1.63
		REAL k = 636
		REAL mu = -16.5
	DECLS
		REAL h,dh , T, m
	DISCRETE
		WHEN (h <0) THEN
			TSTOP = TIME
		END WHEN
	CONTINUOUS
		T=-k*m'
		h'= dh
		m*dh' = T - m*g
END COMPONENT





