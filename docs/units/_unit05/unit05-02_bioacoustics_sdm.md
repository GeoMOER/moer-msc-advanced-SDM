---
title: "EX |  Bioacoustic and SDM"
header:
  image: '/assets/images/teaserimages/gemini_audio.png'
  caption: 'Generated with Google Gemini'
toc: true
---

Species Distribution Modeling (SDM) utilizing bioacoustic data is a relatively new and evolving field. In this context, we don´t just model the spatial distribution of a species, but rather a **calling probability**. This approach is largely inspired by the research of [Desjonquères et al. (2022)](https://doi.org/10.1111/2041-210X.13923), who modeled shifts in calling probability for a frog species on the Iberian Peninsula under climate change.

In this exercise, we will apply similar modeling techniques to a German bird species within the federal state of Hessen. However, rather than projecting future climate impacts, we will focus on seasonal dynamics, analyzing how calling probability fluctuates throughout the months based on environmental drivers.

### From Detections to Occurance data
The primary output of bioacoustic monitoring is a "detection" (e.g., BirdNET confirms a Chaffinch was heard at 08:00 AM at station XYZ). In SDM, these detections have to be transformed to **Presence-Only** (or **Presence-Absence**) data. A significant challenge in this process is the sheer volume of data: a single station may record a Chaffinch every few seconds for several hours. Furthermore, each of these detections is associated with a specific confidence score from the classification model, typically on a scale from 0 to 1. Researchers must therefore define aggregation methods to convert these high-frequency, probabilistic detections into reliable occurrence points for spatial analysis.

On [ILIAS](https://ilias.uni-marburg.de/ilias.php?baseClass=ilrepositorygui&ref_id=4559057), you can find a dataset of audio recordings collected on an edge device by [trackIT Systems](https://trackit.systems/) as part of the project [Passive acoustic monitoring in bird sanctuaries in Hesse](https://www.hlnug.de/themen/naturschutz/vogelschutzwarte/passives-akustisches-monitoring-der-vogelschutzgebiete-in-hessen) (german only) of the [HLNUG](https://www.hlnug.de/service/english) (Hessian Agency for Nature Conservation, Environment and Geology). The project records with automatic recording devices on 65 stations in Hesse from 2026 to 2031 bird sanctuaries. We will use the first records of the project recorded from February to May 2026.

Read in the data and make yourself familiar with the structure:

```r
library("dplyr")
library("sf")

data = sf::read_sf("data/gartenrotschwanz.gpkg")%>% rename(geometry = geom)

```

![Gartenrotschwanz](https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Phoenicurus_phoenicurus_08%28js%29%2C_Lodz_%28Poland%29.jpg/1280px-Phoenicurus_phoenicurus_08%28js%29%2C_Lodz_%28Poland%29.jpg)
Image: [*Phoenicurus phoenicurus* by Jerzy Strzelecki](https://en.wikipedia.org/wiki/Common_redstart#/media/File:Phoenicurus_phoenicurus_08(js),_Lodz_(Poland).jpg). [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0).


This dataset contains records for each station where the *Phoenicurus phoenicurus* ([Common redstart](https://en.wikipedia.org/wiki/Common_redstart)) had beed recorded.



### Environmental variables

To predict species distrbution or calling probability from acoustic data, detection records are combined with environmental variables. For this study, we primarily utilize meteorological data from the [**German Weather Service (DWD)**](https://www.dwd.de/EN/Home/home_node.html).

Using the provided script below, we download monthly grids for the year 2026, covering variables such as **precipitation, air temperature, and solar radiation**. These grids are cropped to the federal state of Hesse and processed at a spatial resolution of 1 km. This alignment allows us to correlate specific acoustic activity with the localized weather conditions present at each recording station.

```r
# DWD CDC monthly grids (Germany) -> cropped to Hessen + photoperiod predictors
# Script created with Cursor
# Data: https://opendata.dwd.de/climate_environment/CDC/grids_germany/monthly/
# Run from the project root or set PROJECT_ROOT.
# Requires: terra, sf, geosphere, geodata

suppressPackageStartupMessages({
  library(terra)
  library(sf)
  library(geosphere)
  library(geodata)
})

# ---- user configuration ------------------------------------------------------

project_root <- "C:/Users/bald_local/DATA/Lehre/moer-msc-advanced-SDM/data/aSDM/"
#project_root <- Sys.getenv("PROJECT_ROOT", unset = normalizePath(getwd(), winslash = "/"))

years <- c(2026L)

base_url <- "https://opendata.dwd.de/climate_environment/CDC/grids_germany/monthly"

out_dir_raw <- file.path(project_root, "data", "dwd_raw")
out_dir_hessen <- file.path(project_root, "data", "dwd_hessen")

reference_product <- "air_temperature_mean"

skip_existing_downloads <- TRUE
overwrite_outputs <- FALSE

hessen_name_pattern <- "hess"

# Optional: subset of dwd_products$folder to process (NULL = all rows in dwd_products)
product_folders <- NULL
ev <- Sys.getenv("DWD_PRODUCT_FOLDERS", "")
if (nzchar(ev)) {
  product_folders <- trimws(strsplit(ev, ",", fixed = TRUE)[[1]])
}

# layout:
#    nested     — product/MM_Mon/grids_germany_monthly_<prefix>_YYYYMM.asc.gz
#    flat_asc   — product/grids_germany_monthly_<prefix>_YYYYMM.asc.gz
#    flat_zip   — product/grids_germany_monthly_<prefix>_YYYYMM.zip (ASCII grid inside)
dwd_products <- data.frame(
  folder = c(
    "air_temperature_mean", "air_temperature_max", "air_temperature_min",
    "precipitation", "radiation_global"
  ),
  prefix = c(
    "air_temp_mean", "air_temp_max", "air_temp_min",
    "precipitation","radiation_global"
  ),
  layout = c(
    "nested", "nested", "nested",
    "nested",    "flat_zip"
  ),
  stringsAsFactors = FALSE
)

options(timeout = max(600, getOption("timeout")))

# DHDN / 3-degree Gauss-Kruger zone 3 — used by many DWD CDC Germany grids when
# CRS metadata is missing after reading (e.g. /vsigzip/ ASCII).
default_dwd_crs <- "EPSG:31467"

# ---- helpers ----------------------------------------------------------------

ensure_dwd_crs <- function(r) {
  cr <- crs(r)
  if (is.na(cr) || !nzchar(trimws(as.character(cr)))) {
    crs(r) <- default_dwd_crs
  }
  r
}

# Some DWD products (e.g. radiation *.zip) prepend metadata before the NCOLS line.
read_ascii_strip_to_temp <- function(path) {
  lines <- if (grepl("\\.gz$", path, ignore.case = TRUE)) {
    con <- gzfile(path, "rt")
    on.exit(close(con), add = TRUE)
    readLines(con, warn = FALSE)
  } else {
    readLines(path, warn = FALSE)
  }
  i <- grep("^\\s*ncols\\b", lines, ignore.case = TRUE)[1]
  if (is.na(i)) {
    stop("No NCOLS line in ASCII grid: ", path)
  }
  tmp <- tempfile(fileext = ".asc")
  writeLines(lines[i:length(lines)], tmp)
  tmp
}

# Load ASCII into an in-memory SpatRaster so temp files can be deleted (terra keeps
# lazy file references otherwise).
rast_from_temp_asc <- function(tmp_path) {
  r <- rast(tmp_path)
  w <- wrap(r)
  unlink(tmp_path)
  terra::unwrap(w)
}

join_url <- function(...) {
  parts <- unlist(list(...))
  parts <- gsub("//+", "/", paste(parts, collapse = "/"))
  gsub("https:/", "https://", parts, fixed = TRUE)
}

month_subdir <- function(month) {
  sprintf("%02d_%s", month, month.abb[month])
}

ym <- function(year, month) {
  sprintf("%04d%02d", as.integer(year), as.integer(month))
}

years <- sort(unique(as.integer(years)))

if (length(product_folders)) {
  want <- unique(c(reference_product, product_folders))
  dwd_products <- dwd_products[dwd_products$folder %in% want, , drop = FALSE]
  if (!nrow(dwd_products)) {
    stop("product_folders did not match any rows in dwd_products.")
  }
}

load_hessen_sf <- function() {
  de <- gadm(country = "DEU", level = 1, path = tempdir(), version = "latest")
  nm <- try(de$NAME_1, silent = TRUE)
  if (inherits(nm, "try-error") || is.null(nm)) {
    nm <- de[[grep("^NAME", names(de), value = TRUE)[1]]]
  }
  i <- grepl(hessen_name_pattern, as.character(nm), ignore.case = TRUE)
  if (!any(i)) {
    stop("Could not find Hessen in GADM level-1 (DEU). Check hessen_name_pattern.")
  }
  st_as_sf(de[i, ])
}

rast_from_gz_ascii <- function(gz_path) {
  tmp <- read_ascii_strip_to_temp(gz_path)
  rast_from_temp_asc(tmp)
}

rast_from_zip_ascii <- function(zip_path) {
  td <- tempfile("dwd_unzip_")
  dir.create(td, showWarnings = FALSE, recursive = TRUE)
  utils::unzip(zip_path, exdir = td)
  asc <- list.files(td, pattern = "\\.[Aa][Ss][Cc]$", full.names = TRUE)
  if (!length(asc)) {
    asc <- list.files(td, pattern = "\\.[Gg][Rr][Dd]$", full.names = TRUE)
  }
  if (!length(asc)) {
    unlink(td, recursive = TRUE)
    stop("No .asc/.grd found in zip: ", zip_path)
  }
  if (length(asc) > 1) {
    warning("Multiple rasters in zip, using first: ", basename(asc[1]))
  }
  tmp <- read_ascii_strip_to_temp(asc[1])
  unlink(td, recursive = TRUE)
  rast_from_temp_asc(tmp)
}

dwd_build_url <- function(folder, prefix, layout, year, month) {
  fn <- sprintf("grids_germany_monthly_%s_%s", prefix, ym(year, month))
  if (layout == "nested") {
    join_url(base_url, folder, month_subdir(month), paste0(fn, ".asc.gz"))
  } else if (layout == "flat_asc") {
    join_url(base_url, folder, paste0(fn, ".asc.gz"))
  } else if (layout == "flat_zip") {
    join_url(base_url, folder, paste0(fn, ".zip"))
  } else {
    stop("Unknown layout: ", layout)
  }
}

download_if_needed <- function(url, dest, skip_if_exists) {
  dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)
  if (isTRUE(skip_if_exists) && file.exists(dest) && file.info(dest)$size > 0L) {
    return(TRUE)
  }
  st <- try(download.file(url, dest, mode = "wb", quiet = TRUE), silent = TRUE)
  if (inherits(st, "try-error") || !isTRUE(st == 0L)) {
    if(file.exists(dest)) unlink(dest)
    return(FALSE)
  }
  TRUE
}

load_month_raster <- function(local_path, layout) {
  r <- if (layout %in% c("nested", "flat_asc")) {
    rast_from_gz_ascii(local_path)
  } else if (layout == "flat_zip") {
    rast_from_zip_ascii(local_path)
  } else {
    stop("Unknown layout: ", layout)
  }
  ensure_dwd_crs(r)
}

raw_dest_path <- function(folder, year, month, layout) {
  yms <- ym(year, month)
  ext <- if (layout == "flat_zip") ".zip" else ".asc.gz"
  file.path(out_dir_raw, folder, paste0(yms, ext))
}

align_to_template <- function(r, template) {
  project(r, template)
}

crop_mask_hessen <- function(r, hessen_sf) {
  hv <- vect(st_transform(hessen_sf, crs(r)))
  mask(crop(r, hv), hv)
}

mid_month_doy <- function(month) {
  as.integer(format(as.Date(sprintf("2001-%02d-15", month)), "%j"))
}

latitude_raster <- function(template) {
  n <- ncell(template)
  xy <- xyFromCell(template, seq_len(n))
  pts <- st_as_sf(
    data.frame(x = xy[, 1], y = xy[, 2]),
    coords = c("x", "y"),
    crs = crs(template)
  )
  pts <- st_transform(pts, "EPSG:4326")
  lat <- st_coordinates(pts)[, 2]
  setValues(template, lat)
}

photoperiod_stack <- function(lat_template, template, name_year) {
  months <- 1:12
  doys <- vapply(months, mid_month_doy, integer(1))
  latv <- values(lat_template)
  layers <- vector("list", 12L)
  for (i in seq_along(months)) {
    dl <- geosphere::daylength(latv, doys[i])
    layers[[i]] <- setValues(template, dl)
  }
  r <- rast(layers)
  names(r) <- sprintf("photoperiod_hours_%04d-%02d", name_year, months)
  r
}

photoperiod_delta <- function(ph_stack, circular_wrap = FALSE, name_year) {
  out <- ph_stack * NA
  for (i in 2:12) {
    out[[i]] <- ph_stack[[i]] - ph_stack[[i - 1]]
  }
  if (isTRUE(circular_wrap)) {
    out[[1]] <- ph_stack[[1]] - ph_stack[[12]]
  }
  names(out) <- sprintf("photoperiod_delta_hours_%04d-%02d", name_year, 1:12)
  out
}

process_product_year <- function(folder, prefix, layout, year, hessen_sf, template, skip_dl) {
  layers <- list()
  avail_months <- c()
  for (month in 1:12) {
    url <- dwd_build_url(folder, prefix, layout, year, month)
    dest <- raw_dest_path(folder, year, month, layout)
    
    success <- download_if_needed(url, dest, skip_if_exists = skip_dl)
    
    if (success) {
      r <- try(load_month_raster(dest, layout), silent = TRUE)
      if (!inherits(r, "try-error")) {
        r <- crop_mask_hessen(r, hessen_sf)
        r <- align_to_template(r, template)
        layers[[length(layers) + 1]] <- r
        avail_months <- c(avail_months, month)
      }
    }
  }
  
  if (length(layers) == 0) return(NULL)
  
  stk <- rast(layers)
  names(stk) <- sprintf("%s_%04d-%02d", folder, year, avail_months)
  stk
}

# ---- main -------------------------------------------------------------------

dir.create(out_dir_raw, recursive = TRUE, showWarnings = FALSE)
dir.create(out_dir_hessen, recursive = TRUE, showWarnings = FALSE)

message("Loading Hessen boundary (GADM)...")
hessen_sf <- load_hessen_sf()

if (!reference_product %in% dwd_products$folder) {
  stop("reference_product must be one of dwd_products$folder")
}
pref <- dwd_products[dwd_products$folder == reference_product, , drop = FALSE]

message("Building template from ", reference_product, " (", years[1], "-01)...")
ref_url <- dwd_build_url(pref$folder[1], pref$prefix[1], pref$layout[1], years[1], 1L)
ref_dest <- raw_dest_path(pref$folder[1], years[1], 1L, pref$layout[1])

# Modified template creation to ensure we have a fallback if Jan 2026 isn't out yet
template_success <- download_if_needed(ref_url, ref_dest, skip_if_exists = skip_existing_downloads)
if(!template_success) stop("Template month (January of first year) not available. Year might not have started yet.")

ref_r <- load_month_raster(ref_dest, pref$layout[1])
template <- crop_mask_hessen(ref_r, hessen_sf)

lat_r <- latitude_raster(template)
ph <- photoperiod_stack(lat_r, template, years[1])
ph_d <- photoperiod_delta(ph, circular_wrap = FALSE, years[1])

photo_dir <- file.path(out_dir_hessen, "photoperiod")
dir.create(photo_dir, showWarnings = FALSE, recursive = TRUE)
ph_path <- file.path(photo_dir, "photoperiod_hours.tif")
phd_path <- file.path(photo_dir, "photoperiod_delta_hours.tif")

if (!file.exists(ph_path) || isTRUE(overwrite_outputs)) {
  writeRaster(ph, ph_path, overwrite = TRUE, gdal = c("COMPRESS=DEFLATE", "TILED=YES"))
  message("Wrote ", ph_path)
} else {
  message("Skip (exists): ", ph_path)
}
if (!file.exists(phd_path) || isTRUE(overwrite_outputs)) {
  writeRaster(ph_d, phd_path, overwrite = TRUE, gdal = c("COMPRESS=DEFLATE", "TILED=YES"))
  message("Wrote ", phd_path)
} else {
  message("Skip (exists): ", phd_path)
}

for (year in years) {
  ydir <- file.path(out_dir_hessen, as.character(year))
  dir.create(ydir, showWarnings = FALSE, recursive = TRUE)
  
  for (k in seq_len(nrow(dwd_products))) {
    folder <- dwd_products$folder[k]
    prefix <- dwd_products$prefix[k]
    layout <- dwd_products$layout[k]
    
    out_tif <- file.path(ydir, paste0(folder, ".tif"))
    if (file.exists(out_tif) && !isTRUE(overwrite_outputs)) {
      message("Skip (exists): ", out_tif)
      next
    }
    
    message("Processing ", folder, " ", year, " ...")
    stk <- process_product_year(folder, prefix, layout, year, hessen_sf, template, skip_existing_downloads)
    
    if (is.null(stk)) {
      message("No data available for ", folder, " in year ", year)
      next
    }
    
    writeRaster(stk, out_tif, overwrite = TRUE, gdal = c("COMPRESS=DEFLATE", "TILED=YES"))
    message("Wrote ", out_tif)
  }
}

message("Done. Cropped stacks: ", out_dir_hessen, "; photoperiod: ", photo_dir)
```

[![](/assets/images/teaserimages/unit05/precipitation.png)](https://doi.org/10.1007/978-3-030-97540-1_7)

#### Additional Environmental Variables

Beyond meteorological data, incorporating diverse environmental datasets can enhance the predictive power of an SDM or a calling probability model. High-resolution remote sensing data, in particular, is increasingly used to capture habitat characteristics ([Regos et al. 2022](https://doi.org/10.1002/rse2.255), [Randin et al. 2020](https://doi.org/10.1016/j.rse.2019.111626)).

Key environmental variables can be derived from the following sources:
* **LiDAR Data:** Used to quantify forest structure, including canopy height, vertical complexity, and understory density.
* **Optical Remote Sensing:** Satellite imagery provides spectral indices such as the Normalized Difference Vegetation Index (NDVI) to monitor vegetation health and phenology.
* **Land Use Classifications:** Useful for identifying specific habitat types, such as mixed forests, grasslands, or urbanized areas.
* **Digital Elevation Models (DEM):** Provide information on altitude, slope, and aspect, which affect local microclimates and species preferences.

If you wish to further refine your model, you may consider adding specific predictors such as NDVI derived from Landsat or Sentinel-2 data to account for seasonal changes in vegetation.


## Creating a space-time dataframe

This exercise is a little bit different then the exemplary workflow in [Unit 03]({{ '/units/unit03/unit03-00_overview.html' | relative_url }}) as we will not only predict general species distribution but calling probability at different times. This also means we need to do different data preprocessing as we need a dataframe with space-time information for model training. Furthermore, we also need to generate some kind of background information. Here we will use 10,000 randomly distributed background points for simplicity sake.

```r 
setwd("C:/Users/bald_local/DATA/Lehre/moer-msc-advanced-SDM/data/aSDM/")

library("dplyr")
library(terra)      # For raster handling
library(predicts)   # For background point sampling
library(sf)         # For spatial data frames
library(tidyverse)  # For data manipulation (dplyr, tidyr, stringr, purrr)
library(lubridate)
library(ggplot2)


data = sf::read_sf("data/gartenrotschwanz_full_data.gpkg")%>% rename(geometry = geom)


# Drop the geometry temporarily to speed up non-spatial grouping
data_summary <- data %>%
 # st_drop_geometry() %>%
  mutate(day = floor_date(time, "day")) %>%
  group_by(day, species, station) %>%
  summarise(
    n_detections = n(),
    mean_confidence = mean(confidence, na.rm = TRUE),
    .groups = "drop"
  )


library(quantreg)


q10 = quantile(data_summary$mean_confidence, probs = seq(0, 1, 0.1))[2][[1]]
y0 <- q10 # Your asymptote (the 10th percentile baseline)
a  <- 1 - q10 # The maximum penalty for n=1
med_n <- median(data_summary$n_detections) # The "pivot point" of your data
med_n<- quantile(data_summary$n_detections, 0.25)[[1]]
b_auto <- log(2) / med_n
# Define the threshold function
# As n increases, the required confidence drops toward 0.4
# $$C_{min}(n) = y_0 + a \cdot e^{-b \cdot n}$$$y_0$ (Asymptote): 
#The baseline confidence you'd accept even if you have 10,000 detections (e.g., 0.42 based on your trend line).
#$a$ (Penalty): How much extra confidence you require for a single detection.
#$b$ (Decay): How fast you "forgive" the confidence requirement as more detections come in.



# 3. Define the automated function
threshold_curve <- function(n) {
  y0 + a * exp(-b_auto * n)
}

threshold_curve <- function(n) {
  q10 + (1-q10) * exp(-0.3 * n)
}

# Apply to your data
data_summary <- data_summary %>%
  mutate(
    req_confidence = threshold_curve(n_detections),
    is_reliable = mean_confidence >= req_confidence
  )


ggplot(data_summary, aes(x = n_detections, y = mean_confidence)) +
  geom_point(aes(color = is_reliable), alpha = 0.5) +
 # facet_wrap(~station)+
  scale_x_log10() +
  stat_function(fun = threshold_curve, color = "black", linewidth = 1, linetype = "dashed") +
  theme_minimal() +
  labs(title = "Exponential Filtering",
       subtitle = "Points above the dashed line are included")


data = data_summary%>%dplyr::filter(is_reliable == T);rm(data_summary)

sf::write_sf(data, "data/phoenicurus_phoenicurus_filtered_data.gpkg")


```

To filter the raw data we will use an exponential decay funtion that gradually filters out points with low confidence or with middle to low confidence and very little detections per day.


![](../assets/images/unit05/filtering.png)



### Creating a space time dataframe

Now we will create a dataframe with the extracted environmental data that contains information for each day. For each step in time we will also have one background dataset with 10,000 background points each.

```r
setwd("C:/Users/bald_local/DATA/Lehre/moer-msc-advanced-SDM/data/aSDM/")

library("dplyr")
library(terra)      # For raster handling
library(predicts)   # For background point sampling
library(sf)         # For spatial data frames
library(tidyverse)  # For data manipulation (dplyr, tidyr, stringr, purrr)
library(lubridate)
library(ggplot2)


data = sf::read_sf("data/phoenicurus_phoenicurus_filtered_data.gpkg")%>% rename(geometry = geom)
data <- data %>%
  select(day,  station, geometry) %>%
  rename(time = day) %>%
  mutate(
    year  = year(time),
    month = month(time),
    day   = day(time),
    presence=1
  ) %>% sf::st_transform( sf::st_crs("EPSG:25832"))

#load the previously downloaded environmental variables

r=list.files("data/hyras_hessen/", pattern = "*.tif$", full.names = TRUE,
             recursive = TRUE)
r=terra::rast(r)

# Sample background points
bg = predicts::backgroundSample(mask = r[[1]], n = 10000)
bg = data.frame(bg)
bg = bg %>%
  sf::st_as_sf(coords = c("x", "y"), crs = st_crs(r)) %>% 
  dplyr::mutate(presence = 0,station="bg")

# Get unique year/month pairs from your data
time_combos <- data %>%
  st_drop_geometry() %>%
  distinct(time, day, month, year)

# Create the cross-join (Every point x Every time step)
# This will result in (10,000 points * N time steps) rows
bg_expanded <- bg %>%
  cross_join(time_combos)



bg_expanded=sf::st_transform(bg_expanded, sf::st_crs("EPSG:25832"))

data = rbind(data,bg_expanded);rm(bg_expanded, bg, time_combos)

data = sf::st_transform(data, crs=terra::crs(r))

ext_matrix <- terra::extract(r, data, ID = FALSE)

# 2. Map the variables and dates
# Raster layer names look like: "air_temp_mean_20260322"
layer_names <- names(r)
# Extract the date part (YYYYMMDD) and the variable name part
raster_dates <- str_extract(layer_names, "\\d{8}$")
raster_vars  <- str_remove(layer_names, "_\\d{8}$")

# Unique variables (air_temp_max, air_temp_mean, photoperiod, precipitation)
unique_vars <- unique(raster_vars)

# 3. Match the 'data' dates to the 'raster' dates
# Create a YYYYMMDD string for each row in your data
data_date_strings <- format(data$time, "%Y%m%d")

# 4. Extract only the matching cells for each variable
# This loop avoids pivoting by pulling values directly from the extraction matrix
for(v in unique_vars) {
  message("Aligning variable: ", v)
  
  # Find which columns in 'ext_matrix' belong to this variable
  var_cols <- which(raster_vars == v)
  sub_matrix <- ext_matrix[, var_cols]
  colnames(sub_matrix) <- raster_dates[var_cols]
  
  # For each row in data, pick the column in the sub_matrix that matches data_date_strings
  # We use matrix indexing [row_index, col_index] for speed
  col_indices <- match(data_date_strings, colnames(sub_matrix))
  
  # Assign to data (using row/col indexing)
  data[[v]] <- sub_matrix[cbind(seq_len(nrow(data)), col_indices)]
}


# Remove the heavy matrix from memory
rm(ext_matrix)

sf::write_sf(data, "data/trainingData.gpkg")

```

---

### References (Work in Progress)
**Darras, K., et al.** (2019). Sampling birds with combined hygrometers and acoustic recorders. *Scientific Reports*.
**Shonfield, J., & Bayne, E. M.** (2017). Autonomous recording units in avian ecological research: current use and future applications. *The Condor*.


- Mapping the calling probability of common 

- seasonal accoustic patterns of birds in germany: https://link.springer.com/article/10.1007/s10336-025-02307-y

