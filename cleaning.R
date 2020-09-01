#### Goal ####
## Plot historical India population data over time and see how India was always a populous nation and the explosion 
# 1970s was primarily because of increased food production and was in-line with the global population trends
## Also highlight how India's population is concentrated in dense hubs and there is huge potential in spreading out over
# larger area to reduce burden on land and resources

#### ToDo ####
# 1. Trim and clean datasets and make new tables consisting only of the attributes you wanna plot
# 2. Make plots

library(xlsx)
library(tidyverse)

#### Cleaning "Census since 1901.xls" ####
india_historical_data = read.xlsx2("data/raw/Census since 1901.xls", startRow = 5, sheetIndex = 1)
names(india_historical_data) <- c("State.Code", "District.Code", "Geographical.Unit", "Census.Year", "Population", "Variation.Absolute", "Variation.Percentage", "Males", "Females")

india_historical_data_cleaned <- india_historical_data %>% dplyr::select(-2, -6, -7)
india_historical_data_cleaned$Census.Year <- gsub("[$@+#]+", "", x = india_historical_data_cleaned$Census.Year) %>% trimws(which = "both")

# Remove empty/blank rows
# Source: https://stackoverflow.com/questions/6437164/removing-empty-rows-of-a-data-file-in-r/37322563#37322563
india_historical_data_cleaned <- india_historical_data_cleaned[!apply(india_historical_data_cleaned == "", 1, all), ]

# Yeh bhen ka loda madarchoid randi ki aulaad tidyr isme fill nahi kar pa rahi hai. Dimag ki ma chod ke rakh di madarchod ne
# india_historical_data_cleaned %>% as_tibble %>% tidyr::fill(State.Code) %>% View

# Writing xlsx and clean data manually in excel
write.xlsx(india_historical_data_cleaned, "data/clean/india_historical_data.xlsx")

#### Cleaning "Global food production FAO.csv" ####