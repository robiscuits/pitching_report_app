library(tidyverse)
library(ggplot2)

#Load Data
load_data = function(path){
  raw_data = read.csv(path, fileEncoding = "latin1", stringsAsFactors = FALSE)
  features = raw_data %>%
  rename(
    pitcher_name = Pitcher,
    pitcher_id = PitcherId,
    pitch_type = TaggedPitchType,
    release_speed = RelSpeed,
    release_spin_rate = SpinRate,
    pfx_x = HorzBreak,
    pfx_z = InducedVertBreak,  
    plate_x = PlateLocSide,
    plate_z = PlateLocHeight,
    release_pos_x = RelSide,
    release_pos_z = RelHeight,
    description = PitchCall
  ) %>%
  mutate(
    in_zone = abs(plate_x) <= 0.83 & plate_z >= 1.5 & plate_z <= 3.5,
    
    # -----------------------------------------------------------------------
    # Called strikes, swinging strikes, foul balls are always strikes
    # In Play is only a strike if the pitch was *located* inside the zone
    # -----------------------------------------------------------------------
    is_strike = case_when(
      description %in% c("StrikeCalled", "StrikeSwinging", "FoulBallOff") ~ TRUE,
      description == "InPlay" & in_zone ~ TRUE,
      TRUE ~ FALSE
    ),
    is_swing = description %in% c("StrikeSwinging", "FoulBallOff", "InPlay"),
    is_whiff = description == "StrikeSwinging",
    is_chase = is_swing & !in_zone
  )
  return(features)
}

# Percentage helper
pct = function(n, d) {
  ifelse(d == 0, 0, round(100 * n / d, 1))
}
