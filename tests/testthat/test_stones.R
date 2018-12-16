context("multistate stones reading tests")

library(dplyr)
library(stringr)

test_that("Multistate Stones sampling is read correctly", {
  file = bt_read.stones("../../bayestraits_output/MS_MCMC_wSS_wPR.Stones.txt")

  expect_true(compare(colnames(file$stones_sampling),
                      c("Stone.No", "Power", "N", "Stone.MLh",
                        "Running.MLh"))$equal)
})

test_that("Multistate Stones settings is read correctly", {
  file = bt_read.stones("../../bayestraits_output/MS_MCMC_wSS_wPR.Stones.txt")

  expect_true(compare(attributes(file)$settings,
                      list(`Steppingstone sampler:` =
                             c("No Stones:                  100",
                                "Start It:                   1010001",
                               "It Per Stone:               1000",
                               "Sample Freq:                1",
                               "Dist:                       Beta(0.400000,1.000000)")))$equal)
})

test_that("Multistate Stones log-likelihood is read correctly", {
  file = bt_read.stones("../../bayestraits_output/MS_MCMC_wSS_wPR.Stones.txt")

  expect_true(compare(attributes(file)$settings,
                      list(`Steppingstone sampler:` =
                             c("No Stones:                  100",
                               "Start It:                   1010001",
                               "It Per Stone:               1000",
                               "Sample Freq:                1",
                               "Dist:                       Beta(0.400000,1.000000)")))$equal)
})
