pollutantmean <- function(directory, pollutant, id = 1:332) {
	## 'directory' is a character vector of length 1 indicating
	## the location of the CSV files

	## 'pollutant' is a character vector of length 1 indicating
	## the name of the pollutant for which we will calculate the
	## mean; either "sulfate" or "nitrate".

	## 'id' is an integer vector indicating the monitor ID numbers
	## to be used
	
	## Return the mean of the pollutant across all monitors list
	## in the 'id' vector (ignoring NA values)
	## NOTE: Do not round the result!

	
	tag=sprintf("%03d.csv", id)
	##formmatting the input id to make a list of relavent file names
	##could also use the following code to format the id
	##tag=paste(formatC(id, width=3, flag="0"), ".csv", sep="")
	
	tag=file.path(directory,tag)
	##file.path returns the full directory of locations in the wd
	##we can now open the files without changing the wd
	
	info=lapply(tag,read.csv)
	##using lapply to apply read.csv to all files stored in tag
	##the info from each file is indexed in the info list
	
	info=do.call(rbind.data.frame,info)
	##do.call calls a function and passes all other arguments to that function
	##so each item(dataframe) of the list 'info' is passed seperated to rbind.data.frame
	##do.call is useful for passing lists of arguments to a function
	##rbind combines the given lists/dataframes row by row
	##data.frame creates a dataframe from the output of the rbind()
	##data.frame isn't needed because all passed arguments are dataframes
	
	mean(info[,pollutant],na.rm=TRUE)
	##na.rm ignroed NA values found in the file
	##finding the mean of the called for pollutant
	##because it is a dataset we can call the column by its name
	##the name of the column is given by the header line from read.csv
	
}