library(tidyverse)
library(ggplot2)

#Load Data
load_data = function(path){
  raw_data = read.csv(path)
  features = raw_data %>%
    mutate(
      is_strike = description %in% c("called_strike", "foul", "swinging_strike", "in_play"),
      is_swing  = description %in% c("foul", "swinging_strike", "in_play"),
      is_whiff  = description == "swinging_strike",
      is_chase  = is_swing & (plate_x < -0.83 | plate_x > 0.83 | plate_z < 1.5 | plate_z > 3.5)
    )
}

# Percentage helper
pct = function(n, d) {
  ifelse(d == 0, 0, round(100 * n / d, 1))
}