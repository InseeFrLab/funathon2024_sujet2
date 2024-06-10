main_color <- "black"

input_date <- shinyWidgets::airDatepickerInput(
  "date",
  label = "Mois choisi",
  value = "2019-01-01",
  view = "months",
  minView = "months",
  minDate = "2018-01-01",
  maxDate = "2022-12-01",
  dateFormat = "MMMM yyyy",
  language = "fr"
)

input_airport <- selectInput(
  "select",
  "Aéroport choisi",
  choices = liste_aeroports,
  selected = default_airport
)

ui <- page_navbar(
  title = "Tableau de bord des aéroports français",
  bg = main_color,
  inverse = TRUE,
  header = em("Projet issu du funathon 2024, organisé par l'Insee et la DGAC"),
  layout_columns(
    card(
      input_date,
      gt_output(outputId = "table")
    ),
    layout_columns(
      card(leafletOutput("carte")),
      card(card_header("Fréquentation d'un aéroport", class = "bg-dark"),
           input_airport,
           plotlyOutput("figure")
          ),
      col_widths = c(12,12)
    ),
    cols_widths = c(12,12,12)
  )
  
)


# ui <- page_fillable(
#   
#   layout_columns(
#     card(card_header("Card 1"),
#          fluidPage(
#            ,
#          ),
#          card(card_header("Card 2"),),
#          card(card_header("Card 3"), "foo"),
#          col_widths = breakpoints(
#            sm = c(4, 4, 4), 
#            md = c(3, 3, 6), 
#            lg = c(-2, 8, -2)
#          )
#     )
#     
#   )
#   
# ui <- page_navbar(
#   title = "Tableau de bord aéroports",
#   bg = "#2D89C8",
#   inverse = TRUE,
#   nav_panel(
#     title = "La BDD", 
#     fluidPage(
#       shinyWidgets::airDatepickerInput(
#         "date",
#         label = "Mois choisi",
#         value = "2019-01-01",
#         view = "months",
#         minView = "months",
#         minDate = "2018-01-01",
#         maxDate = "2022-12-01",
#         dateFormat = "MMMM yyyy",
#         language = "fr"
#       ),
#       gt_output(outputId = "table")
#     )
#   ),
# nav_panel(title = "Flux par apt", p("Second page content.")),
# nav_panel(title = "Carte", p("Third page content.")),
# nav_spacer(),
# nav_menu(
#   title = "Links",
#   align = "right",
#   nav_item(tags$a("DGAC", href = "https://www.ecologie.gouv.fr/direction-generale-laviation-civile-dgac")),
#   nav_item(tags$a("Insee", href = "https://www.insee.fr/fr/accueil")),
#   nav_item(tags$a("data.gouv", href = "https://www.data.gouv.fr/fr/"))
# )
#)
