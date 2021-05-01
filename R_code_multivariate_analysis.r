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

# diminuisco la dimensione dell'immagine aggregando i pixel (ricampionamento)
p224r63_2011res <- aggregate(p224r63_2011, fact=10)


par(mfrow=c(2,1)) # apro una finestra grafica 2x1
plotRGB(p224r63_2011, 4, 3, 2, stretch="lin") # plotto l'immagine originale
plotRGB(p224r63_2011res, 4, 3, 2, stretch="lin") # plotto l'immagine ricampionata

# PCA
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

summary(p224r63_2011res_pca$model) # sommario del modello 
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin") #plotto le prime 3 bande 
