#' Translate tibble columns into nested submenus.
#'
#' Translate tibble columns into nested submenus. Each successive variable
#' will form another dropdown. The final variable is the end-item. Print
#' with \code{bb_print} or \code{cat}.
#'
#' @param .data A tibble or dataframe.
#' @param ... Variables to nest into dropdown menus. Each variable forms a new set of dropdowns.
#'
#' @export
#' @examples
#' bb_nest(mtcars, cyl, mpg)
#' mtcars %>% rownames_to_column() %>% arrange(cyl) %>% bb_nest(cyl, rowname)

bb_nest <- function(.data, ...){
  dots <- enquos(...)
  for(numdot in length(dots):1){
    .data %<>%
      {
        if(numdot == 1)
          ungroup(.)
        else
          group_by(., !!!(dots[1:numdot-1]))
      } %>%
      transmute(bb_ready =
                  (!!!(dots[numdot])) %>%
                  map(~paste(strrep("--", numdot - 1), .)) %>%
                  str_trim() %>%
                  paste(.,
                        if(exists("bb_ready")){bb_ready},
                        sep = "\n",
                        collapse = "\n")
      ) %>%
      distinct()
  }
  .data %>% pull() %>% str_replace_all("\n{2,}", "\n")
}
