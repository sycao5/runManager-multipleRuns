# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1

source("setup.R")

rast_base <- raster(file.path(dir_spatial, 'raster/ohibc_rgn_raster_500m.tif')) %>%
crop(ext_howe)

rast_watershed <- gdal_rast2(src = file.path(dir_spatial, 'watershed/howe_sound_watersheds'),
                             rast_base = rast_base,
                             dst = file.path(dir_goal, 'spatial/howe_sound_watershed_500m.tif'),
                             # value = 'WATERSHED_',
                             override_p4s = TRUE)
