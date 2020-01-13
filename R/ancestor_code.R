bt_addtag = function(tree, taxa, label = "ANC"){
  anc = ape::getMRCA(tree, taxa)
  desc_idx = phytools::getDescendants(tree, node = anc)

  desc_taxa = tree$tip.label[desc_idx]
  desc_taxa = desc_taxa[!is.na(desc_taxa)]
  desc_taxa = paste(desc_taxa, collapse = " ")

  sprintf("AddTag %s %s", label, desc_taxa)
}

bt_addmodel = function(dag){
  d =  ggdag::tidy_dagitty(dag)

  # find all parameters in the model
  parameters = unique(c(d$data$name, d$data$to))
  parameters = parameters[!is.na(parameters)]

  # get all possible transitions
  all_transitions = as.vector(outer(parameters, parameters, paste, sep=""))

  # transitions in the model
  model_transitions = paste(d$data$name, d$data$to, sep = "")
  # remove model transitions that have no outward paths
  model_transitions = model_transitions[-grep("NA", model_transitions)]

  # get zero transitions
  transitions = all_transitions[!all_transitions %in% model_transitions]

  idx = sapply(strsplit(transitions, ""), function(x) x[1] != x[2]) # remove circular labels
  transitions = paste("q", transitions[idx], sep = "")

  lines = paste("Restrict", transitions, "0")

  out = (paste(lines, collapse = "\n"))
  class(out) = "bt_model"
  out
}
