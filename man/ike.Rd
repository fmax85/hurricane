\name{ike}
\alias{ike}
\docType{data}
\title{Ike storm data}
\description{Data for the Ike storm of 2008. The tabulated data contained in this dataset
were refactored from the cited source. The source code used to generate this dataset can be found in \code{resource\\data_cleaner.R}.}
\usage{data("ike")}
\format{
  A data frame with 174 observations on the following 9 variables.
  \describe{
    \item{\code{storm_id}}{\strong{character}: storm name}
    \item{\code{date}}{\strong{character}: date of data record}
    \item{\code{latitude}}{\strong{numeric}: latitude of the recorded storm eye}
    \item{\code{longitude}}{\strong{numeric}: longitude of the recorded storm eye}
    \item{\code{wind_speed}}{\strong{character}: wind speed, in knots}
    \item{\code{ne}}{\strong{numeric}: maximum radial extent of the wind in the NE quadrant, in nautical miles}
    \item{\code{nw}}{\strong{numeric}: maximum radial extent of the wind in the NW quadrant, in nautical miles}
    \item{\code{se}}{\strong{numeric}: maximum radial extent of the wind in the SE quadrant, in nautical miles}
    \item{\code{sw}}{\strong{numeric}: maximum radial extent of the wind in the SW quadrant, in nautical miles}
  }
}
\details{See source.}
\source{\href{http://rammb.cira.colostate.edu/research/tropical_cyclones/tc_extended_best_track_dataset/}{EBTD Archive}.}
\references{See source.}
\examples{
data(ike)
events <- unique(ike$date)
}
\keyword{datasets}
