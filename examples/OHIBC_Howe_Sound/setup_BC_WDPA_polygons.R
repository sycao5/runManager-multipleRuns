
# Summary: OHIBC Lasting Special Places subgoal (Sense of Place)

# Data Sources
#
#WDPA database <citation info?>
#
#BC Parks, Ecological Reserves, and Protected Areas data
#

# Methods

## Read in BC WDPA-MPA shapefile
#
#We will create a BC-specific polygon subset of the WDPA global dataset, then rasterize to BC Albers at 500 m resolution.
#NOTE: If BC WDPA file does not yet exist, `get_wdpa_poly()` creates it from the original WDPA-MPA file.  This takes a long time, due to reading in the full WDPA-MPA geodatabase into a SpatialPolygonsDataFrame.

# hs_ws <- readOGR(dsn = file.path(dir_goal, 'watershed'), layer = 'howe_sound_watersheds')
# hs_rgn <- readOGR(dsn = file.path(dir_spatial), layer = 'howe_sound_rgn')
# bbox(hs_ws)
# #         min       max
# # x 1141118.3 1238724.7
# # y  471385.5  616826.2
# bbox(hs_rgn)
# #         min       max
# # x 1169571.2 1227753.5
# # y  473548.3  534590.4
source("setup.R")

poly_hs_wdpa <- get_wdpa_poly(p4s_bcalb, reload = FALSE) %>%  ### defaults to BC Albers
  spTransform(CRS(p4s_bcalb)) %>%
  crop(ext_howe)

writeOGR(poly_hs_wdpa,
         dsn = path.expand(file.path(dir_goal, 'spatial')),
         layer = 'hs_wdpa_poly',
         driver = 'ESRI Shapefile',
         overwrite_layer = TRUE)
