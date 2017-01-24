# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1

## Combine scores for inland and offshore, and writing output layers

# @BEGIN combine_scores_for_inland_&_offshore_&_outputs
# @in setup_configuration_file @AS setup.R
# @in prot_3nm_stats_file @URI file:{dir_goal}/int/area_protected_3nm.csv
# @in prot_1km_stats_file @URI file:{dir_goal}/int/area_protected_1km.csv
# @in prot_ws_stats_file  @URI file:{dir_goal}/int/area_protected_ws.csv
# @out area_protected_total_file @URI file:{dir_goal}/output/area_protected_total.csv


# @BEGIN set_up_configuration_and_start_provenance_tracking
# @in setup_configuration_file @AS setup.R
# @out dir_goal

source("setup.R")
# @END set_up_configuration_and_start_provenance_tracking


# @BEGIN read_in_protected_area_&_total_area_by_region
# @param dir_goal
# @in prot_3nm_stats_file @URI file:{dir_goal}/int/area_protected_3nm.csv
# @in prot_1km_stats_file @URI file:{dir_goal}/int/area_protected_1km.csv
# @in prot_ws_stats_file  @URI file:{dir_goal}/int/area_protected_ws.csv
# @out prot_3nm
# @out prot_1km
# @out prot_ws

prot_3nm <- read.csv(file.path(dir_goal, 'int', 'area_protected_3nm.csv'))
prot_1km <- read.csv(file.path(dir_goal, 'int', 'area_protected_1km.csv'))
prot_ws  <- read.csv(file.path(dir_goal, 'int', 'area_protected_ws.csv'))

# @END read_in_protected_area_&_total_area_by_region


# @BEGIN combine_scores_for_inland_&_offshore_&_write_output_layers
# @in prot_1km
# @in prot_3nm
# @in prot_ws
# @out area_protected_total_file @URI file:{dir_goal}/output/area_protected_total.csv

prot_df <- prot_1km %>%
  dplyr::select(rgn_id, year,
                lsp_st_1km = lsp_status,
                a_prot_1km = a_prot_km2,
                a_tot_1km  = a_tot_km2) %>%
  full_join(prot_3nm %>%
              dplyr::select(rgn_id, year,
                            lsp_st_3nm = lsp_status,
                            a_prot_3nm = a_prot_km2,
                            a_tot_3nm  = a_tot_km2),
            by = c('rgn_id', 'year')) %>%
  full_join(prot_ws %>%
              dplyr::select(rgn_id, year,
                            lsp_st_ws = lsp_status,
                            a_prot_ws = a_prot_km2,
                            a_tot_ws  = a_tot_km2),
            by = c('rgn_id', 'year')) %>%
  fill(lsp_st_1km:a_tot_ws) %>%
  ### this catches any years where NAs exist for one or the other region;
  ### the complete() and fill() from the dataframes should catch this anyway
  mutate(lsp_st_1km = ifelse(is.na(lsp_st_1km), 0, lsp_st_1km),
         lsp_st_3nm = ifelse(is.na(lsp_st_3nm), 0, lsp_st_3nm),
         lsp_st_ws  = ifelse(is.na(lsp_st_ws),  0, lsp_st_ws),
         lsp_status_areawt  = (lsp_st_ws * a_tot_ws + lsp_st_3nm * a_tot_3nm) / (a_tot_ws + a_tot_3nm),
         lsp_status_3nm_1km = (lsp_st_3nm + lsp_st_1km) / 2,
         lsp_status         = (lsp_st_ws  + lsp_st_3nm) / 2) %>%
  distinct()

write.csv(prot_df, file.path(dir_goal, 'output', 'area_protected_total.csv'))

# @END combine_scores_for_inland_&_offshore_&_write_output_layers

# @END combine_scores_for_inland_&_offshore_&_outputs