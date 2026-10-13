# Data-splitting
str(Solo)
colnames(Solo)
PTS_ <- createDataPartition(Solo$Sand_gkg, p = .70, list = F, times = 1)
head(PTS_)
Solo_cal <- Solo[PTS_,]
#str(PI.train)
#View(PI.train)
Solo_val <- Solo[-PTS_,]
str(PI.val)
View(Solo_val)
# Exporting BD. Training and validation
write.csv(PTS_Cal, "./PTS_Cal.csv")
write.csv(PTS_Val, "./PTS.Val.csv") 
