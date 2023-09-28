# This is a simple script to summarize and visualize lake area in Iceland
# Author: Ryan McClure
# Date created: Sept 28th 2023

# Ensure all packages used are up to date with pacman
if (!require("pacman")) install.packages("pacman")
# Use Pacman to install and load packages (its better!)
pacman::p_load(dplyr, ggplot2, readr)

# Load the file and rename the columns
iceland <- readr::read_csv("./data/Iceland.csv", col_names = F) %>%
  rename(year = X1, month = X2, hylak_id = X3, lat = X4, lon = X5, area_km2 = X7,
         temp_K = X8, percent_ice = X9)

# View the first 10 values
head(iceland, 10)

# What are the column names?
names(iceland)

# Summarize the columns
summary(iceland)

# Q1 How many lakes are in Iceland?
paste0("There are ", length(unique(iceland$X3)), " GLCP Lakes in Iceland")

# Q2 How many lakes are swelling and how many are shrinking?

# Q3 


                   