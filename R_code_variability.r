#R_code_variability.r 

library(raster) # richiamo pacchetto
library(RStoolbox)

setwd('/Users/benedettabellini/lab') #setto cartella di lavoro 

sent <- brick("sentinel.png") # importo l'immagine 
# NIR 1, RED 2, GREEN 3 
plotRGB(sent, stretch="lin") # plotto l'immagine 

nir <- sent$sentinel.1 # cambio nome alla banda
red <- sent$sentinel.2
ndvi <- (nir - red) / (nir + red) #calcolo indice di vegetazione
plot(ndvi) #plotto l'indice di vegetazione

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) #creo scala di colori
plot(ndvi,col=cl) #plotto l'indice di vegetazione con scala di colori creata

# Calcolo della deviazione standard dell'ndvi
ndvisd3 <- focal(ndvi, w=matrix(1/9,nrow=3,ncol=3), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvisd3, col=clsd) #plotto

#Calcolo della media dell'ndvi
ndvimean3 <- focal(ndvi, w=matrix(1/9,nrow=3,ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvimean3, col=clsd) #plotto

# Cambio grandezza della moving window 13x13
ndvisd13 <- focal(ndvi, w=matrix(1/169,nrow=13,ncol=13), fun=sd) #calcolo devizione standard
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvisd13, col=clsd) #plotto
