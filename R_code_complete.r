# R complete - Telerilevamento Geo-ecologico

#-------------------------------------------
# Summary:
# 1. Remote sensing first code
# 2. R code time series
# 3. R code Copernicus data
# 4. R code knitr 
# 5. R code multivariete analysis 
# 6. R code classification 
# 7. R code ggplot2
# 8. R code vegetation indices
# 9. R code land cover 
# 10. R code variability
# 11. R code spectral signatures

#-------------------------------------------

# 1. Remote sensing first code

# Il mio primo codice in R per il telerilevamento
install.packages("raster") # installo il pacchetto raster, il pacchetto è esterno ad R
library(raster) #richiamo il pacchetto installato
setwd("/Users/benedettabellini/lab/") # indicazione cartella di lavoro

# Importo l'immagine satellitare e la visualizzo
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

### Day 2 
# colour change
cl <- colorRampPalette(c("black","grey","light grey"))(100) 
plot(p224r63_2011, col=cl)

# colour change -> new 
cls <- colorRampPalette(c("blue","red","magenta","pink","white"))(100)
plot(p224r63_2011, col=cls) #plotto l'immagine con la nuova scala di colori 

### Day 3
# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio 

# dev.off will clean the current graph
dev.off()

# plot only band 1
plot(p224r63_2011$B1_sre)

# plot band 1 with a predefined colorRampPalette 
clt <- colorRampPalette(c('purple','orange','pink','white'))(100)
plot(p224r63_2011$B1_sre, col=clt)

dev.off()

# par(mfrow...) prepara lo schermo a mettere le immagini in un dato numero di righe e colonne
par(mfrow=c(1,2)) # par(mfcol...) se vogliamo usare prima il numero di colonne
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
# 2 righe e 1 colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# Plottiamo le 4 immagini di Landsat in 4 righe e 1 colonna
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# a quadrat of bands
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# per ogni banda stabiliamo una colorRampPalette
par(mfrow=c(2,2))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clnir)

### Day 4
# Visualizing data by RGB plotting

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio 

# RGB permette di visualizzare tre bande per volta 
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") # alla componenre R associo la banda del rosso, alla G associo banda del verde e B la banda del blu
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # alla componente R associo la banda 4 cioè NIR
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# mount a 2x2 multiframe
pdf("il_mio_primo_pdf_con_R.pdf") #crea un pdf che viene salvato nella cartella di lavoro
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

# use stretch linear
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
# use stretch histogram
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# par natural colours, false colours and false colours with histogram stretching
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# Installo il pacchetto RStoolbox
install.packages("RStoolbox")
# Richiamo pacchetto installato
library(RStoolbox)

# Installo il pacchetto ggplot2
install.packages("ggplot2")
library(ggplot2) #richiamo il pacchetto ggplot2

### DAY 5
# Multitemporal set
p224r63_1988 <- brick("p224r63_1988_masked.grd") # importo l'immagine satellitare del 1988 e le assegno un nome
p224r63_1998 

plot(p224r63_1988) # visualizzazione grafica delle singole bande
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin") # uso per la visualizzazione tre bande quella del rosso, del verde e del blu
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") # associo NIR alla componente red 

# Visualizzo in una finestra 2x1 l'immagine satellitare del 2011 e del 1988
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") 
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# creo un pdf
pdf("multitemp.pdf")
par(mfrow=c(2,2)) 
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin") # uso stretch lineare
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist") # use histogram stretching
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

#-------------------------------------------

# 2. R code time series

# Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

# install.packages("raster")
library(raster) # richiamo il pacchetto installato

setwd("/Users/benedettabellini/lab/greenland/")

install.packages("rasterVis") # installo il pacchetto rasterVis
library(rasterVis) # richiamo il pacchetto installato

# Importo un file alla volta utilizzando la funzione raster 
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)

# visualizzo le quattro immagini in una finestra 2x2
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# creo una lista di file con la funzione list.files
rlist <- list.files(pattern="lst") #prendo tutti i file che hanno 'lst' in comune nel nome 
rlist
# Importo con la funzione lapply la lista appena creata che contiene tutti i file 
import <- lapply(rlist,raster) #la funzione raster è quella che importa tutti i file e la applico alla lista  
import

# Creazione di un gruppo unico di file raster (raggruppo i file nella lista) tramite la funzione stack
TGr <- stack(import)
TGr
plot(TGr) # visualizzo il singolo file 

plotRGB(TGr, 1, 2, 3, stretch="Lin") # creazione tre immagini sovrapposte del 2000,2005,2010
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")

levelplot(TGr)
levelplot(TGr$lst_2000) #plotto un singolo strato con la media indicata 

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100) # cambio colore della legenda 
levelplot(TGr,col.regions=cl) # plotto l'immagine con il colore cambiato 

levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) # rinomino i layers all'interno dell'immagine

levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) # assegno un titolo all'immagine

#creo meltlist
melt_list <- list.files(pattern="annual") #creo una lista con dentro i file con i valori di ghiaccio negli anni dal '79 al 2007
melt_import <- lapply(melt_list,raster) # applico alla lista creata la funzione raster per importarla
melt <- stack(melt_import) # raggruppo tutti i file che ho importato
melt
levelplot(melt)
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt # sottraggo l'immagine del 1979 al 2007
clb <- colorRampPalette(c("blue", "white","red"))(100) # creo una scala di colori
plot(melt_amount, col=clb) # plotto la differenza fra i due anni 
levelplot(melt_amount, col.regions=clb)

#-------------------------------------------

# 3. R code Copernicus data

# R_code_copernicus.r
# Visualizing Copernicus data

install.packages("ncdf4") # installo il pacchetto "ncdf4"
library(raster) #richiamo il pacchetto "raster" installato precedentemente 
library(ncdf4) # richiamo il pacchetto installato

setwd("/Users/benedettabellini/lab") # setto cartella di lavoro

albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc") # con raster carico un singolo strato

cl <- colorRampPalette(c('light blue','green','red','yellow'))(100) # creo scala di colori
plot(albedo, col=cl) # plottiamo l'albedo con la scala di colori creata 

# ricampionamento (diminuzione della risoluzione)
albedores <- aggregate(albedo, fact=100) # diminuisco l'informazione di 10000 volte
plot(albedores, col=cl)

#-------------------------------------------

# 4. R code knitr 

# R_code_knitr.r

setwd("/Users/benedettabellini/lab/") #setto cartella di lavoro

library(knitr) # richiamo il pacchetto knitr

install.packages("tinytex") #installo pacchetto tinytex
library(tinytex) # richiamo il pacchetto


stitch("R_code_greenland.r.rtf", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#-------------------------------------------

# 5. R code multivariete analysis 

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
plot(p224r63_2011res_pca$map) # visualizzo le varie componenti
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin") #plotto le prime 3 bande 

#-------------------------------------------

# 6. R code classification 

#R_code_classification

library(raster) #richiamo il pacchetto raster
library(RStoolbox) #richiamo il pacchetto RStoolbox

setwd("/Users/benedettabellini/lab/") #setto la cartella di lavoro

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

#-------------------------------------------

# 7. R code ggplot2

# Richiamo i pacchetti precedentemente istallati 
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/") #setto la cartella di lavoro

p224r63 <- brick("p224r63_2011_masked.grd")# importo l'immagine con la funzione <brick>

ggRGB(p224r63,3,2,1, stretch="lin") 
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin") #r=3, g=2, b=1
p2 <- ggRGB(p224r63,4,3,2, stretch="lin") #r=4, g=3, b=1

#Visualizzo insieme le due immagini RGB
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#-------------------------------------------

# 8. R code vegetation indices

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
plot(difndvi, col=cld) # plotto l'ndvi con la nuova scala di colori

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

#-------------------------------------------

# 9. R code land cover 

#R_code_land_cover.r

library(raster)
library(RStoolbox) # serve per la classification
install.packages("ggplot2") # installo il pacchetto ggplot2
library(ggplot2)
install.packages("gridExtra") # installo il pacchetto gridExtra
library(gridExtra) 

setwd("/Users/benedettabellini/lab/") #setto cartella di lavoro

# carico dataset 
defor1 <- brick("defor1.jpg")
plotRGB(defor1, 1, 2, 3, stretch="lin") # plotto 
ggRGB(defor1, 1, 2, 3, stretch="lin") # plotto gli assi e le coordinate spaziali dell'oggetto

# carico seconda immagine
defor2<- brick("defor2.jpg")
plotRGB(defor2, 1, 2, 3, stretch="lin") # plotto 
ggRGB(defor2, 1, 2, 3, stretch="lin") 

# mettiamo in fila le due immagini
par(mfrow=c(1,2)) # creao una finestra grafica con una riga e due colonne
plotRGB(defor1, 1, 2, 3, stretch="lin")
plotRGB(defor2, 1, 2, 3, stretch="lin")

# multiframe con <ggplot2> e <gridExtra>
p1 <- ggRGB(defor1, 1, 2, 3, stretch="lin")
p2 <- ggRGB(defor2, 1, 2, 3, stretch="lin")
grid.arrange(p1, p2, nrow=2) # plotto immagini su due righe 

# Unsupervised classification
d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map) #plotto la mappa
# class 1: foresta
# class 2: agricoltura

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map) #plotto la mappa
# class 1: agricoltura
# class 2: foresta

# con 3 classi
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

# frequencies
freq(d1c$map)
#    value  count
# [1,]     1 305010
# [2,]     2  36282

s1 <-  305010 + 36282
# 341292
prop1 <- freq(d1c$map) / s1
# prop foresta: 0.8936922
# prop agricoltura: 0.1063078

s2 <- 342726
prop2 <- freq(d2c$map) / s2
# prop foresta: 0.5209263
# prop agricoltura: 0.4790737

# build a dataframe
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.36 , 10.63)
percent_2006 <- c(52.09, 47.90)
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

# let's plot 
#1992
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
# 2006
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1) # plotto i due ggplot di fianco 

#-------------------------------------------

# 10. R code variability

#R_code_variability.r 

library(raster) # richiamo pacchetto
library(RStoolbox)
library(ggplot2) # for ggplot plotting
library(gridExtra) # for plotting ggplot together
install.packages("viridis")
library(viridis) # for ggplot colouring

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
ndvisd3 <- focal(ndvi, w=matrix(1/9,nrow=3,ncol=3), fun=sd) #con moving window 3x3
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvisd3, col=clsd) #plotto

#Calcolo della media dell'ndvi
ndvimean3 <- focal(ndvi, w=matrix(1/9,nrow=3,ncol=3), fun=mean) #con moving window 3x3
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvimean3, col=clsd) #plotto

# Uso moving window 13x13
ndvisd13 <- focal(ndvi, w=matrix(1/169,nrow=13,ncol=13), fun=sd) #calcolo devizione standard
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvisd13, col=clsd) #plotto

# Uso moving window 5x5
ndvisd5 <- focal(ndvi, w=matrix(1/25,nrow=5,ncol=5), fun=sd) #calcolo devizione standard
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(ndvisd5, col=clsd) #plotto

# PCA 
sentpca <- rasterPCA(sent)
plot(sentpca$map)
summary(sentpca$model) #the first PC contains 67.3604% of the original information
pc1 <- sentpca$map$PC1 #prendo la prima componente principale
pc1sd5 <- focal(pc1, w=matrix(1/25,nrow=5,ncol=5), fun=sd) #calcolo sd sulla pc1 con moving window 5x5
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #creo scala di colori
plot(pc1sd5, col=clsd) #plotto

# Con la funzione source carico il codice "source_test_lezione.r" in modo che R lo esegua
source("source_test_lezione.r") # "source_test_lezione.r" calcola la sd con finestra 7x7
# carico il codice "source_ggplot.r"
source("source_ggplot.r")

# uso ggplot per plottare le mappa di sd della pc1
p1 <- ggplot()+ #creo finestra vuota
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill= layer))+ #definisco geometria
scale_fill_viridis()+ #uso scala di colore viridis
ggtitle("Standard deviation of PC1 by viridis colour scale") #aggiungo titolo

#uso legenda "magma"
p2 <- ggplot()+ #creo finestra vuota
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill= layer))+ #definisco geometria
scale_fill_viridis(option = "magma")+
ggtitle("Standard deviation of PC1 by magma colour scale") #aggiungo titolo
#uso legenda "inferno"
p3 <- ggplot()+ #creo finestra vuota
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill= layer))+ #definisco geometria
scale_fill_viridis(option = "turbo")+
ggtitle("Standard deviation of PC1 by turbo colour scale") #aggiungo titolo

grid.arrange(p1, p2, p3, nrow=1) #metto insieme le tre mappe 

#-------------------------------------------

# 11. R code spectral signatures

# R_code_spectral_signatures.r

# Richiamo i pacchetti precedentemente installati
library(raster)
library(rgdal)
library(ggplot2)

setwd("/Users/benedettabellini/lab/") # setto la cartella di lavoro

defor2 <- brick("defor2.jpg") #importo l'immagine e l'associo alla variabile 
# NIR, red, green
plotRGB(defor2, 1, 2, 3, stretch="Lin")
plotRGB(defor2, 1, 2, 3, stretch="hist")

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow") #clicco nella mappa per avere informazioni di riflettanza nelle 3 bande
# Results: 
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 178.5 435.5 30293      206       6       19
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 571.5 245.5 166916      40      99      139

# define the columns of the dataset:
band <- c(1,2,3) # metto le bande 1,2,3
forest <- c(206, 6,19) #metto i valori di riflettanza 
water <- c(40,99,139) #metto i valori di riflettanza 
# create the dataframe
spectrals <- data.frame(band, forest, water)

ggplot(spectrals, aes(x=band)) + 
     geom_line(aes(y = forest), color = "green")+
     geom_line(aes(y = water), color = "blue", linetype = "dotted")+
     labs(x="band", y="reflectance")

#################### Multitemporale

defor1 <- brick("defor1.jpg")
plotRGB(defor1, 1, 2, 3, stretch="Lin")
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# Results defor1:
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 89.5 339.5 98622      223       11       33
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 42.5 336.5 100717     218       16       38
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 64.5 341.5 97169     213      36      46
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 80.5 326.5 107895      208       2       22
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 76.5 374.5 73619      224      21      41

plotRGB(defor2, 1, 2, 3, stretch="Lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# Results defor2: 
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 86.5 339.5 99033      197       163      151
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 104.5 338.5 99768     149       157      133
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 110.5 354.5 88302    197      132       128
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 90.5 320.5 112660     169      166       149
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 97.5 309.5 120554     150       137      129

# define the columns of the dataset:
band <- c(1,2,3) 
time1 <- c(223, 11,33)  #facciamo per il primo pixel
time1p2 <- c(218,16,38)
time2 <- c(197,163,151) 
time2p2 <- c(149,157,133)
# create the dataframe
spectralst <- data.frame(band, time1, time2)
ggplot(spectralst, aes(x=band)) + 
     geom_line(aes(y = time1), color = "red", linetype="dotted")+
     geom_line(aes(y = time1p2), color = "red", linetype="dotted"))+
     geom_line(aes(y = time2), color = "gray", linetype = "dotted")+
     geom_line(aes(y = time2p2), color = "gray", linetype="dotted"))+
     labs(x="band", y="reflectance")

# image of Earth observatory
eo <- brick("june_puzzler.jpg")
click(eo, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# output:
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 93.5 373.5 76414    187      163       11
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 219.5 285.5 139900     11      140       0
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 184.5 315.5 118265     41       40      20

# define the columns of the dataset:
band <- c(1,2,3) 
stratum1 <- c(187, 163,11)  #facciamo per il primo pixel
stratum2 <- c(11,140,0) 
stratum3 <- c(41,40,20)
# create the dataframe
spectralsg <- data.frame(band, stratum1, stratum2, stratum3)
ggplot(spectralsg, aes(x=band)) + 
     geom_line(aes(y = stratum1), color = "yellow")+
     geom_line(aes(y = stratum2), color = "green")+
     geom_line(aes(y = stratum3), color = "blue")+
     labs(x="band", y="reflectance")

#-------------------------------------------
