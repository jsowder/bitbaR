#' Asks for user input with a generic Apple dialogue box.
#'
#' Note: only works on Apple computers, as BitBar is Apple-only.
#'
#' @param query Prompt to display. Defaults to "Input below".
#' @param submitButton Button to submit input. Defaults to "Submit".
#' @param cancelButton Button to cancel. Defaults to "Cancel".
#' @param defaultAnswer Initial value in the input box. Defaults to nothing.
#'
#' @export
#' @examples
#' bbPopUp("What is your favorite color?", defaultAnswer = "green")

bb_PopUp <- function(
  query = "Input below"
  ,defaultAnswer = ""
  ,buttonSubmit = "Submit"
  ,buttonCancel = "Cancel"
){
  # Remove quotations -- I haven't figured out how to escape them in the system command.
  danger_patterns <- "\'|\"|\`"
  if(stringr::str_detect(query, danger_patterns))
    warning("All quotations (\', \", \`) are removed from the query.")
  query <-
    query %>%
    stringr::str_remove_all("\'|\"|\`")

  # Build the system call.
  system_call <- stringr::str_glue(
    "osascript -e 'set T to text returned of (display dialog \"{query}\""
    , " buttons {{\"{buttonCancel}\", \"{buttonSubmit}\"}}"
    , " default button \"{buttonSubmit}\""
    , " default answer \"{defaultAnswer}\")'"
  )

  # Call
  system(system_call, intern = TRUE)
}
