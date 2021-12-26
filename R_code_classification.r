#R_code_classification

library(raster) #richiamo il pacchetto raster
library(RStoolbox) #richiamo il pacchetto RStoolbox

setwd("/Users/benedettabellini/lab/") #setto cartella di lavoro

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #importo su R l'immagine
so #visualizzo i dati dell'immagine

# visualize RGB levels
plotRGB(so, 1, 2, 3, stretch="lin")

# Unsupervised Classification
set.seed(42) # permette di usare sempre le stesse regole per fare il modello
soc <- unsuperClass(so, nClasses=3)
plot(soc$map) #visualizzo l'immagine in particolare la mappa

# # Unsupervised Classification with 20 classes
soc20 <- unsuperClass(so, nClasses=20)
plot(soc20$map)

# Download an image from:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("Sun.png")
# Unsupervised Classification
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map) #visualizzo l'immagine 

# Grand Canyon 
# Download image from:
# https://landsat.visibleearth.nasa.gov/view.php?id=80948

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg") # importo su R l'immagine
plotRGB(gc, 1, 2, 3, stretch="lin") # plotto l'immagine con 3 strati 
plotRGB(gc, 1, 2, 3, stretch="hist")

# Unsupervised Classification with 2 classes
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

# Unsupervised Classification with 4 classes
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)
