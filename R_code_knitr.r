# R_code_knitr.r

setwd("/Users/benedettabellini/lab/") #setto cartella di lavoro

library(knitr) # richiamo il pacchetto knitr

stitch("R_code_greenland.rtf", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
