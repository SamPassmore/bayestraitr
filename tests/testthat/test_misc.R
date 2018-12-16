context("misc. tests")

test_that("Settings are read correctly in Multistate", {
  file = bt_read.log("../../bayestraits_output/Artiodactyl.txt.Log.txt")


  some_settings = c(attributes(file)$settings$`Iterations:`,
                    attributes(file)$settings$`Seed:`,
                    attributes(file)$settings$`Analysis Type:`)

  expect_true(compare(some_settings,
                      c("1010000", "1993180274", "MCMC"))$equal)
})
