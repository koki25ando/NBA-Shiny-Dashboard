library(shiny)
library(tidyverse)

##-------------------------------------------------------------Header---------------------
header <- dashboardHeader()

##------------------------------------------------------------Sidebar----------------------
sidebar <- dashboardSidebar(
  textInput(
    inputId = "player_name",
    label = "Type a name of Player :",
    value = "LeBron James",
    placeholder = players_list_since1950$Player
  )
  # selectizeInput(
  #   inputId = "player_name",
  #   label = "Type a name of Player :",
  #   choices = players_list_since1950$Player,
  #   selected = "LeBron James",
  #   multiple = FALSE,
  #   options = NULL
  # )
)

##--------------------------------------------------------------BODY------------------------
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
  )),
  box(
    width = 6,
    title = "Plot",
    plotOutput(
      outputId = "career_plot"
    )
  ))
)

ui <- dashboardPage(header, sidebar, body)