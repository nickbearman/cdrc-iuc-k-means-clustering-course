# data preparation to create internet-input-data.csv file for part 2

setwd("C:/Users/nick/Dropbox/Work/2020-010-CDRC-training/iuc-k-means-clustering/k-means-workbook")

#age
age <- read.csv("data/age.csv")
str(age)
  #Aggregate groups
    age$age_total <- age$Total.People
    age$age0to4 <- age$Age0to4
    age$age5to14 <- age$Age5to7 + age$Age10to14
    age$age16to24 <- age$Age16to17 + age$Age18to19 + age$Age20to24
    age$age25to44 <- age$Age25to29 + age$Age30to44
    age$age45to64 <- age$Age45to59 + age$Age60to64
    age$age65to74 <- age$Age65to74
    age$age75plus <- age$Age75to84 + age$Age85to89 + age$Age90andover
  #calc pc
    age$age0to4pc <- age$Age0to4 / age$age_total
    age$age5to14pc <- age$age5to14 / age$age_total
    age$age16to24pc <- age$age16to24 / age$age_total
    age$age25to44pc <- age$age25to44 / age$age_total
    age$age45to64pc <- age$age45to64 / age$age_total
    age$age75pluspc <- age$age75plus / age$age_total
  #remove extra columns
    age <- age[c(1:5,22,30:35)]
  #check data
    head(age)
  #age data ready
  
#nssec
    nssec <- read.csv("data/nssec.csv")
    head(nssec)
    #rename columns
    colnames(nssec)[7:14] <- c("HigherManagerial1","LowerManagerial2","Intermediate3","SmallEmployers4","SupervisoryTechnical5","SemiRoutine6","Routine7","LongTermUnemployed8")
    #check columns rename
    colnames(nssec)
    head(nssec)
    #calculate percentage
    nssec$HigherManagerial1pc <- nssec$HigherManagerial1 / nssec$NSSEC.Total
    nssec$LowerManagerial2pc <- nssec$LowerManagerial2 / nssec$NSSEC.Total
    nssec$Intermediate3pm <- nssec$Intermediate3 / nssec$NSSEC.Total
    nssec$SmallEmployers4pc <- nssec$SmallEmployers4 / nssec$NSSEC.Total
    nssec$SupervisoryTechnical5pc <- nssec$SupervisoryTechnical5 / nssec$NSSEC.Total
    nssec$SemiRoutine6pc <- nssec$SemiRoutine6 / nssec$NSSEC.Total
    nssec$Routine7pc <- nssec$Routine7 / nssec$NSSEC.Total
    nssec$LongTermUnemployed8pc <- nssec$LongTermUnemployed8 / nssec$NSSEC.Total
    #check
    head(nssec)
    
#internet speeds  
  internet.speeds <- read.csv("data/internet-speeds.csv")
  head(internet.speeds)
  str(internet.speeds)

#combine age, nssec and internet speeds together
  data <- merge(age, nssec, by.x = "GEO_CODE", by.y = "GEO_CODE")
  head(data)
  data <- merge(data, internet.speeds, by.x = "GEO_CODE", by.y = "MSOAcode")
  head(data)
#tidy up columns
  data <- data[,c(1,6:12,17,26:33,36:41)]
  colnames(data)  
  head(data)        

#save as csv file
  write.csv(data, file = "internet-input-data.csv", row.names = FALSE)
  