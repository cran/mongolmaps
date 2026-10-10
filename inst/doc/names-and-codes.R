## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## ----setup--------------------------------------------------------------------
library(mongolmaps)

## ----codes--------------------------------------------------------------------
mn_codes("aimag")
mn_codes("bag", within = "Baganuur")

## ----match--------------------------------------------------------------------
mn_match(c("Khuvsgul", "Hovsgol", "Kh\u00f6vsg\u00f6l", "\u0425\u04e9\u0432\u0441\u0433\u04e9\u043b", "MN-041", "267"))
mn_match(c("MN84", "MN8401"), to = "name_mn")

## ----hints--------------------------------------------------------------------
mn_match(c("Sukhbaatar", "Sukhbaatar district", "Sukhbaatar soum"), within = c(NA, NA, "Selenge"))

## ----typo---------------------------------------------------------------------
mn_match("Ulanbaatr")

## ----ambiguous----------------------------------------------------------------
mn_match("Bayan-Uul", level = "soum")
mn_match("Bayan-Uul", level = "soum", within = "Dornod")

## ----translit-----------------------------------------------------------------
x <- c("\u04e8\u0432\u04e9\u0440\u0445\u0430\u043d\u0433\u0430\u0439", "\u0421\u04af\u0445\u0431\u0430\u0430\u0442\u0430\u0440")
mn_translit(x)
mn_translit(x, to = "nso")

