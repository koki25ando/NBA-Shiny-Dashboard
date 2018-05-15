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
    dataset_for_career_plot <- stats_advanced %>% 
      filter(Player == as.character(input$player_name))
    career_plotly <- dataset_for_career_plot %>% 
      ggplot(aes_string(x = dataset_for_career_plot$Year, y = input$stats_type)) + 
      geom_point() + 
      geom_line()
    ggplotly(career_plotly)
  })
  
  output$cumulative_plot <- renderPlot({
    ggplot() +
      geom_step(aes_string(x = "nth", 
                           y = input$stats_type, 
                           fill = "Player"),
                data = career_cumulative_stats_nth, 
                colour = alpha("grey", 0.7)) +
      geom_step(aes_string(x = "nth", 
                           y = input$stats_type, 
                           fill = "Player"), colour = "red",
                data = career_cumulative_stats_nth %>%
                  filter(Player == as.character(input$player_name))) +
      labs(x = "Season") +
      xlim(0, 25)
  })
}
