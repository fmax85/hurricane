#' Hurricane
#'
#' \code{geom_hurricane} is a special implementation of \link[ggplot2]{geom_polygon}.
#' It is developed to draw the regions of a storm observation corresponding
#' to the same wind speed level, for the four quadrants defined by an origin
#' point. The contour of the "iso-speed" levels are connected by a `polygon`
#' grid object.
#'
#' @seealso
#'  \link[ggplot2]{geom_polygon} for generic polygon
#'
#' @inheritParams ggplot2::geom_polygon
#'
#' @section Aestethics:
#' \code{geom_hurricane} understands the following aesthetics (required in bold):
#' \itemize{
#'   \item \strong{x}: longitude
#'   \item \strong{y}: latitude
#'   \item \strong{r_ne}: wind radius for the NE quadrant, in nautical miles
#'   \item \strong{r_se}: wind radius for the SE quadrant, in nautical miles
#'   \item \strong{r_nw}: wind radius for the SW quadrant, in nautical miles
#'   \item \strong{r_sw}: wind radius for the NW quadrant, in nautical miles
#'   \item colour: (see \link[ggplot2]{geom_polygon})
#'   \item fill: (see \link[ggplot2]{geom_polygon})
#'   \item size: (see \link[ggplot2]{geom_polygon})
#'   \item linetype: (see \link[ggplot2]{geom_polygon})
#'   \item alpha: (see \link[ggplot2]{geom_polygon})
#'   \item scale_radii: scaling factor of the wind radius dimensions
#' }
#'
#' @examples
#' # When using `geom_hurricane`, you will typically need a storm
#' # observation data frame, with specific columns. You can find a
#' # test dataset along with this package named `ike`. Consider
#' # the following code as a test example:
#'
#' \dontrun{
#' library(ggplot2)
#'
#' ike_1 <- ike %>% dplyr::filter(latitude > 29 & latitude < 30)
#' map_plot <- ggmap::get_map("Lousiana", zoom = 6, maptype = "toner-background", source = "stamen")
#' map <- map_plot %>% ggmap::ggmap(extent = "device") +
#' geom_hurricane(data = ike_1, mapping = aes(x = longitude, y = latitude, r_ne = ne, r_se = se, r_sw = sw,
#'                                            r_nw = nw, fill = wind_speed, colour = wind_speed, scale_radii = 0.4)) +
#' scale_color_manual(name = "Wind speed (kts)", values = c("red", "orange", "yellow")) +
#' scale_fill_manual(name = "Wind speed (kts)", values = c("red", "orange", "yellow"))
#'
#' map
#' }
#'
#' @export
geom_hurricane <- function(
    mapping = NULL, data = NULL, position = "identity", na.rm = FALSE, show.legend = NA,
    inherit.aes = TRUE, ...) {
    ggplot2::layer(stat = StatHurricane, geom = GeomHurricane, data = data, mapping = mapping,
                   position = position, show.legend = show.legend, inherit.aes = inherit.aes,
                   params = list(na.rm = na.rm, ...)
    )
}

#' @rdname ggplot2-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomHurricane <- ggplot2::ggproto(
    "GeomHurricane", ggplot2::GeomPolygon,
    default_aes = ggplot2::aes(colour = NA, fill = NA, size = 0.5, linetype = 1, alpha = 0.65)
)
#
#
