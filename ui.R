
##-------------------------------------------------------------Header---------------------
header <- dashboardHeader()

##------------------------------------------------------------Sidebar----------------------
sidebar <- dashboardSidebar(
  selectizeInput(
    inputId = "player_name",
    label = "Type a name of Player :",
    choices = unique(players_list_since1950$Player),
    multiple = F,
    options = list(maxItems = 5, placeholder = 'Select a name'),
    selected = "LeBron James"
  ),
  selectInput(
    inputId = "stats_type",
    label = "Select stats type :",
    choices = stats_advanced %>% 
      select(PTS:STL) %>% 
      names(),
    selected = "PPG"
  ),
  submitButton("SUBMIT", icon("refresh"))
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
    plotlyOutput(
      outputId = "career_plot"
    )
  ),
  box(
    width = 6,
    title = "Cumulative Plot",
    plotOutput(
      outputId = "cumulative_plot"
    )
  )
  )
)

ui <- dashboardPage(header, sidebar, body)