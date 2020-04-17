#' Make a tibble of options passed to your script through bash.
#'
#' This is a developing feature.
#'
#' You can pass arguments to your script with \code{'| param1=foo param2=bar'} arguments.
#' This function collects those inputs when passed to the Rscript you
#' are running.
#'
#' @export
#' @examples
#' RscriptInputs <- bbInputs()

bb_inputs <- function(){

  inputs <- commandArgs() %>%
    tibble::enframe(name = NULL) %>%
    tidyr::separate(col=value, into=c("key", "value"), sep="=", fill='right')

  if('--interactive' %in% inputs$key){
    inputs %<>% add_row(key = "--time", value = Sys.time() %>% as.character())
  }
  return(inputs)
}
