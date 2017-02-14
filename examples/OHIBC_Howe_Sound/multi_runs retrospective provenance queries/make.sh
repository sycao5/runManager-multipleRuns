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
joinOn="filePath"
$QUERIES_DIR/render_complete_graph_$joinOn.sh > $RESULTS_DIR/complete_db_graph_$joinOn.gv
dot -Tpdf $RESULTS_DIR/complete_db_graph_$joinOn.gv > $RESULTS_DIR/complete_db_graph_$joinOn.pdf
dot -Tsvg $RESULTS_DIR/complete_db_graph_$joinOn.gv > $RESULTS_DIR/complete_db_graph_$joinOn.svg

# draw complete multiple runs graph based on File SHA256
joinOn="sha256"
$QUERIES_DIR/render_complete_graph_$joinOn.sh > $RESULTS_DIR/complete_db_graph_$joinOn.gv
dot -Tpdf $RESULTS_DIR/complete_db_graph_$joinOn.gv > $RESULTS_DIR/complete_db_graph_$joinOn.pdf
dot -Tsvg $RESULTS_DIR/complete_db_graph_$joinOn.gv > $RESULTS_DIR/complete_db_graph_$joinOn.svg

# draw worfklow graph upstream of lsp_trend.csv using sha256 but display filePath in the results
##productName="lsp_trend"
##joinOn="filePath"
##productHashCode=97b9fe2837579bac75e964fe212402ba5ac595bb539bce4f7897be9cdcb55638
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1_filePath.sh \'97b9fe2837579bac75e964fe212402ba5ac595bb539bce4f7897be9cdcb55638\' > $RESULTS_DIR/wf_upstream_of_lsp_trend_filePath.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_lsp_trend_filePath.gv > $RESULTS_DIR/wf_upstream_of_lsp_trend_filePath.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_lsp_trend_filePath.gv > $RESULTS_DIR/wf_upstream_of_lsp_trend_filePath.svg

# draw worfklow graph upstream of lsp_status.csv using sha256 but display filePath in the results
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1_filePath.sh \'510e09f1f3ef8fcbc38c43a40e1698cea99ebea15fd64a26339169ba6ce238fc\' > $RESULTS_DIR/wf_upstream_of_lsp_status_filePath.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_lsp_status_filePath.gv > $RESULTS_DIR/wf_upstream_of_lsp_status_filePath.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_lsp_status_filePath.gv > $RESULTS_DIR/wf_upstream_of_lsp_status_filePath.svg

# draw worfklow graph upstream of lsp_trend.csv using sha256 but display hash value in the results
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1_sha256.sh \'97b9fe2837579bac75e964fe212402ba5ac595bb539bce4f7897be9cdcb55638\' > $RESULTS_DIR/wf_upstream_of_lsp_trend_sha256.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_lsp_trend_sha256.gv > $RESULTS_DIR/wf_upstream_of_lsp_trend_sha256.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_lsp_trend_sha256.gv > $RESULTS_DIR/wf_upstream_of_lsp_trend_sha256.svg

# draw worfklow graph upstream of lsp_status.csv using sha256 but display hash value in the results
$QUERIES_DIR/render_rm_graph_upstream_of_file_q1_sha256.sh \'510e09f1f3ef8fcbc38c43a40e1698cea99ebea15fd64a26339169ba6ce238fc\' > $RESULTS_DIR/wf_upstream_of_lsp_status_sha256.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_lsp_status_sha256.gv > $RESULTS_DIR/wf_upstream_of_lsp_status_sha256.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_lsp_status_sha256.gv > $RESULTS_DIR/wf_upstream_of_lsp_status_sha256.svg