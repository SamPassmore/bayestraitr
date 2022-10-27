# test read functions
context("read function tests")


test_that("Schedule function is reading correctly", {
  file = bt_read.schedule("./bayestraits_output/Artiodactyl.txt.Schedule.txt")

  expect_true(
    all(colnames(file) ==
                c("Rate Tried", "% Accepted", "Tree Move Tried", "% Accepted", "Rates - Dev",
                  "Rates - Tried", "Rates - Accepted", "Sample Ave Acceptance", "Total Ave Acceptance"))
    )
})
