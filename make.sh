#!/usr/bin/env bash

# set variables
source ./settings.sh

# create output directories
mkdir -p $FACTS_DIR
mkdir -p $VIEWS_DIR
mkdir -p $RESULTS_DIR

# materialize views of RunManager
$QUERIES_DIR/materialize_rm_views.sh > $VIEWS_DIR/rm_views.P

# draw complete multiple runs graph
$QUERIES_DIR/render_complete_graph.sh > $RESULTS_DIR/complete_db_graph.gv
dot -Tpdf $RESULTS_DIR/complete_db_graph.gv > $RESULTS_DIR/complete_db_graph.pdf
dot -Tsvg $RESULTS_DIR/complete_db_graph.gv > $RESULTS_DIR/complete_db_graph.svg

# draw worfklow graph upstream of C3_fraction_data
#$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh output31_hash_value > $RESULTS_DIR/wf_upstream_of_test_data_C3.gv
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh \'66687AADF862BD776C8FC18B8E9F8E20089714856EE233B3902A591D0D5F2925\' > $RESULTS_DIR/wf_upstream_of_test_data_C3.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_test_data_C3.gv > $RESULTS_DIR/wf_upstream_of_test_data_C3.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_test_data_C3.gv > $RESULTS_DIR/wf_upstream_of_test_data_C3.svg

#$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh output112_hash_value > $RESULTS_DIR/wf_upstream_of_test_data_Grass.gv
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh \'66687AADF862BD776C8FC18B8E9F8E20089714856EE233B3902A591D0D5F2925\' > $RESULTS_DIR/wf_upstream_of_test_data_Grass.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_test_data_Grass.gv > $RESULTS_DIR/wf_upstream_of_test_data_Grass.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_test_data_Grass.gv > $RESULTS_DIR/wf_upstream_of_test_data_Grass.svg
