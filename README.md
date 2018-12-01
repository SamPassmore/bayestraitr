# bayestraitr
Functions for importing and creating BayesTraits files into R

To install this package run this line:

`devtools::install_github('SamPassmore/bayestraitr')`

### Example

There are three functions in this package at the moment for reading in BayesTrait *.Log files, *.Schedule files, & *.Stones

`log = bt_read.log('./bayestrait_output/Artiodactyl.txt.Log.txt')`

Will return a list of the log matrix & the file header.
To access the log data frame you only need to type `log`, but to access a column you currently need to use `log[,"Lh"]` rather than using the `$` operator.

`schedule = bt_read.schedule('./bayestrait_output/Artiodactyl.txt.Schedule.txt')`

This returns one `data.frame` with the contents of the Schedule file.

`stones = bt_read.stones('./bayestrait_output/Artiodactyl.txt.Stones.txt')`

This returns a list of 3 items. `settings` holids the header of the Stones file, `stones_sampling` holds the logging for the stones sampling, \& `marginal_likelihood` holds the marginal log-likelihood.

#### Write files

The function `bt_write` takes various tree types (e.g. `phylo` & `multiphylo`) and `data.frame` input and writes them as input files for BayesTraits. 

`library(ape)
tree = read.nexus('bayestraits_output/Artiodactyl.trees')
data = read.csv('bayestraits_output/Artiodactyl.tsv', sep = "\t")
rownames(data) = data$taxa
bt_write(tree = tree, data = data, variables = 'trait1', filename = 'test')
`
