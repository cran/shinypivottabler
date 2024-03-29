library(shiny)
library(shinypivottabler)
library(pivottabler)
library(data.table)
library(rmarkdown)

data <- data.table(bhmtrains)

data[, ArrivalDelta := as.numeric(difftime(ActualArrival, GbttArrival, units = "mins"))]
data[, DepartureDelta := as.numeric(difftime(ActualDeparture, GbttDeparture, units = "mins"))]

data[, Year := year(OriginGbttDeparture)]
data[, Month := month(OriginGbttDeparture)]

data <- data[!is.na(SchedSpeedMPH)]

data[, c("GbttArrival", "ActualArrival", "GbttDeparture", "ActualDeparture",
         "OriginGbttDeparture", "OriginActualDeparture", "DestinationGbttArrival", "DestinationActualArrival") := NULL]



theme <- list(
  fontName="arial",
  fontSize="1em",
  headerBackgroundColor = "#430838",
  headerColor = "#FFFFFF",
  cellBackgroundColor = "#FFFFFF",
  cellColor = "#000000",
  outlineCellBackgroundColor = "#C0C0C0",
  outlineCellColor = "#000000",
  totalBackgroundColor = "#e6e6e6",
  totalColor = "#000000",
  borderColor = "#000000"
)


additional_expr_num = list(
  "Median" = "paste0('median(', target, ', na.rm = TRUE)')"
)

getmode <- function(x) names(which.max(table(x)))

additional_expr_char = list(
  "Mode" = "paste0('getmode(', target, ')')"
)

additional_combine = c("Modulo" = "%%")


initialization <- list(
  "rows" = c("TOC", "Status"),
  "cols" = "TrainCategory",
  "target" = NULL,
  "idc" = NULL,
  "combine_target" = NULL,
  "combine_idc" = NULL,
  "combine" = NULL,
  "idcs" = c(
    list(
      # simple
      c("label" = "status", "target" = "ServiceId", "idc" = "Count")
    )
  )
)

