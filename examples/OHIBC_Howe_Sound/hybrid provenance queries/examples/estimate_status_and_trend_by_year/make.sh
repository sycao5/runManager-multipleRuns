#!/usr/bin/env bash

# set variables
source ../settings.sh

# create output directories
mkdir -p $FACTS_DIR
mkdir -p $VIEWS_DIR
mkdir -p $RESULTS_DIR

# export YW model facts
$YW_CMD model $SCRIPT_DIR/estimate_status_and_trend_by_year.R \
        -c extract.language=R \
        -c extract.factsfile=$FACTS_DIR/yw_extract_facts.P \
        -c model.factsfile=$FACTS_DIR/yw_model_facts.P \
        -c query.engine=xsb

# materialize views of YW facts
$QUERIES_DIR/materialize_yw_views.sh > $VIEWS_DIR/yw_views.P

# generate reconfacts.P to facts/ folder from the run.yaml which is decoded by yw-matlab bridge
$YW_MATLAB_RECON_CMD recon $SCRIPT_DIR/estimate_status_and_trend_by_year.R \
        -c extract.language=R \
        -c recon.matlab.exportfile=recon/estimate_status_and_trend_by_year.yaml \
        -c recon.factsfile=facts/reconfacts.P \
        -c recon.finderclass=org.yesworkflow.matlab.MatlabResourceFinder \
        -c query.engine=xsb

# draw complete workflow graph
$QUERIES_DIR/render_complete_wf_graph.sh > $RESULTS_DIR/complete_wf_graph.gv
dot -Tpdf $RESULTS_DIR/complete_wf_graph.gv > $RESULTS_DIR/complete_wf_graph.pdf
dot -Tsvg $RESULTS_DIR/complete_wf_graph.gv > $RESULTS_DIR/complete_wf_graph.svg

# draw complete workflow graph with URI template
$YW_CMD graph $SCRIPT_DIR/estimate_status_and_trend_by_year.R \
        -c graph.view=combined \
        -c graph.layout=tb \
        > $RESULTS_DIR/complete_wf_graph_uri.gv
dot -Tpdf $RESULTS_DIR/complete_wf_graph_uri.gv > $RESULTS_DIR/complete_wf_graph_uri.pdf
dot -Tsvg $RESULTS_DIR/complete_wf_graph_uri.gv > $RESULTS_DIR/complete_wf_graph_uri.svg

# list workflow outputs from prospective proveannce graph
$QUERIES_DIR/list_workflow_outputs.sh > $RESULTS_DIR/workflow_outputs.txt


##############
#   Q1_pro   #
##############

# draw prospective provenance graph upstream of lsp_status_trend_summary_db_file
$QUERIES_DIR/render_wf_graph_upstream_of_data_q1.sh lsp_status_trend_summary_db_file > $RESULTS_DIR/wf_upstream_of_lsp_status_trend_summary_db_file.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_lsp_status_trend_summary_db_file.gv > $RESULTS_DIR/wf_upstream_of_lsp_status_trend_summary_db_file.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_lsp_status_trend_summary_db_file.gv > $RESULTS_DIR/wf_upstream_of_lsp_status_trend_summary_db_file.svg

##############
#   Q2_pro   #
##############

# list script inputs upstream of output data C3_fraction_data
$QUERIES_DIR/list_inputs_upstream_of_data_q2.sh lsp_status_trend_summary_db_file  lsp_status_trend_summary_db_file > $RESULTS_DIR/inputs_upstream_of_lsp_status_trend_summary_db_file.txt

##############
#   Q3_pro   #
##############


# draw prospective provenance graph downstream of area_protected_total_file
$QUERIES_DIR/render_wf_graph_downstream_of_data_q3.sh area_protected_total_file > $RESULTS_DIR/wf_downstream_of_area_protected_total_file.gv
dot -Tpdf $RESULTS_DIR/wf_downstream_of_area_protected_total_file.gv > $RESULTS_DIR/wf_downstream_of_area_protected_total_file.pdf
dot -Tsvg $RESULTS_DIR/wf_downstream_of_area_protected_total_file.gv > $RESULTS_DIR/wf_downstream_of_area_protected_total_file.svg

##############
#   Q4_pro   #
##############


# list script outputs downstream of input data area_protected_total_file
$QUERIES_DIR/list_outputs_downstream_of_data_q4.sh area_protected_total_file area_protected_total_file > $RESULTS_DIR/outputs_downstream_of_area_protected_total_file.txt


##############
#   Q5_pro   #
##############

# draw hybrid provenance graph upstream of lsp_status_trend_summary_db_file
$QUERIES_DIR/render_wf_recon_graph_upstream_of_data_q5.sh lsp_status_trend_summary_db_file > $RESULTS_DIR/wf_recon_upstream_of_lsp_status_trend_summary_db_file.gv
dot -Tpdf $RESULTS_DIR/wf_recon_upstream_of_lsp_status_trend_summary_db_file.gv > $RESULTS_DIR/wf_recon_upstream_of_lsp_status_trend_summary_db_file.pdf
dot -Tsvg $RESULTS_DIR/wf_recon_upstream_of_lsp_status_trend_summary_db_file.gv > $RESULTS_DIR/wf_recon_upstream_of_lsp_status_trend_summary_db_file.svg


##############
#   Q6_pro   #
##############


# draw hybrid provenance graph with all observables

$QUERIES_DIR/render_recon_complete_wf_graph_q6.sh > $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv
dot -Tpdf $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv > $RESULTS_DIR/wf_recon_complete_graph_all_observables.pdf
dot -Tsvg $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv > $RESULTS_DIR/wf_recon_complete_graph_all_observables.svg
