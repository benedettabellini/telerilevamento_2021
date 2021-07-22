R_code_spectral_signatures.r

library(raster)
library(rgdal)
library(ggplot2)
setwd("/Users/benedettabellini/lab/")

defor2 <- brick("defor2.jpg")
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

