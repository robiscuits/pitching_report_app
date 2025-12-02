library(dplyr)
library(tidyverse)
library(DT)

# Pitch Characteristics #
pitch_characteristics = function(df) {
  
  df_summary = df %>%
    group_by(pitch_type) %>%
    summarise(
      velo_avg = mean(release_speed, na.rm = TRUE),
      spin_avg = mean(release_spin_rate, na.rm = TRUE),
      hmov_avg = mean(pfx_x, na.rm = TRUE),
      vmov_avg = mean(pfx_z, na.rm = TRUE),
      usage = n() / nrow(df),
      .groups = "drop"
    ) %>%
    mutate(
      usage = round(100 * usage, 1)
    ) %>%
    rename(
      `Avg Velo` = velo_avg,
      `Avg Spin` = spin_avg,
      `Horiz Mov` = hmov_avg,
      `Vert Mov` = vmov_avg,
      `Usage Pct` = usage
    )
  
  datatable(df_summary,
            rownames = FALSE)
}

# Pitch Efficacy #
pitch_efficacy = function(df) {
  
  df_eff = df %>%
    group_by(pitch_type) %>%
    summarise(
      pitches = n(),
      swings  = sum(is_swing, na.rm = TRUE),
      strikes = sum(is_strike, na.rm = TRUE),
      whiffs  = sum(is_whiff, na.rm = TRUE),
      chases  = sum(is_chase, na.rm = TRUE),
      called_strikes = sum(description == "called_strike"),
      .groups = "drop"
    ) %>%
    mutate(
      strike_pct = pct(strikes, pitches),
      whiff_pct  = pct(whiffs, swings),
      chase_pct  = pct(chases, swings),
      csw_pct    = pct(whiffs + called_strikes, pitches)
    ) %>%
    select(
      pitch_type,
      `Strike Pct` = strike_pct,
      `Whiff Pct`  = whiff_pct,
      `Chase Pct`  = chase_pct,
      `CSW Pct`    = csw_pct
    )
  
  datatable(df_eff,
            rownames = FALSE)
}

