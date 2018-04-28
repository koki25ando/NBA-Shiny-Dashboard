library(shiny)
library(tidyverse)

##----------------------------------------------------------------------------------
header <- dashboardHeader()

##----------------------------------------------------------------------------------
sidebar <- dashboardSidebar(
  textInput(
    inputId = "player_name",
    label = "Type a name of Player :",
    value = "LeBron James"
  )
)

##----------------------------------------------------------------------------------
body <- dashboardBody(
  imageOutput("img"),
  tableOutput(
    outputId = "table"
  ),
  tableOutput(
    outputId = "career_summary_table"
  )
)

ui <- dashboardPage(header, sidebar, body)