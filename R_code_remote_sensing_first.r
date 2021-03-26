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
plot(p224r63_2011, col=cls)

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
library(ggplot2)


