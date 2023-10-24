# This is a simple script to summarize and visualize lake area in Iceland
# Author: Ryan McClure
# Date created: Sept 28th 2023

# Ensure all packages used are up to date with pacman
if (!require("pacman")) install.packages("pacman")
# Use Pacman to install and load packages (its better!)
pacman::p_load(dplyr, ggplot2, readr, trend, broom)

# Load the file and rename the columns
iceland <- readr::read_csv("./sandbox_data/data/Iceland.csv", col_names = F) %>%
  rename(year = X1, month = X2, hylak_id = X3, lat = X4, country = X6, lon = X5, area_km2 = X7,
         temp_K = X8, percent_ice = X9)

# View the first 10 values
head(iceland, 10)

# What are the column names?
names(iceland)

# Summarize the columns
summary(iceland)

# Q1 How many lakes are in Iceland?
paste0("There are ", length(unique(iceland$hylak_id)), " GLCP Lakes in Iceland")

# Q2 What do the trends look like?
iceland %>% group_by(hylak_id, year) %>%
  summarize(area_mean = mean(area_km2)) %>%
  ggplot(., aes(x = year, y = area_mean, group = hylak_id)) + 
  geom_line()

# Q4 WTF is up with data to 2000? Lets remove it! 
iceland_short <- iceland %>% 
  filter(year > 2000)

# plot again
iceland_short %>% group_by(hylak_id, year) %>% 
  summarize(area_mean = mean(area_km2)) %>%
  ggplot(., aes(x = year, y = area_mean, group = hylak_id)) + 
  geom_line()

# That looks better

# Q3 How many lakes are swelling and how many are shrinking?
lake_areal_change <- iceland_short %>% 
  dplyr::select(hylak_id, area_km2) %>%
  # Grouping by hylak_id
  dplyr::group_by(hylak_id) %>%
  # Z-score lake area
  mutate(area_km2 = scale(area_km2)) %>%
  na.omit(.) %>%
  # Summarizing and calculating the sens slope from the trend package
  summarise(across(c(1),  ~list(sens.slope(ts(.))))) %>%
  dplyr::group_by(hylak_id) %>%
  mutate(sens.slope = unlist(purrr::map(area_km2, "estimates")),
         p.value = unlist(purrr::map(area_km2, "p.value"))) %>%
  select(-area_km2) %>%
  select(hylak_id, sens.slope)

# Identify the swelling, shrinking, and no change lakes
swelling_ids <- lake_areal_change %>% filter(sens.slope > 0) %>% select(hylak_id)
shrinking_ids <- lake_areal_change %>% filter(sens.slope < 0) %>% select(hylak_id)
no_change_ids <- lake_areal_change %>% filter(sens.slope == 0) %>% select(hylak_id)

# Output those numbers in a silly sentence
paste0("There are ", length(swelling_ids$hylak_id), " Swelling lakes, ", 
       length(shrinking_ids$hylak_id), " Shrinking lake, and ", length(no_change_ids$hylak_id), " No-Change lakes in Iceland")
