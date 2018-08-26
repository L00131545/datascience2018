post_codes <- read.csv("NIPostcodes.csv", header = FALSE, na.strings = c("", "NA"))
str(post_codes)
head(post_codes, 10)

sapply(post_codes, function(x) sum(is.na(x)))
sapply(post_codes, function(x) mean(is.na(x)))

str(post_codes)
head(post_codes, 10)
colnames(post_codes) <- c("Organisation_Name", "Sub_building_Name", "Building_Name", "Number", "Primary_Thorfare", "Alt_Thorfare", "Secondary_Thorfare", "Locality", "Townland", "Town", "County", "Postcode", "x_coordinates", "y_coordinates", "Id")
str(post_codes)
head(post_codes, 10)

post_codes$County = factor(post_codes$County, levels = levels(factor(post_codes$County)), ordered = FALSE)
str(post_codes)

post_codes <- post_codes[, c(15, 1:14)]
str(post_codes)

attach(post_codes)
Limavady_data = subset(post_codes, grepl('LIMAVADY', Locality) & grepl('LIMAVADY', Townland) & grepl('LIMAVADY', Town))
str(Limavady_data)
head(Limavady_data)

write.csv(Limavady_data, file = 'Limavady.csv', row.names = FALSE)
write.csv(post_codes, file = 'CleanNIPostcodeData.csv', row.names = FALSE)
