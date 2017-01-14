# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1

## Set up coastal buffer rasters
#
# Buffer shapefiles are located in `github/ohibc/prep/spatial`.  LSP uses 1 km inland and 3nm offshore buffers, while resilience requires analysis over the entire EEZ.
#
# Analysis will be done using raster::crosstab() comparing the WDPA raster to various region rasters.  Using a 500 m raster is the coarsest that should be used on a 1 km feature; a base raster is available at `~/github/ohibc/prep/spatial/ohibc_rgn_raster_500m.tif`.
#
# * If rasters are not already available for 1 km inland, 3 nm offshore, and EEZ:
#   * Read in buffer shapefiles to SpatialPolygonsDataFrames

source("setup.R")
### check for presence of buffer rasters
rast_3nm_file <- file.path(dir_goal, 'spatial/hs_offshore_3nm_raster_500m.tif')
rast_1km_file <- file.path(dir_goal, 'spatial/hs_inland_1km_raster_500m.tif')
cat(sprintf("what??"))
reload <- TRUE

if(!file.exists(rast_3nm_file) | !file.exists(rast_1km_file) | reload == TRUE) {
  message('Creating region buffer rasters from region buffer shapefiles')

  rast_base <- raster(file.path(dir_spatial, 'raster/ohibc_rgn_raster_500m.tif')) %>%
    crop(ext_howe)

  poly_3nm_file <- file.path(dir_spatial, 'howe_sound_offshore_3nm.shp')
  poly_1km_file <- file.path(dir_spatial, 'howe_sound_inland_1km.shp')

  rast_1km  <- gdal_rast2(src = poly_1km_file,
                          rast_base = rast_base,
                          dst = rast_1km_file,
                          value = 'rgn_id',
                          override_p4s = TRUE)
  rast_3nm  <- gdal_rast2(src = poly_3nm_file,
                          rast_base = rast_base,
                          dst = rast_3nm_file,
                          value = 'rgn_id',
                          override_p4s = TRUE)
}

