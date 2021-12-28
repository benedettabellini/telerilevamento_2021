#Esame Telerilevamento 
# Sardegna occidentale, zona dell'Oristanese

install.packages("raster") #installo il pacchetto raster 
install.packages("rasterVIs") #installo il pacchetto rasterVis
install.packages("RStoolbox") #installo il pacchetto RStoolbox

#Richiamo i pacchetti installati in R
library(raster) 
library(rasterVis) 
library(RStoolbox) 
setwd("/Users/benedettabellini/sardegna") #setto la cartella di lavoro 

#Immagine del 16/09/2019
rlist <-list.files(pattern="T32TMK_20190916T101029_10m_B") #credo una lista di file 
#importo con la funzione <lapply> la lista appena creata che contiene tutti i file
import <- lapply(rlist,raster) #la funzione raster importa tutti i file e la applico alla lista 
Sard2019 <- stack(import) #la funzione <stack> raggruppa tutti i file della lista in un gruppo unico
#Applico il procedimento precedente anche all'immagine del 05/09/2021
rlist2 <-list.files(pattern="T32TMK_20210905T100549_10m_B")
import2 <- lapply(rlist2,raster)
Sard2021 <- stack(import2)

# presento le due immagini nel visibile, e le visualizzo in una finestra grafica 1x2
par(mfrow=c(1,2)) # la funzione <par> crea una finestra grafica
plotRGB(Sard2019, 3,2,1, stretch="lin") #la funzione <plotRGB> permette di visualizzare 3 bande alla volta
plotRGB(Sard2021, 3,2,1, stretch="lin")

# presento le due immagini in falsi colori, e le visualizzo in una finestra grafica 1x2
par(mfrow=c(1,2)) # con 
plotRGB(Sard2019, 4,3,1, stretch="lin")
plotRGB(Sard2021, 4,3,1, stretch="lin")

#Calcolo l'ndvi 
#ndvi=(NIR-RED)/(NIR+RED)
#ndvi 2019
red19 <- raster("T32TMK_20190916T101029_10m_B04.jp2")
nir19 <- brick("T32TMK_20190916T101029_10m_B08.jp2") 
ndvi19 <- (nir19-red19)/(nir19+red19)
plot(ndvi19)

#ndvi21
red21 <- brick("T32TMK_20210905T100549_10m_B04.jp2")
nir21 <- brick("T32TMK_20210905T100549_10m_B08.jp2")
ndvi21 <- (nir21-red21)/(nir21+red21)
plot(ndvi21)

# Visualizzo i due ndvi con una colorRampPalette
cl <- colorRampPalette(c("black","green","red"))(100)
par(mfrow=c(1,2))
plot(ndvi19, col=cl)
plot(ndvi21, col=cl)


cl <- colorRampPalette(c("black","dark red","orange","pink","green"))(100)

# cambio risoluzione all'immagine nir da 10m a 20 m 
swir19 <- brick("T32TMK_20190916T101029_B12.jp2") 
nir19_20m<- aggregate(nir19, fact=2)
writeRaster(nir19,"T32TMK_20190916T101029_20m_B12.tif")

NBR19 <- (nir19_20m-swir19)/(nir19_20m+swir19) # calcolo l'NBR
plot(NBR19, col=cl)
swir21 <- brick("T32TMK_20210905T100549_B12.jp2") 
nir21_20m<- aggregate(nir21, fact=2)
NBR21 <- (nir21_20m-swir21)/(nir21_20m+swir21)
plot(NBR21, col=cl)
par(mfrow=c(1,2))
plot(NBR19, col=cl)
plot(NBR21, col=cl)
deltaNBR <- NBR19-NBR21
plot(deltaNBR, col=cl)

ndvi <- ()

# Profilo spettrale

red21_20m<- aggregate(red21, fact=2)
list21_20m <- c("swir21","nir21_20m","red21_20m")
import21_20m <- lapply(list21_20m,raster)
Sard2021 <- stack(import2)
plotRGB(list21_20m, 1,2,3, stretch="lin")
