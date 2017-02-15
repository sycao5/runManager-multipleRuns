# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1

# @BEGIN setup_watershed_raster
# @in setup_configuration_file @AS setup_R
# @in rast_base @URI file:{dir_spatial}/raster/ohibc_rgn_raster_500m.tif
# @in howe_sound_watersheds @URI file:{dir_spatial}/watershed/howe_sound_watersheds 
# @out rast_watershed @URI file:{dir_goal}/spatial/howe_sound_watershed_500m.tif


# @BEGIN set_up_configuration_and_start_provenance_tracking
# @in setup_configuration_file @AS setup_R
# @out dir_spatial
# @out dir_goal

source("setup_R")
# @END set_up_configuration_and_start_provenance_tracking


# @BEGIN raster_to_same_extents_resolution_as_500m_base_raster
# @param dir_spatial
# @param dir_goal
# @in rast_base @URI file:{dir_spatial}/raster/ohibc_rgn_raster_500m.tif
# @in howe_sound_watersheds @URI file:{dir_spatial}/watershed/howe_sound_watersheds 
# @out rast_watershed @URI file:{dir_goal}/spatial/howe_sound_watershed_500m.tif

rast_base <- raster(file.path(dir_spatial, 'raster/ohibc_rgn_raster_500m.tif')) %>%
crop(ext_howe)

rast_watershed <- gdal_rast2(src = file.path(dir_spatial, 'watershed/howe_sound_watersheds'),
                             rast_base = rast_base,
                             dst = file.path(dir_goal, 'spatial/howe_sound_watershed_500m.tif'),
                             # value = 'WATERSHED_',
                             override_p4s = TRUE)
							 
# @END raster_to_same_extents_resolution_as_500m_base_raster

# @END setup_watershed_raster