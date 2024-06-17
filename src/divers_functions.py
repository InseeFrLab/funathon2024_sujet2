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
        .agg({"apt_pax_dep": "sum", "apt_pax_arr": "sum", "apt_pax_tr": "sum"})
        .sort_values("paxdep", ascending = False)
    )
    return table2