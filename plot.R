library(tidyverse)
library(magrittr)
library(ggplot2)
library(xlsx)

historical_data <- read.xlsx2("data/clean/india_historical_data.xlsx", sheetIndex = 1)
#%<>% piped assignment from magrittr
historical_data %<>% dplyr::select(-1)
historical_data$Population <- historical_data$Population %>% as.character() %>% as.numeric()

gg = ggplot(historical_data %>% dplyr::filter(Geographical.Unit == "INDIA")) + geom_point(aes(x=Census.Year, y=Population, group=1)) + geom_line(aes(x=Census.Year, y=Population, group=1)) + theme_bw()
gg
gg + geom_point(aes(x=Census.Year, y=Males, group=2,))