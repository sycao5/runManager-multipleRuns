
# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1

# @BEGIN estimate_status_and_trend_by_year
# @in setup_configuration_file @AS setup_R
# @in area_protected_total_file @URI file:{dir_goal}/output/area_protected_total.csv
# @out lsp_status_file @URI file:{dir_goal}/output/lsp_status.csv
# @out lsp_trend_file @URI file:{dir_goal}/output/lsp_trend.csv
# @out lsp_status_trend_summary_db_file 

# @BEGIN set_up_configuration_and_start_provenance_tracking
# @in setup_configuration_file @AS setup_R
# @out dir_goal

source("setup_R")
# @END set_up_configuration_and_start_provenance_tracking

# @BEGIN create_new_stats_and_trend_file 
# @param dir_goal
# @out status_file_handle
# @out trend_file_handle

status_file <- file.path(dir_goal, 'output', 'lsp_status.csv')
trend_file  <- file.path(dir_goal, 'output', 'lsp_trend.csv')

# @END create_new_stats_and_trend_file


# @BEGIN define_param_year_span 
# @out year_span

year_span <- 20

# @END define_param_year_span

# @BEGIN output_estimate_status_file_by_region_since_1980
# @param year_span
# @param dir_goal
# @in area_protected_total_file @URI file:{dir_goal}/output/area_protected_total.csv
# @in status_file_handle
# @out status_df_data

status_df <- read.csv(file.path(dir_goal, 'output', 'area_protected_total.csv')) %>%
  select(rgn_id, year, lsp_status) %>%
  filter(year > max(year) - year_span)
# @END output_estimate_status_file_by_region_since_1980  
  
# @BEGIN write_status_to_csv_file
# @in status_df_data
# @out lsp_status_file @URI file:{dir_goal}/output/lsp_status.csv
write.csv(status_df, status_file)
# @END write_status_to_csv_file  


# @BEGIN output_estimate_trend_file_by_region_since_1980
# @param dir_goal
# @param year_span
# @in area_protected_total_file @URI file:{dir_goal}/output/area_protected_total.csv
# @in trend_file_handle
# @out trend_df_data

trend_df <- read.csv(file.path(dir_goal, 'output', 'area_protected_total.csv')) %>%
  select(rgn_id, year, lsp_status) %>%
  filter(year > max(year) - year_span)

trend_df$trend_lm <- lm(lsp_status ~ year, data = trend_df)$coefficients[[2]]


### convert to percent change per annum and mult by 5 for 5-year prediction
trend_df <- trend_df %>%
  mutate(lsp_trend = trend_lm/first(lsp_status) * 5) %>%
  select(-lsp_status, -trend_lm)

# @END output_estimate_trend_file_by_region_since_1980

# @BEGIN write_trend_to_csv_file
# @in trend_df_data
# @out lsp_trend_file @URI file:{dir_goal}/output/lsp_trend.csv
write.csv(trend_df, trend_file)
# @END write_trend_to_csv_file




# Year-by-year status and trend estimates will be saved:

# @BEGIN save_year_by_year_status_and_trend_estimates
# @in status_df_data
# @in trend_df_data
# @out lsp_status_trend_summary_db_file 

lsp_status_trend_summary <- status_df %>%
  left_join(trend_df,  by = c('rgn_id', 'year')) %>%
  arrange(desc(year), rgn_id)

head(lsp_status_trend_summary)

# @END save_year_by_year_status_and_trend_estimates


#DT::datatable(lsp_status_trend_summary, caption = 'LSP status and trend estimates')

# @END estimate_status_and_trend_by_year