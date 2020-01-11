library(ape)
library(phytools)

add_tag = function(tree, taxa, label = "ANC"){
  anc = ape::getMRCA(tree, taxa)
  desc_idx = phytools::getDescendants(tree, node = anc)

  desc_taxa = tree$tip.label[desc_idx]
  desc_taxa = desc_taxa[!is.na(desc_taxa)]
  desc_taxa = paste(desc_taxa, collapse = " ")

  sprintf("AddTag %s %s", label, desc_taxa)
}

