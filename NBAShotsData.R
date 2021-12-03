## Aryaman Suri Technical Assessment '
library(tidyverse)
## Data read in
setwd("/Users/arysuri/Downloads")
shots_data <- read.csv("shots_data.csv")

## Filter the data by team and shot zone from the original data set

## Two point shots are when |x| is less than 22 when y is less than or equal to 7.8, or when the distance is less than 23.75 when y is greater than 7.8 
teamA2PT <- filter(shots_data, team == "Team A" & ((y <= 7.8 & abs(x) < 22) | (y > 7.8 & sqrt(x**2 + y**2) < 23.75)))
teamB2PT <- filter(shots_data, team == "Team B" & ((y <= 7.8 & abs(x) < 22) | (y > 7.8 & sqrt(x**2 + y**2) < 23.75)))
## Non corner threes are when y is greater than 7.8, and the coordinate distance is greater than or equal to 23.75
teamANC3 <- filter(shots_data, team == "Team A" & y > 7.8 & sqrt(x**2 + y**2) >= 23.75)
teamBNC3 <- filter(shots_data, team == "Team B" & y > 7.8 & sqrt(x**2 + y**2) >= 23.75)
## Corner threes are when the y coordinate is less than or equal to 7.8, and |x| >= 22
teamAC3 <- filter(shots_data, team == "Team A" & y <= 7.8 & abs(x) >= 22)
teamBC3 <- filter(shots_data, team == "Team B" & y <= 7.8 & abs(x) >= 22)

## Calculate Shot Distribution for each zone and team by dividing number of shots within zone by total number of shots
teamA2PTDist <- nrow(teamA2PT)/nrow(filter(shots_data, team == "Team A"))
teamB2PTDist <- nrow(teamB2PT)/nrow(filter(shots_data, team == "Team B"))

teamANC3Dist <- nrow(teamANC3)/nrow(filter(shots_data, team == "Team A"))
teamBNC3Dist <- nrow(teamBNC3)/nrow(filter(shots_data, team == "Team B"))

teamAC3Dist <- nrow(teamAC3)/nrow(filter(shots_data, team == "Team A"))
teamBC3Dist <- nrow(teamBC3)/nrow(filter(shots_data, team == "Team B"))

## Calculate eFG%
## Only 2s in 2pt zone, so it is just makes/total within zone
teamA2PTeFG <- nrow(filter(teamA2PT, fgmade == 1))/nrow(teamA2PT)
teamB2PTeFG <- nrow(filter(teamB2PT, fgmade == 1))/nrow(teamB2PT)

## Just threes, so it just 1.5*makes/total within zone
teamANC3eFG <- (nrow(filter(teamANC3, fgmade == 1)) * 1.5)/nrow(teamANC3)
teamBNC3eFG <- (nrow(filter(teamBNC3, fgmade == 1)) * 1.5)/nrow(teamBNC3)

## Just threes, so it just 1.5*makes/total within zone
teamAC3eFG <- (nrow(filter(teamAC3, fgmade == 1)) * 1.5)/nrow(teamAC3)
teamBC3eFG <- (nrow(filter(teamBC3, fgmade == 1)) * 1.5)/nrow(teamBC3)

## Put data in data frame
teamAShotZoneData <- data.frame(c(teamA2PTDist, teamANC3Dist, teamAC3Dist), c(teamA2PTeFG, teamANC3eFG, teamAC3eFG))
colnames(teamAShotZoneData) <- c("Team A Shot Distribution", "Team A Effective Field Goal")
rownames(teamAShotZoneData) <- c("2PT", "NC3", "C3")
teamAShotZoneData

teamBShotZoneData <- data.frame(c(teamB2PTDist, teamBNC3Dist, teamBC3Dist), c(teamB2PTeFG, teamBNC3eFG, teamBC3eFG))
colnames(teamBShotZoneData) <- c("Team B Shot Distribution", "Team B Effective Field Goal")
rownames(teamBShotZoneData) <- c("2PT", "NC3", "C3")
teamBShotZoneData
