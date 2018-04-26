library(shiny)
library(tidyverse)

##----------------------------------------------------------------------------------
header <- dashboardHeader()

##----------------------------------------------------------------------------------
sidebar <- dashboardSidebar(
  textInput(
    inputId = "player_name",
    label = "Type a name of Player :",
    value = "Lebron James"
  )
)

##----------------------------------------------------------------------------------
body <- dashboardBody(
  imageOutput("img"),
  tableOutput(
    outputId = "table"
  )
)

ui <- dashboardPage(header, sidebar, body)