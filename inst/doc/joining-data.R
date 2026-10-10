## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 4.2,
  # Sharp figures on the website; small ones in the CRAN package.
  dpi = if (identical(Sys.getenv("IN_PKGDOWN"), "true")) 200 else 96,
  eval = rlang::is_installed("ggplot2")
)

## ----setup--------------------------------------------------------------------
library(mongolmaps)

## ----small--------------------------------------------------------------------
cases <- data.frame(
  aimag = c("Khovsgol", "Hovd", "\u0423\u0432\u0441", "Ulan Bator", "Dornogobi"),
  cases = c(12, 30, 7, 140, 9)
)
cases_map <- mn_join(cases, by = aimag)
cases_map[c("name", "cases")]

## ----small-map----------------------------------------------------------------
mn_map(cases_map, fill = cases)

## ----nso----------------------------------------------------------------------
head(mn_example_population)

pop_2025 <- mn_example_population[mn_example_population$Year == 2025, ]
aimag_pop <- mn_join(pop_2025, by = "Region", level = "aimag")
mn_map(aimag_pop, fill = value / area_km2, title = "People per km2, 2025")

## ----soums--------------------------------------------------------------------
soum_pop <- mn_join(pop_2025, by = "Region", level = "soum")
mn_map(soum_pop, fill = log10(value), title = "Soum population (log10), 2025")

## ----facets, fig.height = 6---------------------------------------------------
pop_years <- mn_join(mn_example_population, by = "Region", level = "aimag")
mn_map(pop_years, fill = value / 1000) + ggplot2::facet_wrap(~Year, ncol = 2)

## ----parent-------------------------------------------------------------------
soums <- data.frame(
  aimag = c("Dornod", "Govi-Altai", "Khentii"),
  soum = c("Bayan-Uul", "Bayan-Uul", "Bayan-Adarga"),
  herders = c(820, 640, 910)
)
joined <- mn_join(soums, by = "soum", level = "soum", by_parent = "aimag")
joined[!is.na(joined$herders), c("name", "aimag_pcode", "herders")]

## ----mongolstats, eval = FALSE------------------------------------------------
# library(mongolstats)
# tbl <- "DT_NSO_0300_002V4"
# regions <- nso_dim_values(tbl, "Region")$code
# years <- nso_dim_values(tbl, "Year", labels = "en")
# latest <- years$code[1]
# pop <- nso_data(tbl, selections = list(Region = regions, Year = latest), labels = "en")
# mn_map(mn_join(pop, by = "Region", level = "aimag"), fill = value)

## ----check--------------------------------------------------------------------
mn_match(c("Khovd", "Hovd", "Kobdo", "Jargalant"), to = "name_en")

