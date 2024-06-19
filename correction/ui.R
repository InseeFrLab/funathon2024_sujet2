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
           plotlyOutput("lineplot")
          ),
      col_widths = c(12,12)
    ),
    cols_widths = c(12,12,12)
  )
  
)

