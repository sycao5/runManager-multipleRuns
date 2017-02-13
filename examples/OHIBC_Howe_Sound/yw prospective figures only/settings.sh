# define base directories
export EXAMPLE_DIR=.
export PROJECT_ROOT=.

# define lcoation of YesWorkflow jar file
export YW_JAR="${PROJECT_ROOT}/yw_jar/yesworkflow-0.2.1-SNAPSHOT-jar-with-dependencies.jar"

# define command for running YesWorkflow
export YW_CMD="java -jar $YW_JAR"

# destination of facts, views and query results
export SCRIPT_DIR=${EXAMPLE_DIR}/scripts
export RESULTS_DIR=${EXAMPLE_DIR}/results
