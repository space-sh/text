# Text module | [![build status](https://gitlab.com/space-sh/text/badges/master/build.svg)](https://gitlab.com/space-sh/text/commits/master)

Handles text file preprocessing.



## /extractvariables/
	Extract all variable names from a text


## /filter/
	Filter text content on STDIN on #ifdef, #ifndef

	Parses and filters away on #ifdef, #ifndef
	


## /getenv/
	For a list of extracted variables get their values in the current env


## /preprocess/
	Variable substitute and filter text on STDIN

	Does variable substitution using variables in environment,
	then parses and filters away on #ifdef, #ifndef
	


## /variablesubst/
	Substitute variables in text for their given values


# Functions 

## TEXT\_DEP\_INSTALL()  
  
  
  
Check for module dependencies  
  
### Returns:  
- non-zero on failure  
  
  
  
## TEXT\_PREPROCESS()  
Perform a variable substitution and preprocessing using the  
env variables at hand.  
  
