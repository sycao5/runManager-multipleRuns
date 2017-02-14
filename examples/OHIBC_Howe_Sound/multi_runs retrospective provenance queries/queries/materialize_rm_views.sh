
#!/usr/bin/env bash

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$FACTS_DIR/execmetafacts'].
['$FACTS_DIR/filemetafacts'].
['$RULES_DIR/general_rules'].
['$RULES_DIR/rm_view_rules'].

set_prolog_flag(unknown, fail).

rule_banner('exec_used_files(seq, executionId, user, fileId, filePath, sha256, format, archivedFilePath, access).').
printall(exec_used_files(_,_,_,_,_,_,_,_,_)).

rule_banner('exec_generated_files(seq, executionId, user, fileId, filePath, sha256, format, archivedFilePath, access).').
printall(exec_generated_files(_,_,_,_,_,_,_,_,_)).

rule_banner('input_files_to_execution_edges(executionId, fileId).').
printall(input_files_to_execution_edges(_,_)).

rule_banner('execution_to_output_files_edges(executionId, fileId).').
printall(execution_to_output_files_edges(_,_)).

END_XSB_STDIN
