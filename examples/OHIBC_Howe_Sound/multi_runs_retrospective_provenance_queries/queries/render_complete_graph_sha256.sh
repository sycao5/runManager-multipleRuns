#!/usr/bin/env bash

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

    gv_graph('rm_data_view', 'multiple_runs', 'TB'),

        gv_cluster('workflow', 'black'),
            gv_nodestyle__atomic_run,
            gv_nodes__execution(RM),
            gv_node_style__file,
            gv_nodes__file_DataSha256(RM),
        gv_cluster_end,

	   gv_edges__file_DataSha256_to_execution(RM),
	   gv_edges__execution_to_file_DataSha256(RM),
	   
    gv_graph_end.

end_of_file.

graph.

END_XSB_STDIN