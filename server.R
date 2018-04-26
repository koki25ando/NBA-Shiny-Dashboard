library(shiny)
library(tidyverse)

server <- function(input, output){
  output$table <- renderTable({
    players_list_since1950 %>% 
      filter(Player == as.character(input$player_name)) %>% 
      select(-given_name, -family_name, -key, -img_url)
  })
  
  image <- 
    reactive({image_read(players_list_since1950 %>% 
                           filter(Player == as.character(input$player_name)) %>% 
                           select(img_url) %>% 
                           as.character())})
  
  output$img <- renderImage({
    tmpfile <- image() %>%
      image_write(tempfile(fileext='jpg'), format = 'jpg')
    list(src = tmpfile, contentType = "image/jpeg")
  })
}
