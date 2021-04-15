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
plot(TGr) # visualizzo il singolo file 
plotRGB(TGr, 1, 2, 3, stretch="Lin") # creazione tre immagini sovrapposte del 2000,2005,2010

levelplot(TGr)
levelplot(TGr$lst_2000)

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr,col.regions=cl)

levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#creo meltlist
melt_list <- list.files(pattern="annual")
melt_import <- lapply(melt_list,raster)
melt <- stack(melt_import)
melt
levelplot(melt)
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
clb <- colorRampPalette(c("blue", "white","red"))(100)
plot(melt_amount, col=clb)
levelplot(melt_amount, col.regions=clb)
