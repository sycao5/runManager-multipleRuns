# runManager-multipleRuns

This project will query RunManager database in order to analysis the lineage between multiple runs collected by the RunManager. 

## RunManager Database Schema

In the simulated SQLite database used in RunManager, there are three scripts: script_a, script_b, and script_c. There are three runs for script_a and script_a_run_1 and script_a_run_2 are same run created by script_a using the same set of parameter values. There are two runs for script_b which use different parameter values to create these two runs for script_b. script_c uses the outputs from two runs of script_b. The database schema is defined in R version RunManager DB. All these retrospective provenance are represented using logic facts in Prolog.

1. `execmeta`(Seq, ExecutionId, MetadataId, DatapackageId, User, Subject, HostId, StartTime, OperatingSystem, Runtime, SoftwareApplication, ModuleDependencies, EndTime, ErrorMessage, PublishTime, PublishNodeId, PublishId, Console)

2. `filemeta`(FileId, ExecutionId, FilePath, Sha256, Size, User, ModifyTime, CreateTime, Access, Format, ArchivedFilePath) 

3. `tag`(Seq, ExecutionId, Tag)



## Layouts of Repository

The project folders have a folder structure:

| Directory | Description                                                          |
|-----------| :--------------------------------------------------------------------|
| facts/ | the RunManager facts, generated by running DataONE RunManager (R version) on the example script(s). The simulated facts are used at this point (todo: test using real db facts).|
| views/ | materialized views generated from RunManager|
| queries/ | it stores the scripts for two example queries we asked. These quries are recursive Prolog queries that run across retrospective facts in the `facts/` folder and the derived facts in the `views/` folder.|
|rules/| it contains a set of Prolog rules for generating retrospective multiple run views rules (`rm_rules.P` and `rm_view_rules.P`), graph rendering rules (`gv_rules.P`), and populating graph rules (`rm_graph_rules.P`).|
| results/ | all artifacts generated by make.sh|
| clean.sh | removes generated demo artifacts|
| make.sh | creates demo artifacts|

## Installing, Browsing, and Running the runManager-multipleRuns project

### Installing

1. The following free software are required in order to run  this demo.

  * XSB: a Logic Programming and Deductive Database system for Unix and Windows.  It is available at [XSB homepage] (http://xsb.sourceforge.net). The download and installation page for XSB is at [here] (http://xsb.sourceforge.net/downloads/downloads.html). 
  
  * Graphviz:  a Graph Visuzlization Software for Unix and Windows.  It is available at [Graphviz homepage](http://www.graphviz.org). The download and installation page for Graphviz is at  [here](http://www.graphviz.org/Download.php).  The download page is  at [here](https://www.sqlite.org/download.html).
  
  *  SQLite:  a high-reliability, embedded, zero-configuration, public-domain, SQL database engine.  It is availabe at [SQLite homepage](https://www.sqlite.org). 

2. The  following packages are used  in our demo project.
  *  [recordr](https://github.com/NCEAS/recordr)
  *  [matlab-dataone](https://github.com/DataONEorg/matlab-dataone/tree/ml-sqlite)
  
3.  Clone the `runManager-multipleRuns` git repo to your local machine using the command:
  `git clone https://github.com/sycao5/runManager-multipleRuns.git`.
  
