# runManager-multipleRuns

This project aims to query RunManager database in order to analysis multiple runs collected by the RunManager. 

# RunManager Database Schema

1. execmeta(Seq, ExecutionId, MetadataId, DatapackageId, User, Subject, HostId, StartTime, OperatingSystem, Runtime, SoftwareApplication, ModuleDependencies, EndTime, ErrorMessage, PublishTime, PublishNodeId, PublishId, Console)

2. filemeta(FileId, ExecutionId, FilePath, Sha256, Size, User, ModifyTime, CreateTime, Access, Format, ArchivedFilePath) 

3. tag(Seq, ExecutionId, Tag)
