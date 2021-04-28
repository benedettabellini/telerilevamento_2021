# R_code_vegetation_indices.r

library(raster) #richiamo il pacchetto 

setwd("/Users/benedettabellini/lab/") # setto la cartella di lavoro

# importo le immagini
defor1 <- brick("defor1.jpg.png")
defor2 <- brick("defor2.jpg.png")

# b1 = NIR, b2 = red, b3 = green
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
