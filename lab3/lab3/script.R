crime_file_location <- paste0(getwd(), '/input/crimefile/')
postcode_file_location <- paste0(getwd(), '/input/CleanNIPostcodeData.csv')
write_file_location <- paste0(getwd(), '/output/')

csv_file_list <- list.files(path = crime_file_location, pattern = "*.csv", recursive = TRUE, full.names = TRUE)

combine_results <- function(csv_file_list) {
    crimedetail <- NULL
    for (csv_file in csv_file_list) {
        temp <- read.csv(header = TRUE, stringsAsFactors = FALSE, csv_file)
        crimedetail <- rbind(temp, crimedetail)
    }
    return(crimedetail)
}

crimedetail <- combine_results(csv_file_list)
nrow(crimedetail)
head(crimedetail)
str(crimedetail)
write.csv(crimedetail, paste0(write_file_location, '/AllNICrimeData.csv'), row.names = FALSE)

######################### b ##########################

crimedetail$Crime.ID <- NULL
crimedetail$Falls.within <- NULL
crimedetail$Reported.by <- NULL
crimedetail$LSOA.code <- NULL
crimedetail$LSOA.name <- NULL
crimedetail$Last.outcome.category <- NULL
crimedetail$Context <- NULL
head(crimedetail)
str(crimedetail)

###############################c####################

crimedetail$Crime.type = factor(crimedetail$Crime.type, levels = levels(factor(crimedetail$Crime.type)), ordered = FALSE)
head(crimedetail)
str(crimedetail)

############################d#######################

crimedetail$Location <- gsub("On or near ", "", crimedetail$Location)
head(crimedetail)
str(crimedetail)

#############################h######################

cleaned_post_codes <- read.csv(postcode_file_location, header = TRUE)[, c("Primary_Thorfare", "Postcode", "Town", "County")]

unique_post_code <- cleaned_post_codes[!duplicated(cleaned_post_codes$Postcode),]

merged_data <- unique_post_code[, c("Town", "County", "Postcode")]
str(merged_data)
########################################## i ##########################
write.csv(merged_data, paste0(write_file_location, '/FinalNICrimeData.csv'), row.names = FALSE)

########################################## j ##########################

filter_by_location_strabane <- merged_data[grep("Strabane", merged_data$Town, ignore.case = TRUE),]
strabane_Data <- filter_by_location_strabane[grep("BT82", filter_by_location_strabane$Postcode, ignore.case = TRUE),]
head(strabane_Data, 10)
str(strabane_Data)
