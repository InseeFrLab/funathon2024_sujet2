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
  if (exists("source_to_compare")){#compare with other source with the same variable names if loaded with init.R
    dfraw = reactive({
      return(source_to_compare %>% filter((mois %in% input$mon)&(an == input$yea)))
    })
  }
  
  #Table1 pax by faisceau from lsn----
  output$table1 <- DT::renderDataTable(DT::datatable({
    data = bind_cols(
      bind_rows(
        dflsn() %>% summarise(paxloc = round(sum(lsnpaxloc, na.rm = T)/1000000,3)),
        dflsn() %>%
          group_by(lsnfsc) %>%
          summarise(paxloc = round(sum(lsnpaxloc, na.rm = T)/1000000,3)) %>%
          ungroup
      ),
      #dflsn() %>%
        #group_by(lsnfsc) %>%
        #summarise(paxloc = round(sum(lsnpaxloc, na.rm = T)/1000000,3)) %>%
        #ungroup,
      if (exists("source_to_compare")){
        bind_rows(
          dfraw() %>% summarise(paxloc = round(sum(lsnpaxloc, na.rm = T)/1000000,3)),
          dfraw() %>%
            group_by(lsnfsc) %>%
            summarise(paxloc = round(sum(lsnpaxloc, na.rm = T)/1000000,3)) %>%
            ungroup
          )
      }
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
        summarise(paxdep = round(sum(aptpaxdep, na.rm = T)/1000000,3), paxarr = round(sum(aptpaxarr, na.rm = T)/1000000,3), paxtra = round(sum(aptpaxtr, na.rm = T)/1000000,3)) %>%
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