# RTraffic server

function(input, output) {
  output$texte <- renderText({
    paste0("Pax in France - DGAC")
  })
  #create 2 reactive dataframes which will be called below----
  dfapt = reactive({
    return(pax_apt %>% filter((mois %in% input$mon)&(an == input$yea)))
  })
  dflsn = reactive({
    return(pax_lsn %>% filter((mois %in% input$mon)&(an == input$yea)))
  })
  #Table1 pax by lsn link----
  output$table1 <- DT::renderDataTable(DT::datatable({
    data <- bind_rows(
      dflsn() %>%
        summarise(paxloc = sum(lsnpaxloc, na.rm = T)),
      dflsn() %>%
        group_by(lsnfsc) %>%
        summarise(paxloc = sum(lsnpaxloc, na.rm = T)) %>%
        ungroup,
      dflsn() %>%
        group_by(lsn, lsndepnom, lsnarrnom, lsnfsc) %>%
        summarise(paxloc = sum(lsnpaxloc, na.rm = T)) %>%
        arrange(desc(paxloc)) %>%
        ungroup
    )
  }, class = "cell-border compact hover stripe",
  options = list(
    #pageLength = 3,
    #lengthMenu = c(3, 14, 22),
    autoWidth = T,
    columnDefs = list(list(width = '20px', targets = c(0,1,2))),
    dom = "Bfrtip", 
    # scroll :
    scrollY = 145, scrollX = 400, scroller = TRUE,
    # fixer les colonnes : 
    fixedColumns = list(leftColumns = 1),
    # selection :
    select = list(style = 'os', items = 'row'),
    buttons = c(
      # enregistrements
      'copy', 'csv',
      # visualisation des colonnes
      'colvis',
      # selection des elements
      'selectAll', 'selectNone', 'selectRows', 'selectColumns', 'selectCells'
    )
  )))
  #Table2 pax by apt airport----
  output$table2 = DT::renderDataTable(DT::datatable({
    data = bind_rows(
      dfapt() %>%
        group_by(apt, aptnom) %>%
        summarise(paxdep = sum(aptpaxdep, na.rm = T), paxarr = sum(aptpaxarr, na.rm = T), paxtra = sum(aptpaxtr, na.rm = T)) %>%
        arrange(desc(paxdep)) %>%
        ungroup
    )
  }, class = "cell-border compact hover stripe",
  extensions = c("Scroller", "FixedColumns", "Buttons", "Select"), 
  selection = "none",
  options = list(
    #pageLength = 3,
    #lengthMenu = c(3, 14, 22),
    autoWidth = T,
    columnDefs = list(list(width = '20px', targets = c(0,1,2))),
    dom = "Bfrtip", 
    # scroll :
    scrollY = 145, scrollX = 400, scroller = TRUE,
    # fixer les colonnes : 
    fixedColumns = list(leftColumns = 1),
    # selection :
    select = list(style = 'os', items = 'row'),
    buttons = c(
      # enregistrements
      'copy', 'csv',
      # visualisation des colonnes
      'colvis',
      # selection des elements
      'selectAll', 'selectNone', 'selectRows', 'selectColumns', 'selectCells'
    )
  )))
  }