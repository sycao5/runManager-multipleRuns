#!/usr/bin/env bash

ProvidedDataName=$1

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

set_prolog_flag(unknown, fail).


['$VIEWS_DIR/rm_views'].
['$FACTS_DIR/execmetafacts'].
['$FACTS_DIR/filemetafacts'].
['$FACTS_DIR/tagfacts'].
['$RULES_DIR/rm_rules'].
['$RULES_DIR/gv_rules'].
['$RULES_DIR/rm_graph_rules'].

[user].
graph :-

    gv_graph('yw_data_view', 'Upstream graph for multiple runs', 'LR'),

        gv_cluster('workflow', 'black'),
            gv_nodestyle__atomic_run,
            gv_nodes__atomic_executions__upstream_of_data(RM,$ProvidedDataName),
            gv_node_style__file,
            gv_nodes__files__upstream_of_file_sha256(RM,$ProvidedDataName),
        gv_cluster_end,

        gv_edges__file_to_execution__upstream_of_file_sha256(RM, $ProvidedDataName),
        gv_edges__execution_to_file__upstream_of_file_sha256(RM,$ProvidedDataName),

    gv_graph_end.

end_of_file.

graph.

END_XSB_STDIN