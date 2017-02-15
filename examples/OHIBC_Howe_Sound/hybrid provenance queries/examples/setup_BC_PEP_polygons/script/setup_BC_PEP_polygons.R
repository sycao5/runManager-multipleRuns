## Read in BC Parks, Ecological Reserves, and Protected Areas data
# DataBC offers spatial data on BC protected areas with small differences from the WDPA dataset.  We will use this as well.

# @BEGIN setup_BC_PEP_polygons
# @in poly_hs_pep @AS TA_PEP_SVW_polygon @URI file:{dir_anx}/_raw_data/databc/TA_PEP_SVW/TA_PEP_SVW_polygon.shp
# @in setup_configuration_file @AS setup_R
# @out poly_hs_pep @URI file:{dir_goal}/spatial/hs_pep_poly.shp 

# @BEGIN set_up_Configuration_and_start_provenance_tracking
# @in setup_configuration_file @AS setup_R
# @out dir_anx
# @out dir_goal
source("setup_R")
# @END set_up_Configuration_and_start_provenance_tracking

# @BEGIN read_TA_PEP_SVW_polygon
# @param dir_anx
# @in poly_hs_pep @AS TA_PEP_SVW_polygon @URI file:{dir_anx}/_raw_data/databc/TA_PEP_SVW/TA_PEP_SVW_polygon.shp
# @out poly_hs_pep @AS hs_pep_poly

message("reading TA_PEP_SVW_polygon...")
poly_hs_pep <- readOGR(dsn = file.path(dir_anx, '_raw_data/databc/TA_PEP_SVW'),
                       layer = 'TA_PEP_SVW_polygon',
                       stringsAsFactors = FALSE) %>%
  spTransform(CRS(p4s_bcalb)) %>%
  crop(ext_howe)

# @END read_TA_PEP_SVW_polygon

# @BEGIN write_hs_pep_poly
# @in poly_hs_pep @AS hs_pep_poly
# @param dir_goal
# @out poly_hs_pep @URI file:{dir_goal}/spatial/hs_pep_poly.shp 

message("Writing outp hs_pep_ploy...")
writeOGR(poly_hs_pep,
         dsn = path.expand(file.path(dir_goal, 'spatial')),
         layer = 'hs_pep_poly',
         driver = 'ESRI Shapefile',
         overwrite_layer = TRUE)
message("completed BC_PEP_polygons.")

# @END write_hs_pep_poly

# @END setup_BC_PEP_polygons