#!/usr/bin/env Rscript

########################################################
# Author: Kelly Dew-Budd
# Date: 10/14/2020
# Takes output of samtools depth and calculates 
# average coverage
########################################################


# check.packages function: install and load multiple R packages.
# Check to see if packages are installed. Install them if they are not, then load them into the R session.
check.packages <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg)) 
        install.packages(new.pkg, dependencies = TRUE, repos = "http://cran.us.r-project.org")
    sapply(pkg, require, character.only = TRUE)
}

packages <- c("plyr", "docopt")
check.packages(packages)


'Usage:
	Coverage_calc.r [-C <file> -o <output>]

Options:
	-C Output of samtools depth 
	-o name of output file

' -> doc

opts <- docopt(doc)
tmp1 <- read.table(opts$C, header = FALSE, sep = "\t")
tmp2 <- ddply(tmp1, .(V1), summarize, V2 = mean(V3))
tmp2$V3 <- opts$o
tmp2 <- tmp2[c("V3", "V1", "V2")]
write.table(tmp2, opts$o, quote = FALSE, col.names = FALSE, row.names = FALSE)