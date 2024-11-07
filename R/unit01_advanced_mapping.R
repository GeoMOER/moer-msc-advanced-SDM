library(terra)


url="https://data.geo.admin.ch/ch.bag.zeckenstichmodell/zeckenstichmodell/zeckenstichmodell_2056.tif.zip"
file_path="C:/DATA/Lehre/moer-msc-advanced-SDM/data/"
file_name <- "zeckenstichmodell_2056.tif.zip"

# Call the download.file() function, passing in the URL and file name/location as arguments
download.file(url, paste(file_path, file_name, sep = ""), mode = "wb")
# unzip the file
unzip(paste0(file_path, file_name), exdir=file_path)

# load file into r with the terra package and plot
r=terra::rast(paste0(file_path, "ch.bag.zeckenstichmodell_2056.tif"))
terra::plot(r)

library(tidyterra)
library(ggplot2)

ggplot() +
  geom_spatraster(data = r) +
  facet_wrap(~lyr) 


library(ggspatial)

ggplot() +
  geom_spatraster(data = r) +
 # facet_wrap(~lyr, ncol = 4) +
  scale_fill_whitebox_c(
    palette = "muted",
    #limits=c(0,1),
    labels = scales::label_number(suffix = ""),
    n.breaks = 12,
    guide = guide_legend(reverse = TRUE)
  ) + theme_minimal() + ylim(1040000, 1296000)+
  labs(
    fill = "",
    title = "Risk of tick attachment to humans",
    #subtitle = 
  )+
  annotation_north_arrow(
    which_north = TRUE,
    pad_x = unit(0.8, "npc"),
    pad_y = unit(0.75, "npc"),
    height = unit(2, "cm"),
    width = unit(2, "cm"),
    style = north_arrow_fancy_orienteering(text_size =1, text_col = "white",)
  ) +
  annotation_scale(
    height = unit(0.025, "npc"),
    # bar_cols="black",
    width_hint = 0.5,
    pad_x = unit(0.07, "npc"),
    pad_y = unit(0.07, "npc"),
    text_cex = .7
  )

