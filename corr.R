corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
		
		
		tag=list.files(directory)
		tag=file.path(directory,tag)
		info=lapply(tag,read.csv)
		##listing and opening all files in the specified directory
		
		complete=lapply(info,complete.cases)
		for(i in 1:length(list.files(directory))){
			info[[i]]=info[[i]][complete[[i]],1:4]}
		nobs=unlist(lapply(info,nrow))
		##determining the number of complete cases for each file
		
		correlations=vector()
		for(i in 1:length(list.files(directory))){
			if(nobs[i]>threshold){
				correlations=append(correlations,cor(info[[i]][,2],info[[i]][,3]))}}
		##adding to correlations vector if the nobs is greater that the threshold
		
		return(correlations)
}