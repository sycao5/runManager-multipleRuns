#!/usr/bin/env bash

# set variables
source ../settings.sh

# create output directories
mkdir -p $FACTS_DIR
mkdir -p $VIEWS_DIR
mkdir -p $RESULTS_DIR

# export YW model facts
$YW_CMD model $SCRIPT_DIR/get_analysis_rasters.R \
        -c extract.language=R \
        -c extract.factsfile=$FACTS_DIR/yw_extract_facts.P \
        -c model.factsfile=$FACTS_DIR/yw_model_facts.P \
        -c query.engine=xsb

# materialize views of YW facts
$QUERIES_DIR/materialize_yw_views.sh > $VIEWS_DIR/yw_views.P

# generate reconfacts.P to facts/ folder from the run.yaml which is decoded by yw-matlab bridge
$YW_MATLAB_RECON_CMD recon $SCRIPT_DIR/get_analysis_rasters.R \
        -c extract.language=R \
        -c recon.matlab.exportfile=recon/get_analysis_rasters.yaml \
        -c recon.factsfile=facts/reconfacts.P \
        -c recon.finderclass=org.yesworkflow.matlab.MatlabResourceFinder \
        -c query.engine=xsb

# draw complete workflow graph
$QUERIES_DIR/render_complete_wf_graph.sh > $RESULTS_DIR/complete_wf_graph.gv
dot -Tpdf $RESULTS_DIR/complete_wf_graph.gv > $RESULTS_DIR/complete_wf_graph.pdf
dot -Tsvg $RESULTS_DIR/complete_wf_graph.gv > $RESULTS_DIR/complete_wf_graph.svg

# draw complete workflow graph with URI template
$YW_CMD graph $SCRIPT_DIR/get_analysis_rasters.R \
        -c graph.view=combined \
        -c graph.layout=tb \
        > $RESULTS_DIR/complete_wf_graph_uri.gv
dot -Tpdf $RESULTS_DIR/complete_wf_graph_uri.gv > $RESULTS_DIR/complete_wf_graph_uri.pdf
dot -Tsvg $RESULTS_DIR/complete_wf_graph_uri.gv > $RESULTS_DIR/complete_wf_graph_uri.svg

# list workflow outputs
$QUERIES_DIR/list_workflow_outputs.sh > $RESULTS_DIR/workflow_outputs.txt


##############
#   Q1_pro   #
##############

# draw prospective provenance graph upstream of rast_3nm_file
$QUERIES_DIR/render_wf_graph_upstream_of_data_q1.sh rast_3nm_file > $RESULTS_DIR/wf_upstream_of_rast_3nm_file.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_rast_3nm_file.gv > $RESULTS_DIR/wf_upstream_of_rast_3nm_file.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_rast_3nm_file.gv > $RESULTS_DIR/wf_upstream_of_rast_3nm_file.svg


# draw prospective provenance graph upstream of rast_1km_file
$QUERIES_DIR/render_wf_graph_upstream_of_data_q1.sh rast_1km_file > $RESULTS_DIR/wf_upstream_of_rast_1km_file.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_rast_1km_file.gv > $RESULTS_DIR/wf_upstream_of_rast_1km_file.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_rast_1km_file.gv > $RESULTS_DIR/wf_upstream_of_rast_1km_file.svg


##############
#   Q2_pro   #
##############

# list script inputs upstream of output data rast_3nm_file
$QUERIES_DIR/list_inputs_upstream_of_data_q2.sh rast_3nm_file  rast_3nm_file > $RESULTS_DIR/inputs_upstream_of_rast_3nm_file.txt

# list script inputs upstream of output data rast_1km_file
$QUERIES_DIR/list_inputs_upstream_of_data_q2.sh rast_1km_file  rast_1km_file > $RESULTS_DIR/inputs_upstream_of_rast_1km_file.txt


##############
#   Q3_pro   #
##############

# draw prospective provenance graph downstream of poly_3nm_file
$QUERIES_DIR/render_wf_graph_downstream_of_data_q3.sh poly_3nm_file > $RESULTS_DIR/wf_downstream_of_poly_3nm_file.gv
dot -Tpdf $RESULTS_DIR/wf_downstream_of_poly_3nm_file.gv > $RESULTS_DIR/wf_downstream_of_poly_3nm_file.pdf
dot -Tsvg $RESULTS_DIR/wf_downstream_of_poly_3nm_file.gv > $RESULTS_DIR/wf_downstream_of_poly_3nm_file.svg


# draw prospective provenance graph downstream of poly_1km_file
$QUERIES_DIR/render_wf_graph_downstream_of_data_q3.sh poly_1km_file > $RESULTS_DIR/wf_downstream_of_poly_1km_file.gv
dot -Tpdf $RESULTS_DIR/wf_downstream_of_poly_1km_file.gv > $RESULTS_DIR/wf_downstream_of_poly_1km_file.pdf
dot -Tsvg $RESULTS_DIR/wf_downstream_of_poly_1km_file.gv > $RESULTS_DIR/wf_downstream_of_poly_1km_file.svg


# draw prospective provenance graph downstream of rast_base
$QUERIES_DIR/render_wf_graph_downstream_of_data_q3.sh rast_base > $RESULTS_DIR/wf_downstream_of_rast_base.gv
dot -Tpdf $RESULTS_DIR/wf_downstream_of_rast_base.gv > $RESULTS_DIR/wf_downstream_of_rast_base.pdf
dot -Tsvg $RESULTS_DIR/wf_downstream_of_rast_base.gv > $RESULTS_DIR/wf_downstream_of_rast_base.svg


##############
#   Q4_pro   #
##############

# list script outputs downstream of input data poly_3nm_file
$QUERIES_DIR/list_outputs_downstream_of_data_q4.sh poly_3nm_file poly_3nm_file > $RESULTS_DIR/outputs_downstream_of_poly_3nm_file.txt

# list script outputs downstream of input data poly_1km_file
$QUERIES_DIR/list_outputs_downstream_of_data_q4.sh poly_1km_file poly_1km_file > $RESULTS_DIR/outputs_downstream_of_poly_1km_file.txt

# list script outputs downstream of input data rast_base
$QUERIES_DIR/list_outputs_downstream_of_data_q4.sh rast_base rast_base > $RESULTS_DIR/outputs_downstream_of_rast_base.txt


##############
#   Q5_pro   #
##############

# draw hybrid provenance graph upstream of rast_3nm_file
$QUERIES_DIR/render_wf_recon_graph_upstream_of_data_q5.sh rast_3nm_file > $RESULTS_DIR/wf_recon_upstream_of_rast_3nm_file.gv
dot -Tpdf $RESULTS_DIR/wf_recon_upstream_of_rast_3nm_file.gv > $RESULTS_DIR/wf_recon_upstream_of_rast_3nm_file.pdf
dot -Tsvg $RESULTS_DIR/wf_recon_upstream_of_rast_3nm_file.gv > $RESULTS_DIR/wf_recon_upstream_of_rast_3nm_file.svg


# draw hybrid provenance graph upstream of rast_1km_file
$QUERIES_DIR/render_wf_recon_graph_upstream_of_data_q5.sh rast_1km_file > $RESULTS_DIR/wf_recon_upstream_of_rast_1km_file.gv
dot -Tpdf $RESULTS_DIR/wf_recon_upstream_of_rast_1km_file.gv > $RESULTS_DIR/wf_recon_upstream_of_rast_1km_file.pdf
dot -Tsvg $RESULTS_DIR/wf_recon_upstream_of_rast_1km_file.gv > $RESULTS_DIR/wf_recon_upstream_of_rast_1km_file.svg


##############
#   Q6_pro   #
##############


# draw hybrid provenance graph  with all observables

$QUERIES_DIR/render_recon_complete_wf_graph_q6.sh > $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv
dot -Tpdf $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv > $RESULTS_DIR/wf_recon_complete_graph_all_observables.pdf
dot -Tsvg $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv > $RESULTS_DIR/wf_recon_complete_graph_all_observables.svg
