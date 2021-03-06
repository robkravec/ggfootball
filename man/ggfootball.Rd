% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggfootball.R
\name{ggfootball}
\alias{ggfootball}
\title{Plot American Football Field}
\usage{
ggfootball(
  left_endzone_color = "gray90",
  right_endzone_color = "gray90",
  field_color = "green4",
  field_alpha = 0.85,
  top_buffer = 1,
  bottom_buffer = 1,
  left_buffer = 1,
  right_buffer = 1,
  five_yd_lines = TRUE,
  ydline_labels = TRUE,
  ydline_label_size = 4,
  outer_hash = TRUE,
  inner_hash = FALSE
)
}
\arguments{
\item{left_endzone_color}{Color of left end zone, specified in quotes}

\item{right_endzone_color}{Color of right end zone, specified in quotes}

\item{field_color}{Color of field (not including end zones), specified
in quotes}

\item{field_alpha}{Opacity of field color (not including end zones),
specified as numeric between 0.0 and 1.0}

\item{top_buffer}{Empty space provided on top of plot, specified as numeric}

\item{bottom_buffer}{Empty space provided at bottom of plot, specified as
numeric}

\item{left_buffer}{Empty space provided to left of plot, specified as numeric}

\item{right_buffer}{Empty space provided to right of plot, specified as
numeric}

\item{five_yd_lines}{Boolean value indicating whether to include white
vertical lines at each five yard increment}

\item{ydline_labels}{Boolean value indicating whether to include yard line
labels every ten yards}

\item{ydline_label_size}{Size of text used for yard line labels, specified
as numeric}

\item{outer_hash}{Boolean value indicating whether to include hash marks
outside of yard line labels (near sidelines)}

\item{inner_hash}{Boolean value indicating whether to include hash marks
near middle of field}
}
\value{
The output will be a plot of an American football field
}
\description{
This function produces a plot of an American football field using ggplot2
objects. Originally, this function was created for the NFL Big Data Bowl 2021
on Kaggle (\url{https://www.kaggle.com/c/nfl-big-data-bowl-2021}). To keep
with the conventions of the datasets provided, the plotted field spans from
0 - 120 in the x-direction and 0 - 53.3 in the y-direction. It is expected
that users will add other ggplot2 objects (e.g., points representing players,
text annotations) to produce complete visualizations.
}
\examples{
ggfootball()
ggfootball(left_endzone = "red", right_endzone = "blue",
    field_alpha = 0.7)
ggfootball() + geom_point(data =
    data.frame(x = c(10, 20), y = c(20, 30)),
    aes(x = x, y = y))

}
