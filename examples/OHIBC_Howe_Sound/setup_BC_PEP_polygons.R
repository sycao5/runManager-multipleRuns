source("setup.R")

## Read in BC Parks, Ecological Reserves, and Protected Areas data

# DataBC offers spatial data on BC protected areas with small differences from the WDPA dataset.  We will use this as well.

message("reading TA_PEP_SVW_polygon...")
poly_hs_pep <- readOGR(dsn = file.path(dir_anx, '_raw_data/databc/TA_PEP_SVW'),
                       layer = 'TA_PEP_SVW_polygon',
                       stringsAsFactors = FALSE) %>%
  spTransform(CRS(p4s_bcalb)) %>%
  crop(ext_howe)

message("Writing outp hs_pep_ploy...")
writeOGR(poly_hs_pep,
         dsn = path.expand(file.path(dir_goal, 'spatial')),
         layer = 'hs_pep_poly',
         driver = 'ESRI Shapefile',
         overwrite_layer = TRUE)
message("completed BC_PEP_polygons.")
