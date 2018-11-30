#' Read BayesTraits Log files
#'
#' Given a the path of a BayesTraits log file, this function will find the start of the logged output and import the data as a data.frame into R.
#' @keywords excd, BayesTraits, phylogeny
#' @param filename the path to the BayesTraits log file
#' @return A data.frame of the logs found in the BayesTraits log file & a list of settings taken from the header of the file
#' @export

'[.bt' <- function(x, ...) '['(x[[1]], ...)

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

  settings = readLines(filename, n = i - 1) %>%
    .get_attributes()

  d = read.table(filename, skip = i-1, sep = '\t',
             header = TRUE, check.names = FALSE, quote=NULL)
  d[sapply(d, function(x) all(is.na(x)))] <- NULL

  obj = list(output = d, attr = settings)
  class(obj) <- append(class(obj), c("bt_log", "bt"))
  obj
}

.get_attributes = function(line){
  line %>%
  as_tibble() %>% #View()
    tidyr::separate(value, into = c("header", "info"), sep = "\\s{2,}", extra = "merge", fill = "right") %>%
    mutate(header = na_if(header, "")) %>%
    fill(header) %>% # fills empty info
    filter(!is.na(info)) %>% # gets rid of titles with empty info
    mutate(info = str_trim(info)) %>%
    split(.$header) %>%
    map(pull, info)
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

  settings = readLines(filename, n = i - 1) %>%
    read.table(text = ., sep = "\t", col.names = c("setting", "value"))

  close(con)

  d = read.table(filename, skip = i-1, sep = '\t',
                 header = TRUE, check.names = FALSE, quote=NULL)
  d[sapply(d, function(x) all(is.na(x)))] <- NULL

  obj = d
  class(obj) <- append(class(obj), c("bt_schedule", "bt"))
  obj
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

  settings = stone_file[1:(idx-1)] %>%
    .get_attributes()

  stones = stone_file[idx:(length(stone_file) - 1)] %>%
    read.table(text = ., sep = "\t", header = TRUE)

  marginal_likelihood = stone_file[length(stone_file)] %>%
    str_extract_all("[0-9\\.]+") %>%
    as.numeric()

  obj = list(settings = settings, stones_sampling = stones,
             marginal_likelihood = marginal_likelihood)
  class(obj) <- append(class(obj), c("bt_stones", "bt"))
  obj
}
