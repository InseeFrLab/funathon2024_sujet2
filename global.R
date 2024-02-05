# RTraffic global

#install.packages("DT")#if necessary install package

#Test Push Thomas

#rm(list = ls())
t0 = Sys.time()
if (exists("data_already_loaded")){#check the data is already loaded----
  print("already loaded")} else {
    #global parameters
    year_num = 2018:2022 #to be modified eg c(2019,2022,2023) 
    year_char = as.list(as.character(year_num))
    month_char = c(paste0("0", 1:9),10:12)
    paths = data.frame(year_num,
                       c("https://www.data.gouv.fr/fr/datasets/r/3b7646ea-276c-4c9b-8151-1e96af2adbf9",
                         "https://www.data.gouv.fr/fr/datasets/r/e8efa154-045e-4f8f-a1d7-76a39fa03b7b",
                         "https://www.data.gouv.fr/fr/datasets/r/6717f107-be00-4b4b-9706-fa0e5190fb69",
                         "https://www.data.gouv.fr/fr/datasets/r/2f9f6e54-e2d7-4e85-b811-2e5e68fa5bca",
                         "https://www.data.gouv.fr/fr/datasets/r/f1bd931e-c99e-41ce-865e-9e9785c903ec"
                       ),#apt airport data year after year
                       c("https://www.data.gouv.fr/fr/datasets/r/9c5354ad-31cb-4217-bc88-fb7c9be22655",
                         "https://www.data.gouv.fr/fr/datasets/r/0c0a451e-983b-4f06-9627-b5ff1bccd2fc",
                         "https://www.data.gouv.fr/fr/datasets/r/dad30bed-7276-4a67-a1ab-a856e6e01788",
                         "https://www.data.gouv.fr/fr/datasets/r/bbf6492d-86ac-43a0-9260-7df2ffdb5a77",
                         "https://www.data.gouv.fr/fr/datasets/r/af8950bc-e90a-4b7e-bb81-70c79d4c3846"
                       ),#lsn links data year after year
                       c("https://www.data.gouv.fr/fr/datasets/r/ddfea6a0-df7e-4402-99fc-165f573f2e10",
                         "https://www.data.gouv.fr/fr/datasets/r/8421e029-c8c7-410d-b38c-54455ac3265d",
                         "https://www.data.gouv.fr/fr/datasets/r/818eec10-6122-4788-8233-482e779ab837",
                         "https://www.data.gouv.fr/fr/datasets/r/0b954774-ccd1-43ec-9b5a-f958fba03e87",
                         "https://www.data.gouv.fr/fr/datasets/r/bcec3e1e-940a-4772-bc28-0d7b2b53c718"
                       )#cie company data year after year
    )
    names(paths) = c("year","apt","lsn","cie")
    
    #load libraries & variables & functions----
    #library(data.table)
    library(dplyr)
    library(shiny)
    library(stringr)
    
    simplify_text = function(texte){#replace upper case by lower case, delete punctuation and replace é by e, in variable names
      texte=tolower(texte)
      texte=str_replace_all(texte,"[:punct:]","")
      texte=str_replace_all(texte,"[:space:]","")
      texte=str_replace_all(texte,"[àâä]","a")
      texte=str_replace_all(texte,"[ç]","c")
      texte=str_replace_all(texte,"[éèêë]","e")
      texte=str_replace_all(texte,"[îï]","i")
      texte=str_replace_all(texte,"[ôö]","o")
      texte=str_replace_all(texte,"[ùûü]","u")
      return(texte)
    }
    
    load_data = function(data_typ){
      df = NULL
      for (i in paths[[1]]){
        print(paste0(data_typ," ",i))
        x = paths %>%
          select("year", all_of(data_typ)) %>% 
          filter(year == i) #filter on the year selected
        df = rbind(df,read.csv(x[[2]], sep = ";", dec = ",")) #add new dataframe to previous one
      }
      df = df %>% 
        mutate(an = str_sub(ANMOIS,1,4)) %>%
        mutate(mois = str_sub(ANMOIS,5,6))
      names(df)=simplify_text(names(df))
      rm(x,i)
      return(df)
    }

    #load data online----
    pax_apt = load_data("apt")
    pax_cie = load_data("cie")
    pax_lsn = load_data("lsn")
    data_already_loaded = TRUE
    }
print(Sys.time()-t0) #measures runtime----