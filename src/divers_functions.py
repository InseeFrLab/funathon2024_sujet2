def create_data_from_input(data, year, month):
  data = (
    data
    .loc[data['mois'].astype(str) == str(month)]
    .loc[data["an"].astype(str) == str(year)]
  )
  return data


def summary_stat_airport(data):
    table2 = (
        data
        .groupby("apt", "apt_nom")
        .agg({"paxdep": "sum", "paxarr": "sum", "paxtra": "sum"})
        .sort_values("paxdep", ascending = False)
    )
    return table2