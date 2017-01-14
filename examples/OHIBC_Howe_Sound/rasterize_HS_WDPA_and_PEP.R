# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1


## Rasterize the BC WDPA-MPA shapefile to Howe Sound extents

source("setup.R")
rast_base <- raster(file.path(dir_spatial, 'raster/ohibc_rgn_raster_500m.tif')) %>%
  crop(ext_howe)

hs_wdpa_shp_file  <- file.path(dir_goal, 'spatial', 'hs_wdpa_poly.shp')
hs_wdpa_rast_file <- file.path(dir_goal, 'spatial', 'hs_wdpa_rast_500m.tif')
hs_pep_shp_file   <- file.path(dir_goal, 'spatial', 'hs_pep_poly.shp')
hs_pep_rast_file  <- file.path(dir_goal, 'spatial', 'hs_pep_rast_500m.tif')

rast_wdpa <- gdal_rast2(src = hs_wdpa_shp_file,
                        rast_base = rast_base,
                        dst = hs_wdpa_rast_file,
                        value = 'STATUS_YR',
                        override_p4s = TRUE)

rast_pep  <- gdal_rast2(src = hs_pep_shp_file,
                        rast_base = rast_base,
                        dst = hs_pep_rast_file,
                        value = 'OBJECTID', ### no year field available
                        override_p4s = TRUE)
