function(input, output) {
  
  output$date1 <- renderText(input$date)
  output$date2 <- renderText(input$date)
  output$airport <- renderText(input$select)
  
}