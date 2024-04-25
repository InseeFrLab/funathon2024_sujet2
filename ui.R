# RTraffic ui

fluidPage(
  verbatimTextOutput(outputId = "texte"),
  checkboxGroupInput("mon", "Mois : ",
                     month_list,
                     selected = month_list[1],
                     inline = TRUE),
  radioButtons("yea", "Année : ",
               year_list,
               selected = year_list[1],
               inline = TRUE),
  DT::dataTableOutput("table1"),
  DT::dataTableOutput("table2")
)