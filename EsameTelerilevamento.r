#Esame Telerilevamento 
# Sardegna occidentale, zona dell'Oristanese

install.packages("raster") #installo il pacchetto raster 
install.packages("rasterVIs") #installo il pacchetto rasterVis
install.packages("RStoolbox") #installo il pacchetto RStoolbox
install.packages("rasterdiv") #installo il pacchetto rasterdiv

#Richiamo i pacchetti installati in R
library(raster) 
library(rasterVis) 
library(RStoolbox) 
library(rasterdiv)

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
plotRGB(Sard2019, 3,2,1, stretch="lin") #la funzione <plotRGB> permette di visualizzare 3 bande alla volta, con uno stretch lineare
plotRGB(Sard2021, 3,2,1, stretch="lin")

# presento le due immagini in falsi colori (con banda NIR nella componente red), e le visualizzo in una finestra grafica 1x2
par(mfrow=c(1,2)) 
plotRGB(Sard2019, 4,3,2, stretch="lin")
plotRGB(Sard2021, 4,3,2, stretch="lin")

# Visualizzo sia le immagini nel visibile che in falsi colori in una finestra 2x2
par(mfrow=c(2,2)) 
plotRGB(Sard2019, 3,2,1, stretch="lin") 
plotRGB(Sard2021, 3,2,1, stretch="lin")
plotRGB(Sard2019, 4,3,2, stretch="lin")
plotRGB(Sard2021, 4,3,2, stretch="lin")

#Bande Sentinel
#B04: rosso
#B08: nir
#B12: swir

cl <- colorRampPalette(c("darkblue","yellow","red","black"))(100) #creo una scala di colori per visualizzare le immagini che creerò 

#Calcolo l'ndvi=(NIR-RED)/(NIR+RED)
#ndvi 2019
red19 <- raster("T32TMK_20190916T101029_10m_B04.tif") #con <raster> carico la banda B4 e la associo ad una variabile
nir19 <- raster("T32TMK_20190916T101029_10m_B08.tif") 
ndvi19 <- (nir19-red19)/(nir19+red19) #calcolo l'indice di vegetazione dell'anno 2019
#ndvi 2021
red21 <- brick("T32TMK_20210905T100549_10m_B04.tif")
nir21 <- brick("T32TMK_20210905T100549_10m_B08.tif")
ndvi21 <- (nir21-red21)/(nir21+red21) #calcolo l'indice di vegetazione dell'anno 2021
#Visualizzo i due ndvi in una finestra 1x2
par(mfrow=c(1,2))
plot(ndvi19, col=cl, main="NDVI 16/09/2019")
plot(ndvi21, col=cl, main="NDV 05/09/2021")

#Differenza fra i due ndvi 
difndvi <- ndvi19-ndvi21
cld <- colorRampPalette(c("blue","white","red","black"))(100)#creo una nuova scala di colori
plot(difndvi, col=cld) #plotto la differenza fra i due ndvi con la nuova scala di colori 
# i valori più alti indicano dove ho maggior sofferenza della vegetazione

#Calcolo NBR, prima devo fare delle procedure:
#carico la banda SWIR, essa ha una risoluzione di 20 m 
swir19 <- raster("T32TMK_20190916T101029_B12.tif") 
# cambio risoluzione all'immagine nir, sia del 2019 che del 2021, da 10m a 20 m 
nir19_20m<- aggregate(nir19, fact=2) # all'immagine salvata in nir19 cambio moltiplico la risoluzione di 
writeRaster(nir19_20m,"T32TMK_20190916T101029_20m_B08.tif") #salvo con la funzione <writeRaster> l'immagine appena creata nella cartella di lavoro 
NBR19 <- (nir19_20m-swir19)/(nir19_20m+swir19) # calcolo l'NBR
plot(NBR19, col=cl)
#Eseguo lo stesso procedimento precidente all'immagine del 2021
swir21 <- raster("T32TMK_20210905T100549_B12.tif") #carico la B12
nir21_20m<- aggregate(nir21, fact=2)
writeRaster(nir21_20m,"T32TMK_20210905T100549_20m_B08.tif" )
NBR21 <- (nir21_20m-swir21)/(nir21_20m+swir21)
#Visualizzo i due NBR in una finestra 1x2
plot(NBR21, col=cl)
par(mfrow=c(1,2))
plot(NBR19, col=cl, main="NBR 16/09/2019")
plot(NBR21, col=cl, main="NBR 05/09/2021")
# Calcolo la differenza fra i due NBR 
deltaNBR <- NBR19-NBR21
plot(deltaNBR, col=cld) #plotto la differenza fra i due NDR con la scala di colori precedentemente creata



# Profilo spettrale

red21_20m<- aggregate(red21, fact=2)
list21_20m <- c("swir21","nir21_20m","red21_20m")
import21_20m <- lapply(list21_20m,raster)
Sard2021 <- stack(import2)
plotRGB(list21_20m, 1,2,3, stretch="lin")
