# R_code_multivariate_analysis.r

library(raster) #richiamo il pacchetto raster
library(RStoolbox) # richiamo il pacchetto RStoolbox

setwd("/Users/benedettabellini/lab/") # setto cartella di lavoro
p224r63_2011 <- brick("p224r63_2011_masked.grd") # importo l'immagine 

plot(p224r63_2011) # plotto l'immagine con le varie bande

p224r63_2011 # vedo informazione dell'immagine

# plottiamo i valori dei pixel della banda 1 contro i valori dei pixel della banda 2
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)

# Plotto tutte le possibili correlazioni tra tutte le variabili
pairs(p224r63_2011)
