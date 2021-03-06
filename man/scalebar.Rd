% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/scalebar.R
\name{scalebar}
\alias{scalebar}
\title{North symbol}
\usage{
scalebar(data = NULL, location = "bottomright", dist, height = 0.02,
  st.dist = 0.02, st.bottom = TRUE, st.size = 5, dd2km = NULL, model,
  x.min, x.max, y.min, y.max, anchor = NULL)
}
\arguments{
\item{data}{the same \code{\link{data.frame}} passed to \code{\link{ggplot}} to plot the map.}

\item{location}{string indicating the symbol's location in the plot. Possible options: "topright" (default), "bottomright", "bottomleft" and "topleft".}

\item{dist}{distance in km to represent with the scale bar.}

\item{height}{number between 0 and 1 to indicate the height of the scale bar, as a proportion of the y axis.}

\item{st.dist}{number between 0 and 1 to indicate the distance between the scale bar and the scale bar text, as a proportion of the y axis.}

\item{st.bottom}{logical. If TRUE (default) the scale bar text is displayed at the bottom of the scale bar, if FALSE, it is displayed at the top.}

\item{st.size}{number to indicate the scale bar text size. It is passed to the size argument of \code{\link{annotate}} function.}

\item{dd2km}{logical. If TRUE \code{dist} it is assumed that map coordinates are in decimal degrees, if FALSE, it assumed they are in meters.}

\item{model}{choice of ellipsoid model ("WGS84", "GRS80", "Airy", "International", "Clarke", "GRS67") Used when dd2km is TRUE.}

\item{x.min}{if \code{data} is not defined, number with the minimum x coordinate. Useful for ggmap.}

\item{x.max}{if \code{data} is not defined, number with the maximum x coordinate. Useful for ggmap.}

\item{y.min}{if \code{data} is not defined, number with the minimum y coordinate. Useful for ggmap.}

\item{y.max}{if \code{data} is not defined, number with the maximum y coordinate. Useful for ggmap.}

\item{anchor}{named \code{\link{vector}} with coordinates to control the symbol position. For \code{location = "topright"}, \code{anchor} defines the coordinates of the symbol's topright corner and so forth. The x coordinate must be named as x and the y coordinate as y.}
}
\description{
Adds a north symbol to maps created with ggplot or ggmap.
}
\examples{
library(rgdal); library(rgeos)
dsn <- system.file('extdata', package = 'ggsn')

## Map in geographic coordinates.
map <- readOGR(dsn, 'sp')
map@data$id <- 1:nrow(map@data)
map.ff <- fortify(map, region = 'id')
map.df <- merge(map.ff, map@data, by = 'id')

ggplot(data = map.df, aes(long, lat, group = group, fill = nots)) +
    geom_polygon() +
    coord_equal() +
    geom_path() +
    scale_fill_brewer(name = 'Animal abuse\\nnotifications', palette = 8) +
    scalebar(map.df, dist = 5, dd2km = TRUE, model = 'WGS84')

## Map in meter coordinates.
map2 <- spTransform(map, CRS("+init=epsg:31983"))
map2@data$id <- 1:nrow(map2@data)
map2.ff <- fortify(map2, region = 'id')
map2.df <- merge(map2.ff, map2@data, by = 'id')

ggplot(data = map2.df, aes(long, lat, group = group, fill = nots)) +
    geom_polygon() +
    coord_equal() +
    geom_path() +
    scale_fill_brewer(name = 'Animal abuse\\nnotifications', palette = 8) +
    scalebar(map2.df, dist = 5)

ggplot(data = map2.df, aes(long, lat, group = group, fill = nots)) +
    geom_polygon() +
    coord_equal() +
    geom_path() +
    scale_fill_brewer(name = 'Animal abuse\\nnotifications', palette = 8) +
    scalebar(map2.df, dist = 7, anchor = c(x = 355000, y = 7360000),
             st.bottom = FALSE, st.size = 8)

ggplot(data = map2.df, aes(long, lat, group = group, fill = nots)) +
    geom_polygon() +
    coord_equal() +
    geom_path() +
    scale_fill_brewer(name = 'Animal abuse\\nnotifications', palette = 8) +
    scalebar(map2.df, location = 'topright', dist = 5)
}

