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
