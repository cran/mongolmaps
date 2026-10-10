## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 5,
  # Sharp figures on the website; small ones in the CRAN package.
  dpi = if (identical(Sys.getenv("IN_PKGDOWN"), "true")) 200 else 96,
  eval = rlang::is_installed("ggplot2")
)

## ----setup--------------------------------------------------------------------
library(mongolmaps)

## ----levels-------------------------------------------------------------------
mn_ub()
mn_ub_districts()
mn_khoroos()

## ----districts----------------------------------------------------------------
mn_map(mn_ub_districts(), fill = name, label = TRUE)

## ----central------------------------------------------------------------------
central <- c("Bayangol", "Bayanzurkh", "Chingeltei", "Khan-Uul", "Songinokhairkhan", "Sukhbaatar")
mn_map(mn_khoroos(district = central), fill = parent_pcode)

## ----abbrev-------------------------------------------------------------------
mn_khoroos(district = "\u0411\u0417\u0414")

## ----khoroos------------------------------------------------------------------
mn_map(mn_khoroos(district = "Sukhbaatar"), fill = area_km2, label = TRUE)

## ----match--------------------------------------------------------------------
mn_match("15-r khoroo", level = "bag", within = "Bayangol")
mn_match("Bayangol 15")

## ----join, fig.height = 5.5---------------------------------------------------
pop <- mn_example_population[mn_example_population$Year == 2025, ]
khoroo_pop <- mn_join(pop, by = "Region", level = "bag", within = "Ulaanbaatar")

mn_map(
  khoroo_pop[khoroo_pop$parent_pcode %in% c("MN1107", "MN1119", "MN1125"), ],
  fill = value / area_km2,
  title = "People per km2: Bayangol, Sukhbaatar and Chingeltei"
)

## ----leaflet, eval = FALSE----------------------------------------------------
# mn_leaflet(khoroo_pop, fill = value)

