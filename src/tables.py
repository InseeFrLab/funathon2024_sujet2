from great_tables import GT, md

def create_table_airports(stats_aeroports):

    stats_aeroports['name_clean'] = stats_aeroports['apt_nom'].str.title() + " _(" + stats_aeroports['apt'] + ")_"
    stats_aeroports = stats_aeroports[ ['name_clean'] + [ col for col in stats_aeroports.columns if col != 'name_clean' ] ]

    table_gt = (
        GT(stats_aeroports.head(15))
        .cols_hide(columns = stats_aeroports.filter(like = "apt").columns.tolist())
        .fmt_number(columns = stats_aeroports.filter(like = "pax").columns.tolist(), compact = True)
        .fmt_markdown(columns = "name_clean")
        .cols_label(
            name_clean = md("**Aéroport**"),
            paxdep = md("**Départs**"),
            paxarr = md("**Arrivée**"),
            paxtr = md("**Transit**")
        ) 
        .tab_header(
            title = md("**Statistiques de fréquentation**"),
            subtitle = md("Classement des aéroports")
        )
        .tab_source_note(source_note = md("_Source: DGAC, à partir des données sur data.gouv.fr_"))
    )

    return table_gt