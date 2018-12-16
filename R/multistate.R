#' Read BayesTraits Log files
#'
#' Given a the path of a BayesTraits log file, this function will find the start of the logged output and import the data as a data.frame into R.
#' @keywords excd, BayesTraits, phylogeny
#' @param filename the path to the BayesTraits log file
#' @return A data.frame of the logs found in the BayesTraits log file & a list of settings taken from the header of the file
#' @export


bt_read.log <- function(filename){
  con = file(filename, "r")
  i = 1
  j = 1
  attr_list = list()
  while ( TRUE ) {
    line = readLines(con, n = 1)
    if (grepl("Iteration\t", line)|grepl("Tree\t", line)||grepl("Tree No\t", line)) {
      break
    }
    i = i + 1
  }
  close(con)

  settings_raw = readLines(filename, n = i - 1)
  settings = .get_attributes(settings_raw)

  d = read.table(filename, skip = i-1, sep = '\t',
             header = TRUE, check.names = FALSE, quote=NULL)
  d[sapply(d, function(x) all(is.na(x)))] <- NULL

  attr(d,"settings") <- settings
  class(d) <- append(class(d), c("bt_log"))
  d
}

.get_attributes = function(line){
  one = dplyr::as_tibble(line)
  two = tidyr::separate(one, value, into = c("header", "info"), sep = "\\s{2,}", extra = "merge", fill = "right")
  three = dplyr::mutate(two, header = dplyr::na_if(header, ""))
  four = tidyr::fill(three, header) # fills empty info
  five = dplyr::filter(four, !is.na(info)) # gets rid of titles with empty info
  six = dplyr::mutate(five, info = stringr::str_trim(info))
  seven = split(six, six$header)
  purrr::map(seven, dplyr::pull, info)
}

#' Read BayesTraits Schedule files
#'
#' Given a the path of a BayesTraits Schedule file, this function will find the start of the logged output and import the data as a data.frame into R.
#' @keywords excd, BayesTraits, phylogeny
#' @param filename the path to the BayesTraits Schedule file
#' @return A data.frame of the schedule found in the BayesTraits schedule file  & a list of settings taken from the header of the file
#' @export

bt_read.schedule = function(filename){
  con = file(filename, "r")
  i = 1
  while ( TRUE ) {
    line = readLines(con, n = 1)
    if (grepl("Rate Tried\t", line)) {
      break
    }
    i = i + 1
  }

  settings_raw = readLines(filename, n = i - 1)
  settings = read.table(text = settings_raw, sep = "\t", col.names = c("setting", "value"))

  close(con)

  d = read.table(filename, skip = i-1, sep = '\t',
                 header = TRUE, check.names = FALSE, quote=NULL)
  d[sapply(d, function(x) all(is.na(x)))] <- NULL

  attr(d,"settings") <- settings
  class(d) <- append(class(d), c("bt_schedule"))
  d
}

#' Read BayesTraits Stones files
#'
#' Given a the path of a BayesTraits Stones file, this function will find the start of the stones output and import the data. It will also find the marginal likelihood and return both items in a list.
#' @keywords excd, BayesTraits, phylogeny
#' @param filename the path to the BayesTraits Schedule file
#' @return A data.frame of the schedule found in the BayesTraits schedule file  & a list of settings taken from the header of the file
#' @export

bt_read.stones = function(filename){
  con = file(filename, "r")
  stone_file = readLines(con)
  close(con)

  idx = which(str_detect(stone_file, "Stone No\t"))

  settings = .get_attributes(stone_file[1:(idx-1)])

  stones =read.table(text = stone_file[idx:(length(stone_file) - 1)],
               sep = "\t", header = TRUE)

  marginal_likelihood = str_extract_all(stone_file[length(stone_file)] , "[0-9\\.]+")
  marginal_likelihood = as.numeric(marginal_likelihood)

  obj = list(stones_sampling = stones,
             marginal_likelihood = marginal_likelihood)
  attr(obj,"settings") <- settings
  class(obj) <- append(class(obj), c("bt_stones"))
  obj
}
