# Postgame Pitching Report (Shiny App)

This Shiny application provides an interactive postgame pitching report using pitch-tracking data. Users can select a pitcher and view movement, location, and release plots, along with summary tables for pitch characteristics and pitch efficacy.

## Features

- Pitcher dropdown ordered by number of pitches thrown (descending)
- Pitch movement plot (horizontal and vertical movement)
- Standardized pitch location plot with fixed strike-zone box and fixed axes
- Release point plot
- Pitch characteristics table 
- Pitch efficacy table 

## File Structure

- app.R : main Shiny application
- R/helpers.R : data loading, encoding fix, feature engineering
- R/charts.R : movement, location, and release plots
- R/tables.R : pitch characteristics and efficacy tables
- data/ : folder containing the CSV dataset

## Notes

- Data is read using Latin-1 encoding to avoid UTF-8 errors.
- Location plot uses fixed x and y limits so the strike zone does not shift.
- Dropdown choices are sorted by pitch count.
- Basic req() checks are used to prevent plots/tables from rendering early.

## Running the App

In R:

shiny::runApp()

Requires: shiny, tidyverse, ggplot2, DT
