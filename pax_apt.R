# PAX BY AIRPORT----

#rm(list = ls())
library(dplyr)
library(stringr)
init = paste0(str_sub(getwd(), 1, str_locate(getwd(),"Documents")[2]),"/init.R")
if (dir.exists(init)){source(init)} #runs init pg if available, doesn't otherwise
t0 = Sys.time()

#create a dataframe with years and paths----
paths = data.frame(2018:2022,
                   c("https://www.data.gouv.fr/fr/datasets/r/3b7646ea-276c-4c9b-8151-1e96af2adbf9",
                     "https://www.data.gouv.fr/fr/datasets/r/e8efa154-045e-4f8f-a1d7-76a39fa03b7b",
                     "https://www.data.gouv.fr/fr/datasets/r/6717f107-be00-4b4b-9706-fa0e5190fb69",
                     "https://www.data.gouv.fr/fr/datasets/r/2f9f6e54-e2d7-4e85-b811-2e5e68fa5bca",
                     "https://www.data.gouv.fr/fr/datasets/r/f1bd931e-c99e-41ce-865e-9e9785c903ec"
                   )
)
names(paths) = c("year","path")

#load data online----
df = NULL
for (i in paths[[1]]){
  print(i)
  x = paths %>% filter(year == i) #filter on the year selected
  df = rbind(df,read.csv(x[[2]], sep = ";", dec = ",")) #add new dataframe to previous one
}
print(Sys.time()-t0)
rm(x,i,t0)
