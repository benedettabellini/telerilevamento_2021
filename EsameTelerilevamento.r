#Esame Telerilevamento 
# Sardegna occidentale, zona dell'Oristanese
#Confronto fra immagini del 16/09/2019 e 09/05/2021 ossia pre e post incendio avvenuto nell'agosto 2020

install.packages("raster") #installo il pacchetto raster 
install.packages("rasterVIs") #installo il pacchetto rasterVis
install.packages("RStoolbox") #installo il pacchetto RStoolbox
install.packages("rasterdiv") #installo il pacchetto rasterdiv
install.packages("rgdal") #installo il pacchetto rgdal
install.packages("ggplot2") #installo il pacchetto ggplot2

#Richiamo i pacchetti installati in R
library(raster) 
library(rasterVis) 
library(RStoolbox) 
library(rasterdiv)
library(rgdal)
library(ggplot2)

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

#Bande Sentinel
#B02: blu
#B03: verde
#B04: rosso
#B08: nir
#B12: swir

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

cl <- colorRampPalette(c("darkblue","yellow","red","black"))(100) #creo una scala di colori per visualizzare le immagini che creerò 

#Calcolo l'ndvi=(NIR-RED)/(NIR+RED)
#ndvi 2019
red19 <- raster("T32TMK_20190916T101029_10m_B04.tif") #con <raster> carico la banda B4 e la associo ad una variabile
nir19 <- raster("T32TMK_20190916T101029_10m_B08.tif") 
ndvi19 <- (nir19-red19)/(nir19+red19) #calcolo l'indice di vegetazione dell'anno 2019
#ndvi 2021
red21 <- raster("T32TMK_20210905T100549_10m_B04.tif")
nir21 <- raster("T32TMK_20210905T100549_10m_B08.tif")
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
nir19_20m<- aggregate(nir19, fact=2) # all'immagine salvata in nir19 cambio moltiplico la risoluzione di un fattore x2 
writeRaster(nir19_20m,"T32TMK_20190916T101029_20m_B08.tif") #salvo con la funzione <writeRaster> l'immagine appena creata nella cartella di lavoro 
NBR19 <- (nir19_20m-swir19)/(nir19_20m+swir19) # calcolo l'NBR
plot(NBR19, col=cl)
#Eseguo lo stesso procedimento precidente all'immagine del 2021
swir21 <- raster("T32TMK_20210905T100549_B12.tif") #carico la B12
nir21_20m<- aggregate(nir21, fact=2) #cambio risoluzione alla B12 da 10 m a 20 m 
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

# Firma spettrale - vogliamo vedere la riflettanza nelle bande SWIR-NIR-RED nell'immagine post incendio (2021):
red21_20m<- aggregate(red21, fact=2) #cambio risoluzione alla B04 da 10 m a 20 m 
writeRaster(red21_20m, "T32TMK_20210905T100549_20m_B04.tif") #salvo l'immagine appena creata
writeRaster(swir21,"T32TMK_20210905T100549_20m_B12.tif") #creo un nuovo layer della B12 nominandolo con nome diverso 
#creo una lista con i layer del 2021 con stessa risoluzione (20m)
list21_20m <- list.files(pattern="T32TMK_20210905T100549_20m_B") 
import21_20m <- lapply(list21_20m,raster)
Sard2021_20m <- stack(import21_20m) 
Sard2021_20m #contiene le bande RED-NIR-SWIR
jpeg("Profilospettrale21.jpeg") # salvo l'immagine che creo in formato jpeg
plotRGB(Sard2021_20m, 3,2,1, stretch="lin") #visualizzo l'immagine in falsi colori
dev.off() 
ps21_20m <- brick("Profilospettrale21.jpeg")#importo l'immagine appena creata
plotRGB(ps21_20m, 1,2,3, stretch="lin")
#clicco in un pixel di vegetazione non interessata dall'incendio e in un pixel di vegetazione interessato dall'incendio
click(ps21_20m, id=T, xy=T, type="o", col="red") 
#creo una tabella dove metto per ogni banda i valori di riflettanza ottenuti
band <- c(1,2,3)
vegetazione_bruciata <- c(116,17,45)
vegetazione_nonbruciata <- c(31,210,30)
spectrals <- data.frame(band, vegetazione_bruciata,vegetazione_nonbruciata)
#grafico delle firme spettrali 
ggplot(spectrals, aes=(x=band)) + 
      geom_line(aes(x=band, y=vegetazione_bruciata), color="red") + 
      geom_line(aes(x=band, y=vegetazione_nonbruciata), color="green") +
      labs(x="band", y="riflettanza")

#####Multitemporale 
#Ripeto lo stesso procedimento precedente nell'immagine del 2019
red19_20m<- aggregate(red19, fact=2) #cambio risoluzione alla B04 da 10 m a 20 m 
writeRaster(red19_20m, "T32TMK_20190916T101029_20m_B04.tif") #salvo l'immagine appena creata
writeRaster(swir19,"T32TMK_20190916T101029_20m_B12.tif") #creo un nuovo layer della B12 nominandolo con nome diverso 
#creo una lista con i layer del 2021 con stessa risoluzione (20m)
list19_20m <- list.files(pattern="T32TMK_20190916T101029_20m_B") 
import19_20m <- lapply(list19_20m,raster)
Sard2019_20m <- stack(import19_20m) 
Sard2019_20m #contiene le bande RED-NIR-SWIR
jpeg("Profilospettrale19.jpeg") # salvo l'immagine che creo in formato jpeg
plotRGB(Sard2019_20m, 3,2,1, stretch="lin") #visualizzo l'immagine in falsi colori
dev.off() 
ps19_20m <- brick("Profilospettrale19.jpeg")#importo l'immagine appena creata
plotRGB(ps19_20m, 1,2,3, stretch="lin")

#visualizzo in una finestra 1x2 i plot RGB del 2019,2021
par(mfrow=c(1,2))
plotRGB(ps19_20m, 1,2,3, stretch="lin")
plotRGB(ps21_20m, 1,2,3, stretch="lin")

#faccio i click casuali nella zona che è stata interessata all'incendio pre e post
#2019
plotRGB(ps19_20m, 1,2,3, stretch="lin")
click(ps19_20m, id=T, xy=T, type="o", col="red") 
#Results
#      x     y Profilospettrale19.1 Profilospettrale19.2 Profilospettrale19.3
#1 295.5 220.5                   58                  242                   60
#      x     y Profilospettrale19.1 Profilospettrale19.2 Profilospettrale19.3
#1 288.5 229.5                   52                  174                   75
#      x     y Profilospettrale19.1 Profilospettrale19.2 Profilospettrale19.3
#1 279.5 237.5                   36                  190                   42
#      x     y Profilospettrale19.1 Profilospettrale19.2 Profilospettrale19.3
#1 274.5 246.5                   84                  186                   86
#      x     y Profilospettrale19.1 Profilospettrale19.2 Profilospettrale19.3
#1 277.5 260.5                   63                  183                   85

#2021
plotRGB(ps21_20m, 1,2,3, stretch="lin")
click(ps21_20m, id=T, xy=T, type="o", col="red") 
#Results
#      x     y Profilospettrale21.1 Profilospettrale21.2 Profilospettrale21.3
#1 287.5 238.5                  106                   37                   58
#      x     y Profilospettrale21.1 Profilospettrale21.2 Profilospettrale21.3
#1 278.5 243.5                  199                   47                   98
#      x     y Profilospettrale21.1 Profilospettrale21.2 Profilospettrale21.3
#1 271.5 252.5                   73                   46                   51
#      x     y Profilospettrale21.1 Profilospettrale21.2 Profilospettrale21.3
#1 269.5 260.5                  137                  118                  112
#      x     y Profilospettrale21.1 Profilospettrale21.2 Profilospettrale21.3
#1 268.5 269.5                  135                   67                   90
#creo un dataframe con i valori di riflettanza ottenuti e faccio con <le firme spettrali>
time1 <- c(58,242,60)
time1p2 <- c(52,174,75)
time1p3 <- c(36,190,42)
time1p4 <- c(84,186,86)
time1p5 <- c(63,183,85)
time2 <- c(106,37,58)
time2p2 <- c(199,47,98)
time2p3 <- c(73,46,51)
time2p4 <- c(137,118,112)
time2p5 <- c(135,67,90)
ggplot(spectrals, aes=(x=band)) + 
      geom_line(aes(x=band, y=time1), color="red") + 
      geom_line(aes(x=band, y=time1p2), color="red") + 
      geom_line(aes(x=band, y=time1p3), color="red") + 
      geom_line(aes(x=band, y=time1p4), color="red") + 
      geom_line(aes(x=band, y=time1p5), color="red") + 
      geom_line(aes(x=band, y=time2), color="green") +
      geom_line(aes(x=band, y=time2p2), color="green") +
      geom_line(aes(x=band, y=time2p3), color="green") +
      geom_line(aes(x=band, y=time2p4), color="green") +
      geom_line(aes(x=band, y=time2p5), color="green") +
      labs(x="band", y="riflettanza")
#si vede come la zona interessata dall'incendio nel 2021 ha una elevata riflettanza nello swir e una bassa riflettanza nel nir 
#mentre nella vegetazione sana pre incendio si verifica il contrario, ossia una elevata riflettanza nel nir e minore nello swir
#la riflettanza nella banda del rosso rimane immutata 

###############################
#poichè la vegetazione bruciata diminuisce la riflettanza nel nir, facciamo un levelplot della banda del nir nei due anni
listswir <- list.files(pattern="B12") 
importswir<- lapply(listswir,raster)
Sardswir <- stack(importswir) 
plot(Sardswir)
clswir <- colorRampPalette(c("blue", "light blue","pink","red"))(100)
levelplot(Sardswir, col.regions=clswir)
####################################
