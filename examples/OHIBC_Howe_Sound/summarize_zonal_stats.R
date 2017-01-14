# "OHIBC Howe Sound: Lasting Special Places"
# Ocean Health Index. 2016. ohiprep v2016.1: Preparation of data for 2016 Ocean Health Index
# global assessment, [date downloaded]. National Center for Ecological Analysis and Synthesis,
# University of California, Santa Barbara.
# Available at: https://github.com/OHI-Science/ohiprep/releases/edit/v2016.1

source("setup.R")
library(raster)
stats_3nm <- read.csv(file.path(dir_goal, 'int', 'zonal_stats_3nm.csv'))
stats_1km <- read.csv(file.path(dir_goal, 'int', 'zonal_stats_1km.csv'))
stats_ws  <- read.csv(file.path(dir_goal, 'int', 'zonal_stats_ws.csv'))

lsp_thresh <- 0.30

### Determine total cells per region (n_cells_tot) and then a cumulative
### total of cells per region
prot_1km <- stats_1km %>%
  filter(!is.na(rgn_id)) %>% ### ditch cells outside region boundaries
  mutate(n_cells_tot = sum(n_cells),
         n_cells_cum = cumsum(n_cells),
         a_tot_km2   = n_cells_tot / 4,
         a_prot_km2  = n_cells_cum / 4) %>%
  filter(!is.na(year))  %>% ### this ditches non-protected cell counts but already counted in n_cells_tot
  mutate(pct_prot   = round(n_cells_cum / n_cells_tot, 4),
         lsp_status = round(ifelse(pct_prot > lsp_thresh, 100, (pct_prot / lsp_thresh) * 100), 2)) %>%
  distinct() %>%
  complete(year = c(1, 1960:2016)) %>%
  fill(rgn_id:lsp_status)

prot_3nm <- stats_3nm %>%
  filter(!is.na(rgn_id)) %>% ### ditch cells outside region boundaries
  mutate(n_cells_tot = sum(n_cells),
         n_cells_cum = cumsum(n_cells),
         a_tot_km2   = n_cells_tot / 4,
         a_prot_km2  = n_cells_cum / 4) %>%
  filter(!is.na(year))  %>% ### this ditches non-protected cell counts but already counted in n_cells_tot
  mutate(pct_prot   = round(n_cells_cum / n_cells_tot, 4),
         lsp_status = round(ifelse(pct_prot > lsp_thresh, 100, (pct_prot / lsp_thresh) * 100), 2)) %>%
  distinct()  %>%
  complete(year = c(1, 1960:2016)) %>%
  fill(rgn_id:lsp_status)

prot_ws <- stats_ws %>%
  filter(!is.na(rgn_id)) %>% ### ditch cells outside region boundaries
  mutate(n_cells_tot = sum(n_cells),
         n_cells_cum = cumsum(n_cells),
         a_tot_km2   = n_cells_tot / 4,
         a_prot_km2  = n_cells_cum / 4) %>%
  filter(!is.na(year))  %>% ### this ditches non-protected cell counts but already counted in n_cells_tot
  mutate(pct_prot   = round(n_cells_cum / n_cells_tot, 4),
         lsp_status = round(ifelse(pct_prot > lsp_thresh, 100, (pct_prot / lsp_thresh) * 100), 2)) %>%
  distinct()  %>%
  complete(year = c(1, 1960:2016)) %>%
  fill(rgn_id:lsp_status)

write.csv(prot_ws, file.path(dir_goal,  'int', 'area_protected_ws.csv'))
write.csv(prot_3nm, file.path(dir_goal, 'int', 'area_protected_3nm.csv'))
write.csv(prot_1km, file.path(dir_goal, 'int', 'area_protected_1km.csv'))

