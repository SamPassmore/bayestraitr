context("write tests")

test_that("If data is a tibble, throw an error", {

  tree = ape::read.nexus('bayestraits_output/Artiodactyl.trees')
  data = read.csv('bayestraits_output/Artiodactyl.tsv', sep = "\t")

  expect_error(
    bt_write(tree = tree, data = data, variables = "trait1", filename = "tmp")
  )
})
