/*-----------------------------------------------------------------------------------------
 LIBRARY: MATH
 FILE: MATH_csv_to_tab
 DESCRIPTION: Utilities to convert CSV files into EcosimPro tables.
-----------------------------------------------------------------------------------------*/

--=============================================================================
-- Function: csv_to_tab1d
-- Purpose:
--    Reads a CSV file and builds a single 1D TABLE from two selected columns.
--    This is useful when CSV data must be imported into EcosimPro as tabulated
--    input data, where one column represents the independent variable (X axis)
--    and another column represents the dependent variable (Y axis).
--
-- Inputs:
--    fpath:
--       Path to the input CSV file.
--    col1:
--       Column index used as the X axis of the generated table.
--    col2:
--       Column index used as the Y axis of the generated table.
--    sep:
--       Field separator used in the CSV file. Default is ",".
--    headerRows:
--       Number of header rows to skip before reading numeric data.
--       Default is 1.
--
-- Outputs:
--    tab:
--       Generated 1D TABLE using col1 as X values and col2 as Y values.
--=============================================================================
FUNCTION NO_TYPE csv_to_tab1d (IN FILEPATH fpath, IN INTEGER col1, IN INTEGER col2, OUT TABLE tab, STRING sep = ",", INTEGER headerRows = 1)

   DECLS
      
      STRING auxString   "Auxiliary string used to store each line and each extracted field"
      FILEPATH file      "Path to the original CSV file"
      FILEPATH file_aux  "Path to the auxiliary file generated with space-separated fields"

   OBJECTS 
      PARSER_FILE fi     "Parser file class instance for reading"
      PARSER_STRING str  "String parser used to split fields inside each line"
      EFileCsv csv       "CSV object used to write the auxiliary file"
      
   BODY  
      -- Copy input path
      file = fpath
      
      -- Build auxiliary file name
      -- The extension is replaced with "_aux.csv"
      file_aux = file
      file_aux.replace(file_aux.rfind("."),file_aux.length(),"_aux.csv")

      -- Open original file for reading
      ASSERT (fi.open(file)) FATAL "CSV File opening failure. File cannot be loaded"   
   
      -- If header rows exist, skip them before processing data
      IF (headerRows!=0) THEN
         FOR (i IN 1,headerRows)
            fi.getLine(auxString)                            
         END FOR
      END IF

      -- Open auxiliary file using space as separator
      csv.open(file_aux," ")

      -- Read the full original file until the end
      WHILE fi.is_end() == FALSE 
         -- Read one complete line
         fi.getLine(auxString)
         -- Initialize string parser with the line just read
         str.set(auxString)
         -- Extract all fields from the line using the selected separator
         WHILE str.is_end() == FALSE   
            str.getField(auxString, sep)
            -- Write the extracted field into the auxiliary file
            csv.addString(auxString)
         END WHILE

         -- End current line in auxiliary file
         csv.newLine()
      END WHILE

      -- Close auxiliary file
      csv.close()
      -- Create the 1D table from two columns of the auxiliary file:
      tab.readCols1D(file_aux,col1,col2) 

END FUNCTION


--=============================================================================
-- Function: csv_to_ntab1d
-- Purpose:
--    Reads a CSV file and builds multiple 1D TABLE objects sharing the same
--    X column. This is useful when one independent variable must be associated
--    with several dependent-variable datasets, for example when importing
--    several curves from a single CSV file.
--
-- Inputs:
--    file:
--       Path to the input CSV file.
--    cols[]:
--       Array of column indices. cols[1] is used as the common X column,
--       and cols[2], cols[3], ... are used as Y columns for the generated
--       tables.
--    sep:
--       Field separator used in the CSV file. Default is ",".
--    headerRows:
--       Number of header rows to skip before reading numeric data.
--       Default is 1.
--
-- Outputs:
--    tab[]:
--       Array of generated 1D TABLE objects. Each table uses cols[1] as
--       X values and one of the remaining columns as Y values.
--=============================================================================
FUNCTION NO_TYPE csv_to_ntab1d (IN FILEPATH file, IN INTEGER cols[], OUT TABLE tab[], STRING sep = ",", INTEGER headerRows = 1)

   DECLS     
      STRING auxString   "Auxiliary string to store lines and fields"
      FILEPATH file_aux  "Path to the intermediate auxiliary file"
      INTEGER N          "Number of columns specified in the cols array"

   OBJECTS 
      PARSER_FILE fi     "Parser file class instance for reading"
      PARSER_STRING str  "String parser used to split fields with the selected separator"
      EFileCsv csv       "Object used to write the auxiliary file"
      
   BODY  
      -- Number of column indexes received in cols
      -- It is assumed that cols[1] is the common X column
      -- and the remaining entries are Y columns
      N = sizeArrayInt( cols[1], 0 )
      
      -- Build auxiliary file name
      -- The extension is replaced with "_aux.csv"
      file_aux = file
      file_aux.replace(file_aux.rfind("."),file_aux.length(),"_aux.csv")

      -- Open original CSV file
      ASSERT (fi.open(file)) FATAL "CSV File opening failure. File cannot be loaded"   
   
      -- Skip header rows, if any
      IF (headerRows!=0) THEN
         FOR (i IN 1,headerRows)
            fi.getLine(auxString)                            
         END FOR
      END IF

      -- Open auxiliary file with space as separator
      csv.open(file_aux," ")

      -- Process the full CSV file
      WHILE fi.is_end() == FALSE 
         -- Read one line
         fi.getLine(auxString)
         -- Initialize string parser
         str.set(auxString)
         -- Extract all fields from the line
         WHILE str.is_end() == FALSE   
            str.getField(auxString, sep)
            -- Write extracted field into auxiliary file
            csv.addString(auxString)
         END WHILE
         -- End current line in auxiliary file
         csv.newLine()
      END WHILE

      -- Close auxiliary file
      csv.close()

   -- Create multiple 1D tables:
   -- each tab[i] uses cols[1] as the common X column
   -- and cols[i+1] as its corresponding Y column
   FOR (i IN 1,N-1)
      tab[i].readCols1D(file_aux,cols[1],cols[i+1]) 
   END FOR

END FUNCTION