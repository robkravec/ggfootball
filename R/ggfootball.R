#' Plot American Football Field
#'
#' This function produces a plot of an American football field using ggplot2
#' objects. Originally, this function was created for the NFL Big Data Bowl 2021
#' on Kaggle (\url{https://www.kaggle.com/c/nfl-big-data-bowl-2021}). To keep
#' with the conventions of the datasets provided, the plotted field spans from
#' 0 - 120 in the x-direction and 0 - 53.3 in the y-direction. It is expected
#' that users will add other ggplot2 objects (e.g., points representing players,
#' text annotations) to produce complete visualizations.
#'
#' @param left_endzone_color Color of left end zone, specified in quotes
#' @param right_endzone_color Color of right end zone, specified in quotes
#' @param field_color Color of field (not including end zones), specified
#'     in quotes
#' @param field_alpha Opacity of field color (not including end zones),
#'     specified as numeric between 0.0 and 1.0
#' @param top_buffer Empty space provided on top of plot, specified as numeric
#' @param bottom_buffer Empty space provided at bottom of plot, specified as
#'     numeric
#' @param left_buffer Empty space provided to left of plot, specified as numeric
#' @param right_buffer Empty space provided to right of plot, specified as
#'     numeric
#' @param five_yd_lines Boolean value indicating whether to include white
#'     vertical lines at each five yard increment
#' @param yardline_labels Boolean value indicating whether to include yard line
#'     labels every ten yards
#' @param outer_hash Boolean value indicating whether to include hash marks
#'     outside of yard line labels (near sidelines)
#' @param inner_hash Boolean value indicating whether to include hash marks
#'     near middle of field
#'
#' @return The output will be a plot of an American football field
#'
#' @examples
#' ggfootball()
#' ggfootball(left_endzone = "red", right_endzone = "blue",
#'     field_alpha = 0.7)
#' ggfootball() + ggplot2::geom_point(data =
#'     data.frame(x = c(10, 20), y = c(20, 30)),
#'     aes(x = x, y = y))
#'
#' @export

ggfootball <- function(left_endzone_color = "gray90",
                       right_endzone_color = "gray90",
                       field_color = "green4",
                       field_alpha = 0.85,
                       top_buffer = 1,
                       bottom_buffer = 1,
                       left_buffer = 1,
                       right_buffer = 1,
                       five_yd_lines = TRUE,
                       yardline_labels = TRUE,
                       outer_hash = TRUE,
                       inner_hash = FALSE) {

  # Create data frames to add lines to field, hash marks, and 10-yard labels
  hash_df <- data.frame(x = 11:109)


  # Make middle of field green
  gplot <- ggplot2::ggplot() + ggplot2::geom_rect(data = NULL,
                    ggplot2::aes(xmin = 10, xmax = 110, ymin = 0, ymax = 53.3),
                    fill = field_color, color = "black", alpha = field_alpha) +

    # Add endzones
    ggplot2::geom_rect(data = NULL,
              ggplot2::aes(xmin = 0, xmax = 10, ymin = 0, ymax = 53.3),
              fill = left_endzone_color, color = "black") +
    ggplot2::geom_rect(data = NULL,
              ggplot2::aes(xmin = 110, xmax = 120, ymin = 0, ymax = 53.3),
              fill = right_endzone_color, color = "black") +

    # Format gridlines, tick marks, tick labels, and border of plot window
    ggplot2::theme_bw() +
    ggplot2::theme(panel.grid.minor = ggplot2::element_blank(),
          panel.grid.major = ggplot2::element_blank(),
          panel.border = ggplot2::element_blank(),
          axis.text = ggplot2::element_blank(),
          axis.ticks = ggplot2::element_blank(),
          axis.title = ggplot2::element_blank(),
          text = ggplot2::element_text(size = 16),
          #, legend.position = "none" # Optional hiding of legend
    ) +

    # Add x and y axis limits
    ggplot2::lims(x = c(0 - left_buffer, 120 + right_buffer),
                  y = c(0 - bottom_buffer, 53.3 + top_buffer))

  # Add vertical lines at each 5-yard increment
  if(five_yd_lines) {
    # Create data frame with necessary x and y coordinates
    five_yard_df <- data.frame(x = seq(from = 15, to = 105, by = 5))
    # Add to existing plot
    gplot <- gplot +
      ggplot2::geom_segment(data = five_yard_df,
                            mapping = ggplot2::aes(x = x, xend = x,
                                                   y = -Inf, yend = 53.3),
                            color = "white")
  }

  # Add yardline labels
  if(yardline_labels) {
    # Create data frame with labels and coordinates
    yard_labels_df <- data.frame(x = seq(from = 20, to = 100, by = 10),
                                 y = rep(x = 4, n = 9),
                                 digits = c(seq(from = 10, to = 50, by = 10),
                                            seq(from = 40, to = 10, by = -10)))
    # Add to existing plot
    gplot <- gplot +
      ggplot2::geom_text(data = yard_labels_df,
                         mapping = ggplot2::aes(x = x, y = y, label = digits),
                         color = "white", size = 5)
    gplot <- gplot +
      ggplot2::geom_text(data = yard_labels_df,
                         mapping = ggplot2::aes(x = x, y = 53.3 - y,
                                                label = digits),
                         color = "white", angle = 180, size = 5)
  }

  # Add outer hash marks to field
  if(outer_hash) {
    # Create data frame with hash mark x-coordinates
    hash_df <- data.frame(x = 11:109)
    # Add to existing plot
    gplot <- gplot +
      ggplot2::geom_segment(data = hash_df,
                            mapping = ggplot2::aes(x = x, xend = x,
                                                   y = 0.5, yend = 1.5),
                            color = "white") +
      ggplot2::geom_segment(data = hash_df,
                            mapping = ggplot2::aes(x = x, xend = x,
                                                   y = 51.8, yend = 52.8),
                            color = "white")
  }

  # Add inner hash marks to field
  if(inner_hash) {
    # Create data frame with hash mark x-coordinates
    hash_df <- data.frame(x = 11:109)
    # Add to existing plot
    gplot <- gplot +
      ggplot2::geom_segment(data = hash_df,
                            mapping = ggplot2::aes(x = x, xend = x,
                                                   y = 17.8, yend = 18.8),
                            color = "white") +
      ggplot2::geom_segment(data = hash_df,
                            mapping = ggplot2::aes(x = x, xend = x,
                                                   y = 34.6, yend = 35.6),
                            color = "white")
  }

  # Create final solid black outlines for the field
  gplot <- gplot +
    ggplot2::geom_rect(data = NULL,
                       ggplot2::aes(xmin = 10, xmax = 110,
                                   ymin = 0, ymax = 53.3),
                       fill = NA, color = "black") +
    ggplot2::geom_rect(data = NULL,
                       ggplot2::aes(xmin = 0, xmax = 120,
                                    ymin = 0, ymax = 53.3),
                       fill = NA, color = "black")

  # Return plot
  gplot
}
