#R_code_classification

library(raster) #richiamo il pacchetto raster
library(RStoolbox) #richiamo il pacchetto RStoolbox

setwd("/Users/benedettabellini/lab/") #setto la cartella di lavoro

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #importo su R l'immagine
so #visualizzo i dati dell'immagine

# visualize RGB levels
plotRGB(so, 1, 2, 3, stretch="lin")

# Unsupervised Classification
soc <- unsuperClass(so, nClasses=3)
plot(soc$map) #visualizzo l'immagine 

# # Unsupervised Classification with 20 classes
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)
