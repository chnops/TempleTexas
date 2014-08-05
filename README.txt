Scripts: in the order they are likely to be run
===============================================

================
get_valid_taxa.R
================
 * Reads from raw data files a comprehensive list of taxa
 * Removes 'unclassified' taxa
 * Uses the R library `taxize` to get their upstream taxonomy, e.g. superkingdomes
 * Writes them to a file

=============
compile_raw.R
=============
 * Reads from raw data files
 * Reads from "treatments.tsv"
 * Formats data, combining sample treatment information with taxa counts
 * Filters for taxa that are not part of Eukaryota or Viruses

===============
summarize_raw.R
===============
 * Generates summary statistics to help decide on normalization criteria

===========
normalize.R
===========
 * Performs normalization or raw data

=============
bray_curtis.R
=============
 * Generates a matrix of plot by plot dissimilarities
 * Performs PERMANOVA to see which treatments have a significant effect on dissimilarity scores
 * Generates NMDS plots to visualize dissimilarities between treatments

==========
spearman.R
==========
 * Calculates spearman correlation coefficients for each pair of taxa
 * Also calculates a p-value based on the consistency of the correlation coefficient accross multiple samples
 * Also calculates a corrected p-value (false discovery rate) based on number of correlations calculated

================
graph_spearman.R
================
 * Creates graphs of significant positive, and negative correlations

================
check_spearman.R
================
 * Creates a graph of taxa count vs. p-value of spearman correlation

============
abundances.R
============
 * Graphs order count and fold change for plant type side by side
