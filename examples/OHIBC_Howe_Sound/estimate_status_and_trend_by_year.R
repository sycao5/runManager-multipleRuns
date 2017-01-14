
# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1

source("setup.R")
status_file <- file.path(dir_goal, 'output', 'lsp_status.csv')
trend_file  <- file.path(dir_goal, 'output', 'lsp_trend.csv')

year_span <- 20

status_df <- read.csv(file.path(dir_goal, 'output', 'area_protected_total.csv')) %>%
  select(rgn_id, year, lsp_status) %>%
  filter(year > max(year) - year_span)
write.csv(status_df, status_file)

trend_df <- read.csv(file.path(dir_goal, 'output', 'area_protected_total.csv')) %>%
  select(rgn_id, year, lsp_status) %>%
  filter(year > max(year) - year_span)

trend_df$trend_lm <- lm(lsp_status ~ year, data = trend_df)$coefficients[[2]]

### convert to percent change per annum and mult by 5 for 5-year prediction
trend_df <- trend_df %>%
  mutate(lsp_trend = trend_lm/first(lsp_status) * 5) %>%
  select(-lsp_status, -trend_lm)

write.csv(trend_df, trend_file)

# Year-by-year status and trend estimates will be saved:

lsp_status_trend_summary <- status_df %>%
  left_join(trend_df,  by = c('rgn_id', 'year')) %>%
  arrange(desc(year), rgn_id)

head(lsp_status_trend_summary)
#DT::datatable(lsp_status_trend_summary, caption = 'LSP status and trend estimates')

