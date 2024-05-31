month_list = c(paste0("0", 1:9),10:12)
year_list <- 2018:2022

ui <- page_navbar(
  title = "Tableau de bord aéroports",
  bg = "#2D89C8",
  inverse = TRUE,
  nav_panel(
    title = "La BDD", 
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
    
    ),
  nav_panel(title = "Flux par apt", p("Second page content.")),
  nav_panel(title = "Carte", p("Third page content.")),
  nav_spacer(),
  nav_menu(
    title = "Links",
    align = "right",
    nav_item(tags$a("DGAC", href = "https://www.ecologie.gouv.fr/direction-generale-laviation-civile-dgac")),
    nav_item(tags$a("Insee", href = "https://www.insee.fr/fr/accueil")),
    nav_item(tags$a("data.gouv", href = "https://www.data.gouv.fr/fr/"))
  )
)
