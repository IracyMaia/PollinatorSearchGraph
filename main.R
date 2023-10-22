########################################################
#                                                          #
####              Representacão dentro APS              ####
#                                                          #
## %######################################################%##
# Modelos de especies
dir_modelos <- file.path(dirname(getwd()), "03_Modelos/1-SDM/2_Outputs/1_Current/FinalModels/")

# Areas protegidas
pas <- terra::rast("APs.tif")

# raster com km2 dentro de cada celula
r_area <-pas %>% terra::cellSize(mask= TRUE, unit="km")
plot(r_area)

d <- list.files(dir_modelos, pattern = ".tif$", full.names = TRUE)
names(d) <- basename(d) %>% gsub(".tif$", "", .)

df <- data.frame(species = names(d), total_area = NA, area_within_pas = NA)

i = 1
for (i in 1:nrow(df)) {
message("species n: ", i)
r <- terra::rast(d[i])
r <- (r[[2]] > 0)
r[r==0] <- NA
df[i, "total_area"] <- terra::expanse(r, unit="km")[,2]
r2 <- r*pas
r2[r==0] <- NA
df[i, "area_within_pas"] <- sum(as.data.frame(r2*r_area)[,1])
}
plot(r*pas)

# Filtrar as especies que não tem predicciones dentro de Amazonia Legal
# Calculo de proporção
df <- df %>% dplyr::mutate(proportion = area_within_pas / total_area)
head(df)

# Gráfico
summary(df$proportion)
sd(df$proportion)

ggplot(df, aes(total_area, proportion)) + geom_point()
ggplot(df, aes(total_area, area_within_pas)) + geom_point()

readr::write_tsv(df, "protection degree.txt")