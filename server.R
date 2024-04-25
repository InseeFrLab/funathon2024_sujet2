function(input, output) {
  output$texte <- renderText({
    paste0("Pax in France - DGAC on data.gouv.fr")
  })
  #create reactive dataframes which will be called below----
  pax_apt = reactive({
    return(
      create_data_from_input(pax_apt_all, input$yea, input$mon)
    )
  })
  pax_lsn = reactive({
    return(
      create_data_from_input(pax_lsn_all, input$yea, input$mon)
      )
  })
  
  #Table1 pax by faisceau from lsn----
  output$table1 <- DT::renderDataTable(
    DT::datatable(
      summary_stat_liaisons(pax_lsn())
      )
  )
  

  #Table2 pax by apt airport----
  output$table2 = DT::renderDataTable(
      DT::datatable(
        summary_stat_airport(pax_apt())
        )
    )
}