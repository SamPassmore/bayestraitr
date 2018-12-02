context("misc. tests")


test_that("bt class testing", {
  file = "../../bayestraits_output/MS_MCMC.Log.txt" %>%
    bt_read.log()

  expect_true(compare(colnames(file$output),
                      c("Iteration", "Lh", "Tree No", "qDG", "qGD",
                        "Root P(D)", "Root P(G)"))$equal)
})
