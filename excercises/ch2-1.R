#!/usr/bin/Rscript

# install this if nec. using install.packages("multicore", type="source")
library(plyr)
library(multicore)

# get all csvs from the doing data science NYT set
infiles <- dir("~/doing_data_science/oreilly_source/dds_datasets/dds_ch2_nyt/", pattern="\\.csv$")

import <- function(file){
	# get the data straight from the file
	cat(paste("processing", file))
	cat("\n")
	data <- read.csv(paste("~/doing_data_science/oreilly_source/dds_datasets/dds_ch2_nyt/", file, sep=""))

	# add a col describing the file name
	cat(paste("adding file column to", file))
	cat("\n")
	data$sfile <- apply(data, 1, function(row){
		file
	})

	return(data)
}

list.of.dfs <- mclapply(infiles, import)

master_df <- ldply(list.of.dfs, data.frame)
summary(master_df)