#!/bin/bash

# get column one from a comma-separated value file, store as .tmp
tail -n +2 data/treatments.csv | cut -f 1 -d ',' - | sed "s/\"//g" > .tmp

while read sample
do
	echo $sample
	# level can be replaced with genus, species, family, etc.
	level="order"
	wget 'http://metagenomics.anl.gov/metagenomics.cgi?page=MetagenomeOverview&metagenome='$sample'&action=chart_export&name=organism_'$level'_hits&file=download.'$sample'.organism_'$level'_hits' -O 'data/organism_'$level'_hits.'$sample'.tsv' -q &
done < .tmp
rm .tmp
