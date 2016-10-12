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

# draw worfklow graph upstream of C3_fraction_data
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh output31_hash_value > $RESULTS_DIR/wf_upstream_of_test_data.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_test_data.gv > $RESULTS_DIR/wf_upstream_of_test_data.pdf

$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh output112_hash_value > $RESULTS_DIR/wf_upstream_of_test_data_2.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_test_data_2.gv > $RESULTS_DIR/wf_upstream_of_test_data_2.pdf
