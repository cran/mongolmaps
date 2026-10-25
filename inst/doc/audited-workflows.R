## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", fig.width = 7, fig.height = 4.5)

## ----setup--------------------------------------------------------------------
library(mongolmaps)

## ----scoped-------------------------------------------------------------------
district <- mn_join(
  data.frame(place = "Bayangol", cases = 12),
  "place", level = "soum", within = "Ulaanbaatar"
)
mn_join_audit(district)[c("row", "x", "pcode", "status", "action")]

## ----strict-------------------------------------------------------------------
observations <- data.frame(
  place = c("Uvs", "Uvs", "Khovd", "Khovd"),
  Year = c(2024, 2025, 2024, 2025),
  cases = c(10, 12, 20, 15)
)
joined <- mn_join(observations, "place", level = "aimag",
                  strata = "Year", strict = TRUE, fuzzy = FALSE)
mn_join_audit(joined)[c("row", "status", "action")]

## ----ub-----------------------------------------------------------------------
table <- data.frame(
  Region = c("5", "511", "5", "511"),
  Month = c("July", "July", "August", "August"),
  value = c(10, NA, NA, 20)
)
capital <- mn_join(table, "Region", level = "aimag",
                   strata = "Month", value_cols = "value")
sf::st_drop_geometry(capital[capital$pcode == "MN11", c("Month", "value")])
mn_join_audit(capital)[c("row", "x", "action")]

## ----provenance---------------------------------------------------------------
mn_vintages()[c("id", "data_version", "geometry_vintage", "authority")]
mn_provenance(mn_khoroos())[c("id", "source_revision", "effective_date")]
mn_citation(mn_settlements())

## ----comparison, eval=rlang::is_installed("ggplot2")--------------------------
mn_map(joined, fill = cases, limits = c(0, 25), breaks = c(0, 10, 20)) +
  ggplot2::facet_wrap(~Year)

## ----inset, eval=rlang::is_installed(c("ggplot2","patchwork"))----------------
pop <- mn_example_population[mn_example_population$Year == 2025, ]
aimags <- mn_join(pop, "Region", level = "aimag")
mn_inset_ub(aimags, fill = value, trans = "log10",
            title = "Population, 2025")

## ----urban, eval=rlang::is_installed(c("ggplot2","patchwork"))----------------
mn_map_ub(fill = area_km2, title = "District areas")

## ----grid, eval=rlang::is_installed(c("ggplot2","geofacet"))------------------
grid <- mn_ub_grid
grid$value <- seq_len(nrow(grid))
ggplot2::ggplot(grid, ggplot2::aes(1, value)) +
  ggplot2::geom_col() +
  geofacet::facet_geo(~code, grid = mn_ub_grid, label = "name")

## ----cartogram, eval=FALSE----------------------------------------------------
# # Optional package: install.packages("cartogram")
# # For health rates, prepare compatible numerators and denominators separately.
# analysis_map <- sf::st_transform(aimags, mn_crs("albers"))
# analysis_map$people_per_km2 <- analysis_map$value / analysis_map$area_km2
# display_map <- cartogram::cartogram_dorling(analysis_map, weight = "value")
# mn_map(display_map, fill = people_per_km2)

## ----assets-------------------------------------------------------------------
assets <- mn_assets()
assets[assets$id == "worldpop_2025_1km", c("id", "year", "resolution", "url")]

## ----offline, eval=FALSE------------------------------------------------------
# mn_download(c("admin_high", "worldpop_2025_1km"))
# mn_cache_verify()
# options(mongolmaps.offline = TRUE)

