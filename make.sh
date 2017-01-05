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

# draw complete multiple runs graph based on File SHA256
$QUERIES_DIR/render_complete_graph_sha256.sh > $RESULTS_DIR/complete_db_graph_sha256.gv
dot -Tpdf $RESULTS_DIR/complete_db_graph_sha256.gv > $RESULTS_DIR/complete_db_graph_sha256.pdf
dot -Tsvg $RESULTS_DIR/complete_db_graph_sha256.gv > $RESULTS_DIR/complete_db_graph_sha256.svg

# draw worfklow graph upstream of C3_fraction_data
#$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh output31_hash_value > $RESULTS_DIR/wf_upstream_of_test_data_C3.gv
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh \'0C46DBB4A07906AF9F91F09E04919A90108FEE10453F096E1079841CAA0C001D\' > $RESULTS_DIR/wf_upstream_of_test_data_C3.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_test_data_C3.gv > $RESULTS_DIR/wf_upstream_of_test_data_C3.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_test_data_C3.gv > $RESULTS_DIR/wf_upstream_of_test_data_C3.svg

# draw worfklow graph upstream of Grass_data
#$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh output112_hash_value > $RESULTS_DIR/wf_upstream_of_test_data_Grass.gv
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1.sh \'217F6762E376849F8C5440C79078E5B73BFCC4CF054965842D99A3A2B4335F5B\' > $RESULTS_DIR/wf_upstream_of_test_data_Grass.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_test_data_Grass.gv > $RESULTS_DIR/wf_upstream_of_test_data_Grass.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_test_data_Grass.gv > $RESULTS_DIR/wf_upstream_of_test_data_Grass.svg
