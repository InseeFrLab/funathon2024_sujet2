# RTraffic server

function(input, output) {
  output$texte <- renderText({
    paste0("Pax in France - DGAC on data.gouv.fr")
  })
  #create reactive dataframes which will be called below----
  dfapt = reactive({
    return(pax_apt %>% filter((mois %in% input$mon)&(an == input$yea)))
  })
  dflsn = reactive({
    return(pax_lsn %>% filter((mois %in% input$mon)&(an == input$yea)))
  })
  
  #Table1 pax by faisceau from lsn----
  output$table1 <- DT::renderDataTable(DT::datatable({
    data = bind_cols(
      bind_rows(
        dflsn() %>% summarise(paxloc = round(sum(lsnpaxloc, na.rm = T)/1000000,3)),
        dflsn() %>%
          group_by(lsnfsc) %>%
          summarise(paxloc = round(sum(lsnpaxloc, na.rm = T)/1000000,3)) %>%
          ungroup
      )
    )
  }, class = "cell-border compact hover stripe",
  options = list(
    autoWidth = T,
    columnDefs = list(list(width = '20px', targets = c(0,1,2))),
    dom = "Bfrtip", 
    scrollY = 145, scrollX = 400, scroller = TRUE,
    fixedColumns = list(leftColumns = 1),
    select = list(style = 'os', items = 'row'),
    buttons = c(
      'copy', 'csv',
      'colvis',
      'selectAll', 'selectNone', 'selectRows', 'selectColumns', 'selectCells'
    )
  )))
  

  #Table2 pax by apt airport----
  output$table2 = DT::renderDataTable(DT::datatable({
    data = bind_rows(
      dfapt() %>%
        group_by(apt, aptnom) %>%
        summarise(paxdep = round(sum(aptpaxdep, na.rm = T)/1000000,3), paxarr = round(sum(aptpaxarr, na.rm = T)/1000000,3), paxtra = round(sum(aptpaxtr, na.rm = T)/1000000,3)) %>%
        arrange(desc(paxdep)) %>%
        ungroup
    )
  }, class = "cell-border compact hover stripe",
  extensions = c("Scroller", "FixedColumns", "Buttons", "Select"), 
  selection = "none",
  options = list(
    autoWidth = T,
    columnDefs = list(list(width = '20px', targets = c(0,1,2))),
    dom = "Bfrtip", 
    scrollY = 145, scrollX = 400, scroller = TRUE,
    fixedColumns = list(leftColumns = 1),
    select = list(style = 'os', items = 'row'),
    buttons = c(
      'copy', 'csv',
      'colvis',
      'selectAll', 'selectNone', 'selectRows', 'selectColumns', 'selectCells'
    )
  )))
  }