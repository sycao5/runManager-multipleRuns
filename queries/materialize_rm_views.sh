
#!/usr/bin/env bash

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$FACTS_DIR/execmetafacts'].
['$FACTS_DIR/filemetafacts'].
['$RULES_DIR/general_rules'].
['$RULES_DIR/rm_view_rules'].

set_prolog_flag(unknown, fail).

rule_banner('exec_used_files(Seq,ExecutionId,User,FileId,FilePath,Sha256,Format,ArchivedFilePath,Access).').
printall(exec_used_files(_,_,_,_,_,_,_,_,_)).

rule_banner('exec_generated_files(Seq,ExecutionId,User,FileId,FilePath,Sha256,Format,ArchivedFilePath,Access).').
printall(exec_generated_files(_,_,_,_,_,_,_,_,_)).

rule_banner('input_files_to_execution_edges(ExecutionId, FileId).').
printall(input_files_to_execution_edges(_,_)).

rule_banner('execution_to_output_files_edges(ExecutionId, FileId).').
printall(execution_to_output_files_edges(_,_)).

END_XSB_STDIN
