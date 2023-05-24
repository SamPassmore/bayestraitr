test_that("Add Tag tests", {
  tree = ape::read.nexus('./bayestraits_output/Artiodactyl.trees')[[1]]
  taxa = c("Hippopo", "Dolphin")
  label = "ANC"

  expect_equal(bt_addtag(tree, taxa, label), "AddTag ANC Hippopo Whale Porpoise Dolphin FKWhale")
})

d = read.csv('./bayestraits_output/Artiodactyl.tsv', sep = '\t')

unique(d$trait1)

test_that("Add dag test 1", {
  dag = 'dag {
        A -> B
        A -> C
        }'

  out = "Restrict qBA 0
Restrict qCA 0
Restrict qCB 0
Restrict qBC 0"

  class(out) = "bt_model"

  expect_equal(bt_addmodel(dag), out)
})


test_that("Add dag test 2", {
  dag = 'dag {
        1 -> 2
        1 -> 3
        2 -> 4
        3 -> 4
        }'

  out = "Restrict q21 0
Restrict q31 0
Restrict q41 0
Restrict q32 0
Restrict q42 0
Restrict q23 0
Restrict q43 0
Restrict q14 0"

  class(out) = "bt_model"

  expect_equal(bt_addmodel(dag), out)
})
