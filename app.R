# https://shiny.posit.co/r/getstarted/shiny-basics/lesson4/
if (!require("pacman")) install.packages("pacman")
library("pacman")

# install.packages(c("maps", "mapproj"))

p_load("bslib", "shiny", "maps", "mapproj", 
       "shinyloadtest",
       # "shiny.benchmark",
       "arsenal"
       )

# source("../census-app/helpers.R")
# counties <- readRDS("../census-app/data/counties.rds")
source("helpers.R")
counties <- readRDS("data/counties.rds")
# percent_map(counties$white, "darkgreen", "% White")

# View(counties)

# User interface ----
ui <- page_sidebar(
  title = "censusVis",

  sidebar = sidebar(
    helpText(
      "Create demographic maps with information from the 2010 US Census."
    ),
    selectInput(
      "var",
      label = "Choose a variable to display",
      choices =
        c(
          "Percent White",
          "Percent Black",
          "Percent Hispanic",
          "Percent Asian"
        ),
      selected = "Percent White"
    ),
    sliderInput(
      "range",
      label = "Range of interest:",
      min = 0, 
      max = 100, 
      value = c(0, 100)
    )
  ),

  card(plotOutput("map"))
)

# Server logic ----
server <- function(input, output) {
  
  # observe(print(input$var))
  
  output$map <- renderPlot({
    args <- switch(input$var,
      "Percent White" = list(counties$white, "darkgreen", "% White"),
      "Percent Black" = list(counties$black, "black", "% Black"),
      "Percent Hispanic" = list(counties$hispanic, "darkorange", "% Hispanic"),
      "Percent Asian" = list(counties$asian, "darkviolet", "% Asian"))

    args$min <- input$range[1]
    args$max <- input$range[2]

    do.call(percent_map, args)
  })
}
# Run app ----
shinyApp(ui, server)