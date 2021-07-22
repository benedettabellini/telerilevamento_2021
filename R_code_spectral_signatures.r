R_code_spectral_signatures.r

library(raster)
library(rgdal)
setwd("/Users/benedettabellini/lab/")

defor2 <- brick("defor2.jpg")
# NIR, red, green
plotRGB(defor2, 1, 2, 3, stretch="Lin")
plotRGB(defor2, 1, 2, 3, stretch="hist")

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# Results 1 318.5 147.5 236929      200       12       26
      x     y   cell defor2.1 defor2.2 defor2.3
1 202.5 170.5 220322      131      131      155
