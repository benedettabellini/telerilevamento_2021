# R_code_knitr.r

setwd("/Users/benedettabellini/lab/") #setto cartella di lavoro

library(knitr) # richiamo il pacchetto knitr

install.packages("tinytex") #installo pacchetto tinytex
library(tinytex) # richiamo il pacchetto

inytex::install_tinytex()
tinytex::tlmgr_update()

stitch("R_code_greenland.r.rtf", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
