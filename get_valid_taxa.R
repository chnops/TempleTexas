#
#	Step 1: determine which orders to use
#
# # # # # # # # # # # # # # # # # # # # # # #

# treatments.tsv is not available from MG-RAST
treatments <- read.csv('data/treatments.csv', row.names=1)

# A comprehensive list of orders in the raw data can only
# be found by reading each individual raw data file
samples <- rownames(treatments)
allOrders <- vector('character')
for (sample in 1:length(samples)) {
	counts <- data.frame(read.table(paste(c("data/organism_order_hits", samples[sample], "tsv"), collapse="."), sep="\t", row.names=1))
	taxa <- rownames(counts)
	allOrders <- c(allOrders, taxa)
}
allOrders <- unique(allOrders[order(allOrders)])

# MG-RAST has a list of 'unclassified' order counts
# Since these are ambiguous, we remove them here
unambigOrders <- allOrders[-c(grep('unclassified', allOrders))]

# taxize uses various web resources to determine upstream taxonomic information given an order name
library(taxize)
ids <- get_ids(unambigOrders, db='ncbi')
2
# Experimentation with the 'get_ids' command above showed that one of the order names in our raw data was ambiguous
# To specify that we want the order, not a different taxonomic unit with the same name, we put this two here
# 'get_ids' will read it automatically if this script is run from the command line

#Reformat data
# 'rast.name' refers to the name for the order used by MG-RAST
# 'alt.name' refers to the name returned by 'taxize' for the id recovered in 'get_ids'
orders <- data.frame(matrix(unambigOrders, ncol=1))
colnames(orders) <- 'rast.name'
rownames(orders) <- as.matrix(ids$ncbi)[orders$rast.name,]
orders$alt.name<- NA
orders$superkingdom <- NA

# Finallly, retrieve the upstream taxonomy data (i.e. phylum, kingdom, superkingdom)
#  The result from 'classification' requires some parsing
classif <- classification(ids) # this step may take a while
ncbi_classif <- classif$ncbi
for (i in 1:length(ncbi_classif)) {
	id <- attr(ncbi_classif[i], 'name')
	taxonomyTable <- data.frame(ncbi_classif[[i]])

	orders[id, "alt.name"] <- tail(taxonomyTable, n=1)$name
	orders[id,"superkingdom"] <- subset(ncbi_classif[[i]], rank == 'superkingdom')$name
}

# Save output to disk
write.csv(orders, file="data/orders.csv")
q(save="no")
