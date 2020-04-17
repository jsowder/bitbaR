#' @title Print text to BitBar.
#'
#' @param ... What to print. Concatenates arguments without spaces.
#'
#' @return Nothing
#'
#' @export
#' @examples
#' bb_print("text")
#' bb_print(2 + 2)
#' bb_print("text", "more text")
#' bb_print("google", bb_attributes(href = "https://www.google.com""))
#' bb_print("google | href=https://www.google.com")

bb_print <- function(
  ...
){
  cat(
    ...
    , sep = ""
    , fill = TRUE
  )
}
