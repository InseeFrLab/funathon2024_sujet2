import plotly.express as px

def plot_airport_line(df, selected_airport):

  trafic_aeroports = (
    df
    .loc[df['apt'] == default_airport]
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