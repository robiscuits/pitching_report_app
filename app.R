#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
source("R/helpers.R")
source("R/charts.R")
source("R/tables.R")

# Define UI for application
ui = fluidPage(
    # Application title
    titlePanel("Postgame Pitching Report"),

    # Sidebar pitcher selection
    sidebarLayout(
      sidebarPanel(
        selectInput("pitcher", "Choose Pitcher:", choices = NULL),
        hr(),
        helpText("Postgame pitching analysis dashboard.")
      ),
    mainPanel(
      tabsetPanel(
        tabPanel("Movement", plotOutput("movement_plot")),
        tabPanel("Locations", plotOutput("location_plot")),
        tabPanel("Release", plotOutput("release_plot")),
        tabPanel("Characteristics", DTOutput("pitch_table")),
        tabPanel("Efficacy", DTOutput("eff_table"))
      )
    )
  )
)


server = function(input, output, session) {

  pitches = load_pitch_data("data/CWS ML Analyst Dataset.csv")
  
  # Populate dropdown
  observe({
    pitchers = sort(unique(pitches$pitcher_name))
    updateSelectInput(session, "pitcher", choices = pitchers)
  })
  
  # Filter for selected pitcher
  pitcher_data = reactive({
    req(input$pitcher)
    pitches %>% filter(pitcher_name == input$pitcher)
  })
  
  # plot movement
  output$movement_plot = renderPlot({
    plot_movement(pitcher_data())
  })
  
  # plot location
  output$location_plot = renderPlot({
    plot_locations(pitcher_data())
  })
  
  # plot release
  output$release_plot = renderPlot({
    plot_release(pitcher_data())
  })
  
  # Pitch characteristics table
  output$pitch_table = renderDT({
    pitch_characteristics(pitcher_data())
  })
  
  # Efficacy metrics table
  output$eff_table = renderDT({
    pitch_efficacy(pitcher_data())
  })
}


# Run the application 
shinyApp(ui = ui, server = server)
