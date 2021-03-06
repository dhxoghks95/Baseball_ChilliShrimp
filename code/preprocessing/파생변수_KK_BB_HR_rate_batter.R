library(tidyverse)
batter = read.csv('C:/Users/seungjun/Desktop/baseball/Baseball_ChilliShrimp/data/batter_tidy.csv',header=T)

head(batter)

sum = batter %>%
  group_by(P_ID) %>%
  summarise(HR=sum(HR), HIT=sum(HIT), KK=sum(KK), BB=sum(BB), PA=sum(PA))
  
df = sum %>%
  mutate(HR_rate=HR/HIT) %>%
  mutate(KK_rate=KK/PA) %>%
  mutate(BB_rate=BB/PA) 
rate = select(df,c(P_ID,HR_rate,KK_rate,BB_rate))

head(rate)

sum(is.na(rate))
sum(is.infinite(rate$KK_rate))
sum(is.infinite(rate$BB_rate))
sum(is.infinite(rate$HR_rate))

rate[is.na(rate)] = 0
sum(is.na(rate))
rate$BB_rate[is.infinite(rate$BB_rate)] = 0

data = left_join(batter,rate,by='P_ID')

write.csv(data,'C:/Users/seungjun/Desktop/baseball/Baseball_ChilliShrimp/data/batter_KK_BB_HR_rate.csv' )

