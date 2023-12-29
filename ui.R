# RTraffic ui

fluidPage(
  verbatimTextOutput(outputId = "texte"),
  checkboxGroupInput("mon", "Mois : ",
                     month_char,
                     inline = T),
  radioButtons("yea", "Année : ",
                     year_char,
                     inline = T),
  DT::dataTableOutput("table1"),
  DT::dataTableOutput("table2")
)