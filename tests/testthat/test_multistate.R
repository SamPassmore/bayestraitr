context("multistate reading tests")

library(dplyr)
library(stringr)

test_that("Multistate MCMC Log file is read correctly", {
  file = "../../bayestraits_output/MS_MCMC.Log.txt" %>%
    bt_read.log()

  expect_true(compare(colnames(file),
                      c("Iteration", "Lh", "Tree No", "qDG", "qGD",
                        "Root P(D)", "Root P(G)"))$equal)
})

test_that("Multistate Max. Likelihood Log file is read correctly", {
  file = "../../bayestraits_output/MS_ML.Log.txt" %>%
    bt_read.log()

  expect_true(compare(colnames(file),
                      c("Tree No", "Lh", "qDG",	"qGD",
                        "Root P(D)", "Root P(G)"))$equal)
})

test_that("Multistate MCMC w Tags Log file is read correctly", {
  file = "../../bayestraits_output/MS_MCMC_wSS_wTag.Log.txt" %>%
    bt_read.log()

  expect_true(compare(colnames(file),
                      c("Iteration", "Lh", "Tree No", "qDG", "qGD",
                        "Root P(D)", "Root P(G)", "RecNode P(D)", "RecNode P(G)"))$equal)
})


test_that("Multistate MCMC w MRCA Log file is read correctly", {
  file = "../../bayestraits_output/MS_MCMC_wSS_wMRCA.Log.txt" %>%
    bt_read.log()

  expect_true(compare(colnames(file),
                      c("Iteration", "Lh", "Tree No", "qDG", "qGD", "Root P(D)",
                        "Root P(G)", "VarNode P(D)", "VarNode P(G)"))$equal)
})

test_that("Multistate MCMC w Fossilisation Log file is read correctly", {
  file = "../../bayestraits_output/MS_MCMC_wF.Log.txt" %>%
    bt_read.log()

  expect_true(compare(colnames(file),
                      c("Iteration", "Lh", "Tree No", "qDG", "qGD",
                        "Root P(D)", "Root P(G)", "Node01 P(D)", "Node01 P(G)"))$equal)
})

