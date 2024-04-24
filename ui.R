# RTraffic ui

fluidPage(
  verbatimTextOutput(outputId = "texte"),
  checkboxGroupInput("mon", "Mois : ",
                     month_char,
                     selected = month_char[1],
                     inline = TRUE),
  radioButtons("yea", "Année : ",
               year_char,
               selected = year_char[1],
               inline = TRUE),
  DT::dataTableOutput("table1"),
  DT::dataTableOutput("table2")
)