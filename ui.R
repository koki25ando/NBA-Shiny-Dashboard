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
  fluidRow(
  box(
    width = 3,
    height = 250,
    title = "Profile Picture",
    imageOutput("img")),
  box(
    width = 9,
    title = "Player Information",
    tableOutput(
      outputId = "table"
  )),
  box(
    width = 9,
    title = "Career Stats",
    tableOutput(
    outputId = "career_summary_table"
  )))
)

ui <- dashboardPage(header, sidebar, body)