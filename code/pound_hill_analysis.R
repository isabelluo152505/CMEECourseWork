MyData <- read.csv("data/pound_hill_data.csv")

MyMetaData <- read.csv("data/pound_hill_meta_data.csv", sep = ";")

print(dim(MyData))
print(head(MyData))

print(dim(MyMetaData))
print(head(MyMetaData))

str(MyData)
str(MyMetaData)

SpeciesCounts <- MyData[4:44, 2:60]

print(dim(SpeciesCounts))

SpeciesCounts[SpeciesCounts == ""] <- "0"
print(SpeciesCounts[1:5, 1:5])

SpeciesCounts[] <- lapply(SpeciesCounts, as.numeric)
str(SpeciesCounts)

SpeciesNames <- MyData[4:44, 1]
print(head(SpeciesNames))
print(length(SpeciesNames))

CultivationNames <- names(MyData)[-1]

print(head(CultivationNames))
print(length(CultivationNames))

CultivationNames <- sub("\\.[0-9]+$", "", CultivationNames)
print(head(CultivationNames))
print(unique(CultivationNames))

BlockNames <- as.character(unlist(MyData[1, -1]))
print(head(BlockNames))
print(unique(BlockNames))
print(length(BlockNames))

PlotNames <- as.character(unlist(MyData[2, -1]))
print(head(PlotNames))
print(unique(PlotNames))
print(length(PlotNames))

QuadratNames <- as.character(unlist(MyData[3, -1]))
print(head(QuadratNames))
print(unique(QuadratNames))
print(length(QuadratNames))

LongSpecies <- rep(SpeciesNames, times = 59)
print(head(LongSpecies))
print(length(LongSpecies))

LongCultivation <- rep(CultivationNames, each = 41)
print(length(LongCultivation))
print(head(LongCultivation))
print(LongCultivation[40:44])

LongBlock <- rep(BlockNames, each = 41)

LongPlot <- rep(PlotNames, each = 41)

LongQuadrat <- rep(QuadratNames, each = 41)

print(length(LongBlock))
print(length(LongPlot))
print(length(LongQuadrat))

print(LongQuadrat[40:43])

LongCount <- unlist(SpeciesCounts, use.names = FALSE)
print(length(LongCount))
print(head(LongCount))
print(LongCount[40:45])

LongData <- data.frame(
  Cultivation = LongCultivation,
  Block = LongBlock,
  Plot = LongPlot,
  Quadrat = LongQuadrat,
  Species = LongSpecies,
  Count = LongCount
)
print(dim(LongData))
print(head(LongData))
str(LongData)


is.numeric(LongData$Count)
all(LongData$Count >= 0)

length(unique(LongData$Species))
length(unique(LongData$Plot))

UniqueQuadrats <- unique(LongData[, c("Plot", "Quadrat")])

print(head(UniqueQuadrats))
print(nrow(UniqueQuadrats))

QuadratRichness <- aggregate(
  Count ~ Cultivation + Block + Plot + Quadrat,
  data = LongData,
  FUN = function(x) sum(x > 0)
)

print(dim(QuadratRichness))
print(head(QuadratRichness))

names(QuadratRichness)[5] <- "Richness"
print(head(QuadratRichness))

PlotRichness <- aggregate(
  Richness ~ Cultivation + Block + Plot,
  data = QuadratRichness,
  FUN = mean
)

print(dim(PlotRichness))
print(head(PlotRichness))

names(PlotRichness)[4] <- "MeanRichness"
print(names(PlotRichness))

length(unique(PlotRichness$Plot))

write.csv(
  PlotRichness,
  file = "results/pound_hill_plot_richness.csv",
  row.names = FALSE
)

file.exists("results/pound_hill_plot_richness.csv")

stripchart(
  MeanRichness ~ Cultivation,
  data = PlotRichness,
  method = "jitter",
  vertical = TRUE,
  pch = 19,
  xlab = "Cultivation timing",
  ylab = "Mean species richness per quadrat"
)

pdf("results/pound_hill_plot_richness.pdf")

stripchart(
  MeanRichness ~ Cultivation,
  data = PlotRichness,
  method = "jitter",
  vertical = TRUE,
  pch = 19,
  xlab = "Cultivation timing",
  ylab = "Mean species richness per quadrat"
)

dev.off()
file.exists("results/pound_hill_plot_richness.pdf")

#Which treatment has the highest typical richness?
#May has the highest typical richness

#How variable are the plots within treatments? 
#The plot shows a considerable variation within treatments.
#Ranges of richness for May is about 7.5 to 11.5, for March is about 6.2 to 10, and for October is about 6.4 to 10.2. This shows even in the same cultivation timing, richness may differ due to many reasons
#Does the figure alone show that cultivation timing caused the differences? 
#No. It only shows oberved differences in species richness among three cultivation treatments. We cannot prove that different cultivation time have caused the variation in species richness
#What else would you need to know about the design?
#We need to know the intial conditions for each plots, for example, previous land use. Also we need to know does all plots have the similar soil conditons, and the conditon to get enough sunlight and water.


QuadratAbundance <- aggregate(
  Count ~ Cultivation + Block + Plot + Quadrat,
  data = LongData,
  FUN = sum
)


names(QuadratAbundance)[5] <- "Abundance"

print(dim(QuadratAbundance))
print(head(QuadratAbundance))

PlotAbundance <- aggregate(
  Abundance ~ Cultivation + Block + Plot,
  data = QuadratAbundance,
  FUN = mean
)


print(dim(PlotAbundance))
print(head(PlotAbundance))

print(aggregate(
  MeanRichness ~ Cultivation,
  data = PlotRichness,
  FUN = mean
))

print(aggregate(
  Abundance ~ Cultivation,
  data = PlotAbundance,
  FUN = mean
))

#Compare its pattern with richness. Why might the two responses tell different ecological stories?
#May cultivation had the highest mean species richness, whereas October cultivation had the highest mean abundance
#This suggests that greater plant abundance does not necessarily lead to greater species richness. 
#The reason might be high plant abundance is often driven by a massive population of just a few dominant species rather than a wide variety of species.