#' AddTag: Code to determine a tag for BayesTraits
#'
#' Given a tree and a set of taxa, this function will return all taxa between the two given and return
#' an AddTag line that can be added to a BayesTraits script to use with other analysis (e.g. RecNode)
#' @keywords excd, BayesTraits, phylogeny
#' @param tree an object of class phylo
#' @param taxa a vector of character strings indicating relevant taxa
#' @param label the name of the label (ANC by default)
#' @return a string starting with 'AddTag' followed by the label and taxa names
#' @export

bt_addtag = function(tree, taxa, label = "ANC"){
  anc = ape::getMRCA(tree, taxa)
  desc_idx = phytools::getDescendants(tree, node = anc)

  desc_taxa = tree$tip.label[desc_idx]
  desc_taxa = desc_taxa[!is.na(desc_taxa)]
  desc_taxa = paste(desc_taxa, collapse = " ")

  sprintf("AddTag %s %s", label, desc_taxa)
}

#' Create model: Code to determine restrictions for a DAG
#'
#' For a given DAG, this function will return the necessary restrictions for that model to be estimated
#' Currently, this function returns all parameters that must be restricted to zero.
#' @keywords excd, BayesTraits, phylogeny
#' @param dag a description of the model using DAGs. These can be created at dagitty.net and copied into this function.
#' @return a string of Restrictions that can be placed into a BayesTraits script.
#' @export

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
