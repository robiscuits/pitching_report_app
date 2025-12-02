library(ggplot2)
library(dplyr)

# Pitch Movement #
plot_movement = function(df) {
  ggplot(df, aes(x = pfx_x, y = pfx_z, color = pitch_type)) +
    geom_point(alpha = 0.8) +
    # TODO: adjust labels or scaling if needed
    labs(
      title = "Pitch Movement",
      x = "Horizontal Break (in)",
      y = "Vertical Break (in)"
    ) +
    theme_bw()
}

# Pitch Locations #
plot_locations = function(df) {
  ggplot(df, aes(plate_x, plate_z, color = pitch_type)) +
    geom_point(alpha = 0.5) +
    geom_rect(aes(
      xmin = -0.85, xmax = 0.85,
      ymin = 1.5, ymax = 3.5
    ), fill = "black", color = "black", linewidth = 1) +
    coord_fixed() +
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
      x = "Release X",
      y = "Release Z"
    ) +
    theme_bw()
}