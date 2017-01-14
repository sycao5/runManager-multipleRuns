# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1

# Calculate goal model

source("setup.R")

rast_3nm  <- raster(file.path(dir_goal, 'spatial/hs_offshore_3nm_raster_500m.tif'))
values(rast_3nm)[!is.na(values(rast_3nm))] <- 1
rast_1km  <- raster(file.path(dir_goal, 'spatial/hs_inland_1km_raster_500m.tif'))
values(rast_1km)[!is.na(values(rast_1km))] <- 1
rast_ws   <- raster(file.path(dir_goal, 'spatial/howe_sound_watershed_500m.tif'))
values(rast_ws)[!is.na(values(rast_ws))] <- 1

rast_pep  <- raster(file.path(dir_goal, 'spatial/hs_pep_rast_500m.tif'))
rast_wdpa_pep <- raster(file.path(dir_goal, 'spatial/hs_wdpa_rast_500m.tif'))
### will adjust values of this to include pep areas

### for any non-WDPA cells with PEP values, set to 1 (distinct from WDPA values, which are all years)
values(rast_wdpa_pep)[!is.na(values(rast_pep)) & is.na(values(rast_wdpa_pep))] <- 1

zonal_3nm_file <- file.path(dir_goal, 'int', 'zonal_stats_3nm.csv')
zonal_1km_file <- file.path(dir_goal, 'int', 'zonal_stats_1km.csv')
zonal_ws_file  <- file.path(dir_goal, 'int', 'zonal_stats_ws.csv')

stats_3nm <- raster::crosstab(rast_wdpa_pep, rast_3nm, useNA = TRUE, progress = 'text') %>%
  as.data.frame() %>%
  setNames(c('year', 'rgn_id', 'n_cells')) %>%
  mutate(year   = as.integer(as.character(year)),
         rgn_id = as.integer(as.character(rgn_id))) %>%
  filter(!is.na(rgn_id)) %>%
  arrange(rgn_id, year)

stats_1km <- raster::crosstab(rast_wdpa_pep, rast_1km, useNA = TRUE, progress = 'text') %>%
  as.data.frame() %>%
  setNames(c('year', 'rgn_id', 'n_cells')) %>%
  mutate(year   = as.integer(as.character(year)),
         rgn_id = as.integer(as.character(rgn_id))) %>%
  filter(!is.na(rgn_id)) %>%
  arrange(rgn_id, year)

stats_ws <- raster::crosstab(rast_wdpa_pep, rast_ws, useNA = TRUE, progress = 'text') %>%
  as.data.frame() %>%
  setNames(c('year', 'rgn_id', 'n_cells')) %>%
  mutate(year   = as.integer(as.character(year)),
         rgn_id = as.integer(as.character(rgn_id))) %>%
  filter(!is.na(rgn_id)) %>%
  arrange(rgn_id, year)

write.csv(stats_3nm, zonal_3nm_file)
write.csv(stats_1km, zonal_1km_file)
write.csv(stats_ws,  zonal_ws_file)
