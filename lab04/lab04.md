lab4
================

``` r
my_table1 <- data.frame(
  Player = c("Thompson", "Curry", "Green", "Durant", "Pachulia"),
  Position = c("SG", "PG", "PF", "SF", "C"),
  Salary = c(16663575   , 12112359, 15330435, 26540100, 2898000),
  Points = c(1742, 1999, 776, 1555, 426),
  PPG = c(22.3, 25.3, 10.2, 25.1, 6.1),
  Rookie = c(FALSE, FALSE, FALSE, FALSE, FALSE)
)

 str(my_table1)
```

    ## 'data.frame':    5 obs. of  6 variables:
    ##  $ Player  : Factor w/ 5 levels "Curry","Durant",..: 5 1 3 2 4
    ##  $ Position: Factor w/ 5 levels "C","PF","PG",..: 5 3 2 4 1
    ##  $ Salary  : num  16663575 12112359 15330435 26540100 2898000
    ##  $ Points  : num  1742 1999 776 1555 426
    ##  $ PPG     : num  22.3 25.3 10.2 25.1 6.1
    ##  $ Rookie  : logi  FALSE FALSE FALSE FALSE FALSE

``` r
 my_table1
```

    ##     Player Position   Salary Points  PPG Rookie
    ## 1 Thompson       SG 16663575   1742 22.3  FALSE
    ## 2    Curry       PG 12112359   1999 25.3  FALSE
    ## 3    Green       PF 15330435    776 10.2  FALSE
    ## 4   Durant       SF 26540100   1555 25.1  FALSE
    ## 5 Pachulia        C  2898000    426  6.1  FALSE
