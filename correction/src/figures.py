import pandas as pd
import plotly.express as px

def plot_airport_line(df, selected_airport):

  trafic_aeroports = (
    df
    .loc[df['apt'] == selected_airport]
  )
  trafic_aeroports['date'] = pd.to_datetime(
    trafic_aeroports['anmois'] + '01', format='%Y%m%d'
  )


  fig = px.line(
    trafic_aeroports, x="date", y="trafic",
    text="apt_nom"
  )
  fig.update_traces(
    mode="markers+lines", type = "scatter",
    hovertemplate="<i>Aéroport:</i> %{text}<br>Trafic: %{y}"
  )

  return fig



import pandas as pd
import folium

def map_leaflet_airport(df, airports_location, month, year):

    df['date'] = pd.to_datetime(df['anmois'] + '01', format='%Y%m%d')
        
    # Filter by month and year
    trafic_date = df.loc[
        (df['mois'].astype(int) == month) & (df['an'].astype(int) == int(year))
    ]
        
    # Perform an inner join with airport locations
    trafic_aeroports = airports_location.merge(trafic_date, left_on="Code.OACI", right_on="apt", suffixes = ["_x", ""])
    trafic_aeroports['date'] = trafic_aeroports['date'].dt.strftime('%Y-%m-%d')

    palette = ['green', 'blue', 'red']  # Define your color palette

    trafic_aeroports['volume'] = pd.qcut(trafic_aeroports['trafic'], 3, labels=False) + 1
    trafic_aeroports['color']  = trafic_aeroports['volume'].apply(lambda x: palette[x-1])

    m = folium.Map()

    # Iterate over each point in the GeoDataFrame
    for idx, row in trafic_aeroports.iterrows():
        # Extract the coordinates and other properties
        coord = row['geometry']
        name = row['Nom']
        code_oaci = row['Code.OACI']
        trafic = int(row['trafic'])
        color = row['color']
        
        # Create the popup content
        popup_content = f"{name} ({code_oaci}) : {trafic} voyageurs"
        
        # Add a marker with the specified icon and color
        folium.Marker(
            location=[coord.y, coord.x],
            popup=folium.Popup(popup_content, parse_html=True),
            icon=folium.Icon(icon="plane", prefix='fa', color=color)
        ).add_to(m)

    return m
