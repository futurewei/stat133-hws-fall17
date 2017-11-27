#  @title remove-missing()
#  @description remove missing 
#  @param x is a vector
#  @return a vector without missing val

remove_missing <- function(x){
  x<-x[is.na(x)==FALSE]
  return(x)
}


#  @title get_minimum()
#  @description get min value in vector 
#  @param x is a vector
#  @return a min val

get_minimum <- function(x,na.rm=TRUE){
  if (!is.numeric(x)) {
    stop("x is not numeric")
  }
  if(na.rm==TRUE){
    remove_missing(x)
  }
    x<-sort(x)
    return(x[1])
}



#  @title get_maximum()
#  @description get max value in vector 
#  @param x is a vector
#  @return a max val

get_maximum <- function(x,na.rm=TRUE){
  if (!is.numeric(x)) {
    stop("x is not numeric")
  }
  if(na.rm==TRUE){
    remove_missing(x)
  }
    x<-sort(x,decreasing = TRUE)
    return(x[1])
}

#  @title get_range()
#  @description get range of vector
#  @param x is a vector
#  @return a range val

get_range <- function(a, b=TRUE){
  if (b==TRUE)
  {
    a <- remove_missing(a)
  }
  min <- get_minimum(a)
  max <- get_maximum(a)
  return (max - min)
}

#  @title get_percentile10()
#  @description get 10 percentile of vector
#  @param a is a vector
#  @return a percentile10 value

get_percentile10 <- function(a, b=TRUE) {
  if (b == TRUE)
  {
    a<-remove_missing(a)
  }
  return (quantile(a,probs = 0.1,na.rm=TRUE))
}

#  @title get_percentile90()
#  @description get 90 percentile of vector
#  @param a is a vector
#  @return a percentile90 value
get_percentile90 <- function(a, b=TRUE){
  if (b == TRUE)
  {
    a<-remove_missing(a)
  }
 
  return (quantile(a,probs = 0.9,na.rm=TRUE))
}

#  @title get_median()
#  @description get median from a vector
#  @param a is a vector
#  @return the medain value
get_median <- function(a, na=TRUE){
  if (na == TRUE){
    a <- remove_missing(a)
  }
  a <- sort(a)
  median <- 0
  if ((length(a) %% 2) == 0){
     median = (a[length(a)/2] + a[length(a)/2+1])/2
  }else{
    median = a[length(a)/2 + 1]
  }
  return (median)
}


#  @title get_average()
#  @description get average from a vector
#  @param a is a vector
#  @return the average value
get_average <- function(a, na=TRUE){
  if (na == TRUE)
  {
      a<- remove_missing(a)
  }
    
  count <- 0
  sum <- 0
  for (i in 1:length(a)){
    count = count + 1
    sum = sum + a[i]
  }
  result = sum/count
  return (result)
}


#  @title get_stdev()
#  @description get standard deviation from a vector
#  @param a is a vector
#  @return the stdev value

get_stdev <- function(a, na=TRUE) {
  if(na == TRUE){
    a <- remove_missing(a)
  }
  
  avg <- get_average(a, TRUE)
  sum <- 0
  count <- 0
  for (i in 1:length(a))
  {
    count = count + 1
    sum = sum + ((a[i] - avg)*(a[i] - avg))
  }
  result = sqrt(sum /(count -1))
  return (result)
}



#  @title get_quartile1()
#  @description get quartile1
#  @param a is a vector
#  @return the quartile1
get_quartile1<-function(a, b=TRUE){
  if (b == TRUE)
  {
    a<-remove_missing(a)
  }
  return (quantile(a,probs = 0.25,na.rm=TRUE))
}


#  @title get_quartile3()
#  @description get quartile3
#  @param a is a vector
#  @return the quartile3
get_quartile3 <- function(a, b=TRUE){
  if (b == TRUE)
  {
    a<-remove_missing(a)
  }
  return (quantile(a,probs = 0.75,na.rm=TRUE))
}



#  @title count_missing()
#  @description count how many missing vals
#  @param x is a vector
#  @return the number of missing values
count_missing <- function(x){
  which <- which(is.na(x))
  return(length(which))
}




# @title summary_states()
# @description returns a list of summary statistics
# @param x a numeric vector
# @return a list of summary statistics
summary_stats<-function(x){
  list <- list(
    minimum = get_minimum(x),
    percent10 = get_percentile10(x),
    quartile1 = get_quartile1(x),
    median = get_median(x),
    mean = get_average(x),
    quartile3 = get_quartile3(x),
    percent90 = get_percentile90(x),
    maximum = get_maximum(x),
    range = get_range(x),
    stdev = get_stdev(x),
    missing = count_missing(x))
  return(list)
}


# @title print_stats()
# @description print stats
# @param x a numeric vector
# @return nothing
print_stats <- function(x){
  
  names <- names(summary_stats(x))
  vals <- c(                     get_minimum(x),
                                get_percentile10(x),
                                get_quartile1(x),
                                get_median(x),
                                get_average(x),
                                get_quartile3(x),
                                get_percentile90(x),
                                get_maximum(x),
                                get_range(x),
                                get_stdev(x),
                                count_missing(x))

  name <- format(names,width = 9,justify = "left")
  value <- sprintf("%.4f", vals)
  stats <- paste(name,": ",value,   sep = "")
  cat(stats,sep = "\n")
}




#  @title rescale100()
#  @description rescale value
#  @param x is a val
#  @return a scaled version
rescale100 <- function(x,xmin,xmax){
  z <- 100*((x-xmin)/(xmax-xmin))
  return(z)
}


#  @title drop_lowest()
#  @description drop lowest score
#  @param x is a vector
#  @return a vector with lowest score dropped.
drop_lowest <- function(x){
  x <- sort(x)
  x <- x[-1]
  return(x)
}


#  @title score_homework()
#  @description calculate hw score for student
#  @param hws is a vector
#  @return a averaged value of homework scores

score_homework <- function(hws, drop=TRUE){
  if(drop == TRUE)
  {
    hws <- drop_lowest(hws)
  }
  return (get_average(hws, TRUE))
}

#  @title score_quiz()
#  @description calculate lab score for student
#  @param x is a vector
#  @return a averaged value of quiz scores

score_quiz <- function(x,drop=TRUE){
 if(drop == TRUE)
  {
    quiz <- drop_lowest(x)
  }
  return (get_average(quiz, TRUE))
}


#  @title score_lab()
#  @description calculate lab score for student
#  @param lab is a val
#  @return a corresponding score

score_lab <- function(lab){
  if (lab ==10)
    return (80)
  else if (lab == 9)
    return (60)
  else if (lab == 8)
    return (40)
  else if (lab == 7)
    return (20)
  else if (lab == 11 | lab==12)
    return (100)
  else if(lab == 6 | lab < 6)
    return (0)
}

