# Il mio primo codice in R per il telerilevamento

library(raster)
setwd("/Users/benedettabellini/lab/")

# Importo l'immagine satellitare e la visualizzo
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

# colour change
cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(p224r63_2011, col=cl)

# colour change -> new 
cl <- colorRampPalette(c("purple","green","magenta"))(100)
plot(p224r63_2011, col=cl)
