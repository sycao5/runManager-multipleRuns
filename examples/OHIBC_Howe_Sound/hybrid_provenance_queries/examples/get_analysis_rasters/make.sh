#!/usr/bin/env bash

# set variables
source ../settings.sh

# create output directories
mkdir -p $FACTS_DIR
mkdir -p $VIEWS_DIR
mkdir -p $RESULTS_DIR

for f in $SCRIPT_DIR/*.R
do
	## Get the file name by removeing everything until the last / (the path) from the file name
	str1="${f##*/}"
	## Removes the string .R from the end of it
	filename="${str1%.R}"	
done


# export YW model facts
$YW_CMD model $f \
        -c extract.language=R \
        -c extract.factsfile=$FACTS_DIR/yw_extract_facts.P \
        -c model.factsfile=$FACTS_DIR/yw_model_facts.P \
        -c query.engine=xsb

# materialize views of YW facts
$QUERIES_DIR/materialize_yw_views.sh > $VIEWS_DIR/yw_views.P

# generate reconfacts.P to facts/ folder from the run.yaml which is decoded by yw-matlab bridge
run_yaml="$filename.yaml"
$YW_MATLAB_RECON_CMD recon $f \
        -c extract.language=R \
        -c recon.matlab.exportfile=recon/$run_yaml \
        -c recon.factsfile=facts/reconfacts.P \
        -c recon.finderclass=org.yesworkflow.matlab.MatlabResourceFinder \
        -c query.engine=xsb

# draw complete workflow graph
$QUERIES_DIR/render_complete_wf_graph.sh > $RESULTS_DIR/complete_wf_graph.gv
dot -Tpdf $RESULTS_DIR/complete_wf_graph.gv > $RESULTS_DIR/complete_wf_graph.pdf
dot -Tsvg $RESULTS_DIR/complete_wf_graph.gv > $RESULTS_DIR/complete_wf_graph.svg

# draw complete workflow graph with URI template
complete_wf_graph_name="$filename"_complete_wf_graph_uri
$YW_CMD graph $f \
        -c graph.view=combined \
        -c graph.layout=tb \
        > $RESULTS_DIR/$complete_wf_graph_name.gv
dot -Tpdf $RESULTS_DIR/$complete_wf_graph_name.gv > $RESULTS_DIR/$complete_wf_graph_name.pdf
dot -Tsvg $RESULTS_DIR/$complete_wf_graph_name.gv > $RESULTS_DIR/$complete_wf_graph_name.svg

# list workflow outputs from prospective proveannce graph
$QUERIES_DIR/list_workflow_outputs.sh > $RESULTS_DIR/workflow_outputs.txt


##############
#   Q1_pro   #
##############

# draw prospective provenance graph upstream of rast_3nm_file
productName="rast_3nm_file"
$QUERIES_DIR/render_wf_graph_upstream_of_data_q1.sh $productName > $RESULTS_DIR/wf_upstream_of_$productName.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_$productName.gv > $RESULTS_DIR/wf_upstream_of_$productName.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_$productName.gv > $RESULTS_DIR/wf_upstream_of_$productName.svg

# draw prospective provenance graph upstream of rast_1km_file
productName="rast_1km_file"
$QUERIES_DIR/render_wf_graph_upstream_of_data_q1.sh $productName > $RESULTS_DIR/wf_upstream_of_$productName.gv
dot -Tpdf $RESULTS_DIR/wf_upstream_of_$productName.gv > $RESULTS_DIR/wf_upstream_of_$productName.pdf
dot -Tsvg $RESULTS_DIR/wf_upstream_of_$productName.gv > $RESULTS_DIR/wf_upstream_of_$productName.svg


##############
#   Q2_pro   #
##############

# list script inputs upstream of output data rast_3nm_file
productName="rast_3nm_file"
$QUERIES_DIR/list_inputs_upstream_of_data_q2.sh $productName $productName > $RESULTS_DIR/inputs_upstream_of_$productName.txt

# list script inputs upstream of output data rast_1km_file
productName="rast_1km_file"
$QUERIES_DIR/list_inputs_upstream_of_data_q2.sh $productName $productName > $RESULTS_DIR/inputs_upstream_of_$productName.txt


##############
#   Q3_pro   #
##############

# draw prospective provenance graph downstream of poly_3nm_file
productName="poly_3nm_file"
$QUERIES_DIR/render_wf_graph_downstream_of_data_q3.sh $productName > $RESULTS_DIR/wf_downstream_of_$productName.gv
dot -Tpdf $RESULTS_DIR/wf_downstream_of_$productName.gv > $RESULTS_DIR/wf_downstream_of_$productName.pdf
dot -Tsvg $RESULTS_DIR/wf_downstream_of_$productName.gv > $RESULTS_DIR/wf_downstream_of_$productName.svg


# draw prospective provenance graph downstream of poly_1km_file
productName="poly_1km_file"
$QUERIES_DIR/render_wf_graph_downstream_of_data_q3.sh $productName > $RESULTS_DIR/wf_downstream_of_$productName.gv
dot -Tpdf $RESULTS_DIR/wf_downstream_of_$productName.gv > $RESULTS_DIR/wf_downstream_of_$productName.pdf
dot -Tsvg $RESULTS_DIR/wf_downstream_of_$productName.gv > $RESULTS_DIR/wf_downstream_of_$productName.svg


# draw prospective provenance graph downstream of rast_base
productName="rast_base"
$QUERIES_DIR/render_wf_graph_downstream_of_data_q3.sh $productName > $RESULTS_DIR/wf_downstream_of_$productName.gv
dot -Tpdf $RESULTS_DIR/wf_downstream_of_$productName.gv > $RESULTS_DIR/wf_downstream_of_$productName.pdf
dot -Tsvg $RESULTS_DIR/wf_downstream_of_$productName.gv > $RESULTS_DIR/wf_downstream_of_$productName.svg


##############
#   Q4_pro   #
##############

# list script outputs downstream of input data poly_3nm_file
productName="poly_3nm_file"
$QUERIES_DIR/list_outputs_downstream_of_data_q4.sh $productName $productName > $RESULTS_DIR/outputs_downstream_of_$productName.txt

# list script outputs downstream of input data poly_1km_file
productName="poly_1km_file"
$QUERIES_DIR/list_outputs_downstream_of_data_q4.sh $productName $productName > $RESULTS_DIR/outputs_downstream_of_$productName.txt

# list script outputs downstream of input data rast_base
productName="rast_base"
$QUERIES_DIR/list_outputs_downstream_of_data_q4.sh $productName $productName > $RESULTS_DIR/outputs_downstream_of_$productName.txt


##############
#   Q5_pro   #
##############

# draw hybrid provenance graph upstream of rast_3nm_file
productName="rast_3nm_file"
$QUERIES_DIR/render_wf_recon_graph_upstream_of_data_q5.sh $productName > $RESULTS_DIR/wf_recon_upstream_of_$productName.gv
dot -Tpdf $RESULTS_DIR/wf_recon_upstream_of_$productName.gv > $RESULTS_DIR/wf_recon_upstream_of_$productName.pdf
dot -Tsvg $RESULTS_DIR/wf_recon_upstream_of_$productName.gv > $RESULTS_DIR/wf_recon_upstream_of_$productName.svg


# draw hybrid provenance graph upstream of rast_1km_file
productName="rast_1km_file"
$QUERIES_DIR/render_wf_recon_graph_upstream_of_data_q5.sh $productName > $RESULTS_DIR/wf_recon_upstream_of_$productName.gv
dot -Tpdf $RESULTS_DIR/wf_recon_upstream_of_$productName.gv > $RESULTS_DIR/wf_recon_upstream_of_$productName.pdf
dot -Tsvg $RESULTS_DIR/wf_recon_upstream_of_$productName.gv > $RESULTS_DIR/wf_recon_upstream_of_$productName.svg


##############
#   Q6_pro   #
##############


# draw hybrid provenance graph  with all observables

$QUERIES_DIR/render_recon_complete_wf_graph_q6.sh > $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv
dot -Tpdf $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv > $RESULTS_DIR/wf_recon_complete_graph_all_observables.pdf
dot -Tsvg $RESULTS_DIR/wf_recon_complete_graph_all_observables.gv > $RESULTS_DIR/wf_recon_complete_graph_all_observables.svg
