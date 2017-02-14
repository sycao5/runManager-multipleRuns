# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1


## Rasterize the BC WDPA-MPA shapefile to Howe Sound extents

# @BEGIN  Rasterize_HS_WDPA_and_PEP
# @in setup_configuration_file @AS setup_R
# @in hs_wdpa_shp_file @URI file:{dir_goal}/spatial/hs_wdpa_poly.shp
# @in hs_pep_shp_file @URI file:{dir_goal}/spatial/hs_pep_poly.shp
# @in ohibc_rgn_raster_500m @URI file:{dir_spatial}/raster/ohibc_rgn_raster_500m.tif

# @out hs_wdpa_rast_file @URI file:{dir_goal}/spatial/hs_wdpa_rast_500m.tif
# @out hs_pep_rast_file @URI file:{dir_goal}/spatial/hs_pep_rast_500m.tif 

# @BEGIN set_up_configuration_and_start_provenance_tracking
# @in setup_configuration_file @AS setup_R
# @out dir_spatial
# @out dir_goal

source("setup_R")
# @END set_up_configuration_and_start_provenance_tracking


# @BEGIN rasterize_ohibc_rgn_raster_500m_shape_file_at_500m_resolution
# @param dir_spatial
# @in ohibc_rgn_raster_500m @URI file:{dir_spatial}/raster/ohibc_rgn_raster_500m.tif
# @out rast_base @AS extent_of_howe_sound

rast_base <- raster(file.path(dir_spatial, 'raster/ohibc_rgn_raster_500m.tif')) %>%
  crop(ext_howe)
# @END rasterize_ohibc_rgn_raster_500m_shape_file_at_500m_resolution


# @BEGIN load_and_create_howe_sound_wdpa_pep_files
# @param dir_goal
# @in hs_wdpa_shp_file @URI file:{dir_goal}/spatial/hs_wdpa_poly.shp
# @in hs_pep_shp_file @URI file:{dir_goal}/spatial/hs_pep_poly.shp
# @out hs_wdpa_rast_file_handle 
# @out hs_pep_rast_file_handle  

hs_wdpa_shp_file  <- file.path(dir_goal, 'spatial', 'hs_wdpa_poly.shp')
hs_wdpa_rast_file <- file.path(dir_goal, 'spatial', 'hs_wdpa_rast_500m.tif')
hs_pep_shp_file   <- file.path(dir_goal, 'spatial', 'hs_pep_poly.shp')
hs_pep_rast_file  <- file.path(dir_goal, 'spatial', 'hs_pep_rast_500m.tif')
# @END load_and_create_howe_sound_wdpa_pep_files


# @BEGIN rasterize_howe_sound_wdpa_shape_file
# @in hs_wdpa_shp_file @URI file:{dir_goal}/spatial/hs_wdpa_poly.shp
# @in rast_base  @AS extent_of_howe_sound
# @in hs_wdpa_rast_file_handle 
# @out hs_wdpa_rast_file  @URI file:{dir_goal}/spatial/hs_wdpa_rast_500m.tif

rast_wdpa <- gdal_rast2(src = hs_wdpa_shp_file,
                        rast_base = rast_base,
                        dst = hs_wdpa_rast_file,
                        value = 'STATUS_YR',
                        override_p4s = TRUE)
# @END rasterize_wdpa_shape_file


# @BEGIN rasterize_howe_sound_pep_shape_file
# @in hs_pep_shp_file @URI file:{dir_goal}/spatial/hs_pep_poly.shp
# @in rast_base  @AS extent_of_howe_sound
# @in hs_pep_rast_file_handle
# @out hs_pep_rast_file @URI file:{dir_goal}/spatial/hs_pep_rast_500m.tif

rast_pep  <- gdal_rast2(src = hs_pep_shp_file,
                        rast_base = rast_base,
                        dst = hs_pep_rast_file,
                        value = 'OBJECTID', ### no year field available
                        override_p4s = TRUE)
# @END rasterize_howe_sound_pep_shape_file
						
# @END Rasterize_HS_WDPA_and_PEP