library(testthat)
source('../code/functions.R',chdir = TRUE)


#Unit testremove_missing
context('testing remove-missing()')
test_that("remove-missing", {
  a <- c(1, 2, 3, NA)
  expect_equal(remove_missing(a), c(1,2,3))
  b <- c(1,3,4)
  expect_equal(remove_missing(b), c(1,3,4))
  c <- c(NA,NA, NA, NA)
  expect_equal(remove_missing(c), logical(0))
})

#Unit test  get_minimum
context('testing get-min()')
test_that("min",{
  a <- c(1, 2,3, NA, 4)
  min <- get_minimum(a)
  expect_equal(get_minimum(a), 1)
  expect_equal(is.numeric(get_minimum(a)),TRUE)
}
)


#Unit test  max
context('testing get-max()')
test_that("max",{
  a <- c(1, 2,3, NA, 4)
  min <- get_maximum(a)
  expect_equal(get_maximum(a), 4)
  expect_equal(is.numeric(get_maximum(a)),TRUE)
}
)

#Unit test get_range
context('testing get-range()')
test_that("Range Test",{
  a <- c(10,20,30)
  res <- get_range(a)
  expect_equal(res, 20)
  expect_equal(is.numeric(res), TRUE)
}
)

#Unit test get_percentile10
context('testing get-percentile10()')
test_that("percentile10",{
  a <- c(1, 4, 7, NA, 10)
  test <- get_percentile10(a)
  expect_equal(test,1.9)
  expect_equal(is.numeric(test), TRUE)
}
)

#Unit test  median
context('testing get-median()')
test_that("function median",{
  a <- c(1, 2, 3,4,5)
  res <- get_median(a)
  expect_equal(res, 3)
}
)


#Unit test  get_averge
context('testing get-avg()')
test_that("function average",{
  a <- c(1, 2, 3)
  res <- get_averge(a)
  expect_equal(res, 2)
}
)

#Unit test  get_stdev
context('testing get-stdev()')
test_that("stdv",{
  a <- c(1, 1, 1)
  res <- get_stdev(a)
  expect_equal(res, 0)
}
)

#Unit test count_missing
context('testing count-missing()')
test_that("count_missing",{
  a <- c(NA, 1, NA, 2)
  res <- count_missing(a)
  #output is correct
  expect_equal(res, 2)
  b <- c(1,2,3,4,5)
  res <- count_missing(b)
  expect_equal(res,  0)
}
)



#Unit test drop_lowest
context('testing drop-lowest()')
test_that("drop_lowest",{
  a <-c (1,2,3,4)
  res <- drop_lowest(a)
  expect_equal(length(res), 3)
  expect_equal(res, c(2,3,4))
}
)

#Unit test score_homework()
context('testing score-hw()')
test_that("hw",{
  hws <- c(1,2,3,4,5)
  res1 <- score_homework(hws, drop = TRUE)
  res2 <- score_homework(hws, drop = FALSE)
  expect_equal(res1, 3.5)
  expect_equal(res2, 3)
}
)

#Unit test score_quiz
context('testing score_quiz()')
test_that("quiz",{
  quizzes <- c(50, 50, 50, 0)
  res <- score_quiz(quizzes)
  expect_equal(res, 50)
  expect_equal(is.numeric(res), TRUE)
}
)

#Unit test score_lab()
context('testing score_lab()')
test_that("lab",{
  res <- score_lab(12)
  expect_equal(res, 100 )
  expect_equal(is.numeric(res), TRUE)
}
)

