library(testthat)
source('functions.R')
sink('../output/test-reporter.txt')
test_file('tests.R')
sink()


