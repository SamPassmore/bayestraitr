library(ape)
library(phytools)

tree = read.nexus('bayestraits_output/Artiodactyl.trees')

taxa = c("Hippopo", "Dolphin")

label = "ANC"

add_tag = function(tree, taxa, label = "ANC"){
  anc = getMRCA(tree, taxa)
  desc_idx = getDescendants(tree, node = anc)

  desc_taxa = tree$tip.label[desc_idx]
  desc_taxa = desc_taxa[!is.na(desc_taxa)]
  desc_taxa = paste(desc_taxa, collapse = " ")

  sprintf("AddTag %s %s", label, desc_taxa)
}

