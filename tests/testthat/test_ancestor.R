test_that("Add Tag tests", {
  tree = read.nexus('bayestraits_output/Artiodactyl.trees')[[1]]
  taxa = c("Hippopo", "Dolphin")
  label = "ANC"

  expect_equal(add_tag(tree, taxa, label), "AddTag ANC Hippopo Whale Porpoise Dolphin FKWhale")
})
