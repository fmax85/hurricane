#' Ike storm data
#'
#' Data for the Ike storm of 2008. The tabulated data contained in this dataset
#' were refactored from the cited source
#'
#' @docType data
#'
#' @usage data(grav)
#'
#' @format An object of class \code{"tbl_df"} with 174 rows and 9 variables:
#' \itemize{
#'   \item \code{storm_id}: storm name
#'   \item \code{date}: date of data record
#'   \item \code{latitude}: latitude of the recorded storm center
#'   \item \code{longitude}: longitude of the recorded storm center
#'   \item \code{wind_speed}: wind speed [knot]
#'   \item \code{ne}: maximum radial extent of the wind in the NE quadrant [mile]
#'   \item \code{nw}: maximum radial extent of the wind in the NW quadrant [mile]
#'   \item \code{se}: maximum radial extent of the wind in the SE quadrant [mile]
#'   \item \code{sw}: maximum radial extent of the wind in the SW quadrant [mile]
#' }
#'
#' @keywords datasets
#'
#' @source \href{http://rammb.cira.colostate.edu/research/tropical_cyclones/tc_extended_best_track_dataset/}{EBTD Archive}
#'
#' @examples
#' data(ike)
#' events <- unique(ike$date)
"ike"
