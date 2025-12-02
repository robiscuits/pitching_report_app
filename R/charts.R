library(ggplot2)
library(dplyr)

# Pitch Movement #
plot_movement = function(df) {
  ggplot(df, aes(x = pfx_x, y = pfx_z, color = pitch_type)) +
    geom_point(alpha = 0.8) +
    labs(
      title = "Pitch Movement",
      x = "Horizontal Break (in)",
      y = "Induced Vertical Break (in)"
    ) +
    theme_bw()
}

# Pitch Locations #
plot_locations = function(df) {
  ggplot(df, aes(plate_x, plate_z, color = pitch_type)) +
    geom_point(alpha = 0.5) +
    # strike zone OUTLINE, no aes()
    geom_rect(
      xmin = -0.83, xmax = 0.83,
      ymin = 1.5,  ymax = 3.5,
      fill = NA, color = "black", linewidth = 1
    ) +
    coord_fixed() +
    scale_x_continuous(limits = c(-2, 2)) +
    scale_y_continuous(limits = c(0, 5)) +
    labs(
      title = "Pitch Locations",
      x = "Horizontal Location",
      y = "Vertical Location"
    ) +
    theme_bw()
}

# Release Point #
plot_release = function(df) {
  ggplot(df, aes(release_pos_x, release_pos_z, color = pitch_type)) +
    geom_point(alpha = 0.5) +
    coord_fixed() +
    labs(
      title = "Release Point Consistency",
      x = "Release Side",
      y = "Release Height"
    ) +
    theme_bw()
}