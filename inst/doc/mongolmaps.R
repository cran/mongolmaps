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

## ----levels-------------------------------------------------------------------
mn_aimags()

## ----filter-------------------------------------------------------------------
mn_soums(aimag = "Khovd")
mn_aimags(region = "Western")

## ----map-soums----------------------------------------------------------------
mn_map(mn_soums(aimag = c("Khovd", "Uvs", "Bayan-Ulgii")), fill = aimag_pcode, label = TRUE)

## ----map-add------------------------------------------------------------------
library(ggplot2)
mn_map(mn_aimags()) +
  geom_sf(data = mn_settlements(type = c("capital", "aimag_centre")), colour = "firebrick") +
  labs(title = "Aimag centres")

## ----map-context--------------------------------------------------------------
mn_map(mn_regions(), fill = name, context = TRUE)

## ----crs----------------------------------------------------------------------
mn_aimags(crs = "albers")

## ----mongolian----------------------------------------------------------------
mn_map(mn_aimags(lang = "mn"), label = TRUE, lang = "mn")

## ----high, eval = FALSE-------------------------------------------------------
# mn_soums(aimag = "Khovd", resolution = "high")

## ----sources------------------------------------------------------------------
mn_sources()[c("id", "provider", "license")]

