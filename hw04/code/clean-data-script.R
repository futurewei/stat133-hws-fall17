# read in csv file with raw scores
source("functions.R")
original = read.csv('../data/rawdata/rawscores.csv',stringsAsFactors = FALSE)
raw_score = original 

#head(raw_score)
sink(file='../output/summary-rawscores.txt')
str(original)
sink()
for(i in 1:16){
  sink('../output/summary-rawscores.txt',append = TRUE)
  print(summary_stats(raw_score[,i]))
  print(print_stats(raw_score[,i]))
  sink()
}

for (i in 1:nrow(raw_score)) { 
  for (j in 1:ncol(raw_score)) {
    if (is.na(raw_score[i,j])==TRUE) 
      raw_score[i,j] <- 0
  }
}
raw_score <- raw_score


raw_score$QZ1 <- rescale100(raw_score$QZ1,xmin = 0,xmax = 12)
raw_score$QZ2 <- rescale100(raw_score$QZ2,xmin = 0,xmax = 18)
raw_score$QZ3 <- rescale100(raw_score$QZ3,xmin = 0,xmax = 20)
raw_score$QZ4 <- rescale100(raw_score$QZ4,xmin = 0,xmax = 20)
raw_score$Test1 <- rescale100(raw_score$EX1,xmin=0,xmax = 80)
raw_score$Test2 <- rescale100(raw_score$EX2,xmin=0,xmax = 90)



hw <- raw_score[,1:9]
raw_score$Homework <- round(apply(hw, 1, score_homework,drop=TRUE),0)

quiz <- raw_score[,11:14]
raw_score$Quiz <- round(apply(quiz,1, score_quiz,drop=TRUE),0)


#Add Lab
raw_score$Lab <- as.numeric(lapply(raw_score$ATT,function(x) score_lab(x)))


#Add Overall
raw_score$Overall <- raw_score$Lab *0.1+0.3* raw_score$Homework +0.15*raw_score$Quiz+0.2*raw_score$Test1+0.25*raw_score$Test2

grade_assign <- function(score){
  if (score >=0 & score < 50)
    return ("F")
  else if (score >=50 & score < 60)
    return ("D")
  else if (score >=60 & score < 70)
    return ("C-")
  else if (score >=70 & score < 77.5)
    return ("C")
  else if (score >=77.5 & score < 79.5)
    return ("C+")
  else if (score >=79.5 & score < 82)
    return ("B-")
  else if (score >=82 & score < 86)
    return ("B")
  else if (score >=86 & score < 88)
    return ("B+")
  else if (score >=88 & score < 90)
    return ("A-")
  else if (score >=90 & score < 95)
    return ("A")
  else if (score >=95 & score <= 100)
    return ("A+")
}

for (i in 1: 334){
  raw_score$grade[i] <- grade_assign(raw_score$Overall[i])
}



#Export summary
files <- c("Lab", "Homework", "Quiz", "Test1", "Test2", "Overall")
for(i in 1:6){
  file = files[i]
  sink (file = paste("../output/", file, "-stats.txt"))
  # read df by name using [[]]
  print(summary_stats(raw_score[[file]]))
  print(print_stats(raw_score[[file]]))
  sink()
}

sink(file='../output/summary-cleanscores.txt')
str(raw_score)
sink()

write.csv(raw_score, file = '../data/cleandata/cleanscores.csv')