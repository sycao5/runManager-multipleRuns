#!/usr/bin/env bash

# set variables
source ./settings.sh

# create output directories
mkdir -p $RESULTS_DIR


for f in $SCRIPT_DIR/*.R
do
	## Get the file name by removeing everything until the last / (the path) from the file name
	str1="${f##*/}"
	## Removes the string .R from the end of it
	filename="${str1%.R}"	
	
	# draw complete workflow graph with URI template
	complete_wf_graph_name="$filename"_complete_wf_graph_uri
	$YW_CMD graph $f \
	        -c graph.view=combined \
	        -c graph.layout=tb \
	        > $RESULTS_DIR/$complete_wf_graph_name.gv
	dot -Tpdf $RESULTS_DIR/$complete_wf_graph_name.gv > $RESULTS_DIR/$complete_wf_graph_name.pdf
	dot -Tsvg $RESULTS_DIR/$complete_wf_graph_name.gv > $RESULTS_DIR/$complete_wf_graph_name.svg
done






