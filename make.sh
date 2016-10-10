#!/usr/bin/env bash

# set variables
source ./settings.sh

# create output directories
mkdir -p $FACTS_DIR
mkdir -p $VIEWS_DIR

# materialize views of RunManager
$QUERIES_DIR/materialize_rm_views.sh > $VIEWS_DIR/rm_views.P

# draw complete multiple runs graph
$QUERIES_DIR/render_complete_graph.sh > $RESULTS_DIR/complete_db_graph.gv
dot -Tpdf $RESULTS_DIR/complete_db_graph.gv > $RESULTS_DIR/complete_db_graph.pdf
