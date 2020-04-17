#' bb_head
#'
#' This is a description.
#'
#' @param icon Description. Defaults to NULL.
#' @param refresh Description. Defaults to NULL.
#'
#' @export
#'
#' @examples
#' bb_head()


bb_head <- function(
  icon = "\U0001f4a1" # Lightbulb
  , refresh = TRUE
){
  # Display Icon
  bb_print(icon)
  bb_print("---")

  # Display Refresh Button
  if(refresh){
  bb_print("Refresh | terminal=false refresh=true")
  bb_print("---")
  }
}

