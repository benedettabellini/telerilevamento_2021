# R_code_copernicus.r
# Visualizing Copernicus data

instal.packages("ncdf4") # installo il pacchetto "ncdf4"
library(raster)
library(ncdf4) # richiamo il pacchetto installato

setwd("/Users/benedettabellini/lab") # setto cartella di lavoro

albedo <- raster("c_gls_ALBH_202006130000_GLOBE_PROBAC_V!.5.1.nc") # con raster carico un singolo strato

cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)
plot(albedo, col=cl)

# ricampionamento
albedores <- aggregate(albedo, fact=100)
plot(albedores, col=cl)
