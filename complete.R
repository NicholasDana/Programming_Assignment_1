complete <- function(directory, id = 1:332) {
	## 'directory' is a character vector of length 1 indicating
	## the location of the CSV files

	## 'id' is an integer vector indicating the monitor ID numbers
	## to be used

	## Return a data frame of the form:
	## id nobs
	## 1  117
	## 2  1041
	## ...
	## where 'id' is the monitor ID number and 'nobs' is the
	## number of complete cases
	
	
	tag=sprintf("%03d.csv", id)
	##formatting the input id to make a list of relevent file names
	##could also use the following code to format the id
	##tag=paste(formatC(id, width=3, flag="0"), ".csv", sep="")
	
	tag=file.path(directory,tag)
	##file.path returns the full directory of locations in the wd
	##we can now open the files without changing the wd
	
	info=lapply(tag,read.csv)
	##using lapply to apply read.csv to all files stored in tag
	##the info from each file is indexed in the info list
	
	complete=lapply(info,complete.cases)
	##creating a list of vectors determining if a row is a complete case
	
	for(i in 1:length(id)){
	
		info[[i]]=info[[i]][complete[[i]],1:4]
		##aligning each element in the info list to its complete counterpart
		
	}
	
	nobs=unlist(lapply(info,nrow))
	##applying nrow to each element in the list info
	##this shows the amount of complete cases in each file
	##using unlist to turn the list output into a vector, as id is
	return(cbind.data.frame(id,nobs))
}