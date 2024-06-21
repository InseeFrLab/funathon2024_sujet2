import pandas as pd

def create_data_from_input(data, year, month):
  data = (
    data
    .loc[
      (data['mois'].astype(str) == str(month)) &
      (data["an"].astype(str) == str(year))
    ]
  )
  return data


def summary_stat_airport(data):
    table2 = (
        data
        .groupby(["apt", "apt_nom"])
        .agg({"apt_pax_dep": "sum", "apt_pax_arr": "sum", "apt_pax_tr": "sum", "trafic": "sum"})
        .sort_values("trafic", ascending=False)
        .reset_index()
    )
    table2.columns = table2.columns.str.replace("apt_pax_", "pax")
    return table2
