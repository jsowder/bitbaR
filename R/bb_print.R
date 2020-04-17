#' @title Print strings in BitBar fashion
#'
#' @description I print, BitBar-style.
#'
#' @param ... What to print. Vectors are concatenated.
#' @param nest Level of nesting Defaults to 0.
#' @param sep What to seperate vectors by. Defaults to "".
#' @param collapse What to collapse vectors by. Defaults to "".
#'
#' @return Nothing
#'
#' @examples
#' bb_print(nest = 1, c("this", "that"))
#' bb_print(nest = 2, "this", "that")
#' bb_print(nest = 3, c("this", "that"), "and the other")
#' bb_print(nest = 4, c("2 + 2 = ", 2 + 2))
#'
#' @export

bb_print <- function(
  ...
  , nest = 0
  , sep = ""
  , collapse = ""
){
  null_results <-
    list(...) %>%
    Filter(f = length) %>% # Drops empties.
    lapply(function(x){
      cat(
        strrep("--", nest)
        , paste(
          x
          , sep = sep
          , collapse = collapse
        )
        , sep = ""
        , fill = TRUE
      )
    })
}
