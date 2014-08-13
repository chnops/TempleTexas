User input
==========
In order to use these statistics, you need an input file specifying your MG_RAST sample ids.
The format is somewhat specific: it must be a comma separated table; it must have a row of column headers followed by one row per sample; the MG_RAST sample id must be the first column of the row, but the subsequent columns can contain whatever other data about the sample you want.
The scripts here will look for such a file under the name `data/treatments.csv`.

Scripts: in the order they are likely to be run
===============================================

### download_raw.R
 * Reads a list of MG_RAST ids from a file
 * Downloads one file per MG_RAST id, which contains read counts for several orders
 * Easily edited to get a file for family, genus, species, etc. instead of order

### get_valid_taxa.R
 * Reads a comprehensive list of taxa from raw data files
 * Removes 'unclassified' taxa
 * Uses the R library `taxize` to get their upstream taxonomy, e.g. superkingdoms
 * Writes all the retrieved taxonomies to a file

### compile_raw.R
 * Reads from the downloaded raw data files and from `data/treatments.csv`
 * Compiles and formats read count data with treatment data
 * Filters out taxa that are part of the incorrect superkingdoms, 'Eukaryota' or 'Viruses'

### summarize_raw.R
 * Generates summary statistics to help decide on normalization criteria

### normalize.R
 * Performs normalization on raw data

### bray_curtis.R
 * Generates a matrix of dissimilarites between each pair of samples
 * Performs PERMANOVA to see which treatments have a significant effect on dissimilarity scores
 * Generates NMDS plots to visualize dissimilarities between treatments

### spearman.R
 * Calculates the spearman correlation coefficients between each pair of taxa within each treatment

### graph_spearman.R
 * Creates graphs depciting significant correlations

### abundances.R
 * OPTIONAL
 * Graphs order count and fold change for plant type side by side
 * Just some interesting summary statistics for community composition per treatment

### check_spearman.R
 * OPTIONAL
 * Creates a graph of taxa count vs. p-value of spearman correlation
 * Satisfied my worry that high or low count taxa would appear to have overly significant effects

### check_cutoff_effect.R
 * OPTIONAL
 * Runs our bray_curtis analysis multiple times at various cutoffs
 * Explores the possibility that 'arbitrary' normalization decisions will alter results
