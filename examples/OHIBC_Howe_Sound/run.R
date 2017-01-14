library(recordr)
rc <- new("Recordr")
#projDir <- "/Users/slaughter/Projects/CommunityDynamics/Recordr/OHI_BC"
savedDir <- getwd()
setwd("/Users/slaughter/git/OHI-Science/ohibc")
source("setup.R")
runNumber = 1
tagStr <- sprintf("ohibc run %s", runNumber)
#record(rc, "setup_BC_WDPA_polygons.R", tag=tagStr, allowErrors=T)
record(rc, "setup_BC_PEP_polygons.R", tag=tagStr, allowErrors=T)
record(rc, "rasterize_HS_WDPA_and_PEP.R", tag=tagStr)
record(rc, "get_analysis_rasters.R", tag=tagStr, allowErrors=T)
record(rc, "setup_watershed_raster.R", tag=tagStr)
record(rc, "lsp_zonal_stats.R", tag=tagStr)
record(rc, "summarize_zonal_stats.R", tag=tagStr)
record(rc, "combine_inland_and_offshore.R", tag=tagStr)
record(rc, "estimate_status_and_trend_by_year.R", tag=tagStr)

setwd(savedDir)