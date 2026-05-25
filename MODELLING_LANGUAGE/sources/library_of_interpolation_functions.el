/*-----------------------------------------------------------------------------------------
 LIBRARY: MODELLING_LANGUAGE
 FILE: library_of_global_interpolation_function

-----------------------------------------------------------------------------------------*/
// Library of interpolation functions
/*
	The modelling language allows using tables in one (1D), two (2D) or three (3D) dimensions. Normally, the tables are used to introduce tabulated data related to one or several variables and interpolation methods are usually used to access their values, entering these variables over those that are tabulated. 
	There are two different ways to use tables, each with its advantages and drawbacks:
	 	Using the basic types TABLE_1D, TABLE_2D and TABLE_3D. 
	 	Using an external class called TABLE.
	The advantage of using the first type is that the values of the table can be defined when the variable is declared, which is not the case with the second type. Nevertheless, the advantage of declaring a table object using an instance of the class TABLE is that a multitude of methods are available associated with the object to interpolate, read, save, etc. We could say that functional programming is done with the first type, and with the second, object oriented programming. Depending on the need, one or the other can be used. The different when it comes time to declare it is that in the first case, you have to declare in a DATA or DECLS block, while in the second, as it is an instance of an external object, it has to be declared in the OBJECTS block.
	Notice also that in newer versions of the EL compiler it is also allowed to use variables of types TABLE_1D, TABLE_2D, and TABLE_3D just as if they were instances of TABLE class.
	The use of the first type will be explained in this chapter, while the other use of tables will be explained in the chapter on external classes.
*/
// Reading tables
/*
	Reading tables from ASCII and XML files
	EL allows external tables (1D, 2D and 3D) to be read from ASCII or XML files (see Appendix F). The only difference is an integer argument that you pass to the function to read the table. The reading functions are:
	INTEGER  readTable1D( STRING filename, 
	                      TABLE_1D t, 
	                      IN INTEGER format )
	
	INTEGER  readTable2D( STRING filename, 
	                      TABLE_2D t, 
	                      IN INTEGER format )
	
	INTEGER  readTable3D( STRING filename, 
	                      TABLE_3D t, 
	                      IN INTEGER format )
	The first argument is the file name, the second is the table (it can be either TABLE_1D or TABLE_2D or TABLE_3D) and the third is an integer with two possible values: 1 means the file is in ASCII format and 2 means the file is in XML format.
	If the XML format is used, there are fields in the file not used for objects such as TABLE_1D, TABLE_2D and TABLE_3D but for a more generic table class named TABLE. See the specific chapter dedicated to TABLE class to better understand all these fields.
	The format of ASCII files for TABLE_1D must follow the following syntax:
	x 10
	V
	0.21556 1.03581
	0.34721 1.10500
	0.50444 1.21050
	0.58864 1.28809
	0.65517 1.34042
	0.74116 1.40804
	0.77724 1.46745
	0.81336 1.52683
	0.86094 1.59777
	0.93168 1.69644

	The format of XML files for TABLE_1D must follow the syntax from Appendix F, for example:
	<?xml version="1.0" encoding="UTF-8" standalone="no"?>
	<!DOCTYPE eds SYSTEM "DTDFILE_FULLPATH">
	<table type="1D" name="PRsurge_vs_Wc_sec" description="Surge pressure ratio versus corrected massflow rate" version="1.0" cdate="01/01/2007" mdate="01/08/2007" revision="0.1">
	  <interp default="SPLINE" valid="{CONSTANT, LINEAR, SPLINE}" /> 
	  <extrap default="LINEAR" valid="{FORBIDDEN, CONSTANT, LINEAR, SPLINE}" /> 
	  <axis1 id="Wc" description="Corrected Massflow Rate (kg/sec)" value="{0.21556, 0.34721, 0.50444, 0.58864, 0.65517, 0.74116, 0.77724, 0.81336, 0.86094, 0.93168}" /> 
	  <return id="PRsurge" description="Surge Pressure Ratio (-)" value="{1.03581, 1.10500, 1.21050, 1.28809, 1.34042, 1.40804, 1.46745, 1.52683, 1.59777, 1.69644}" /> 
	  </table>
	For TABLE_2D in ASCII format:
	X 4
	0.74000 0.80000 0.90000 1.00000
	y 10
	0.00000 0.11111 0.22222 0.33333 0.44444 0.55555 0.66666 0.7 0.8 1.00000
	V
	58.4751386 58.3129686 58.2048553 57.7029902 56.5690050 54.7078205 51.9223126 49.4833389 47.3870683 44.6423087  
	62.6509410 62.4921274 62.1264380 61.4629731 60.0702192 57.2192355 55.7118989 53.8956418 52.8212118 51.5587129  
	66.6014306 66.3955998 66.1897689 65.8167658 65.1240457 63.6205402 61.2686354 58.5144723 55.7686678 53.8137971  
	69.9783104 69.9166656 69.6279452 69.3085765 68.9376630 68.5361013 68.0582673 67.7347193 67.3167886 65.7631314

	And for TABLE_2D in XML:
	<?xml version="1.0" encoding="UTF-8" standalone="no"?>
	<!DOCTYPE eds SYSTEM "DTDFILE_FULLPATH">
	<table type="2D" name="Wc_vs_NcRdes_BETA" description="Corrected mass flow versus rotational speed and BETA parameter" versgion="1.0" cdate="02/03/2006" mdate="13/08/2007" revision="0.2">
		<interp default="LINEAR" valid="{CONSTANT, LINEAR, CUBIC, SPLINE}" />
		<extrap default="CONSTANT" valid="{FORBIDDEN, CONSTANT, LINEAR, CUBIC, SPLINE}" />
		<axis1,0.80,0.90,1.00}" />
		<axis2 id="BETA" description="BETA parameter (-)" value="{0.00,0.11,0.22,0.33,0.44,0.55,0. 66,0.7,0.8,1.00}" />
	<return id="Wc" description="Corrected mass flow (kg/sec)" value="{{58.47,58.31,58.20,57.70,56.56,54.70,51.922,49.48,47.38,44.64},					{62.60,62.74,62.80,61.41,60.62,57.55,55.89,53.88,52.82,51.55},
	{66.06,66.98,66.89,65.88,65.17,63.62,61.24,58.53,55.76,53.71},
	{69.04,69.56,69.52,69.35,68.30,68.13,68.73,67.73,67.36,65.76}}" />
	</table>
	
	For TABLE_3D in ASCII format:
	X 2
	0.2 0.4
	y 3
	0.7 0.8 0.9
	z 3
	6.0 -2.0 -3
	V
	4.0 1.0 5.4
	6.0 3.0 1.7 
	7.0 0.0 2
	V
	2.0 5.0 -34
	3.0 7.0 -4
	5.0 9.12e-3 567

	And for TABLE_3D in XML format:
	<?xml version="1.0" encoding="UTF-8" standalone="no"?>
	<!DOCTYPE eds SYSTEM "DTDFILE_FULLPATH">
	   <table type="3D" name="mu_T" description="Dynamic Viscosity as a function of T, FARB and WAR)">
	      <interp default="LINEAR" valid="{CONSTANT, LINEAR, SPLINE}" />
	      <extrap default="CONSTANT" valid="{FORBIDDEN, CONSTANT, LINEAR, SPLINE}" />
	      <axis1 id="WAR" description="Water to Air Ratio (-)" value="{ 0.2,0.4 }" />
	      <axis2 id="T" description="Temeperature(K)" value="{ 0.7,0.8,0.9}" />
	      <axis3 id="FARB" description="Burnt Fuel to Air Ratio (-)" value="{6.0,-2.0,-3}" />
	      <return id="mu" description="Dynamic Viscosity (Ns/m2)" value="{{     
	        {{4.0,1.0,5.4},{6.0,3.0,1.7},{7.0,0.0 ,2}},
		 {{2.0,5.0,-34},{3.0,7.0,-4},{5.0,9.12e-3,567}}}" />
	   </table>

	Other functions can be used to delete existing tables (typically needed if you want to use a different table in the same table variable) and to print tables, namely:
	INTEGER clearTable1D( TABLE_1D t )
	INTEGER clearTable2D( TABLE_2D t )
	INTEGER clearTable3D( TABLE_3D t )
	INTEGER printTable1D( TABLE_1D t, IN INTEGER format )
	INTEGER printTable2D( TABLE_2D t, IN INTEGER format )
	INTEGER printTable3D( TABLE_3D t, IN INTEGER format )
	
*/
COMPONENT comp_usingTables
	DATA
        FILEPATH tableFileXml = "@MODELLING_LANGUAGE@/tables/table1d.xml"  
   DECLS
        REAL Rxml
		  TABLE_1D txml
		  TABLE_1D tab
   INIT
        readTable1D(tableFileXml,txml,2)  -- read from XML
		  -- It reads the 4th column of the file in the independent variable of the table tab1, and the 8th column of the file in the dependent variable of the table tab1
		  readTableCols1D("@MODELLING_LANGUAGE@/tables/myTable.txt",4,8,tab) 
        printTable1D (tab, 1)  
END COMPONENT

// General Interpolation Functions
/*
	This section introduces the general interpolation functions available in the language
	These functions have the following characteristics:
 	Default interpolation methods can be used or they can be specified in the call.
 	Optionally, the analytical derivatives can be obtained upon interpolating.
 	An interpolation can be used that will save the last cells of the table where the interpolation is performed so that in the following call, the search will begin from this position, thus saving time. 
	The functions are split into 4 families and each family has 3 functions:
	Family 1: Interpolation using the default methods family:
		FUNCTION REAL interpd1D(TABLE_1D tbl,   -- 1D table
		    IN REAL x,                          -- input value x
		    OUT REAL dx=DUMMY_REAL)             -- derivative @F/@x
		
		FUNCTION REAL interpd2D(TABLE_2D tbl,   -- 2D table
		    IN REAL x,                          -- input value x
		    IN REAL y,                          -- input value y
		    OUT REAL dx=DUMMY_REAL,             -- derivative @F/@x
		    OUT REAL dy=DUMMY_REAL)             -- derivative @F/@y
		
		FUNCTION REAL interpd3D(TABLE_3D tbl,   -- 2D table
		    IN REAL x,                          -- input value x
		    IN REAL y,                          -- input value y
		    IN REAL z,                          -- input value y
		    OUT REAL dx=DUMMY_REAL,             -- derivative @F/@x 
		    OUT REAL dy=DUMMY_REAL,             -- derivative @F/@y
		    OUT REAL dz=DUMMY_REAL)             -- derivative @F/@z
		This family of functions allows interpolating using the default methods. Be aware that if you use the basic types TABLE_1D, TABLE_2D and TABLE_3D, the default interpolation and extrapolation methods are always LINEAR.
	Family 2: Interpolation setting the methods family:
		FUNCTION REAL interp1D(TABLE_1D tbl,    -- 1D table
		      IN ENUM t_interp tin,             -- interpolation method
		      IN ENUM t_interp tex,             -- extrapolation method
		      IN REAL x,                        -- input value x
		      OUT REAL dx=DUMMY_REAL)           -- derivative @F/@x
		
		FUNCTION REAL interp2D(TABLE_2D tbl,    -- 2D table
		      IN ENUM t_interp tin,             -- interpolation method
		      IN ENUM t_interp tex,             -- extrapolation method
		      IN REAL x,                        -- input value x
		      IN REAL y,                        -- input value y
		      OUT REAL dx=DUMMY_REAL,           -- derivative @F/@x
		      OUT REAL dy=DUMMY_REAL)           -- derivative @F/@y
		
		FUNCTION REAL interp3D(TABLE_3D tbl,    -- 2D table
		      IN ENUM t_interp tin,             -- interpolation method
		      IN ENUM t_interp tex,             -- extrapolation method
		      IN REAL x,                        -- input value x
		      IN REAL y,                        -- input value y
		      IN REAL z,                        -- input value y
		      OUT REAL dx=DUMMY_REAL,           -- derivative @F/@x 
		      OUT REAL dy=DUMMY_REAL,           -- derivative @F/@y
		      OUT REAL dz=DUMMY_REAL)           -- derivative @F/@z
		Using this family, you can set the interpolation and extrapolation methods you want.
	Family 3: Interpolation using the default methods and keeping the last position in the table family:
		FUNCTION REAL interpHistd1D(TABLE_1D tbl,     -- 1D table
		    IN REAL x,                                -- input value x
		    OUT INTEGER iprev,                        -- last  cell at table
		    OUT REAL dx=DUMMY_REAL)                   -- derivative @F/@x
		
		FUNCTION REAL interpHistd2D(TABLE_2D tbl,     -- 2D table
		    IN REAL x,                                -- input value x
		    IN REAL y,                                -- input value y
		    OUT INTEGER iprev,                        -- last  cell at table
		    OUT INTEGER jprev,                        -- last  cell at table    
		    OUT REAL dx=DUMMY_REAL,                   -- derivative @F/@x
		    OUT REAL dy=DUMMY_REAL)                   -- derivative @F/@y
		
		FUNCTION REAL interpHistd3D(TABLE_3D tbl,     -- 2D table
		    IN REAL x,                                -- input value x
		    IN REAL y,                                -- input value y
		    IN REAL z,                                -- input value y
		    OUT INTEGER iprev,                        -- last  cell at table
		    OUT INTEGER jprev,                        -- last  cell at table    
		    OUT INTEGER kprev,                        -- last  cell at table    
		    OUT REAL dx=DUMMY_REAL,                   -- derivative @F/@x 
		    OUT REAL dy=DUMMY_REAL,                   -- derivative @F/@y
		    OUT REAL dz=DUMMY_REAL)                   -- derivative @F/@z
		This family of functions allows interpolating using the default methods and providing some extra integer arguments that return the latest cells in the table for interpolating. This can save time next time as it allows beginning the search from this position.
	Family 4: Interpolation setting the interpolation and extrapolation methods and keeping the last positions in the table family:
		FUNCTION REAL interpHist1D(TABLE_1D tbl,      -- 1D table
		    IN ENUM t_interp tin,                     -- interpolation method
		    IN ENUM t_interp tex,                     -- extrapolation method
		    IN REAL x,                                -- input value x
		    OUT INTEGER iprev,                        -- last  cell at table
		    OUT REAL dx=DUMMY_REAL)                   -- derivative @F/@x
		
		FUNCTION REAL interpHist2D(TABLE_2D tbl,      -- 2D table
		    IN ENUM t_interp tin,                     -- interpolation method
		    IN ENUM t_interp tex,                     -- extrapolation method
		    IN REAL x,                                -- input value x
		    IN REAL y,                                -- input value y
		    OUT INTEGER iprev,                        -- last  cell at table
		    OUT INTEGER jprev,                        -- last  cell at table    
		    OUT REAL dx=DUMMY_REAL,                   -- derivative @F/@x
		    OUT REAL dy=DUMMY_REAL)                   -- derivative @F/@y
		
		FUNCTION REAL interpHist3D(TABLE_3D tbl,      -- 3D table
		    IN ENUM t_interp tin,                     -- interpolation method
		    IN ENUM t_interp tex,                     -- extrapolation method
		    IN REAL x,                                -- input value x
		    IN REAL y,                                -- input value y
		    IN REAL z,                                -- input value y
		    OUT INTEGER iprev,                        -- last cell at table
		    OUT INTEGER jprev,                        -- last  cell at table    
		    OUT INTEGER kprev,                        -- last cell at table    
		    OUT REAL dx=DUMMY_REAL,                   -- derivative @F/@x 
		    OUT REAL dy=DUMMY_REAL,                   -- derivative @F/@y
		    OUT REAL dz=DUMMY_REAL)                   -- derivative @F/@z
		It is similar to the last family but allows setting the interpolation methods.
		They interpolate in tables declared as TABLE_1D, TABLE_2D and TABLE_3d for one, two and three dimensions. The arguments are as follows:
		 	tbl: the table to be interpolated.
		 	tin: the selected interpolation method.
		 	tex: the selected extrapolation method.
		 	x,y,z: the input values to the table.
		 	iprev,jprev,kprev: integer values with the latest position in the table used for interpolation.
		 	dx,dy,dz: optional arguments in all functions. They are filled with the analytical derivatives at the interpolation points.
		Interpolation methods available
	These tables are best used to perform interpolations. Different types of interpolations can be performed, depending on the dimension and degree of accuracy required and how smooth you want the transitions between the different points to be. 
	Many of the interpolation functions, optionally, can retry the value of the analytical derivatives in the interpolation points. This may be of interest in the case where you want to know the trend of the curve.
	The available interpolation and extrapolation methods for each dimension are shown in the following table, along with indication of whether they are valid for extracting the analytical derivative
	DIMENSION	METHOD	INTERPOLATION	EXTRAPOLATION	DERIVATIVES
	1D				FORBIDDEN	NO					YES					NO
	1D				LINEAR		YES				YES					YES
	1D				CONSTANT		YES				YES					YES
	1D				SPLINE		YES				YES					YES
	1D				AKIMA			YES				YES					YES
	1D				CUBIC			NO					NO						NO
	2D				FORBIDDEN	NO					YES					NO
	2D				LINEAR		YES				YES					YES
	2D				CONSTANT		YES				YES					YES
	2D				SPLINE		YES				YES					YES
	2D				AKIMA			YES				YES					YES
	2D				CUBIC			YES				YES					YES
	2				DM(*)	Same as 1D	YES		YES					NO
	3D				FORBIDDEN	NO					YES					NO
	3D				LINEAR		YES				YES					YES
	3D				CONSTANT		YES				YES					YES
	3D				SPLINE		YES				YES					YES
	3D				AKIMA			NO					NO						NO
	3D				CUBIC			NO					NO						NO
	(*) Special case for a 2D interpolation with multiple 1D tables inside. Explained later on in this chapter
	The enumeration type used to define the interpolation method is defined in the enumeration t_interp which may have the following values.
	ENUM t_interp =   { LINEAR,
	                    CONSTANT, 
	                    AKIMA,
	                    SPLINE 
	                    CUBIC,
	                    DEFAULT, 
	                    FORBIDDEN }
	The meaning of each one is as follows:
	 	LINEAR: Linear interpolation between two points (see testInterpLinear component in previous section). This is a classical interpolation method that in many situations could be the most effective since it is the fastest interpolation method but in other cases may not be appropriate since it can introduce big discontinuities between two segments of the table, which could lead to problems of non-convergence. This results in a continuous curve, with a discontinuous derivative (in general), thus of differentiability class C0. To avoid this, you can use either other more sophisticated interpolation methods like AKIMA or SPLINE but lose some performance in the calculation time or use functions like timeTableInterp(), which properly handle the discontinuities.
	 	CONSTANT: Constant interpolation is done for each interval
		SPLINE: Cubic interpolation by 3rd order polynomials between 2 points. The final result provides a cubic curve on each interval, with matching first and second derivatives at the supplied data-points. The second derivative is chosen to be zero at the first and last points. Sometimes the disadvantage of SPLINE method is that they could oscillate in the neighbourhood of an outlier. In general the AKIMA method is less affected by the outliers and it fits with more accuracy the original points. Spline method ensures C2 continuity between segments (first & second derivatives)
 		CUBIC: Special Bi-cubic interpolation available only for interpolation in two dimension tables. It uses a method with 3rd order polynomials between 4 point grids. This squared grid is formed by each 4 point connection. This method requires the calculation of the gradients on each 4 points of the grid
  		DEFAULT: It takes the default interpolation/extrapolation method. If not specified the default method is LINEAR. There are two cases:
 			Basic types: TABLE_1D, TABLE_2D & TABLE_3D. It uses LINEAR interpolation/extrapolation methods.
 			Advanced types: TABLE and MAP classes. In this case the user can set in the XML file both the desired default methods and the valid methods.
 		FORBIDDEN: Extrapolation in the table is forbidden. If reached, an error message

*/
COMPONENT comp_generalInterpolationFunctions
	DECLS
    REAL x_linear
	 REAL x_constant
	 REAL x_akima
	 REAL x_spline
	 REAL x_cubic
	 REAL x_linearc
    TABLE_1D mtab = {{0.0, 40.0, 81.0, 100.0, 150.0, 200.},
                     {9.5, 9.5, 400.6, 16.6, 368.0, 3.}}
	TABLE_2D table2d ={ {0, 5, 10}, {0,1,2,3,4,5,5.5,6,7,8,9,10},
           {{0,100,120,120,100,10,10,10,90,10,10,70},
           {0,100,120,120,100,10,10,10,90,10,10,70},
           {0,100,120,120,100,10,10,10,90,10,10,70}}}
	CONTINUOUS
     	x_linear = interp1D(mtab,LINEAR,LINEAR,TIME)
		x_constant = interp1D(mtab,CONSTANT, CONSTANT,TIME)
		x_akima = interp1D(mtab,AKIMA,AKIMA,TIME)
		x_spline = interp1D(mtab, SPLINE, SPLINE,TIME)
		x_cubic =  interp2D(table2d,CUBIC,CUBIC,TIME,TIME)
		x_linearc = interp2D(table2d,LINEAR,LINEAR,TIME,TIME)
END COMPONENT
// Obtaining the analytical derivatives
/*
	The modeller can also obtain, optionally, the analytical derivative when interpolating. One, two or three extra variables have to be created depending on whether the interpolation is in one, two or three dimensions, to obtain the corresponding derivative with respect to the X, Y or Z axis
*/
COMPONENT comp_analyticalDerivatives
	DECLS
  		REAL x_linear,x_akima,x_spline
		REAL dx_linear,dx_akima,dx_spline
		REAL x_linear2,x_akima2,x_cubic2
   	REAL dx_linear2,dx_akima2,dx_cubic2
		REAL dy_linear2,dy_akima2,dy_cubic2
		REAL z_linear3
		REAL dx_linear3,dy_linear3,dz_linear3 
   	TABLE_1D mtab = {{0.0, 40.0, 81.0, 100.0, 150.0, 200.},
                    {9.5, 9.5, 400.6, 16.6, 368.0, 3.}}
		TABLE_2D table2d ={ {0, 5, 10}, {0,1,2,3,4,5,5.5,6,7,8,9,10},
		  {{0,100,120,120,100,10,10,10,90,10,10,70},
	     {23,45,32,12,-100,10,45,78,78,79,120,170},
		  {400,900,1200,4500,4900,4900,7800,8900,10000,3400,-3400,5600}}}
		 TABLE_3D table3d =	{ { 0., 1. },  -- X values
                         	  { 0, 1, 2},  -- Y values
                     	  { 0, 3, 6 }, -- Z values
                          { { { 1.,5, 2} , 
                            { 8.,4, 9} , 
                            { 3.,6, 7}} ,
                      	{ { 11.,12, 30} , 
                            { 13.,14, 2} , 
                            { 15.,16, 41}}}}


CONTINUOUS
    x_linear = interp1D(mtab,LINEAR,LINEAR,TIME,dx_linear)
    x_akima = interp1D(mtab,AKIMA,AKIMA,TIME,dx_akima)
    x_spline = interp1D(mtab,SPLINE,SPLINE,TIME,dx_spline)
	 
	 x_cubic2 =  interp2D(table2d,CUBIC,CUBIC,TIME,0,dx_cubic2,dy_cubic2)
    x_akima2 =  interp2D(table2d,AKIMA,AKIMA,TIME,0,dx_akima2,dy_akima2)
	 x_linear2 = interp2D(table2d,LINEAR,LINEAR,TIME,0,dx_linear2,dy_linear2)

	z_linear3=  interp3D(table3d,LINEAR,LINEAR,0,TIME,0,dx_linear3,dy_linear3,dz_linear3)

END COMPONENT
// Special 2D tables
/*
	There is a special type of 2D table in which different tables are introduced for different values of another dimension. For example, in the world of aircraft engines, it is common to be able to include tables in which, given a compressor work coefficient (gH), there is a different associated table for different values of the relative corrected rotational speeds (NcRdes) with different efficiency (Eff) values. Even those tables can have different dimensions and value (otherwise it would be a classical 3D table). For example:
	gh	-0.5											
		NcRdes	0	0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	1
		Eff	0.81	0.82	0.83	0.84	0.85	0.86	0.87	0.88	0.89	0.91											
	gh	-0.3											
		NcRdes	0	0.05	0.1	0.15	0.2	0.25	0.5	0.6	1		
		Eff	0.83	0.835	0.84	0.845	0.85	0.88	0.91	0.94	0.97							
	gh	-0.2											
		NcRdes	0	0.1	0.2	0.3	0.4	0.5	0.6	0.7			
		Eff	0.81	0.82	0.83	0.84	0.85	0.86	0.87	0.97	
	Notice that first 2D table contains 10 values whereas the second only 9 values and the third 8 values. When this table is interpolated, a gh and a NcRdes will have to be given as input argument, in other words, it will behave like a typical 2D interpolation. In this case, the internal algorithm will take charge of interpolating correctly through the different tables.
	This type of table can only be used from a TABLE object and cannot be created using the basic type TABLE_2D.
	These tables can only be read from an XML file. The differences with respect to the format of a normal 2D table are as follows:
	The attribute type will be  of a normal table
	Internally, this table will contain multiple 1D tables, a different one for each value of the first axis (e.g.  gh). The interpolation and extrapolation methods should be written globally before the tables, in this way all tables will use the interpolation methods and makes no necessary to write them at table level.
	Each 1D table will have an        value="-0.5" />
	The fields  will contain the values of the table of the second axis (eg NcRes) and the (eg. Eff) values
	For example, for the previous table, the format in XML would be:
	<?xml version="1.0" encoding="UTF-8" standalone="no"?>
	<!DOCTYPE eds SYSTEM "DTDFILE_FULLPATH">
	<table type="2DM" name="Eff_vs_gh_NcRdes" description="Efficiency versus gh and NcRdes" version="1.0" cdate="04/09/2015" mdate="04/09/2015" revision="0.1">
	   <interp default="LINEAR" valid="{LINEAR,AKIMA}" />
	   <extrap default="LINEAR" valid="{FORBIDDEN,AKIMA, CONSTANT, LINEAR}" />
	   <table type="1D" name="Eff_vs_NcRdes" description="Efficiency vs Design Point Relative Corrected Rotational Speed at gh = -0.5">
	      <axis0 id="gh" description= value="-0.5" />
	      <axis1 id="NcRdes" description="Design Point Relative Corrected Rotational
	      Speed (-)" value="{0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1}" />
	      <return id="Eff" description="Efficiency"
	      value="{0.81,0.82,0.83,0.84,0.85,0.86,0.87,0.88,0.89,0.9,0.91}" />
	   </table>
	   <table type="1D" name="Eff_vs_NcRdes" description="Efficiency vs Design Point Relative Corrected Rotational Speed at gh = -0.3">
	      <axis0 id="gh" description="Compressor work coefficientvalue="-0.3" />
	      <axis1 id="NcRdes" description="Design Point Relative Corrected Rotational 
	      Speed (-)" value="{0,0.05,0.1,0.15,0.2,0.25,0.5,0.6,1 }" />
	      <return id="Eff" description="Efficiency "
	      value="{0.83,0.835,0.84,0.845,0.85,0.88,0.91,0.94,0.97}" />
	   </table>
	   <table type="1D" name="Eff_vs_NcRdes" description=" Efficiency vs Design Point Relative Corrected Rotational Speed at gh = -0.2">
	      <axis0 id="gh" description="Compressor work coefficient value="-0.2" />
	      <axis1 id="NcRdes" description="Design Point Relative Corrected Rotational 
	      Speed (-)" value="{0,0.1,0.2,0.3,0.4,0.5,0.6,0.7}" />
	      <return id="Eff" description="Efficiency "
	        value="{0.81,0.82,0.83,0.84,0.85,0.86,0.87,0.97}" />
	   </table>
	</table>
*/
COMPONENT comp_special2dtables
DATA
   REAL gh= -0.3
DECLS
   REAL result
   FILEPATH fpath= "@MODELLING_LANGUAGE@/tables/table2m.xml"
OBJECTS
   TABLE tab
INIT
   tab.read(fpath)
CONTINUOUS
   result= tab.interpd2D(gh,TIME)
END COMPONENT
// Interpolation with history
/*
	In very large tables it can be useful to begin the task of searching the cell to be interpolated at the position it was tried the previous time, as this can sometimes save a lot of time. There are two families of interpolation functions which allow you to pass extra arguments to keep the latest interpolated cells at the table, and then at the next call these numbers can be used as starting cells. Remember that the first task when interpolating is always to find the right cell to be interpolated.
	As a table may be used for several interpolations simultaneously, you can send additional position marker arguments. This way, if a table is being interpolated in two well separated areas, you can do the task more efficiently by using two sets of position variables. The format of these functions is similar to the above, but there are extra INTEGER arguments which are used as a memory position to start next time from a certain position. The values are changed internally by the interpolation functions and the change is visible outside (is OUT). The interpolation function should have as many integer arguments as dimensions. 
	This introduces two integer variables, "lastx" and  to which the interpolation function assigns a value of the last cell position at the table. When the next interpolation begins, these values are used to begin the search for the interpolation (close to where the previous one left off
*/
COMPONENT comp_interpolationWithHistory
DECLS
	REAL x_cubic
	REAL dx_cubic,dy_cubic
	INTEGER lastx = 0 
	INTEGER lasty = 0
	TABLE_2D table2d ={ {0, 5, 10}, {0,1,2,3,4,5,5.5,6,7,8,9,10},
		   {{0,100,120,120,100,10,10,10,90,10,10,70},
		   {23,45,32,12,-100,10,45,78,78,79,120,170},
	       {400,900,1200,4500,4900,4900,7800,8900,10000,3400,-3400,5600}}}
CONTINUOUS
	x_cubic = interpHist2D (table2d,CUBIC,CUBIC,TIME,TIME, 
					lastx,lasty,dx_cubic,dy_cubic)
END COMPONENT
// Particular interpolation functions
/*
	For historical and backwards compatibility reasons EL maintains some old functions for interpolating specifically created for certain interpolation methods. Today, these functions can still be used but it is recommended to use the general interpolation functions explained previously.
		Linear Interpolation in Tables
	EL has built-in routines for linear interpolation in tables. The first argument to these routines is the table, followed by the input values to the table. They return the interpolated value. Each of these functions implements interpolation for one, two and three dimensional tables. The format is:
		FUNCTION REAL linearInterp1D( TABLE_1D my1Dtable,
	                              REAL vx )
	
		FUNCTION REAL linearInterp2D( TABLE_2D my2Dtable,
	                              REAL vx,
	                              REAL vy )
	
		FUNCTION REAL linearInterp3D( TABLE_3D my3Dtable,
	                              REAL vx,
	                              REAL vy,
	                              REAL vz )
	For example, using interpolation to calculate a variable:
	x = linearInterp2D(my2Dtable, z, t)
	This is equivalent to writing:
		x = interpd2D(my2Dtable,z, t) 
		x = interp2D(my2Dtable,LINEAR,LINEAR,z, t)
		x = interp2D(my2Dtable,DEFAULT, DEFAULT,z, t) -only if default is LINEAR
	There are also some linear interpolations with history functions. They are:
		FUNCTION REAL linearInterpHist1D( TABLE_1D my1Dtable,
	                                  REAL x,
	                                  OUT INTEGER pi )
	
		FUNCTION REAL linearInterpHist2D( TABLE_2D  my2Dtable,
	                                  REAL x,
	                                  REAL y,
	                                  OUT INTEGER  pi,
	                                  OUT INTEGER  pj )
	
		FUNCTION REAL linearInterpHist3D( TABLE_3D my3Dtable,
	                                  REAL x,
	                                  REAL y,
	                                  REAL z,
	                                  OUT INTEGER  pi,
	                                  OUT INTEGER  pj,
	                                  OUT INTEGER  pk )
	For example, using interpolation to calculate a variable:
		x = linearInterpHist2D (my2Dtable, z, t, pi, pj)
		This is equivalent to writing (using the general interpolation functions):
			x = interpHist2D(my2Dtable,SPLINE,SPLINE,z, t, pi, pj)
			x = interpHistd2D (my2Dtable,z, t, pi, pj)
			x = interpHist2D(my2Dtable,DEFAULT, DEFAULT,z, t, pi, pj) -only if default is LINEAR
	
	
		Interpolation with Spline Algorithm in Tables
	There are some similar counterpart functions to interpolate using the SPLINE methods directly. The following functions are available for this interpolation:
		FUNCTION REAL splineInterp1D( TABLE_1D my1Dtable,
	                              REAL x )
	
		FUNCTION REAL splineInterp2D( TABLE_2D my2Dtable,
	                              REAL x,
	                              REAL y )
	
		FUNCTION REAL invSplineInterp1D( TABLE_1D my1Dtable,
	                                 REAL val )
	For example, using interpolation to calculate a variable:
		x = splineInterp2D (my2Dtable, z, t)
	This is equivalent to writing (using the general interpolation functions):
		x = interp2D(my2Dtable,LINEAR,LINEAR,z, t)
	The invSplineInterp1D() function is the inverse function of splineInterp1D(). This function can be used either directly by the user for making reverse calculation (x= splineInterp1D (y) transformed to y= invSplineInterp1D (x)) or internally by the tool to calculate variable y. For example, if a variable is determined as:
		x = splineInterp1D(mtab, y) 
	The tool knows  since it knows how to transform the previous equation into this one:
		y = invSplineInterp1D(mtab, x)
		
	Interpolation with Akima Method
	There are other interpolation methods available for the Akima method. The following functions are available for this interpolation:
		FUNCTION REAL akimaInterp1D( TABLE_1D my1Dtable,
	                             REAL x )
	
		FUNCTION REAL akimaInterp2D( TABLE_2D my2Dtable,
	                             REAL x,
	                             REAL y )
	For example, using interpolation to calculate a variable:
		x = akimaInterp2D (my2Dtable, z, t)
	This is equivalent to writing (using the general interpolation functions):
		x = interp2D(my2Dtable,AKIMA, AKIMA,z, t)
	
*/
// Interpolations with events detection
/*
	One of the most common problems when using linear or constant interpolation are the discontinuities that are produced in each of the segment crossing points on the interpolation curve which, in many cases, can lead to problems of non-convergence. If the interpolation is done with respect to TIME, there are special functions that are entrusted with handling these discontinuities properly. 
	These functions provide a family of time interpolation functions which use TIME as the input parameter in the table and avoid discontinuity problems between two intervals. The available functions are:
	
	FUNCTION REAL timeTableInterp( REAL TIME,
	                               TABLE_1D table )
	
	FUNCTION REAL timeTableStep( REAL TIME,
	                             TABLE_1D table
	
	FUNCTION REAL periodTimeTableInterp( REAL TIME,
	                                     TABLE_1D table,
	                                     REAL period )
	
	FUNCTION REAL periodTimeTableStep( REAL TIME,
	                                   TABLE_1D table,
	                                   REAL period )
	The function timeTableInterp() is similar to linearInterp1D() and interp1D(table,LINEAR,LINEAR,TIME) but deals properly with discontinuities
	The difference with linearInterp1D(myTable,TIME) is that this function identifies the crossing points (eg, at time 100, 200, etc.), it pauses the simulation, makes the change of the x value, solves the residues with this new value and continues. In other words, it is a  interpolation handling discontinuities
	The difference with interp1D(myTable,CONSTANT,CONSTANT,TIME) is that this function identifies the crossing points and it handles the changes properly. You can see in the figure how at TIME=100 the crossing point is detected and handled
	The function periodTimeTableInterp() is similar to timeTableInterp() but with a repeatable period from the table
	The function periodTimeTableStep() is similar to periodTimeTableInterp() but returns the step value for the table

*/
COMPONENT comp_interpolationsWithEventsDetection
    DATA
        TABLE_1D myTable = { {0,100,200,300,400,500},{1, 3, 2, 4, 5, 1} }
    DECLS
        REAL x
		  REAL y
		  REAL z
		  REAL m
    CONTINUOUS
        x= timeTableInterp(TIME, myTable) --The difference with linearInterp1D(myTable,TIME) is that this function identifies the crossing points (eg, at time 100, 200, etc.), it pauses the simulation, makes the change of the x value, solves the residues with this new value and continues. In other words, it is a  interpolation handling discontinuities
		  y= timeTableStep(TIME, myTable) --The function timeTableStep() is similar to interp1D(myTable,CONSTANT,CONSTANT,TIME) but handles the discontinuities properly. It returns the step position at time TIME from the table. It is not an interpolation but just the step value at that position
		  z= periodTimeTableInterp(TIME, myTable,200)
		  m= periodTimeTableStep(TIME, myTable,200)
END COMPONENT
//	Advanced Interpolation Functions on Table Intervals
/*
	EL provides another family of advanced functions to detect which interval of the table a variable is in and to interpolate in a specific interval. These functions allow the user to manually handle the discontinuities at the connection points between two intervals. In previous functions the handling of discontinuities was done internally by the solver but these functions allow them to be handled by the modeller.
	Important: the intervals begin with value 0 for the first interval, 1 for the second, and so on.
	To detect what the actual interval is during an interpolation, the available functions are:
	FUNCTION BOOLEAN cellCrossing1D( TABLE_1D tbl, 
	   					REAL x, 
	   					INTEGER pi, 
	   					OUT INTEGER i )
	
	FUNCTION BOOLEAN cellCrossing2D( TABLE_2D tbl, 
	   					REAL x, 
	   					REAL y, 
	   					INTEGER pi, 
	   					OUT INTEGER i,  
	   					INTEGER pj, 
	   					OUT INTEGER j )
	
	FUNCTION BOOLEAN cellCrossing3D( TABLE_3D tbl, 
	   					REAL x, 
	   					REAL y, 
	   					REAL z, 
	   					INTEGER pi, 
	   					OUT INTEGER i, 
	   					INTEGER pj, 
	   					OUT INTEGER j,  
	   					INTEGER pk, 
	   					OUT INTEGER k )
	These functions return TRUE when the interval number of x is different from "pi","pj" and "pk" (depending on the dimension). The new interval is stored in "i", "j" and "k". 
	There is another family of functions for linear interpolation in a specific interval, namely:
	FUNCTION REAL cellLinearInterp1D( TABLE_1D tbl, 
	                                  REAL x, 
	                                  INTEGER i )
	
	
	FUNCTION REAL cellLinearInterp2D( TABLE_2D tbl, 
	                                  REAL x, 
	                                  REAL y,  
	                                  IN INTEGER i, 
	                                  INTEGER j )
	
	FUNCTION REAL cellLinearInterp3D( TABLE_3D tbl, 
	                                  REAL x, 
	                                  REAL y, 
	                                  REAL z,  
	                                  INTEGER i, 
	                                  INTEGER j, 
	                                  INTEGER k )
	These functions return the linear interpolated or extrapolated value of x, y and z with respect to the i-th, j-th and k-th interval (depending on dimensions) of the table tbl.
	

*/
COMPONENT comp_advancedInterpolationFunconTableIntervals
	DATA
     TABLE_1D table = { {0,100,200,300,400,500},{1, 3, 2, 4, 5, 1} } 
  	DECLS
     INTEGER i, pi=0
     REAL signal_out=0
	  REAL x
  	DISCRETE
     WHEN (cellCrossing1D( table, TIME, pi, i)) THEN
        WRITE("\n***Detected crossing at TIME=%g, previous interval=%d,new interval=%d\n\n",TIME,pi,i)
        pi = i
     END WHEN
  	CONTINUOUS
    signal_out = cellLinearInterp1D( table, TIME, pi )
	 x = cellLinearInterp1D( table, TIME, 2) --without interval detection 
END COMPONENT
// Waveform Functions
/*
	The program provides a set of functions normally used to generate inputs to simulation variables based normally on TIME input variable. These are very useful but they are often difficult to program, as they are discontinuous. Sometimes this discontinuity is not important or does not have much influence on the system of equations and can be ignored. In such functions the discontinuities are detected automatically by the program. Each discontinuity is handled properly to continue the simulation. The following functions have been implemented in the predefined libraries for use in models and experiments.
	The first argument to all these functions is time. Generally, TIME is used, but you can also specify a phase lag over time, by using an expression like, for example, TIME+phase.

		square() function
	This function generates a square wave form, as shown in the following figure:
	  
	The function prototype is:
	"C++" FUNCTION REAL square( REAL xtime, REAL period )    
	Where xtime is the time of calculation and period is the desired period of change

		step() function
	This function generates a step wave form, as shown in the following figure:
	 
	The function prototype is:
	"C++" FUNCTION REAL step( REAL xtime, REAL timeStep )   
	Where xtime is the time of calculation and timeStep is the delay to generate the step
	
		pulse() function
	This function generates a pulse wave form, as shown in the following figure:
	 
	The function prototype is:
	"C++" FUNCTION REAL pulse( REAL xtime,
	                           REAL period,
	                           REAL width )    
	Where xtime is the time of calculation, period is the delay between pulses, and width is the size of the pulse
	
		ramp() function
	This function generates a pulse wave form, as shown in the following figure:
	  
	The function prototype is:
	"C++" FUNCTION REAL ramp( REAL xtime, REAL period ) 
	Where xtime is the time of calculation and period gives the width of the ramp

*/
COMPONENT comp_waveformFunctions
DECLS
    REAL x
	 REAL y
	 REAL z
	 REAL m
  CONTINUOUS
    	x=  square(TIME, 2)
		y=  step(TIME, 2)
	 	z=  pulse(TIME,2,0.5)
		m=  ramp(TIME,1.5)
END COMPONENT
// Use basic tables as objects
/*
	In newer versions of the EL compiler it is also allowed to use variables of types TABLE_1D, TABLE_2D, and TABLE_3D just as if they were instances of TABLE class

*/
TABLE_1D global_libvarT1 = { { 0 , 0.5 , 1 } , { 67.23 , 4.83 , 3.23} }
FUNCTION NO_TYPE func_useTypesTable1DTable2dTable3d()
  DECLS
    REAL vr
    TABLE_1D fcn_libvarT1 = { { 0 , 0.5 , 1 } , { 67.23 , 4.83 , 3.23} }
  BODY
    global_libvarT1.getValue(2,0,0,vr)
    fcn_libvarT1.getValue(2,0,0,vr)
    vr = interp1D(global_libvarT1,LINEAR,LINEAR,0.25)
    vr = interp1D(fcn_libvarT1,LINEAR,LINEAR,0.25)
END FUNCTION

COMPONENT comp_useTypesTable1DTable2dTable3d
  DATA
    TABLE_1D dataT1 = { { 0 , 0.5 , 1 } , { 67.23 , 4.83 , 3.23} }
    TABLE_2D dataT2 = { { 1 , 2 } , { 0.9 , 1.0 , 1.2 } , { { 4 , 6 , 7 } , { 2 , 3 , 2 } } } 
    TABLE_3D dataT3 = { { 1. , 2. } , { 1. , 2. , 3. } , { 4 , 5 } ,
			{ { { 1. , 2. } , { 3. , 4. } , { 5. , 6. } } ,
			{ { 11. , 12. } , { 13. , 14. } , { 15. , 16. } } }
			}
    REAL dataReal = 0.7
  DECLS
    INTEGER varDiscrete 
    REAL varExplicit
    TABLE_1D varT1 = { { 0 , 0.5 , 1 } , { 67.23 , 4.83 , 3.23} }
    TABLE_2D varT2 = { { 1 , 2 } , { 0.9 , 1.0 , 1.2 } , { { 4 , 6 , 7 } , { 2 , 3 , 2  } } }
    TABLE_3D varT3 = { { 1. , 2. } , { 1. , 2. , 3. } , { 4 , 5 } ,
				{ { { 1. , 2. } , { 3. , 4. } , { 5. , 6. } } ,
				{ { 11. , 12. } , { 13. , 14. } , { 15. , 16. } } }
				}
  INIT
    func_useTypesTable1DTable2dTable3d()
  CONTINUOUS
  varExplicit = sin(TIME) + varT1.nx() + global_libvarT1.interpd1D(dataReal) +  interp1D(global_libvarT1,LINEAR,LINEAR,0.25) + interp1D(varT1,LINEAR,LINEAR,0.25)
END COMPONENT