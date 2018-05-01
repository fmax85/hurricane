#' Hurricane
#'
#' \code{stat_hurricane} computes a specific data frame of coordinates required
#' by \link{geom_hurricane}. It contains the geographical points corresponding
#' to the four quarters of circle, specified by the origin point of the storm
#' and the wind radii in the four quadrants, for each wind speed level.
#' The \link[geosphere]{destPoint} function is adopted to generate the points
#' representing the quarters of circles.
#'
#' @seealso
#'  \link{geom_hurricane}
#'
#' @examples
#' # When using `stat_hurricane`, you will typically need a storm
#' # observation data frame, with specific columns. You can find a
#' # test dataset along with this package named `ike`. Consider
#' # the following code as a test example:
#'
#' \dontrun{
#' library(ggplot2)
#'
#' ike_1 <- ike %>% dplyr::filter(latitude > 29 & latitude < 30)
#' plot <- ggplot(data = ike_1, mapping = aes(x = longitude, y = latitude)) +
#' stat_hurricane(mapping = aes(x = longitude, y = latitude, r_ne = ne,mr_se = se, r_sw = sw,
#'                              r_nw = nw, colour = wind_speed), alpha = 0) +
#' theme_minimal()
#' }
#'
#' @export
stat_hurricane <- function(
    mapping = NULL, data = NULL, geom = "polygon", position = "identity", na.rm = FALSE, show.legend = NA,
    inherit.aes = TRUE, ...) {
    ggplot2::layer(stat = StatHurricane, data = data, mapping = mapping, geom = geom,
                   position = position, show.legend = show.legend, inherit.aes = inherit.aes,
                   params = list(na.rm = na.rm, ...)
    )
}

#' @rdname ggplot2-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatHurricane <- ggplot2::ggproto(
    "StatHurricane", ggplot2::Stat,
    required_aes = c("x", "y", "r_ne", "r_se", "r_sw", "r_nw"),
    default_aes = ggplot2::aes(x = NULL, y = NULL, r_ne = NULL, r_se = NULL, r_sw = NULL, r_nw = NULL,
                               scale_radii = 1.0),
    compute_group = function(data, scales) {
        eye <- c( mean(data$x), mean(data$y) )
        scale <- data[1,]$scale_radii
        if(is.null(scale)) {scale = 1.0}
        xne <- geosphere::destPoint(eye, b = seq(  0,  90, length.out = 21), d = data[1,]$r_ne*1852.0*scale)
        xnw <- geosphere::destPoint(eye, b = seq(270, 360, length.out = 21), d = data[1,]$r_nw*1852.0*scale)
        xse <- geosphere::destPoint(eye, b = seq( 90, 180, length.out = 21), d = data[1,]$r_se*1852.0*scale)
        xsw <- geosphere::destPoint(eye, b = seq(180, 270, length.out = 21), d = data[1,]$r_sw*1852.0*scale)
        df_34 <- as.data.frame(rbind(xne, xse, xsw, xnw))
        colnames(df_34) <- c("x", "y")
        df_34["wind"] <- NA
        df_34$wind <- 34
        xne <- geosphere::destPoint(eye, b = seq(  0,  90, length.out = 21), d = data[2,]$r_ne*1852.0*scale)
        xse <- geosphere::destPoint(eye, b = seq( 90, 180, length.out = 21), d = data[2,]$r_se*1852.0*scale)
        xsw <- geosphere::destPoint(eye, b = seq(180, 270, length.out = 21), d = data[2,]$r_sw*1852.0*scale)
        xnw <- geosphere::destPoint(eye, b = seq(270, 360, length.out = 21), d = data[2,]$r_nw*1852.0*scale)
        df_50 <- as.data.frame(rbind(xne, xse, xsw, xnw))
        colnames(df_50) <- c("x", "y")
        df_50["wind"] <- NA
        df_50$wind <- 50
        xne <- geosphere::destPoint(eye, b = seq(  0,  90, length.out = 21), d = data[3,]$r_ne*1852.0*scale)
        xse <- geosphere::destPoint(eye, b = seq( 90, 180, length.out = 21), d = data[3,]$r_se*1852.0*scale)
        xsw <- geosphere::destPoint(eye, b = seq(180, 270, length.out = 21), d = data[3,]$r_sw*1852.0*scale)
        xnw <- geosphere::destPoint(eye, b = seq(270, 360, length.out = 21), d = data[3,]$r_nw*1852.0*scale)
        df_64 <- as.data.frame(rbind(xne, xse, xsw, xnw))
        colnames(df_64) <- c("x", "y")
        df_64["wind"] <- NA
        df_64$wind <- 64
        df <- rbind(df_34, df_50, df_64)
        df$wind <- as.factor(df$wind)
        df
    }
)
#
#
