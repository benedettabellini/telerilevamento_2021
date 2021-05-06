# R_code_vegetation_indices.r

library(raster) #richiamo il pacchetto 
library(RStoolbox) # richiamo il pacchetto per calcolare gli ndvi
install.packages("rasterdiv") #carico il pacchetto rasterdiv per calcolorare gli ndvi del mondo
library(rasterdiv) # richiamo il pacchetto
library(rasterVis)

setwd("/Users/benedettabellini/lab/") # setto la cartella di lavoro

# importo le immagini
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1 = NIR, b2 = red, b3 = green
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# Calcoliamo indice di vegetazione 1
dvi1 <- defor1$defor1.1 - defor1$defor1.2 # differenza fra la banda NIR e banda RED
plot(dvi1)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # creo scala di colori
plot(dvi1, col=cl, main="DVI at time 1") # plotto l'immagine con la scala di colori creata

# indice di vegetazione 2 
dvi2 <- defor2$defor2.1 - defor2$defor2.2 # differenza fra la banda NIR e banda RED
plot(dvi2)
dev(off)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # creo scala di colori
plot(dvi2, col=cl, main="DVI at time 2")

#plotto insieme i due dvi
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# Diffirenza fra i due dvi
difdvi <- dvi1 - dvi2
cld <- colorRampPalette(c('blue', 'white', 'red'))(100) #creo scala di colori
plot(difdvi, col=cld) # plotto la differenza fra i dvi

# Calcolo ndvi
# (NIR-RED) / (NIR+RED)
#ndv1
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl) # lo visualizzo 

#ndvi2
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl) # lo visualizzo

# Differenza fra i due ndvi
difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue', 'white', 'red'))(100) # creo scala di colori
plot(difndvi, col=cld)

# RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green=3, red=2, nir=1) # calcolo tutti gli indici
plot(vi1, col=cl) # visualizzo gli indici calcolati 

vi2 <- spectralIndices(defor2, green=3, red=2, nir=1) # calcolo tutti gli indici
plot(vi2, col=cl)

# worldwide NDVI 
plot(copNDVI)

# trasformo i pixel con valori dei pixel 253, 254, 255 (acqua) in NA
copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) 
plot(copNDVI)

# raster package needed:
levelplot(copNDVI)






