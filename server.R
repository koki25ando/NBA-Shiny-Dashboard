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
  
  output$career_summary_table <- renderTable({
    career_summary_stats %>% filter(Player == as.character(input$player_name))
  })
  
  output$career_plot <- renderPlotly({
    career_plotly <- stats_advanced %>% 
      filter(Player == as.character(input$player_name)) %>% 
      ggplot(aes(x = Year, y = PPG)) + 
      geom_point() + 
      geom_line()
    ggplotly(career_plotly)
  })
  
  output$cumulative_plot <- renderPlotly({
    career_cumulative_plotly <- career_cumulative_stats %>% 
      filter(Player == as.character(input$player_name)) %>% 
      ggplot(aes(x = Year, y = Career_PTS)) + 
      geom_point() +
      geom_step()
    ggplotly(career_cumulative_plotly)
  })
}
