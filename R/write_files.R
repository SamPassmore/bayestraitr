#' Write / Create BayesTraits tree and data files
#'
#' Given a tree & data.frame or vector, this function will create input files for BayesTraits with the suffix \*.bttrees and \*btdata.
#' This function will also format the data file for BayesTrait \(e.g. remove or replace NA values with "-"\)
#' @keywords excd, BayesTraits, phylogeny
#' @param tree an object of class phylo or list of phylo objects
#' @param data a data.frame
#' @param variables a character string or character vector of the names of columns to subset to, alternatively you can use the numeric values to indicate the column
#' @param dir the directory to save the output files to. Defaults to current directory
#' @param na.omit a TRUE/FALSE argument to specify whether NA values should be removed from your final data file
#' @param optional: used to name the output file. Will use variable names by default.
#' @return two files will be saved to the specified directory *.bttrees holding the pruned tree files and *.btdata holding the subset and formatted data.
#' @export

bt_write <- function(tree, data, variables, dir = "./", na.omit = FALSE, filename){
  # Establish a new 'ArgCheck' object
  #Check <- ArgumentCheck::newArgCheck()
  # subset data to necessary variables keeping rownames
  data = data[,variables, drop = FALSE]

  # remove nas if necessary
  if(na.omit){
    data = data[complete.cases(data), , drop = FALSE]
  } else {
    data[is.na(data)] = "-"
  } # else replace NAs with hyphens

  # prune tree to match rownames in the data
  # for single tree
  if(class(tree) == 'phylo'){
    td = geiger::treedata(phy = tree, data = data, warnings = TRUE)
    tree = td$phy
    data = td$data
  } else if(all(unlist(lapply(tree, class)) == 'phylo')){ # for list of trees
    td = lapply(tree, function(x) geiger::treedata(x, data, warnings = TRUE))
    tree = lapply(td, function(x) x$phy)
    data = td[[1]]$data
  }

  # write files
  if(missing(filename)){
    filename = paste0(variables, collapse = "-")
  }

  ape::write.nexus(tree, file = paste0(dir, filename, ".bttrees"))
  write.table(data, file = paste0(dir, filename, ".btdata"),
              quote = FALSE, col.names = FALSE, sep = "\t")
}
