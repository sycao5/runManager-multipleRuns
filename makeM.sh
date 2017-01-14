#!/usr/bin/env bash

# set variables
source ./settings.sh

# create output directories
mkdir -p $FACTS_DIR
mkdir -p $VIEWS_DIR
mkdir -p $RESULTS_DIR

# materialize views of RunManager
$QUERIES_DIR/materialize_rm_views.sh > $VIEWS_DIR/rm_views.P

# draw complete multiple runs graph based on file path
$QUERIES_DIR/render_complete_graph_filePath.sh > $RESULTS_DIR/complete_db_graph_filePath.gv
dot -Tpdf $RESULTS_DIR/complete_db_graph_filePath.gv > $RESULTS_DIR/complete_db_graph_filePath.pdf
dot -Tsvg $RESULTS_DIR/complete_db_graph_filePath.gv > $RESULTS_DIR/complete_db_graph_filePath.svg

# draw complete multiple runs graph based on File SHA256
$QUERIES_DIR/render_complete_graph_sha256.sh > $RESULTS_DIR/complete_db_graph_sha256.gv
dot -Tpdf $RESULTS_DIR/complete_db_graph_sha256.gv > $RESULTS_DIR/complete_db_graph_sha256.pdf
dot -Tsvg $RESULTS_DIR/complete_db_graph_sha256.gv > $RESULTS_DIR/complete_db_graph_sha256.svg

# draw worfklow graph upstream of C3_fraction_data using sha256 but display filePath in the results
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1_filePath.sh \'0C46DBB4A07906AF9F91F09E04919A90108FEE10453F096E1079841CAA0C001D\' > $RESULTS_DIR/wf_upstream_of_C3_filePath.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_C3_filePath.gv > $RESULTS_DIR/wf_upstream_of_C3_filePath.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_C3_filePath.gv > $RESULTS_DIR/wf_upstream_of_C3_filePath.svg

# draw worfklow graph upstream of Grass_data using sha256 but display filePath in the results
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1_filePath.sh \'217F6762E376849F8C5440C79078E5B73BFCC4CF054965842D99A3A2B4335F5B\' > $RESULTS_DIR/wf_upstream_of_Grass_filePath.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_Grass_filePath.gv > $RESULTS_DIR/wf_upstream_of_Grass_filePath.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_Grass_filePath.gv > $RESULTS_DIR/wf_upstream_of_Grass_filePath.svg

# draw worfklow graph upstream of C3_fraction_data using sha256 but display hash value in the results
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1_sha256.sh \'0C46DBB4A07906AF9F91F09E04919A90108FEE10453F096E1079841CAA0C001D\' > $RESULTS_DIR/wf_upstream_of_C3_sha256.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_C3_sha256.gv > $RESULTS_DIR/wf_upstream_of_C3_sha256.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_C3_sha256.gv > $RESULTS_DIR/wf_upstream_of_C3_sha256.svg

# draw worfklow graph upstream of Grass_data using sha256 but display hash value in the results
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1_sha256.sh \'217F6762E376849F8C5440C79078E5B73BFCC4CF054965842D99A3A2B4335F5B\' > $RESULTS_DIR/wf_upstream_of_Grass_sha256.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_Grass_sha256.gv > $RESULTS_DIR/wf_upstream_of_Grass_sha256.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_Grass_sha256.gv > $RESULTS_DIR/wf_upstream_of_Grass_sha256.svg